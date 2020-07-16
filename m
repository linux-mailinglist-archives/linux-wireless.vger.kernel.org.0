Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF13221D97
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jul 2020 09:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgGPHr6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jul 2020 03:47:58 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:22750 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgGPHr6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jul 2020 03:47:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594885676; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=+ce0kxHfFA9ILiexCaIyb9KwC+bF35kV30XqjwR77Qk=; b=Xbgl+T74g7Uebu8RltRBP1/ximatCdYfv/Bo9Oc7r0ZavEuXx0OoKB37AiNWuwNeqIGMUj0K
 QvGfEX3samFklXMpJqs+ETrNgUcYaX1Ih5KH3iV26JmGfxI8Ei80eIyBrEYwriV6C0HmyBV5
 wX9u1w/0/9+leXiaGvpERIsA48M=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f10062a65270fa595288352 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Jul 2020 07:47:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 38AC5C433CB; Thu, 16 Jul 2020 07:47:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E601AC433C6;
        Thu, 16 Jul 2020 07:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E601AC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [RESEND 2/2] ath11k: add debugfs for TWT debug calls
References: <20200624080321.2271943-1-john@phrozen.org>
        <20200624080321.2271943-2-john@phrozen.org>
Date:   Thu, 16 Jul 2020 10:47:48 +0300
In-Reply-To: <20200624080321.2271943-2-john@phrozen.org> (John Crispin's
        message of "Wed, 24 Jun 2020 10:03:21 +0200")
Message-ID: <87tuy7x5nf.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

John Crispin <john@phrozen.org> writes:

> These new debugfs files allow us to manually add/del/pause/resume TWT
> dialogs for test/debug purposes.
>
> The debugfs files expect the following parameters
> add_dialog      - mac dialog_id wake_intvl_us wake_intvl_mantis
>                   wake_dura_us sp_offset_us twt_cmd flag_bcast
>                   flag_trigger flag_flow_type flag_protection
> del_dialog      - mac dialog_id
> pause_dialog    - mac dialog_id
> resume_dialog   - mac dialog_id sp_offset_us next_twt_size

Full examples (including full path to the debugfs file) for some of
these would be nice, especially for add_dialog file.

Also please add Tested-on tag:

https://wireless.wiki.kernel.org/en/users/drivers/ath11k/submittingpatches#hardware_families

And Cc linux-wireless, otherwise patchwork won't see these.

BTW, I prefer to avoid using RESEND, REPOST etc. Increasing the version
number makes it easier to track patches, even if there are no changes
between versions.

> +static ssize_t ath11k_write_twt_add_dialog(struct file *file,
> +					   const char __user *ubuf,
> +					   size_t count, loff_t *ppos)
> +{
> +	struct ath11k_vif *arvif = file->private_data;
> +	struct wmi_twt_add_dialog_params params = { 0 };
> +	u8 buf[128] = {0};
> +	int ret;
> +
> +	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
> +	if (ret < 0)
> +		return ret;
> +
> +	buf[ret] = '\0';
> +	ret = sscanf(buf, "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx %u %u "
> +		     "%u %u %u %hhu %hhu %hhu %hhu %hhu",
> +		     &params.peer_macaddr[0],
> +		     &params.peer_macaddr[1],
> +		     &params.peer_macaddr[2],
> +		     &params.peer_macaddr[3],
> +		     &params.peer_macaddr[4],
> +		     &params.peer_macaddr[5],
> +		     &params.dialog_id,
> +		     &params.wake_intvl_us,
> +		     &params.wake_intvl_mantis,
> +		     &params.wake_dura_us,
> +		     &params.sp_offset_us,
> +		     &params.twt_cmd,
> +		     &params.flag_bcast,
> +		     &params.flag_trigger,
> +		     &params.flag_flow_type,
> +		     &params.flag_protection);
> +	if (ret != 16)
> +		return -EINVAL;
> +
> +	params.vdev_id = arvif->vdev_id;
> +
> +	ret = ath11k_wmi_send_twt_add_dialog_cmd(arvif->ar, &params);
> +
> +	return ret ? ret : count;

More lines but easier to read:

ret = foo();
if (ret)
        return ret;

return count;

> +static ssize_t ath11k_write_twt_del_dialog(struct file *file,
> +					   const char __user *ubuf,
> +					   size_t count, loff_t *ppos)
> +{
> +	struct ath11k_vif *arvif = file->private_data;
> +	struct wmi_twt_del_dialog_params params = { 0 };
> +	u8 buf[64] = {0};
> +	int ret;
> +
> +	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
> +	if (ret < 0)
> +		return ret;
> +
> +	buf[ret] = '\0';
> +	ret = sscanf(buf, "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx %u",
> +		     &params.peer_macaddr[0],
> +		     &params.peer_macaddr[1],
> +		     &params.peer_macaddr[2],
> +		     &params.peer_macaddr[3],
> +		     &params.peer_macaddr[4],
> +		     &params.peer_macaddr[5],
> +		     &params.dialog_id);
> +	if (ret != 7)
> +		return -EINVAL;
> +
> +	params.vdev_id = arvif->vdev_id;
> +
> +	ret = ath11k_wmi_send_twt_del_dialog_cmd(arvif->ar, &params);
> +
> +	return ret ? ret : count;
> +}

Ditto.

> +static ssize_t ath11k_write_twt_pause_dialog(struct file *file,
> +					     const char __user *ubuf,
> +					     size_t count, loff_t *ppos)
> +{
> +	struct ath11k_vif *arvif = file->private_data;
> +	struct wmi_twt_pause_dialog_params params = { 0 };
> +	u8 buf[64] = {0};
> +	int ret;
> +
> +	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
> +	if (ret < 0)
> +		return ret;
> +
> +	buf[ret] = '\0';
> +	ret = sscanf(buf, "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx %u",
> +		     &params.peer_macaddr[0],
> +		     &params.peer_macaddr[1],
> +		     &params.peer_macaddr[2],
> +		     &params.peer_macaddr[3],
> +		     &params.peer_macaddr[4],
> +		     &params.peer_macaddr[5],
> +		     &params.dialog_id);
> +	if (ret != 7)
> +		return -EINVAL;
> +
> +	params.vdev_id = arvif->vdev_id;
> +
> +	ret = ath11k_wmi_send_twt_pause_dialog_cmd(arvif->ar, &params);
> +
> +	return ret ? ret : count;

And here as well.

> +static ssize_t ath11k_write_twt_resume_dialog(struct file *file,
> +					      const char __user *ubuf,
> +					      size_t count, loff_t *ppos)
> +{
> +	struct ath11k_vif *arvif = file->private_data;
> +	struct wmi_twt_resume_dialog_params params = { 0 };
> +	u8 buf[64] = {0};
> +	int ret;
> +
> +	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
> +	if (ret < 0)
> +		return ret;
> +	buf[ret] = '\0';
> +	ret = sscanf(buf, "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx %u %u %u",
> +		     &params.peer_macaddr[0],
> +		     &params.peer_macaddr[1],
> +		     &params.peer_macaddr[2],
> +		     &params.peer_macaddr[3],
> +		     &params.peer_macaddr[4],
> +		     &params.peer_macaddr[5],
> +		     &params.dialog_id,
> +		     &params.sp_offset_us,
> +		     &params.next_twt_size);
> +	if (ret != 9)
> +		return -EINVAL;
> +
> +	params.vdev_id = arvif->vdev_id;
> +
> +	ret = ath11k_wmi_send_twt_resume_dialog_cmd(arvif->ar, &params);
> +
> +	return ret ? ret : count;

And here.

> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -2061,6 +2061,8 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
>  			ath11k_wmi_send_twt_enable_cmd(ar, ar->pdev->pdev_id);
>  		else
>  			ath11k_wmi_send_twt_disable_cmd(ar, ar->pdev->pdev_id);
> +		if (vif->type == NL80211_IFTYPE_AP)
> +			ath11k_debugfs_twt(arvif, info->twt_requester);

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

> @@ -4608,6 +4610,8 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
>  
>  	/* TODO: recal traffic pause state based on the available vdevs */
>  
> +	debugfs_remove_recursive(arvif->debugfs_twt);
> +	arvif->debugfs_twt = NULL;

And this could be ath11k_debug_remove_interface().

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
