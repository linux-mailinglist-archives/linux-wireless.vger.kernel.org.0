Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53D37E03D8
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Nov 2023 14:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjKCNlZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Nov 2023 09:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKCNlY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Nov 2023 09:41:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA4F1B2
        for <linux-wireless@vger.kernel.org>; Fri,  3 Nov 2023 06:41:18 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3CuuY1016386;
        Fri, 3 Nov 2023 13:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XrFp0PV1x6kZa0SPBEXz3dOh/rhS8QLympQiYCB8DUk=;
 b=EunpgQmh1Lvtv5aKG3z+9OQ6pljYUVsDWG/C1c7Tek/2mZyS7SFUv/FlN/P/010y/SA6
 ktzNo71/cFdnHhV4ldHekTZ4mfyeKr8zToeWkvd/xxSBW3LomtZ0xaXs67ZE+mZGPRKE
 C5ZFdSlIVOGZjpC4eqPi/Qx+AQON0VR0LKDeeXmwE+I5yvRSHb4qWZXmtHvODIIWitip
 gBOfyg3ZNu7LVeRfu2L7K5rsm4HUV77X8O0dJq2kxRg6SeESVSO7Dt7nese5Hj0FsoRJ
 LNOtB3dGLzUrTdYcRUP/ue+LqRSSeoH9by+L1bz6wo7Zc3RiMiGv5osjOGOIZZuIJrkC +A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u4wmjgjp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 13:41:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A3DfArC009480
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Nov 2023 13:41:10 GMT
Received: from [10.110.70.214] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 3 Nov
 2023 06:41:09 -0700
Message-ID: <9d108ead-8871-40ec-88bc-12f185b7688a@quicinc.com>
Date:   Fri, 3 Nov 2023 06:41:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] wifi: ath12k: add factory test mode support
Content-Language: en-US
To:     Aaradhana Sahu <quic_aarasahu@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231103093746.24146-1-quic_aarasahu@quicinc.com>
 <20231103093746.24146-4-quic_aarasahu@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231103093746.24146-4-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mV6AT8d5lNBjsNlu2intoKSzapbMVfbq
X-Proofpoint-GUID: mV6AT8d5lNBjsNlu2intoKSzapbMVfbq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030114
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/3/2023 2:37 AM, Aaradhana Sahu wrote:
> Add support to process factory test mode commands(FTM) for calibration.
> By default firmware start with MISSION mode and to process the FTM commands
> firmware needs to be restarted in FTM mode using module parameter ftm_mode.
> The pre-request is all the radios should be down before starting the test.
> 
> All ath12k test mode interface related commands specified in enum
> ath_tm_cmd.
> 
> When start command ATH_TM_CMD_TESTMODE_START is received, ar state
> is set to test Mode and FTM daemon sends test mode command to wifi
> driver via cfg80211. Wifi driver sends these command to firmware as
> wmi events. If it is segmented commands it will be broken down into
> multiple segments and encoded with TLV header else it is sent to
> firmware as it is.
> 
> Firmware response via UTF events, wifi driver creates skb and send
> to cfg80211, cfg80211 sends firmware response to FTM daemon via
> netlink message.
> 
> Command to boot in ftm mode
> insmod ath12k ftm_mode=1
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00126-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/Makefile   |   1 +
>   drivers/net/wireless/ath/ath12k/core.c     |  19 +-
>   drivers/net/wireless/ath/ath12k/core.h     |  13 +
>   drivers/net/wireless/ath/ath12k/debug.h    |   1 +
>   drivers/net/wireless/ath/ath12k/dp.c       |   3 +
>   drivers/net/wireless/ath/ath12k/mac.c      |  13 +-
>   drivers/net/wireless/ath/ath12k/pci.c      |   1 +
>   drivers/net/wireless/ath/ath12k/testmode.c | 406 +++++++++++++++++++++
>   drivers/net/wireless/ath/ath12k/testmode.h |  42 +++
>   drivers/net/wireless/ath/ath12k/wmi.c      |  34 ++
>   drivers/net/wireless/ath/ath12k/wmi.h      |  20 +
>   11 files changed, 549 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
>   create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
> 
> diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
> index 62c52e733b5e..20bfa824370e 100644
> --- a/drivers/net/wireless/ath/ath12k/Makefile
> +++ b/drivers/net/wireless/ath/ath12k/Makefile
> @@ -22,6 +22,7 @@ ath12k-y += core.o \
>   	    dp_mon.o
>   
>   ath12k-$(CONFIG_ATH12K_TRACING) += trace.o
> +ath12k-$(CONFIG_NL80211_TESTMODE) += testmode.o
>   
>   # for tracing framework to find trace.h
>   CFLAGS_trace.o := -I$(src)
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index b936760b5140..9351b55a65fb 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -40,6 +40,10 @@ static int ath12k_core_rfkill_config(struct ath12k_base *ab)
>   	return ret;
>   }
>   
> +bool ath12k_ftm_mode;
> +module_param_named(ftm_mode, ath12k_ftm_mode, bool, 0444);
> +MODULE_PARM_DESC(ftm_mode, "Boots up in factory test mode");
> +
>   int ath12k_core_suspend(struct ath12k_base *ab)
>   {
>   	int ret;
> @@ -472,6 +476,11 @@ static int ath12k_core_soc_create(struct ath12k_base *ab)
>   {
>   	int ret;
>   
> +	if (ath12k_ftm_mode) {
> +		ab->fw_mode = ATH12K_FIRMWARE_MODE_FTM;
> +		ath12k_info(ab, "Booting in ftm mode\n");
> +	}
> +
>   	ret = ath12k_qmi_init_service(ab);
>   	if (ret) {
>   		ath12k_err(ab, "failed to initialize qmi :%d\n", ret);
> @@ -663,7 +672,7 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
>   {
>   	int ret;
>   
> -	ret = ath12k_core_start_firmware(ab, ATH12K_FIRMWARE_MODE_NORMAL);
> +	ret = ath12k_core_start_firmware(ab, ab->fw_mode);
>   	if (ret) {
>   		ath12k_err(ab, "failed to start firmware: %d\n", ret);
>   		return ret;
> @@ -682,7 +691,7 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
>   	}
>   
>   	mutex_lock(&ab->core_lock);
> -	ret = ath12k_core_start(ab, ATH12K_FIRMWARE_MODE_NORMAL);
> +	ret = ath12k_core_start(ab, ab->fw_mode);

suggest you drop the 2nd param and just let ath12k_core_start() retrieve 
ab->fw_mode

>   	if (ret) {
>   		ath12k_err(ab, "failed to start core: %d\n", ret);
>   		goto err_dp_free;
> @@ -811,7 +820,8 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
>   	for (i = 0; i < ab->num_radios; i++) {
>   		pdev = &ab->pdevs[i];
>   		ar = pdev->ar;
> -		if (!ar || ar->state == ATH12K_STATE_OFF)
> +		if (!ar || ar->state == ATH12K_STATE_OFF ||
> +		    ar->state == ATH12K_STATE_TM)
>   			continue;
>   
>   		ieee80211_stop_queues(ar->hw);
> @@ -870,6 +880,9 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
>   			ath12k_warn(ab,
>   				    "device is wedged, will not restart radio %d\n", i);
>   			break;
> +		case ATH12K_STATE_TM:
> +			ath12k_warn(ab, "fw mode reset done radio %d\n", i);
> +			break;
>   		}
>   		mutex_unlock(&ar->conf_mutex);
>   	}
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 68c42ca44fcb..3e5472556aff 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -199,6 +199,7 @@ enum ath12k_dev_flags {
>   	ATH12K_FLAG_REGISTERED,
>   	ATH12K_FLAG_QMI_FAIL,
>   	ATH12K_FLAG_HTC_SUSPEND_COMPLETE,
> +	ATH12K_FLAG_FTM_SEGMENTED,
>   };
>   
>   enum ath12k_monitor_flags {
> @@ -429,12 +430,19 @@ enum ath12k_state {
>   	ATH12K_STATE_RESTARTING,
>   	ATH12K_STATE_RESTARTED,
>   	ATH12K_STATE_WEDGED,
> +	ATH12K_STATE_TM,
>   	/* Add other states as required */
>   };
>   
>   /* Antenna noise floor */
>   #define ATH12K_DEFAULT_NOISE_FLOOR -95
>   
> +struct ath12k_ftm_event_obj {
> +	u32 data_pos;
> +	u32 expected_seq;
> +	u8 *eventdata;
> +};
> +
>   struct ath12k_fw_stats {
>   	u32 pdev_id;
>   	u32 stats_id;
> @@ -588,6 +596,8 @@ struct ath12k {
>   	bool monitor_vdev_created;
>   	bool monitor_started;
>   	int monitor_vdev_id;
> +	struct completion fw_mode_reset;
> +	u8 ftm_msgref;
>   };
>   
>   struct ath12k_band_cap {
> @@ -674,6 +684,7 @@ struct ath12k_soc_dp_stats {
>   /* Master structure to hold the hw data which may be used in core module */
>   struct ath12k_base {
>   	enum ath12k_hw_rev hw_rev;
> +	enum ath12k_firmware_mode fw_mode;
>   	struct platform_device *pdev;
>   	struct device *dev;
>   	struct ath12k_qmi qmi;
> @@ -776,6 +787,8 @@ struct ath12k_base {
>   		/* protected by data_lock */
>   		u32 fw_crash_counter;
>   	} stats;
> +	bool ftm_segment_handler;
> +	struct ath12k_ftm_event_obj ftm_event_obj;
>   	u32 pktlog_defs_checksum;
>   
>   	struct ath12k_dbring_cap *db_caps;
> diff --git a/drivers/net/wireless/ath/ath12k/debug.h b/drivers/net/wireless/ath/ath12k/debug.h
> index aa685295f8a4..11139793547d 100644
> --- a/drivers/net/wireless/ath/ath12k/debug.h
> +++ b/drivers/net/wireless/ath/ath12k/debug.h
> @@ -33,6 +33,7 @@ __printf(2, 3) void ath12k_err(struct ath12k_base *ab, const char *fmt, ...);
>   __printf(2, 3) void ath12k_warn(struct ath12k_base *ab, const char *fmt, ...);
>   
>   extern unsigned int ath12k_debug_mask;
> +extern bool ath12k_ftm_mode;
>   
>   #ifdef CONFIG_ATH12K_DEBUG
>   __printf(3, 4) void __ath12k_dbg(struct ath12k_base *ab,
> diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
> index 6893466f61f0..b7827b95ded6 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.c
> +++ b/drivers/net/wireless/ath/ath12k/dp.c
> @@ -1255,6 +1255,9 @@ void ath12k_dp_cc_config(struct ath12k_base *ab)
>   	u32 wbm_base = HAL_SEQ_WCSS_UMAC_WBM_REG;
>   	u32 val = 0;
>   
> +	if (ath12k_ftm_mode)
> +		return;
> +
>   	ath12k_hif_write32(ab, reo_base + HAL_REO1_SW_COOKIE_CFG0(ab), cmem_base);
>   
>   	val |= u32_encode_bits(ATH12K_CMEM_ADDR_MSB,
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index fc0d14ea328e..de57a57afde0 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -13,6 +13,7 @@
>   #include "hw.h"
>   #include "dp_tx.h"
>   #include "dp_rx.h"
> +#include "testmode.h"
>   #include "peer.h"
>   
>   #define CHAN2G(_channel, _freq, _flags) { \
> @@ -598,7 +599,10 @@ struct ath12k *ath12k_mac_get_ar_by_pdev_id(struct ath12k_base *ab, u32 pdev_id)
>   		return NULL;
>   
>   	for (i = 0; i < ab->num_radios; i++) {
> -		pdev = rcu_dereference(ab->pdevs_active[i]);
> +		if (ab->fw_mode == ATH12K_FIRMWARE_MODE_FTM)
> +			pdev = &ab->pdevs[i];
> +		else
> +			pdev = rcu_dereference(ab->pdevs_active[i]);
>   
>   		if (pdev && pdev->pdev_id == pdev_id)
>   			return (pdev->ar ? pdev->ar : NULL);
> @@ -5043,6 +5047,11 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
>   	struct ath12k_pdev *pdev = ar->pdev;
>   	int ret;
>   
> +	if (ath12k_ftm_mode) {
> +		ath12k_err(ab, "fail to start mac operations in ftm mode\n");
> +		return -EWOULDBLOCK;
> +	}
> +
>   	ath12k_mac_drain_tx(ar);
>   	mutex_lock(&ar->conf_mutex);
>   
> @@ -5057,6 +5066,7 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
>   	case ATH12K_STATE_RESTARTED:
>   	case ATH12K_STATE_WEDGED:
>   	case ATH12K_STATE_ON:
> +	case ATH12K_STATE_TM:
>   		WARN_ON(1);
>   		ret = -EINVAL;
>   		goto err;
> @@ -7114,6 +7124,7 @@ static const struct ieee80211_ops ath12k_ops = {
>   	.get_survey			= ath12k_mac_op_get_survey,
>   	.flush				= ath12k_mac_op_flush,
>   	.sta_statistics			= ath12k_mac_op_sta_statistics,
> +	CFG80211_TESTMODE_CMD(ath12k_tm_cmd)
>   };
>   
>   static void ath12k_mac_update_ch_list(struct ath12k *ar,
> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
> index 3006cd3fbe11..9d30c7ea235f 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c
> @@ -1195,6 +1195,7 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
>   	ab_pci->ab = ab;
>   	ab_pci->pdev = pdev;
>   	ab->hif.ops = &ath12k_pci_hif_ops;
> +	ab->fw_mode = ATH12K_FIRMWARE_MODE_NORMAL;
>   	pci_set_drvdata(pdev, ab);
>   	spin_lock_init(&ab_pci->window_lock);
>   
> diff --git a/drivers/net/wireless/ath/ath12k/testmode.c b/drivers/net/wireless/ath/ath12k/testmode.c
> new file mode 100644
> index 000000000000..cc5e482049a5
> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath12k/testmode.c
> @@ -0,0 +1,406 @@
> +// SPDX-License-Identifier: BSD-3-Clause-Clear
> +/*
> + * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include "testmode.h"
> +#include <net/netlink.h>
> +#include "debug.h"
> +#include "wmi.h"
> +#include "hw.h"
> +#include "core.h"
> +#include "hif.h"
> +#include "../testmode_i.h"
> +
> +#define ATH12K_FTM_SEGHDR_CURRENT_SEQ		GENMASK(3, 0)
> +#define ATH12K_FTM_SEGHDR_TOTAL_SEGMENTS	GENMASK(7, 4)
> +
> +static const struct nla_policy ath12k_tm_policy[ATH_TM_ATTR_MAX + 1] = {
> +	[ATH_TM_ATTR_CMD]		= { .type = NLA_U32 },
> +	[ATH_TM_ATTR_DATA]		= { .type = NLA_BINARY,
> +					    .len = ATH_TM_DATA_MAX_LEN },
> +	[ATH_TM_ATTR_WMI_CMDID]		= { .type = NLA_U32 },
> +	[ATH_TM_ATTR_VERSION_MAJOR]	= { .type = NLA_U32 },
> +	[ATH_TM_ATTR_VERSION_MINOR]	= { .type = NLA_U32 },
> +};
> +
> +static struct ath12k *ath12k_tm_get_ar(struct ath12k_base *ab)
> +{
> +	struct ath12k_pdev *pdev;
> +	struct ath12k *ar;
> +	int i;
> +
> +	for (i = 0; i < ab->num_radios; i++) {
> +		pdev = &ab->pdevs[i];
> +		ar = pdev->ar;
> +
> +		if (ar && ar->state == ATH12K_STATE_TM)
> +			return ar;
> +	}
> +
> +	return NULL;
> +}
> +
> +void ath12k_tm_wmi_event_unsegmented(struct ath12k_base *ab, u32 cmd_id,
> +				     struct sk_buff *skb)
> +{
> +	struct sk_buff *nl_skb;
> +	struct ath12k *ar;
> +
> +	ath12k_dbg(ab, ATH12K_DBG_TESTMODE,
> +		   "testmode event wmi cmd_id %d skb length %d\n",
> +		   cmd_id, skb->len);
> +
> +	ath12k_dbg_dump(ab, ATH12K_DBG_TESTMODE, NULL, "", skb->data, skb->len);
> +
> +	ar = ath12k_tm_get_ar(ab);
> +	if (!ar) {
> +		ath12k_warn(ab, "testmode event not handled due to invalid pdev\n");
> +		return;
> +	}
> +
> +	spin_lock_bh(&ar->data_lock);
> +
> +	nl_skb = cfg80211_testmode_alloc_event_skb(ar->hw->wiphy,
> +						   2 * nla_total_size(sizeof(u32)) +
> +						   nla_total_size(skb->len),
> +						   GFP_ATOMIC);
> +	spin_unlock_bh(&ar->data_lock);
> +
> +	if (!nl_skb) {
> +		ath12k_warn(ab,
> +			    "failed to allocate skb for unsegmented testmode wmi event\n");
> +		return;
> +	}
> +
> +	if (nla_put_u32(nl_skb, ATH_TM_ATTR_CMD, ATH_TM_CMD_WMI) ||
> +	    nla_put_u32(nl_skb, ATH_TM_ATTR_WMI_CMDID, cmd_id) ||
> +	    nla_put(nl_skb, ATH_TM_ATTR_DATA, skb->len, skb->data)) {
> +		ath12k_warn(ab, "failed to populate testmode unsegmented event\n");
> +		kfree_skb(nl_skb);
> +		return;
> +	}
> +
> +	cfg80211_testmode_event(nl_skb, GFP_ATOMIC);
> +}
> +
> +void ath12k_tm_process_event(struct ath12k_base *ab, u32 cmd_id,
> +			     const struct ath12k_wmi_ftm_event *ftm_msg,
> +			     u16 length)
> +{
> +	struct sk_buff *nl_skb;
> +	struct ath12k *ar;
> +	u32 data_pos, pdev_id;
> +	u16 datalen;
> +	u8 total_segments, current_seq;
> +	u8 const *buf_pos;
> +
> +	ath12k_dbg(ab, ATH12K_DBG_TESTMODE,
> +		   "testmode event wmi cmd_id %d ftm event msg %pK datalen %d\n",
> +		   cmd_id, ftm_msg, length);
> +	ath12k_dbg_dump(ab, ATH12K_DBG_TESTMODE, NULL, "", ftm_msg, length);
> +	pdev_id = DP_HW2SW_MACID(le32_to_cpu(ftm_msg->seg_hdr.pdev_id));
> +
> +	if (pdev_id >= ab->num_radios) {
> +		ath12k_warn(ab, "testmode event not handled due to invalid pdev id\n");
> +		return;
> +	}
> +
> +	ar = ab->pdevs[pdev_id].ar;
> +
> +	if (!ar) {
> +		ath12k_warn(ab, "testmode event not handled due to absence of pdev\n");
> +		return;
> +	}
> +
> +	current_seq = le32_get_bits(ftm_msg->seg_hdr.segmentinfo,
> +				    ATH12K_FTM_SEGHDR_CURRENT_SEQ);
> +	total_segments = le32_get_bits(ftm_msg->seg_hdr.segmentinfo,
> +				       ATH12K_FTM_SEGHDR_TOTAL_SEGMENTS);
> +	datalen = length - (sizeof(struct ath12k_wmi_ftm_seg_hdr_params));
> +	buf_pos = ftm_msg->data;
> +
> +	if (current_seq == 0) {
> +		ab->ftm_event_obj.expected_seq = 0;
> +		ab->ftm_event_obj.data_pos = 0;
> +	}
> +
> +	data_pos = ab->ftm_event_obj.data_pos;
> +
> +	if ((data_pos + datalen) > ATH_FTM_EVENT_MAX_BUF_LENGTH) {
> +		ath12k_warn(ab,
> +			    "Invalid event length date_pos[%d] datalen[%d]\n",
> +			    data_pos, datalen);
> +		return;
> +	}
> +
> +	memcpy(&ab->ftm_event_obj.eventdata[data_pos], buf_pos, datalen);
> +	data_pos += datalen;
> +
> +	if (++ab->ftm_event_obj.expected_seq != total_segments) {
> +		ab->ftm_event_obj.data_pos = data_pos;
> +		ath12k_dbg(ab, ATH12K_DBG_TESTMODE,
> +			   "partial data received current_seq[%d], total_seg[%d]\n",
> +			    current_seq, total_segments);
> +		return;
> +	}
> +
> +	ath12k_dbg(ab, ATH12K_DBG_TESTMODE,
> +		   "total data length[%d] = [%d]\n",
> +		   data_pos, ftm_msg->seg_hdr.len);
> +
> +	spin_lock_bh(&ar->data_lock);
> +	nl_skb = cfg80211_testmode_alloc_event_skb(ar->hw->wiphy,
> +						   2 * nla_total_size(sizeof(u32)) +
> +						   nla_total_size(data_pos),
> +						   GFP_ATOMIC);
> +	spin_unlock_bh(&ar->data_lock);
> +
> +	if (!nl_skb) {
> +		ath12k_warn(ab,
> +			    "failed to allocate skb for testmode wmi event\n");
> +		return;
> +	}
> +
> +	if (nla_put_u32(nl_skb, ATH_TM_ATTR_CMD,
> +			ATH_TM_CMD_WMI_FTM) ||
> +	    nla_put_u32(nl_skb, ATH_TM_ATTR_WMI_CMDID, cmd_id) ||
> +	    nla_put(nl_skb, ATH_TM_ATTR_DATA, data_pos,
> +		    &ab->ftm_event_obj.eventdata[0])) {
> +		ath12k_warn(ab, "failed to populate testmode event");
> +		kfree_skb(nl_skb);
> +		return;
> +	}
> +
> +	cfg80211_testmode_event(nl_skb, GFP_ATOMIC);
> +}
> +
> +static int ath12k_tm_cmd_get_version(struct ath12k *ar, struct nlattr *tb[])
> +{
> +	struct sk_buff *skb;
> +
> +	ath12k_dbg(ar->ab, ATH12K_DBG_TESTMODE,
> +		   "testmode cmd get version_major %d version_minor %d\n",
> +		   ATH_TESTMODE_VERSION_MAJOR,
> +		   ATH_TESTMODE_VERSION_MINOR);
> +
> +	spin_lock_bh(&ar->data_lock);
> +	skb = cfg80211_testmode_alloc_reply_skb(ar->hw->wiphy,
> +						2 * nla_total_size(sizeof(u32)));
> +	spin_unlock_bh(&ar->data_lock);
> +
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	if (nla_put_u32(skb, ATH_TM_ATTR_VERSION_MAJOR,
> +			ATH_TESTMODE_VERSION_MAJOR) ||
> +	    nla_put_u32(skb, ATH_TM_ATTR_VERSION_MINOR,
> +			ATH_TESTMODE_VERSION_MINOR)) {
> +		kfree_skb(skb);
> +		return -ENOBUFS;
> +	}
> +
> +	return cfg80211_testmode_reply(skb);
> +}
> +
> +static int ath12k_tm_cmd_process_ftm(struct ath12k *ar, struct nlattr *tb[])
> +{
> +	struct ath12k_wmi_pdev *wmi = ar->wmi;
> +	struct sk_buff *skb;
> +	struct ath12k_wmi_ftm_cmd *ftm_cmd;
> +	int ret = 0;
> +	void *buf;
> +	size_t aligned_len;
> +	u32 cmd_id, buf_len;
> +	u16 chunk_len, total_bytes, num_segments;
> +	u8 segnumber = 0, *bufpos;
> +
> +	mutex_lock(&ar->conf_mutex);
> +	ath12k_dbg(ar->ab, ATH12K_DBG_TESTMODE, "ar->state  %d\n", ar->state);
> +	if (ar->state != ATH12K_STATE_TM) {
> +		ret = -ENETDOWN;
> +		goto out;
> +	}
> +
> +	if (!tb[ATH_TM_ATTR_DATA]) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	buf = nla_data(tb[ATH_TM_ATTR_DATA]);
> +	buf_len = nla_len(tb[ATH_TM_ATTR_DATA]);
> +	cmd_id = WMI_PDEV_UTF_CMDID;
> +	ath12k_dbg(ar->ab, ATH12K_DBG_TESTMODE,
> +		   "testmode cmd wmi cmd_id %d buf %pK buf_len %d\n",
> +		   cmd_id, buf, buf_len);
> +	ath12k_dbg_dump(ar->ab, ATH12K_DBG_TESTMODE, NULL, "", buf, buf_len);
> +	bufpos = buf;
> +	total_bytes = buf_len;
> +	num_segments = total_bytes / MAX_WMI_UTF_LEN;
> +
> +	if (buf_len - (num_segments * MAX_WMI_UTF_LEN))
> +		num_segments++;
> +
> +	while (buf_len) {
> +		if (buf_len > MAX_WMI_UTF_LEN)
> +			chunk_len = MAX_WMI_UTF_LEN;    /* MAX message */
> +		else
> +			chunk_len = buf_len;
> +
> +		skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, (chunk_len +
> +					sizeof(struct ath12k_wmi_ftm_cmd)));
> +
> +		if (!skb) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		ftm_cmd = (struct ath12k_wmi_ftm_cmd *)skb->data;
> +		aligned_len  = chunk_len + sizeof(struct ath12k_wmi_ftm_seg_hdr_params);
> +		ftm_cmd->tlv_header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE, aligned_len);
> +		ftm_cmd->seg_hdr.len = cpu_to_le32(total_bytes);
> +		ftm_cmd->seg_hdr.msgref = cpu_to_le32(ar->ftm_msgref);
> +		ftm_cmd->seg_hdr.segmentinfo = le32_encode_bits(num_segments, ATH12K_FTM_SEGHDR_TOTAL_SEGMENTS) |
> +					       le32_encode_bits(segnumber, ATH12K_FTM_SEGHDR_CURRENT_SEQ);

drivers/net/wireless/ath/ath12k/testmode.c:264: line length of 113 
exceeds 90 columns
drivers/net/wireless/ath/ath12k/testmode.c:265: line length of 106 
exceeds 90 columns

> +		segnumber++;
> +		memcpy(&ftm_cmd->data, bufpos, chunk_len);
> +		ret = ath12k_wmi_cmd_send(wmi, skb, cmd_id);
> +
> +		if (ret) {
> +			ath12k_warn(ar->ab, "ftm wmi command fail: %d\n", ret);
> +			kfree_skb(skb);
> +			goto out;
> +		}
> +
> +		buf_len -= chunk_len;
> +		bufpos += chunk_len;
> +	}
> +
> +	++ar->ftm_msgref;
> +out:
> +	mutex_unlock(&ar->conf_mutex);
> +	return ret;
> +}
> +
> +static int ath12k_tm_cmd_testmode_start(struct ath12k *ar, struct nlattr *tb[])
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&ar->conf_mutex);
> +
> +	if (ar->state == ATH12K_STATE_TM) {
> +		ret = -EALREADY;
> +		goto out;
> +	}
> +
> +	if (ar->state != ATH12K_STATE_OFF) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	ar->ab->ftm_event_obj.eventdata = kzalloc(ATH_FTM_EVENT_MAX_BUF_LENGTH,
> +						  GFP_KERNEL);
> +
> +	if (!ar->ab->ftm_event_obj.eventdata) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	ar->state = ATH12K_STATE_TM;
> +	ar->ftm_msgref = 0;
> +out:
> +	mutex_unlock(&ar->conf_mutex);
> +	return ret;
> +}
> +
> +static int ath12k_tm_cmd_wmi(struct ath12k *ar, struct nlattr *tb[])
> +{
> +	struct ath12k_wmi_pdev *wmi = ar->wmi;
> +	struct sk_buff *skb;
> +	u32 cmd_id, buf_len;
> +	int ret;
> +	void *buf;
> +
> +	mutex_lock(&ar->conf_mutex);
> +
> +	if (!tb[ATH_TM_ATTR_DATA]) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (!tb[ATH_TM_ATTR_WMI_CMDID]) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	buf = nla_data(tb[ATH_TM_ATTR_DATA]);
> +	buf_len = nla_len(tb[ATH_TM_ATTR_DATA]);
> +
> +	if (!buf_len) {
> +		ath12k_warn(ar->ab, "No data present in testmode command\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	cmd_id = nla_get_u32(tb[ATH_TM_ATTR_WMI_CMDID]);
> +
> +	ath12k_dbg(ar->ab, ATH12K_DBG_TESTMODE,
> +		   "testmode cmd wmi cmd_id %d  buf length %d\n",
> +		   cmd_id, buf_len);
> +
> +	ath12k_dbg_dump(ar->ab, ATH12K_DBG_TESTMODE, NULL, "", buf, buf_len);
> +
> +	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, buf_len);
> +
> +	if (!skb) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	memcpy(skb->data, buf, buf_len);
> +
> +	ret = ath12k_wmi_cmd_send(wmi, skb, cmd_id);
> +	if (ret) {
> +		dev_kfree_skb(skb);
> +		ath12k_warn(ar->ab, "failed to transmit wmi command (testmode): %d\n",
> +			    ret);
> +		goto out;
> +	}
> +
> +out:
> +	mutex_unlock(&ar->conf_mutex);
> +	return ret;
> +}
> +
> +int ath12k_tm_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
> +		  void *data, int len)
> +{
> +	struct ath12k *ar = hw->priv;
> +	struct nlattr *tb[ATH_TM_ATTR_MAX + 1];
> +	struct ath12k_base *ab;
> +	int ret;
> +
> +	ret = nla_parse(tb, ATH_TM_ATTR_MAX, data, len, ath12k_tm_policy,
> +			NULL);
> +	if (ret)
> +		return ret;
> +
> +	if (!tb[ATH_TM_ATTR_CMD])
> +		return -EINVAL;
> +
> +	ab = ar->ab;
> +	switch (nla_get_u32(tb[ATH_TM_ATTR_CMD])) {
> +	case ATH_TM_CMD_WMI:
> +		return ath12k_tm_cmd_wmi(ar, tb);
> +	case ATH_TM_CMD_TESTMODE_START:
> +		return ath12k_tm_cmd_testmode_start(ar, tb);
> +	case ATH_TM_CMD_GET_VERSION:
> +		return ath12k_tm_cmd_get_version(ar, tb);
> +	case ATH_TM_CMD_WMI_FTM:
> +		set_bit(ATH12K_FLAG_FTM_SEGMENTED, &ab->dev_flags);
> +		return ath12k_tm_cmd_process_ftm(ar, tb);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> diff --git a/drivers/net/wireless/ath/ath12k/testmode.h b/drivers/net/wireless/ath/ath12k/testmode.h
> new file mode 100644
> index 000000000000..5f68a2f44789
> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath12k/testmode.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: BSD-3-Clause-Clear */
> +/*
> + * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include "core.h"
> +#include "hif.h"
> +
> +#ifdef CONFIG_NL80211_TESTMODE
> +
> +void ath12k_tm_wmi_event_unsegmented(struct ath12k_base *ab, u32 cmd_id,
> +				     struct sk_buff *skb);
> +void ath12k_tm_process_event(struct ath12k_base *ab, u32 cmd_id,
> +			     const struct ath12k_wmi_ftm_event *ftm_msg,
> +			     u16 length);
> +int ath12k_tm_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
> +		  void *data, int len);
> +
> +#else
> +
> +static inline void ath12k_tm_wmi_event_unsegmented(struct ath12k_base *ab, u32 cmd_id,
> +						   struct sk_buff *skb)
> +{
> +	return;

Please run ath12k-check on your patches
drivers/net/wireless/ath/ath12k/testmode.h:26: void function return 
statements are not generally useful

> +}
> +
> +static inline void ath12k_tm_process_event(struct ath12k_base *ab, u32 cmd_id,
> +					   const struct ath12k_wmi_ftm_event *msg,
> +					   u16 length)
> +{
> +	return;

drivers/net/wireless/ath/ath12k/testmode.h:26: void function return 
statements are not generally useful

> +}
> +
> +static inline int ath12k_tm_cmd(struct ieee80211_hw *hw,
> +				struct ieee80211_vif *vif,
> +				void *data, int len)
> +{
> +	return 0;
> +}
> +
> +#endif
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index f10e0cfca1ef..da7ed0b6a15f 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -19,6 +19,7 @@
>   #include "mac.h"
>   #include "hw.h"
>   #include "peer.h"
> +#include "testmode.h"
>   
>   struct ath12k_wmi_svc_ready_parse {
>   	bool wmi_svc_bitmap_done;
> @@ -6539,6 +6540,33 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
>   	kfree(tb);
>   }
>   
> +static void ath12k_tm_wmi_event_segmented(struct ath12k_base *ab, u32 cmd_id,
> +					  struct sk_buff *skb)
> +{
> +	const struct ath12k_wmi_ftm_event *ev;
> +	const void **tb;
> +	int ret;
> +	u16 length;
> +
> +	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
> +
> +	if (IS_ERR(tb)) {
> +		ret = PTR_ERR(tb);
> +		ath12k_warn(ab, "failed to parse ftm event tlv: %d\n", ret);
> +		return;
> +	}
> +
> +	ev = tb[WMI_TAG_ARRAY_BYTE];
> +	if (!ev) {
> +		ath12k_warn(ab, "failed to fetch ftm msg\n");
> +		kfree(tb);
> +		return;
> +	}
> +
> +	length = skb->len - TLV_HDR_SIZE;
> +	ath12k_tm_process_event(ab, cmd_id, ev, length);
> +	kfree(tb);
> +}

drivers/net/wireless/ath/ath12k/wmi.c:6570: Please use a blank line 
after function/struct/union/enum declarations

>   static void
>   ath12k_wmi_pdev_temperature_event(struct ath12k_base *ab,
>   				  struct sk_buff *skb)
> @@ -6772,6 +6800,12 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
>   	case WMI_VDEV_DELETE_RESP_EVENTID:
>   		ath12k_vdev_delete_resp_event(ab, skb);
>   		break;
> +	case WMI_PDEV_UTF_EVENTID:
> +		if (test_bit(ATH12K_FLAG_FTM_SEGMENTED, &ab->dev_flags))
> +			ath12k_tm_wmi_event_segmented(ab, id, skb);
> +		else
> +			ath12k_tm_wmi_event_unsegmented(ab, id, skb);
> +		break;
>   	/* TODO: Add remaining events */

since you have to respin this patch, can you please remove this 
unnecessary comment? Adding specific event handling is just part of 
normal feature development, not a TODO

>   	default:
>   		ath12k_dbg(ab, ATH12K_DBG_WMI, "Unknown eventid: 0x%x\n", id);
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index dcbae5258b35..567ede091d48 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -3486,6 +3486,26 @@ struct wmi_get_pdev_temperature_cmd {
>   	__le32 pdev_id;
>   } __packed;
>   
> +#define MAX_WMI_UTF_LEN 252
> +
> +struct ath12k_wmi_ftm_seg_hdr_params {
> +	__le32 len;
> +	__le32 msgref;
> +	__le32 segmentinfo;
> +	__le32 pdev_id;
> +} __packed;
> +
> +struct ath12k_wmi_ftm_cmd {
> +	__le32 tlv_header;
> +	struct ath12k_wmi_ftm_seg_hdr_params seg_hdr;
> +	u8 data[];
> +} __packed;
> +
> +struct ath12k_wmi_ftm_event {
> +	struct ath12k_wmi_ftm_seg_hdr_params seg_hdr;
> +	u8 data[];
> +} __packed;
> +
>   #define WMI_BEACON_TX_BUFFER_SIZE	512
>   
>   struct wmi_bcn_tmpl_cmd {

