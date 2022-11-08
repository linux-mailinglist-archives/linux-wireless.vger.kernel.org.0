Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4968620D1F
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 11:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbiKHKUn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 05:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiKHKUV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 05:20:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928A114D13
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 02:20:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48E77B816DD
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 10:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30151C433D6;
        Tue,  8 Nov 2022 10:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667902818;
        bh=fj3GSjuI/xSDQX1HQai9knNPR5hppsvev38xKxYNPFo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mvd7sFW2tY2oJMAVWF+GerRLIYEGXDYfBWpg2MDXULNdZ65+Y/frPtDmLOHI6sbLO
         ehrOIt8jprA0eKOybe2KuEqxKyMnjpsn9OjofYKUcygwKtGqi4gjJpRVBLWHCkSejB
         l7xELMzZoJfnUc0XwXz3Y7avH0EwD7kzGozS8jZhMg3Je314OWs/4K6N3g9evji4t7
         /KWUiiLXHGLKwbfh0OwiD1hA+ZnODdcWhIp10Jp5wcwPsuIPCW2zriDsxH8fCCTZrU
         kbrQJZ60d/fPJ7C1jG6scAncdDC3GaTT1uaLwEWUHH6LDx+W8bE9L3eZw5QTTT5R4D
         5OBgDCJvZCIKg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] wifi: ath11k: reduce the timeout value back for hw scan from 10 seconds to 1 second
References: <20221011072408.23731-1-quic_wgong@quicinc.com>
        <20221011072408.23731-3-quic_wgong@quicinc.com>
Date:   Tue, 08 Nov 2022 12:20:14 +0200
In-Reply-To: <20221011072408.23731-3-quic_wgong@quicinc.com> (Wen Gong's
        message of "Tue, 11 Oct 2022 03:24:08 -0400")
Message-ID: <8735atg335.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> For 11d scan, commit 9dcf6808b253 ("ath11k: add 11d scan offload support")
> increased the timeout from one second to max 10 seconds when 11d scan
> offload enabled and 6 GHz enabled, it is reasonable for the commit, it
> is because the first 11d scan request is sent to firmware before the
> first hw scan request after wlan load, then the hw scan started event
> will reported from firmware after the 11d scan finished, it needs about
> 6 seconds when 6 GHz enabled, so increased it from one second to 10
> seconds in the commit to avoid timed out for hw scan started. Then
> another commit 1f682dc9fb37 ("ath11k: reduce the wait time of 11d scan
> and hw scan while add interface") change the sequence of the first 11d
> scan and hw scan, then ath11k will receive the hw scan started event
> from firmware immediately for the first hw scan, thus ath11k does not
> need set the timeout value to max 10 seconds again, and this is to set
> the timeout value back from 10 seconds to 1 second.
>
> After the 1st hw scan finished, firmware will start 11d scan immediately,
> and firmware need use some seconds to finish 11d scan, if the 2nd hw
> scan is sent from ath11k to firmware before 11d scan finished, the 2nd
> hw scan will started after 11d scan finished, this will lead timeout to
> wait scan started in ath11k. Treat the timeout as a normal situation if
> 11d scan is running and skip report scan fail for this situation.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

[...]

> @@ -3682,7 +3677,12 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
>  
>  	ret = ath11k_start_scan(ar, &arg);
>  	if (ret) {
> -		ath11k_warn(ar->ab, "failed to start hw scan: %d\n", ret);
> +		if (ret == -EBUSY)
> +			ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
> +				   "scan engine is busy 11d state %d\n", ar->state_11d);
> +		else
> +			ath11k_warn(ar->ab, "failed to start hw scan: %d\n", ret);
> +
>  		spin_lock_bh(&ar->data_lock);
>  		ar->scan.state = ATH11K_SCAN_IDLE;
>  		spin_unlock_bh(&ar->data_lock);

This feels like a hack to me, for example will these failed scans now
cause delays is connection establishment? IMHO it's crucial from user's
point of view that we don't delay that in any way.

I would rather fix the root cause, do we know what's causing this?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
