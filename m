Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936E24C4E2A
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Feb 2022 19:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiBYS6T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Feb 2022 13:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiBYS6S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Feb 2022 13:58:18 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D126560DA4
        for <linux-wireless@vger.kernel.org>; Fri, 25 Feb 2022 10:57:43 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so7551177ooi.2
        for <linux-wireless@vger.kernel.org>; Fri, 25 Feb 2022 10:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lOZZLfUBaLgR1tDlA9UZVnfZuVriO9rHfgOVrr6rkVc=;
        b=mcK7Ew/RG7DEXNW0CrXb0kbYaQfwTOZKFZrtQuyWY8nJDLrw5i1Cx2MJMoYC10LEfI
         BiDjDaRgDfEex7h+YQPEVcYYq/BGeNg6qOBaC3imIZq/V6d7wFc+q66Eyw5yL3x8NeiX
         rfqr+IsTHbhPDUswyfOLxvfbk9DnxZlbrAntClWW7aRS0oyJbaOADlPcAF3hsRTzW272
         broaJ6y9LnnZCuUa4mq4GcA3zmmhbZzJLoaZLWvVPhMqopt5DpRDu9lIQLhE4fJ1C4x/
         tb9wyhG4DZicfgl5U60nTlrzZoeVzY3OR6CfSKUj71lBtqV6CrzreKAqzt7iGcZur+0S
         6mlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lOZZLfUBaLgR1tDlA9UZVnfZuVriO9rHfgOVrr6rkVc=;
        b=uvMtlKmnkWoQfiJccB2tmbbUyDWp3dqtIgXqEMQ/VN0PSfu1vZfb5ZOL8Z1Iu7HDrO
         07186xXsz51OvhQmD1/4WaCzE7szNuTBY6rMKrw+m4cem8lsLTGf5EJ6W2s/haroBNgZ
         1To8z+WhPStOFqw1NdguYKv4pXyIGwMvQ70gLdKS8vWT+NmKmqvT8fVSQwsJeOxpboub
         w1Y9d++JsQISTwJquyHvjKo5jaeHt5SXrLh49xBMetq7cSK6n5y42Yl3srSs/9ki1MN+
         iNuTKBw0ZSlHa7d2LZJn2hrDe9fL00hJugVWlqNKHeQGtAXnPJTKJU6/E7D3g0PuRQFi
         FrPg==
X-Gm-Message-State: AOAM531Poo1rH2uqmM5ayj3bFXzy2rW3M4fqjkN57Vi2dV8VWy71NgmD
        WYSbhB4LNmgTzbOxIdoroug=
X-Google-Smtp-Source: ABdhPJzrt/jUWwIU5iOlT9W47rPXSMbAuJ2j94GO4kd9E5rLFA7+5xdJZZ6f+kRUiVXpPTM+O+GaiQ==
X-Received: by 2002:a05:6870:6014:b0:d6:ca51:2108 with SMTP id t20-20020a056870601400b000d6ca512108mr2031565oaa.47.1645815463057;
        Fri, 25 Feb 2022 10:57:43 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c8-20020a4ad788000000b0031ce69b1640sm1397904oou.10.2022.02.25.10.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 10:57:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 25 Feb 2022 10:57:41 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v7 1/4] ath11k: add support for device recovery for
 QCA6390/WCN6855
Message-ID: <20220225185741.GA2895319@roeck-us.net>
References: <20220225084548.19534-1-quic_wgong@quicinc.com>
 <20220225084548.19534-2-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225084548.19534-2-quic_wgong@quicinc.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Feb 25, 2022 at 03:45:45AM -0500, Wen Gong wrote:
> Currently ath11k has device recovery logic, it is introduced by this
> patch "ath11k: Add support for subsystem recovery" which is upstream
> by https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=ath11k-bringup&id=3a7b4838b6f6f234239f263ef3dc02e612a083ad.
> 
> The patch is for AHB devices such as IPQ8074, it has remote proc module
> which is used to download the firmware and boots the processor which
> firmware is running on. If firmware crashed, remote proc module will
> detect it and download and boot firmware again. Below command will
> trigger a firmware crash, and then user can test feature of device
> recovery.
> 
> Test command:
> echo assert > /sys/kernel/debug/ath11k/qca6390\ hw2.0/simulate_fw_crash
> echo assert > /sys/kernel/debug/ath11k/wcn6855\ hw2.0/simulate_fw_crash
> 
> Unfortunately, QCA6390 is PCIe bus, it does not have the remote proc
> module, it use mhi module to communicate between firmware and ath11k.
> So ath11k does not support device recovery for QCA6390 currently.
> 
> This patch is to add the extra logic which is different for QCA6390.
> When firmware crashed, MHI_CB_EE_RDDM event will be indicate by
> firmware and then ath11k_mhi_op_status_cb which is the callback of
> mhi_controller will receive the MHI_CB_EE_RDDM event, then ath11k
> will start to do recovery process, ath11k_core_reset() calls
> ath11k_hif_power_down()/ath11k_hif_power_up(), then the mhi/ath11k
> will start to download and boot firmware. There are some logic to
> avoid deadloop recovery and two simultaneous recovery operations.
> And because it has muti-radios for the soc, so it add some logic
> in ath11k_mac_op_reconfig_complete() to make sure all radios has
> reconfig complete and then complete the device recovery.
> 
> Also it add workqueue_aux, because ab->workqueue is used when receive
> ATH11K_QMI_EVENT_FW_READY in recovery process(queue_work(ab->workqueue,
> &ab->restart_work)), and ath11k_core_reset will wait for max
> ATH11K_RESET_TIMEOUT_HZ for the previous restart_work finished, if
> ath11k_core_reset also queued in ab->workqueue, then it will delay
> restart_work of previous recovery and lead previous recovery fail.
> 
> ath11k recovery success for QCA6390/WCN6855 after apply this patch.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03003-QCAHSPSWPL_V1_V2_SILICONZ_LITE-2
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 70 ++++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/core.h | 13 +++++
>  drivers/net/wireless/ath/ath11k/mac.c  | 18 +++++++
>  drivers/net/wireless/ath/ath11k/mhi.c  | 33 ++++++++++++
>  4 files changed, 134 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 7c508e9baa6d..00c83fdb0702 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -1342,6 +1342,65 @@ static void ath11k_core_restart(struct work_struct *work)
>  	complete(&ab->driver_recovery);
>  }
>  
> +static void ath11k_core_reset(struct work_struct *work)
> +{
> +	struct ath11k_base *ab = container_of(work, struct ath11k_base, reset_work);
> +	int reset_count, fail_cont_count;
> +	long time_left;
> +
> +	if (!(test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))) {
> +		ath11k_warn(ab, "ignore reset dev flags 0x%lx\n", ab->dev_flags);
> +		return;
> +	}
> +
> +	/* Sometimes the recovery will fail and then the next all recovery fail,
> +	 * this is to avoid infinite recovery since it can not recovery success.
> +	 */
> +	fail_cont_count = atomic_read(&ab->fail_cont_count);
> +
> +	if (fail_cont_count >= ATH11K_RESET_MAX_FAIL_COUNT_FINAL)
> +		return;
> +
> +	if (fail_cont_count >= ATH11K_RESET_MAX_FAIL_COUNT_FIRST &&
> +	    time_before(jiffies, ab->reset_fail_timeout))
> +		return;
> +
> +	reset_count = atomic_inc_return(&ab->reset_count);
> +
> +	if (reset_count > 1) {
> +		/* Sometimes it happened another reset worker before the previous one
> +		 * completed, then the second reset worker will destroy the previous one,
> +		 * thus below is to avoid that.
> +		 */
> +		ath11k_warn(ab, "already reseting count %d\n", reset_count);
> +
> +		reinit_completion(&ab->reset_complete);
> +		time_left = wait_for_completion_timeout(&ab->reset_complete,
> +							ATH11K_RESET_TIMEOUT_HZ);
> +
> +		if (time_left) {
> +			ath11k_dbg(ab, ATH11K_DBG_BOOT, "to skip reset\n");
> +			atomic_dec(&ab->reset_count);
> +			return;
> +		}
> +
> +		ab->reset_fail_timeout = jiffies + ATH11K_RESET_FAIL_TIMEOUT_HZ;
> +		/* Record the continuous recovery fail count when recovery failed*/
> +		fail_cont_count = atomic_inc_return(&ab->fail_cont_count);

This results in a compiler warning because fail_cont_count is not used
afterwards. I would suggest to replace the statement with

		atomic_inc(&ab->fail_cont_count);

Guenter

> +	}
> +
> +	ath11k_dbg(ab, ATH11K_DBG_BOOT, "reset starting\n");
> +
> +	ab->is_reset = true;
> +	atomic_set(&ab->recovery_count, 0);
> +
> +	ath11k_hif_power_down(ab);
> +	ath11k_qmi_free_resource(ab);
> +	ath11k_hif_power_up(ab);
> +
> +	ath11k_dbg(ab, ATH11K_DBG_BOOT, "reset started\n");
> +}
> +
>  static int ath11k_init_hw_params(struct ath11k_base *ab)
>  {
>  	const struct ath11k_hw_params *hw_params = NULL;
> @@ -1411,6 +1470,9 @@ EXPORT_SYMBOL(ath11k_core_deinit);
>  
>  void ath11k_core_free(struct ath11k_base *ab)
>  {
> +	flush_workqueue(ab->workqueue_aux);
> +	destroy_workqueue(ab->workqueue_aux);
> +
>  	flush_workqueue(ab->workqueue);
>  	destroy_workqueue(ab->workqueue);
>  
> @@ -1434,9 +1496,14 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
>  	if (!ab->workqueue)
>  		goto err_sc_free;
>  
> +	ab->workqueue_aux = create_singlethread_workqueue("ath11k_aux_wq");
> +	if (!ab->workqueue_aux)
> +		goto err_free_wq;
> +
>  	mutex_init(&ab->core_lock);
>  	spin_lock_init(&ab->base_lock);
>  	mutex_init(&ab->vdev_id_11d_lock);
> +	init_completion(&ab->reset_complete);
>  
>  	INIT_LIST_HEAD(&ab->peers);
>  	init_waitqueue_head(&ab->peer_mapping_wq);
> @@ -1445,6 +1512,7 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
>  	INIT_WORK(&ab->restart_work, ath11k_core_restart);
>  	INIT_WORK(&ab->update_11d_work, ath11k_update_11d);
>  	INIT_WORK(&ab->rfkill_work, ath11k_rfkill_work);
> +	INIT_WORK(&ab->reset_work, ath11k_core_reset);
>  	timer_setup(&ab->rx_replenish_retry, ath11k_ce_rx_replenish_retry, 0);
>  	init_completion(&ab->htc_suspend);
>  	init_completion(&ab->wow.wakeup_completed);
> @@ -1455,6 +1523,8 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
>  
>  	return ab;
>  
> +err_free_wq:
> +	destroy_workqueue(ab->workqueue);
>  err_sc_free:
>  	kfree(ab);
>  	return NULL;
> diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
> index d2fc7a7a98f4..c85301e3609b 100644
> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -39,6 +39,10 @@
>  extern unsigned int ath11k_frame_mode;
>  
>  #define ATH11K_MON_TIMER_INTERVAL  10
> +#define ATH11K_RESET_TIMEOUT_HZ (20 * HZ)
> +#define ATH11K_RESET_MAX_FAIL_COUNT_FIRST 3
> +#define ATH11K_RESET_MAX_FAIL_COUNT_FINAL 5
> +#define ATH11K_RESET_FAIL_TIMEOUT_HZ (20 * HZ)
>  
>  enum ath11k_supported_bw {
>  	ATH11K_BW_20	= 0,
> @@ -787,6 +791,15 @@ struct ath11k_base {
>  	struct work_struct restart_work;
>  	struct work_struct update_11d_work;
>  	u8 new_alpha2[3];
> +	struct workqueue_struct *workqueue_aux;
> +	struct work_struct reset_work;
> +	atomic_t reset_count;
> +	atomic_t recovery_count;
> +	bool is_reset;
> +	struct completion reset_complete;
> +	/* continuous recovery fail count */
> +	atomic_t fail_cont_count;
> +	unsigned long reset_fail_timeout;
>  	struct {
>  		/* protected by data_lock */
>  		u32 fw_crash_counter;
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index d5b83f90d27a..5c62faf359a9 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -7881,6 +7881,8 @@ ath11k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
>  				enum ieee80211_reconfig_type reconfig_type)
>  {
>  	struct ath11k *ar = hw->priv;
> +	struct ath11k_base *ab = ar->ab;
> +	int recovery_count;
>  
>  	if (reconfig_type != IEEE80211_RECONFIG_TYPE_RESTART)
>  		return;
> @@ -7892,6 +7894,22 @@ ath11k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
>  			    ar->pdev->pdev_id);
>  		ar->state = ATH11K_STATE_ON;
>  		ieee80211_wake_queues(ar->hw);
> +
> +		if (ab->is_reset) {
> +			recovery_count = atomic_inc_return(&ab->recovery_count);
> +			ath11k_dbg(ab, ATH11K_DBG_BOOT,
> +				   "recovery count %d\n", recovery_count);
> +			/* When there are multiple radios in an SOC,
> +			 * the recovery has to be done for each radio
> +			 */
> +			if (recovery_count == ab->num_radios) {
> +				atomic_dec(&ab->reset_count);
> +				complete(&ab->reset_complete);
> +				ab->is_reset = false;
> +				atomic_set(&ab->fail_cont_count, 0);
> +				ath11k_dbg(ab, ATH11K_DBG_BOOT, "reset success\n");
> +			}
> +		}
>  	}
>  
>  	mutex_unlock(&ar->conf_mutex);
> diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
> index fc3524e83e52..61d83be4841f 100644
> --- a/drivers/net/wireless/ath/ath11k/mhi.c
> +++ b/drivers/net/wireless/ath/ath11k/mhi.c
> @@ -292,15 +292,48 @@ static void ath11k_mhi_op_runtime_put(struct mhi_controller *mhi_cntrl)
>  {
>  }
>  
> +static char *ath11k_mhi_op_callback_to_str(enum mhi_callback reason)
> +{
> +	switch (reason) {
> +	case MHI_CB_IDLE:
> +		return "MHI_CB_IDLE";
> +	case MHI_CB_PENDING_DATA:
> +		return "MHI_CB_PENDING_DATA";
> +	case MHI_CB_LPM_ENTER:
> +		return "MHI_CB_LPM_ENTER";
> +	case MHI_CB_LPM_EXIT:
> +		return "MHI_CB_LPM_EXIT";
> +	case MHI_CB_EE_RDDM:
> +		return "MHI_CB_EE_RDDM";
> +	case MHI_CB_EE_MISSION_MODE:
> +		return "MHI_CB_EE_MISSION_MODE";
> +	case MHI_CB_SYS_ERROR:
> +		return "MHI_CB_SYS_ERROR";
> +	case MHI_CB_FATAL_ERROR:
> +		return "MHI_CB_FATAL_ERROR";
> +	case MHI_CB_BW_REQ:
> +		return "MHI_CB_BW_REQ";
> +	default:
> +		return "UNKNOWN";
> +	}
> +};
> +
>  static void ath11k_mhi_op_status_cb(struct mhi_controller *mhi_cntrl,
>  				    enum mhi_callback cb)
>  {
>  	struct ath11k_base *ab = dev_get_drvdata(mhi_cntrl->cntrl_dev);
>  
> +	ath11k_dbg(ab, ATH11K_DBG_BOOT, "mhi notify status reason %s\n",
> +		   ath11k_mhi_op_callback_to_str(cb));
> +
>  	switch (cb) {
>  	case MHI_CB_SYS_ERROR:
>  		ath11k_warn(ab, "firmware crashed: MHI_CB_SYS_ERROR\n");
>  		break;
> +	case MHI_CB_EE_RDDM:
> +		if (!(test_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags)))
> +			queue_work(ab->workqueue_aux, &ab->reset_work);
> +		break;
>  	default:
>  		break;
>  	}
