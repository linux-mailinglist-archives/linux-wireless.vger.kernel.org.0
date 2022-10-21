Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D20060786E
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 15:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiJUNaW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 09:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiJUNaR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 09:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E211290AF
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 06:30:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2600F61E9F
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 13:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A6AC433D6;
        Fri, 21 Oct 2022 13:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666359008;
        bh=otm6vjOf917CVbDV4BVliAUxIoYgK/kcfD/iNX/POm0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WNs0oqAvXXccJyEmg2Lal3AB2MeZV0/H/A1uEFakznALFkUGRQa809OZeCJNJ3nmD
         joLgF8DQMOenM9IIf49fINkHcnFs+QZ9jwLoadDN2tIk0gQ0jimyIdaNqqKFfue3Ap
         qwGBdiLBxLJe3DdkantklD/BfY6CeRZJwmkpP9kZXfp/XYJGbWlZlzjRoBdnNiX23t
         AmkweXspRocCm7dvyoaEypLll0ZuL/6Rr/TadOg5d5XA8ZMJdaj/rcA4AKB7gMpCae
         FBYnt0cUZVYnp/IA9q/6wSBntXU2UU1JTFZU0ubIc2rJNGnfjaOKMpMTPxV8lLfuUc
         zN58RYbVz73Bg==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Sriram R \(QUIC\)" <quic_srirrama@quicinc.com>
Cc:     "Jeff Johnson \(QUIC\)" <quic_jjohnson@quicinc.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath12k\@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: Re: [PATCH 15/50] wifi: ath12k: add dp_rx.c
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-16-kvalo@kernel.org>
        <b2cd5b02-60ca-c788-af71-9f36f6a8ede3@quicinc.com>
        <SN6PR02MB4334C052EA71CD13F0506E55F7259@SN6PR02MB4334.namprd02.prod.outlook.com>
Date:   Fri, 21 Oct 2022 16:30:04 +0300
In-Reply-To: <SN6PR02MB4334C052EA71CD13F0506E55F7259@SN6PR02MB4334.namprd02.prod.outlook.com>
        (Sriram R.'s message of "Thu, 13 Oct 2022 05:54:54 +0000")
Message-ID: <87ilkdi9sz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Sriram R (QUIC)" <quic_srirrama@quicinc.com> writes:

>>> +static void ath12k_dp_rx_process_received_packets(struct ath12k_base
>>*ab,
>>> +                                               struct napi_struct *napi,
>>> +                                               struct sk_buff_head *msdu_list,
>>> +                                               int ring_id) {
>>> +     struct ieee80211_rx_status rx_status = {0};
>>
>>initializing just on entry seems wrong, see below
>
> We reset the whole struct once, and reset the necessary fields alone
> for every loop within ath12k_dp_rx_h_ppdu or similar places as
> necessary and pass the status to mac80211. The initial reset is
> necessary so as to reset all unused fields. This is an optimization to
> not memset the struct for every loop.

It would be good to document such optimisations with a comment,
otherwise people might be confused.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
