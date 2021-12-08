Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FA846CEBF
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 09:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244701AbhLHITh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 03:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbhLHITh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 03:19:37 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA15C061574
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 00:16:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1D3BFCE200A
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 08:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BC4C00446;
        Wed,  8 Dec 2021 08:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638951362;
        bh=+pJ69idPT2x0MrraTw0JqUqJMITFA71icoOACygOFZc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=lx+NxWZ1HoD3EJeucQCTE4eZTvpTly1DvG/ZMTUKBJDX3HqmZgAV2wS7E9E5NIj7A
         qoF5NT+zEeX71KCSexYz8Ai/1a6TfZDGNiLL4t9wv9Ql0+PteomTHgMt5JXEiH6IE8
         9RZP9Gt2rAtL0wopVpUk+6Tfo2oJdHdabWmwcZ8eC2PQtGBINPnoHE1sOqKPstG/r+
         3z8UUKKycKpVy69TrQu2SvSBe6rvzGXPABf3ZEfE540LRNW1ORKeOnfDdzSdKsLeOW
         rnJGBF4xOdGc02MeO/cdjxwX2epC+X5mSdd9Me7J1wE+57elk+adCqm/H5k8CP85o7
         /t9m2Wzu975fQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: enable IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for
 WCN6855
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211129101309.2931-1-quic_wgong@quicinc.com>
References: <20211129101309.2931-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163895135713.29041.4980786229647025244.kvalo@kernel.org>
Date:   Wed,  8 Dec 2021 08:16:01 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> Currently mac80211 will send 3 scan request for each scan of WCN6855,
> they are 2.4 GHz/5 GHz/6 GHz band scan. Firmware of WCN6855 will
> cache the RNR IE(Reduced Neighbor Report element) which exist in the
> beacon of 2.4 GHz/5 GHz of the AP which is co-located with 6 GHz,
> and then use the cache to scan in 6 GHz band scan if the 6 GHz scan
> is in the same scan with the 2.4 GHz/5 GHz band, this will helpful to
> search more AP of 6 GHz. Also it will decrease the time cost of scan
> because firmware will use dual-band scan for the 2.4 GHz/5 GHz, it
> means the 2.4 GHz and 5 GHz scans are doing simultaneously.
> 
> Set the flag IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN6855 since
> it supports 2.4 GHz/5 GHz/6 GHz and it is single pdev which means
> all the 2.4 GHz/5 GHz/6 GHz exist in the same wiphy/ieee80211_hw.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Sven, after your memory corruption fix is this good to take?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211129101309.2931-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

