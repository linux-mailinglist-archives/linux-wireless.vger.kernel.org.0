Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A8E5B446A
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Sep 2022 08:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiIJG2L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Sep 2022 02:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIJG2J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Sep 2022 02:28:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4719E0E6
        for <linux-wireless@vger.kernel.org>; Fri,  9 Sep 2022 23:28:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9BC1B80687
        for <linux-wireless@vger.kernel.org>; Sat, 10 Sep 2022 06:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921E9C433C1;
        Sat, 10 Sep 2022 06:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662791286;
        bh=4Az+6COg6RQIv37I0MWXhYUrsXE7s/Ds8LZAdFk0tgw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=T9HuTeo7TKQOWFX3smE2UljmvqUIzZUt/Ds2L+UTQkqzbpM7Nxjn7YTi4/tz7ur73
         o4bzsqkzAGQH35/Bi4FMVY4CdbE2qpHU342sUns3blS+61AFefdr2i6q0xy/0+TXHY
         O23AvtI4arHMLbj8GQ+SA/sz4OzjMnx6sRwUogxQsUzgndT/OJVFBkmd4vylJjQ1vr
         /Gu7RyFXX/9hxSnS+MlbrbDvE/kSphGiicCCmYfD2mKDKBOzMPYXis09aFzrt9IBYw
         weK631shuos2CUuMCYC3q2xrrMGCTrnc0CgpGgJYFwMMTD1+ver+sHZ+TGbWPW7XhB
         OaJEdhwaXpIXg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] wifi: ath11k: Enable threaded NAPI
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220905071805.31625-2-quic_mpubbise@quicinc.com>
References: <20220905071805.31625-2-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166279128337.2050.17984018699981295216.kvalo@kernel.org>
Date:   Sat, 10 Sep 2022 06:28:05 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> wrote:

> Enable threaded NAPI on all ath11k targets. Unlike traditional
> NAPI poll which runs in softirq context and on the core which
> scheduled the NAPI, threaded NAPI makes use of kernel threads
> which are under direct control of the scheduler and helps in
> balancing the NAPI processing load across multiple CPUs thereby
> improving throughput.
> 
> In the case of WCN6750, enabling threaded NAPI has improved
> 160 MHz RX throughput by nearly 400 Mbps. Similar gains can
> be expected on other ath11k devices as well.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

13aa2fb692d3 wifi: ath11k: Enable threaded NAPI
7636c9a6e7d7 wifi: ath11k: Add multi TX ring support for WCN6750
97c9e37c7a7d wifi: ath11k: Increase TCL data ring size for WCN6750

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220905071805.31625-2-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

