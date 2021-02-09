Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FF0314BB0
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 10:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhBIJeU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 04:34:20 -0500
Received: from so15.mailgun.net ([198.61.254.15]:47404 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229743AbhBIJcA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 04:32:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612863094; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=zo0gvDHuV2hYczPP7dK3bMYetHdvog14VSL75+shPCc=; b=XaV6bhfytEstLdgoiiZnR0o6aZibdK/SfehI0L+L36j3cP2VgJHHRQ8/FMCRz6X9g5b8jsc1
 xLGDDLDKvoLg5BgDkXvPYr63OX1p2Jit3PXhQttO4Mrg2hhDBPKYFSyOWqdH7VL672eTcgza
 9cmlb0J/TUcESpfMiA2pgZ4D/Ck=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6022563be3df861f4b936cb6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Feb 2021 09:30:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8829CC433CA; Tue,  9 Feb 2021 09:30:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5626FC433CA;
        Tue,  9 Feb 2021 09:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5626FC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        ath11k@lists.infradead.org
Subject: Re: [PATCH V4 2/2] ath11k: add debugfs for TWT debug calls
References: <20210120023048.5016-1-alokad@codeaurora.org>
        <20210120023048.5016-3-alokad@codeaurora.org>
Date:   Tue, 09 Feb 2021 11:30:28 +0200
In-Reply-To: <20210120023048.5016-3-alokad@codeaurora.org> (Aloka Dixit's
        message of "Tue, 19 Jan 2021 18:30:48 -0800")
Message-ID: <87sg65io5n.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ ath11k

Aloka Dixit <alokad@codeaurora.org> writes:

> From: John Crispin <john@phrozen.org>
>
> These new debugfs files allow us to manually add/del/pause/resume TWT
> dialogs for test/debug purposes.
>
> The debugfs files expect the following parameters
> add_dialog	- mac dialog_id wake_intvl_us wake_intvl_mantis
> 		  wake_dura_us sp_offset_us twt_cmd flag_bcast
> 		  flag_trigger flag_flow_type flag_protection
> del_dialog	- mac dialog_id
> pause_dialog	- mac dialog_id
> resume_dialog	- mac dialog_id sp_offset_us next_twt_size
>
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Aloka Dixit <alokad@codeaurora.org>

[...]

> --- a/drivers/net/wireless/ath/ath11k/debug.h
> +++ b/drivers/net/wireless/ath/ath11k/debug.h
> @@ -64,4 +64,12 @@ do {								\
>  		__ath11k_dbg(ar, dbg_mask, fmt, ##__VA_ARGS__);	\
>  } while (0)
>  
> +#ifdef CONFIG_MAC80211_DEBUGFS
> +void ath11k_debugfs_twt(struct ath11k_vif *arvif, bool enable);
> +#else
> +static inline void ath11k_debugfs_twt(struct ath11k_vif *arvif, bool enable)
> +{
> +}
> +#endif
> +
>  #endif /* _ATH11K_DEBUG_H_ */
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index c1608f64ea95..564cdf7a5331 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -2111,6 +2111,8 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
>  			ath11k_wmi_send_twt_enable_cmd(ar, ar->pdev->pdev_id);
>  		else
>  			ath11k_wmi_send_twt_disable_cmd(ar, ar->pdev->pdev_id);
> +		if (vif->type == NL80211_IFTYPE_AP)
> +			ath11k_debugfs_twt(arvif, info->twt_requester);
>  	}

These hunks gave my deja vu and indeed I have provided comments before:

http://lists.infradead.org/pipermail/ath11k/2020-July/000039.html

I'll copy my comments here:

To make this more generic can you call this
ath11k_debugs_add_interface() or something like that? Ah, but this is in
ath11k_mac_op_bss_info_changed(). Shouldn't it be in
ath11k_mac_op_add_interface()?

Hmm, I think I get now. You create the debugfs directory and files only
when twt is actually enabled, not when the interface is added. I have
concerns about files coming and going like that dynamically. Wouldn't it
be cleaner to create the directory and the files when the interface is
added? And just return a good error code if someone tries to use the
debugfs files when twt is disabled?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
