Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2FB7EA830
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Nov 2023 02:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjKNB10 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 20:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKNB1Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 20:27:25 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D828A115
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 17:27:21 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADNcuPn025820;
        Tue, 14 Nov 2023 01:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8oOnmGcddUvxzGMjMZyFcFuv06vbCd3bpzZpzC5bMMI=;
 b=LUClkjZ3+K1xhK9riG2CX4DsZM7rwIHpbeHCB1Jfrrvs+nwRK5vf/1UK/SSJzR+lRlsz
 qjWN3C8o9zACBDTiuY8x/ENLNmlZXAnHj6rSxCdZscSBfEKGRmg0EKNT2YFGrv5aYgO3
 b6nG3yrpmLyAp2YsTB5+KEVQVyh85mNUbDVQYrrkHpDb0vHu/FFNrt8azpUXYt9TukRU
 1hZlypjiEkFMQaXFgN2J8RlgX8NSAl6iESnNRl21KUFjPqpPYecryakmVmpSVA2zYHIV
 ZKMQ1zQcG3PVrX8PYotMGjMKhdkoIgJj92aHwNDldDu0qBcFm/xKyYOo6C8c3R+b7o+q lA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ubqvt8wr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 01:26:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AE1Qto0003847
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 01:26:55 GMT
Received: from [10.71.114.194] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 13 Nov
 2023 17:26:55 -0800
Message-ID: <e0df4f22-c867-410b-8868-5a8f2e55f9c6@quicinc.com>
Date:   Mon, 13 Nov 2023 17:26:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/8] bus: mhi: host: add mhi_power_down_no_destroy()
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <mhi@lists.linux.dev>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20231110102202.3168243-1-kvalo@kernel.org>
 <20231110102202.3168243-2-kvalo@kernel.org>
From:   Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <20231110102202.3168243-2-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VHZ3YcRt_eme5UcZo6hPXdqLfu9fn7wt
X-Proofpoint-GUID: VHZ3YcRt_eme5UcZo6hPXdqLfu9fn7wt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_01,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1011 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/10/2023 2:21 AM, Kalle Valo wrote:
> From: Baochen Qiang <quic_bqiang@quicinc.com>
> 
> If ath11k tries to call mhi_power_up() during resume it fails:
> 
> ath11k_pci 0000:06:00.0: timeout while waiting for restart complete
> 
> This happens because when calling mhi_power_up() the MHI subsystem eventually
> calls device_add() from mhi_create_devices() but the device creation is
> deferred:
> 
> mhi mhi0_IPCR: Driver qcom_mhi_qrtr force probe deferral
> 
> The reason for deferring device creation is explained in dpm_prepare():
> 
> 	/*
> 	 * It is unsafe if probing of devices will happen during suspend or
> 	 * hibernation and system behavior will be unpredictable in this case.
> 	 * So, let's prohibit device's probing here and defer their probes
> 	 * instead. The normal behavior will be restored in dpm_complete().
> 	 */
have you consider registering for pm_notifier callback specifically for 
PM_POST_HIBERNATION (Documentation/power/notifiers.txt), and then making 
decision of calling MHI power up sequence which would make sure that 
created device based driver probe() is completed.
> 
> Because the device probe is deferred, the qcom_mhi_qrtr_probe() is not called and
> qcom_mhi_qrtr_dl_callback() fails silently as qdev is zero:
> 
> static void qcom_mhi_qrtr_dl_callback(struct mhi_device *mhi_dev,
> 				      struct mhi_result *mhi_res)
> {
> 	struct qrtr_mhi_dev *qdev = dev_get_drvdata(&mhi_dev->dev);
> 	int rc;
> 
> 	if (!qdev || mhi_res->transaction_status)
> 		return;
> 
> So what this means that QRTR is not delivering messages and the QMI connection
> is not working between ath11k and the firmware, resulting a failure in firmware
> initialisation.
> 
> To fix this add new function mhi_power_down_no_destroy() which does not destroy
> the devices during power down. This way mhi_power_up() can be called during
> resume and we can get ath11k hibernation working with the following patches.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>   drivers/bus/mhi/host/internal.h |  1 +
>   drivers/bus/mhi/host/pm.c       | 26 +++++++++++++++++++-------
>   include/linux/mhi.h             | 29 +++++++++++++++++++++++++++--
>   3 files changed, 47 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
> index 2e139e76de4c..d1033af285e2 100644
> --- a/drivers/bus/mhi/host/internal.h
> +++ b/drivers/bus/mhi/host/internal.h
> @@ -69,6 +69,7 @@ enum dev_st_transition {
>   	DEV_ST_TRANSITION_FP,
>   	DEV_ST_TRANSITION_SYS_ERR,
>   	DEV_ST_TRANSITION_DISABLE,
> +	DEV_ST_TRANSITION_DISABLE_DESTROY_DEVICE,
>   	DEV_ST_TRANSITION_MAX,
>   };
>   
> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
> index 8a4362d75fc4..e0e429adbda6 100644
> --- a/drivers/bus/mhi/host/pm.c
> +++ b/drivers/bus/mhi/host/pm.c
> @@ -453,7 +453,8 @@ static int mhi_pm_mission_mode_transition(struct mhi_controller *mhi_cntrl)
>   }
>   
>   /* Handle shutdown transitions */
> -static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
> +static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
> +				      bool destroy_device)
>   {
>   	enum mhi_pm_state cur_state;
>   	struct mhi_event *mhi_event;
> @@ -515,8 +516,10 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
>   	dev_dbg(dev, "Waiting for all pending threads to complete\n");
>   	wake_up_all(&mhi_cntrl->state_event);
>   
> -	dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
> -	device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_destroy_device);
> +	if (destroy_device) {
> +		dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
> +		device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_destroy_device);
> +	}
>   
>   	mutex_lock(&mhi_cntrl->pm_mutex);
>   
> @@ -801,7 +804,10 @@ void mhi_pm_st_worker(struct work_struct *work)
>   			mhi_pm_sys_error_transition(mhi_cntrl);
>   			break;
>   		case DEV_ST_TRANSITION_DISABLE:
> -			mhi_pm_disable_transition(mhi_cntrl);
> +			mhi_pm_disable_transition(mhi_cntrl, false);
> +			break;
> +		case DEV_ST_TRANSITION_DISABLE_DESTROY_DEVICE:
> +			mhi_pm_disable_transition(mhi_cntrl, true);
>   			break;
>   		default:
>   			break;
> @@ -1154,7 +1160,8 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>   }
>   EXPORT_SYMBOL_GPL(mhi_async_power_up);
>   
> -void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
> +void __mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful,
> +		      bool destroy_device)
>   {
>   	enum mhi_pm_state cur_state, transition_state;
>   	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> @@ -1190,14 +1197,19 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
>   	write_unlock_irq(&mhi_cntrl->pm_lock);
>   	mutex_unlock(&mhi_cntrl->pm_mutex);
>   
> -	mhi_queue_state_transition(mhi_cntrl, DEV_ST_TRANSITION_DISABLE);
> +	if (destroy_device)
> +		mhi_queue_state_transition(mhi_cntrl,
> +					   DEV_ST_TRANSITION_DISABLE_DESTROY_DEVICE);
> +	else
> +		mhi_queue_state_transition(mhi_cntrl,
> +					   DEV_ST_TRANSITION_DISABLE);
>   
>   	/* Wait for shutdown to complete */
>   	flush_work(&mhi_cntrl->st_worker);
>   
>   	disable_irq(mhi_cntrl->irq[0]);
>   }
> -EXPORT_SYMBOL_GPL(mhi_power_down);
> +EXPORT_SYMBOL_GPL(__mhi_power_down);
>   
>   int mhi_sync_power_up(struct mhi_controller *mhi_cntrl)
>   {
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index 039943ec4d4e..85edc9c5df88 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -644,12 +644,37 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl);
>    */
>   int mhi_sync_power_up(struct mhi_controller *mhi_cntrl);
>   
> +void __mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful,
> +		    bool destroy_device);
> +
>   /**
> - * mhi_power_down - Start MHI power down sequence
> + * mhi_power_down - Start MHI power down sequence. See also
> + * mhi_power_down_no_destroy() which is a variant of this for suspend.
> + *
>    * @mhi_cntrl: MHI controller
>    * @graceful: Link is still accessible, so do a graceful shutdown process
>    */
> -void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful);
> +static inline void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
> +{
> +	__mhi_power_down(mhi_cntrl, graceful, true);
> +}
> +
> +/**
> + * mhi_power_down_no_destroy - Start MHI power down sequence but don't
> + * destroy struct devices. This is a variant for mhi_power_down() and is a
> + * workaround to make it possible to use mhi_power_up() in a resume
> + * handler. When using this variant the caller must also call
> + * mhi_prepare_all_for_transfer_autoqueue() and
> + * mhi_unprepare_all_from_transfer().
> + *
> + * @mhi_cntrl: MHI controller
> + * @graceful: Link is still accessible, so do a graceful shutdown process
> + */
> +static inline void mhi_power_down_no_destroy(struct mhi_controller *mhi_cntrl,
> +					     bool graceful)
> +{
> +	__mhi_power_down(mhi_cntrl, graceful, false);
> +}
>   
>   /**
>    * mhi_unprepare_after_power_down - Free any allocated memory after power down
