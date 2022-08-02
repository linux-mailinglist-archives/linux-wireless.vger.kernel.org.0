Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4986F587756
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Aug 2022 08:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiHBG5u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Aug 2022 02:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiHBG5t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Aug 2022 02:57:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAF860EA
        for <linux-wireless@vger.kernel.org>; Mon,  1 Aug 2022 23:57:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67F5F60FEA
        for <linux-wireless@vger.kernel.org>; Tue,  2 Aug 2022 06:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F4FC43470;
        Tue,  2 Aug 2022 06:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659423465;
        bh=2ga5/i8pNVnB0/lRZCk3qam/9Qc9PPx04rhGzvzLMDg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VlsEeq2HQJAwRH+Jv+PttEE5/RUZdqx1OH62A79W6oMAmrepCibUKEehZ9Cqnk4Og
         hMUDGboF2Tn8LKru+T2fstsh4QzIa+7BwZ6WgGAZ/LoMaU6EjsHgO/HLUf8VuH1HGy
         qnwrUNGqVG5CBd/8CA1jOgKOCmDz07WQdDDQh4+Bgk3P8vp0xf+eLpujVjYYSvBhls
         qwKhaNHbfpfeOqxVAWvS+trQxZZy4yEslEz6f9xAF/4ja32GDg10pqG/org260CbQV
         FMCclu+I1t4/i8h8iam3xHk6pGpVB/MU8JStDA6luDkbLDZmwc6BeCgkSrMytMglFj
         PSnK+kQ9Cqung==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: ath10k: add peer map clean up for peer delete in ath10k_sta_state()
In-Reply-To: <20220801141930.16794-1-quic_wgong@quicinc.com> (Wen Gong's
        message of "Mon, 1 Aug 2022 10:19:30 -0400")
References: <20220801141930.16794-1-quic_wgong@quicinc.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Tue, 02 Aug 2022 09:57:39 +0300
Message-ID: <87sfmfm8t8.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> When peer delete failed in a disconnect operation, use-after-free
> detected by KFENCE in below log. It is because for each vdev_id and
> address, it has only one struct ath10k_peer, it is allocated in
> ath10k_peer_map_event(). When connected to an AP, it has more than
> one HTT_T2H_MSG_TYPE_PEER_MAP reported from firmware, then the
> array peer_map of struct ath10k will be set muti-elements to the
> same ath10k_peer in ath10k_peer_map_event(). When peer delete failed
> in ath10k_sta_state(), the ath10k_peer will be free for the 1st peer
> id in array peer_map of struct ath10k, and then use-after-free happened
> for the 2nd peer id because they map to the same ath10k_peer.
>
> And clean up all peers in array peer_map for the ath10k_peer, then
> user-after-free disappeared
>
> peer map event log:
> [  306.911021] wlan0: authenticate with b0:2a:43:e6:75:0e
> [  306.957187] ath10k_pci 0000:01:00.0: mac vdev 0 peer create b0:2a:43:e6:75:0e (new sta) sta 1 / 32 peer 1 / 33
> [  306.957395] ath10k_pci 0000:01:00.0: htt peer map vdev 0 peer b0:2a:43:e6:75:0e id 246
> [  306.957404] ath10k_pci 0000:01:00.0: htt peer map vdev 0 peer b0:2a:43:e6:75:0e id 198
> [  306.986924] ath10k_pci 0000:01:00.0: htt peer map vdev 0 peer b0:2a:43:e6:75:0e id 166
>
> peer unmap event log:
> [  435.715691] wlan0: deauthenticating from b0:2a:43:e6:75:0e by local choice (Reason: 3=DEAUTH_LEAVING)
> [  435.716802] ath10k_pci 0000:01:00.0: mac vdev 0 peer delete b0:2a:43:e6:75:0e sta ffff990e0e9c2b50 (sta gone)
> [  435.717177] ath10k_pci 0000:01:00.0: htt peer unmap vdev 0 peer b0:2a:43:e6:75:0e id 246
> [  435.717186] ath10k_pci 0000:01:00.0: htt peer unmap vdev 0 peer b0:2a:43:e6:75:0e id 198
> [  435.717193] ath10k_pci 0000:01:00.0: htt peer unmap vdev 0 peer b0:2a:43:e6:75:0e id 166
>
> use-after-free log:
> <6>[21705.888627] wlan0: deauthenticating from d0:76:8f:82:be:75 by local choice (Reason: 3=DEAUTH_LEAVING)
> <4>[21713.799910] ath10k_pci 0000:01:00.0: failed to delete peer d0:76:8f:82:be:75 for vdev 0: -110
> <4>[21713.799925] ath10k_pci 0000:01:00.0: found sta peer d0:76:8f:82:be:75 (ptr 0000000000000000 id 102) entry on vdev 0 after it was supposedly removed
> <3>[21713.799968] ==================================================================
> <3>[21713.799991] BUG: KFENCE: use-after-free read in ath10k_sta_state+0x265/0xb8a [ath10k_core]
> <3>[21713.799991]

In the pending branch I removed the log level numbers, they just make
the commit log harder to read.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
