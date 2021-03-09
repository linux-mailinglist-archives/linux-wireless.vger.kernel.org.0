Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8DE332380
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Mar 2021 12:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCIK7v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Mar 2021 05:59:51 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:17399 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhCIK7b (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Mar 2021 05:59:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615287571; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=EkpYZux4lGjPJ0NFDAaNb4kp+mRV085n5TDuN1w/cWo=; b=Tz2eWlRxQF3m9ZuuRL+HC7FzJlXuOL1NSMoPZhb7TTJtpwFLb6Pq6fv8qyyIW69R206FR9vD
 28FuxPZ3oXsmxBWcsDQJezNLCIvYfYEUxnDhwmdNCbdzXx6CZyu7/69WTieaz9yxF7Gnm3c3
 0IqDWjBtVNUHA/dDnon34IQ+JKg=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 604755112a5e6d1bfa87d380 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Mar 2021 10:59:29
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 625ACC433ED; Tue,  9 Mar 2021 10:59:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 194E3C433CA;
        Tue,  9 Mar 2021 10:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 194E3C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH V5 2/2] ath11k: add debugfs for TWT debug calls
References: <20210222192651.1782-1-alokad@codeaurora.org>
        <20210222192651.1782-3-alokad@codeaurora.org>
Date:   Tue, 09 Mar 2021 12:59:25 +0200
In-Reply-To: <20210222192651.1782-3-alokad@codeaurora.org> (Aloka Dixit's
        message of "Mon, 22 Feb 2021 11:26:51 -0800")
Message-ID: <87o8fszj76.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <alokad@codeaurora.org> writes:

> From: John Crispin <john@phrozen.org>
>
> New debugfs files to manually add/delete/pause/resume TWT
> dialogs for test/debug purposes.
>
> The debugfs files expect the following parameters
> (1) Add dialog
> echo '<Peer_MAC> <Dialog_ID> <Wake_Interval_Usec> <Wake_Interval_Mantis>
> <Wake_Duration_Usec> <First_SP_Offset> <TWT_Command> <1:Broadcast /
> 0:Individual> <1:Triggered / 0:Untriggered> <1:Unannounced /
> 0:Announced> <1:Protected / 0:Unprotected>' >
> /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/twt/add_dialog
>
> Example (Non-triggered and un-announced):
> echo '00:03:7F:20:13:52 1 102400 100 30720 20480 4 0 0 1 0' >
> /sys/kernel/debug/ieee80211/phy0/netdev:wlan0/twt/add_dialog
>
> (2) Delete dialog
> echo '<Peer_MAC> <Dialog_ID>' >
> /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/twt/del_dialog
>
> (3) Pause dialog
> echo '<Peer_MAC> <Dialog_ID>' >
> /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/twt/pause_dialog
>
> (4) Resume dialog
> echo '<Peer_MAC> <Dialog_ID> <SP_Offset_Usec> <Next_TWT_Size>' >
> /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/twt/resume_dialog
>
> Example:
> echo '00:03:7F:20:13:52 1 2000000 3' >
> /sys/kernel/debug/ieee80211/phy0/netdev:wlan0/twt/resume_dialog
>
> Signed-off-by: John Crispin <john@phrozen.org>
> Co-developed-by: Aloka Dixit <alokad@codeaurora.org>
> Signed-off-by: Aloka Dixit <alokad@codeaurora.org>

[...]

> --- a/drivers/net/wireless/ath/ath11k/debug.c
> +++ b/drivers/net/wireless/ath/ath11k/debug.c
> @@ -104,3 +104,227 @@ void ath11k_dbg_dump(struct ath11k_base *ab,
>  EXPORT_SYMBOL(ath11k_dbg_dump);
>  
>  #endif /* CONFIG_ATH11K_DEBUG */
> +
> +#ifdef CONFIG_ATH11K_DEBUGFS
> +static ssize_t ath11k_write_twt_add_dialog(struct file *file,
> +					   const char __user *ubuf,
> +					   size_t count, loff_t *ppos)
> +{
> +	struct ath11k_vif *arvif = file->private_data;
> +	struct wmi_twt_add_dialog_params params = { 0 };
> +	u8 buf[128] = {0};
> +	int ret;
> +
> +	if (arvif->ar->twt_enabled == 0) {
> +		ath11k_err(arvif->ar->ab, "TWT support is not enabled\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
> +	if (ret < 0)
> +		return ret;
> +
> +	buf[ret] = '\0';
> +	ret = sscanf(buf,
> +		     "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx %u %u %u %u %u %hhu %hhu %hhu %hhu %hhu",
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
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t ath11k_write_twt_del_dialog(struct file *file,
> +					   const char __user *ubuf,
> +					   size_t count, loff_t *ppos)
> +{
> +	struct ath11k_vif *arvif = file->private_data;
> +	struct wmi_twt_del_dialog_params params = { 0 };
> +	u8 buf[64] = {0};
> +	int ret;
> +
> +	if (arvif->ar->twt_enabled == 0) {
> +		ath11k_err(arvif->ar->ab, "TWT support is not enabled\n");
> +		return -EOPNOTSUPP;
> +	}
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
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t ath11k_write_twt_pause_dialog(struct file *file,
> +					     const char __user *ubuf,
> +					     size_t count, loff_t *ppos)
> +{
> +	struct ath11k_vif *arvif = file->private_data;
> +	struct wmi_twt_pause_dialog_params params = { 0 };
> +	u8 buf[64] = {0};
> +	int ret;
> +
> +	if (arvif->ar->twt_enabled == 0) {
> +		ath11k_err(arvif->ar->ab, "TWT support is not enabled\n");
> +		return -EOPNOTSUPP;
> +	}
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
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t ath11k_write_twt_resume_dialog(struct file *file,
> +					      const char __user *ubuf,
> +					      size_t count, loff_t *ppos)
> +{
> +	struct ath11k_vif *arvif = file->private_data;
> +	struct wmi_twt_resume_dialog_params params = { 0 };
> +	u8 buf[64] = {0};
> +	int ret;
> +
> +	if (arvif->ar->twt_enabled == 0) {
> +		ath11k_err(arvif->ar->ab, "TWT support is not enabled\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
> +	if (ret < 0)
> +		return ret;
> +
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
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static const struct file_operations ath11k_fops_twt_add_dialog = {
> +	.write = ath11k_write_twt_add_dialog,
> +	.open = simple_open
> +};
> +
> +static const struct file_operations ath11k_fops_twt_del_dialog = {
> +	.write = ath11k_write_twt_del_dialog,
> +	.open = simple_open
> +};
> +
> +static const struct file_operations ath11k_fops_twt_pause_dialog = {
> +	.write = ath11k_write_twt_pause_dialog,
> +	.open = simple_open
> +};
> +
> +static const struct file_operations ath11k_fops_twt_resume_dialog = {
> +	.write = ath11k_write_twt_resume_dialog,
> +	.open = simple_open
> +};
> +
> +void ath11k_debugfs_add_interface(struct ath11k_vif *arvif)
> +{
> +	if (arvif->vif->type == NL80211_IFTYPE_AP && !arvif->debugfs_twt) {
> +		arvif->debugfs_twt = debugfs_create_dir("twt",
> +							arvif->vif->debugfs_dir);
> +		if (IS_ERR_OR_NULL(arvif->debugfs_twt)) {
> +			ath11k_warn(arvif->ar->ab,
> +				    "failed to create twt debugfs: %p\n",
> +				    arvif->debugfs_twt);
> +			arvif->debugfs_twt = NULL;
> +			return;
> +		}
> +
> +		debugfs_create_file("add_dialog", 0200, arvif->debugfs_twt,
> +				    arvif, &ath11k_fops_twt_add_dialog);
> +
> +		debugfs_create_file("del_dialog", 0200, arvif->debugfs_twt,
> +				    arvif, &ath11k_fops_twt_del_dialog);
> +
> +		debugfs_create_file("pause_dialog", 0200, arvif->debugfs_twt,
> +				    arvif, &ath11k_fops_twt_pause_dialog);
> +
> +		debugfs_create_file("resume_dialog", 0200, arvif->debugfs_twt,
> +				    arvif, &ath11k_fops_twt_resume_dialog);
> +	}
> +}
> +
> +void ath11k_debugfs_remove_interface(struct ath11k_vif *arvif)
> +{
> +	debugfs_remove_recursive(arvif->debugfs_twt);
> +	arvif->debugfs_twt = NULL;
> +}
> +
> +#endif /* CONFIG_ATH11K_DEBUGFS */

Shouldn't these functions be in debugfs.c?

> diff --git a/drivers/net/wireless/ath/ath11k/debug.h b/drivers/net/wireless/ath/ath11k/debug.h
> index 659a275e2eb3..2b41cefb68b5 100644
> --- a/drivers/net/wireless/ath/ath11k/debug.h
> +++ b/drivers/net/wireless/ath/ath11k/debug.h
> @@ -64,4 +64,17 @@ do {								\
>  		__ath11k_dbg(ar, dbg_mask, fmt, ##__VA_ARGS__);	\
>  } while (0)
>  
> +#ifdef CONFIG_ATH11K_DEBUGFS
> +void ath11k_debugfs_add_interface(struct ath11k_vif *arvif);
> +void ath11k_debugfs_remove_interface(struct ath11k_vif *arvif);
> +#else /* CONFIG_ATH11K_DEBUGFS */
> +static inline void ath11k_debugfs_add_interface(struct ath11k_vif *arvif)
> +{
> +}
> +
> +static inline void ath11k_debugfs_remove_interface(struct ath11k_vif *arvif)
> +{
> +}
> +#endif /* CONFIG_ATH11K_DEBUGFS */

And these in debugfs.h?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
