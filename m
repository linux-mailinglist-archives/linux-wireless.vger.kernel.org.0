Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7C07659A0
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 19:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjG0RNB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 13:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjG0RMt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 13:12:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1649C2D4B
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 10:12:48 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RFvWpb014295;
        Thu, 27 Jul 2023 17:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Nx2+b4cIxzfQDEXInfXaRfOmrhT0e1MpXnDAeq5sj0E=;
 b=nT1XV5jjn7972a/8R8jDY9I5iw3FjHAEY/4Q9wRqhjK77/O+JSCiIUI9yatG/9MlpH1t
 +G7kltCUQKFa+eXwZud2SZpdjFIqT4H2RIvugRtzNHI+UeZINy1FYL0iKSqFVWp9MvlY
 oD/1wWc6uJzOp2VAWKcZvref835+Yw89e0VHGEBf6OvhToBbHkDIwLCU7fRbAEiqX0bS
 zo/FMwzKDXoUm/8aahs6ulTgW1BHlrSLkyh3ZdYC/ZF6SXPRcn2tE1ydFQBbR5V5/wtG
 5AVJZSdXGQm7q60VXAaHEqCb/p094RgB8vQEJMEvhLJ8ZAmVIB/WyL3XTMBkkzeXfH4d ZQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s34x6k7eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:12:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36RHCSdv021135
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:12:28 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 27 Jul
 2023 10:12:28 -0700
Message-ID: <563e8d01-beba-bff2-54e0-7629c462add0@quicinc.com>
Date:   Thu, 27 Jul 2023 10:12:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] wifi: ath11k: add firmware-2.bin support
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <mhi@lists.linux.dev>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230727100430.3603551-1-kvalo@kernel.org>
 <20230727100430.3603551-4-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230727100430.3603551-4-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DcC4Z740BAk80ZIvownNTXGVql6nE_Ix
X-Proofpoint-ORIG-GUID: DcC4Z740BAk80ZIvownNTXGVql6nE_Ix
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270155
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/27/2023 3:04 AM, Kalle Valo wrote:
> From: Anilkumar Kolli <quic_akolli@quicinc.com>
> 
> Firmware IE containers can dynamically provide various information
> what firmware supports. Also it can embed more than one image so
> updating firmware is easy, user just needs to update one file in
> /lib/firmware/.
> 
> The firmware API 2 or higher will use the IE container format, the
> current API 1 will not use the new format but it still is supported
> for some time. Firmware API 2 files are named as firmware-2.bin
> (which contains both amss.bin and m3.bin images) and API 1 files are
> amss.bin and m3.bin.
> 
> Currently ath11k PCI driver provides firmware binary (amss.bin) path to
> MHI driver, MHI driver reads firmware from filesystem and boots it. Add
> provision to read firmware files from ath11k driver and provide the amss.bin
> firmware data and size to MHI using a pointer.
> 
> Currently enum ath11k_fw_features is empty, the patches adding features will
> add the flags.
> 
> With AHB devices there's no amss.bin or m3.bin, so no changes in how AHB
> firmware files are used. But AHB devices can use future additions to the meta
> data, for example in enum ath11k_fw_features.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9
> 
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Anilkumar Kolli <quic_akolli@quicinc.com>
> Co-developed-by: Kalle Valo <quic_kvalo@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath11k/Makefile |   3 +-
>   drivers/net/wireless/ath/ath11k/core.c   |   8 ++
>   drivers/net/wireless/ath/ath11k/core.h   |  15 +++
>   drivers/net/wireless/ath/ath11k/fw.c     | 157 +++++++++++++++++++++++
>   drivers/net/wireless/ath/ath11k/fw.h     |  27 ++++
>   drivers/net/wireless/ath/ath11k/mhi.c    |  18 ++-
>   drivers/net/wireless/ath/ath11k/qmi.c    |  36 ++++--
>   7 files changed, 247 insertions(+), 17 deletions(-)
>   create mode 100644 drivers/net/wireless/ath/ath11k/fw.c
>   create mode 100644 drivers/net/wireless/ath/ath11k/fw.h
...
> 
> diff --git a/drivers/net/wireless/ath/ath11k/fw.c b/drivers/net/wireless/ath/ath11k/fw.c
> new file mode 100644
> index 000000000000..5423c0be63fa
> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath11k/fw.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: BSD-3-Clause-Clear
> +/*
> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.

should the year be updated?
same question applies to the .h file

> + */
> +
> +#include "core.h"
> +
> +#include "debug.h"
> +
> +static int ath11k_fw_request_firmware_api_n(struct ath11k_base *ab,
> +					    const char *name)
> +{
> +	size_t magic_len, len, ie_len;
> +	int ie_id, i, index, bit, ret;
> +	struct ath11k_fw_ie *hdr;
> +	const u8 *data;
> +	__le32 *timestamp;
> +
> +	ab->fw.fw = ath11k_core_firmware_request(ab, name);
> +	if (IS_ERR(ab->fw.fw)) {
> +		ret = PTR_ERR(ab->fw.fw);
> +		ath11k_dbg(ab, ATH11K_DBG_BOOT, "failed to load %s: %d\n", name, ret);
> +		ab->fw.fw = NULL;
> +		return ret;
> +	}
> +
> +	data = ab->fw.fw->data;
> +	len = ab->fw.fw->size;
> +
> +	/* magic also includes the null byte, check that as well */
> +	magic_len = strlen(ATH11K_FIRMWARE_MAGIC) + 1;
> +
> +	if (len < magic_len) {
> +		ath11k_err(ab, "firmware image too small to contain magic: %zu\n",
> +			   len);
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	if (memcmp(data, ATH11K_FIRMWARE_MAGIC, magic_len) != 0) {
> +		ath11k_err(ab, "Invalid firmware magic\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	/* jump over the padding */
> +	magic_len = ALIGN(magic_len, 4);
> +
> +	len -= magic_len;
> +	data += magic_len;
> +
> +	/* loop elements */
> +	while (len > sizeof(struct ath11k_fw_ie)) {
> +		hdr = (struct ath11k_fw_ie *)data;
> +
> +		ie_id = le32_to_cpu(hdr->id);
> +		ie_len = le32_to_cpu(hdr->len);
> +
> +		len -= sizeof(*hdr);
> +		data += sizeof(*hdr);
> +
> +		if (len < ie_len) {
> +			ath11k_err(ab, "Invalid length for FW IE %d (%zu < %zu)\n",
> +				   ie_id, len, ie_len);
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +
> +		switch (ie_id) {
> +		case ATH11K_FW_IE_TIMESTAMP:
> +			if (ie_len != sizeof(u32))
> +				break;
> +
> +			timestamp = (__le32 *)data;
> +
> +			ath11k_dbg(ab, ATH11K_DBG_BOOT, "found fw timestamp %d\n",
> +				   le32_to_cpup(timestamp));
> +			break;
> +		case ATH11K_FW_IE_FEATURES:
> +			ath11k_dbg(ab, ATH11K_DBG_BOOT,
> +				   "found firmware features ie (%zd B)\n",
> +				   ie_len);
> +
> +			for (i = 0; i < ATH11K_FW_FEATURE_COUNT; i++) {
> +				index = i / 8;
> +				bit = i % 8;
> +
> +				if (index == ie_len)
> +					break;
> +
> +				if (data[index] & (1 << bit))
> +					__set_bit(i, ab->fw.fw_features);
> +			}
> +
> +			ath11k_dbg_dump(ab, ATH11K_DBG_BOOT, "features", "",
> +					ab->fw.fw_features,
> +					sizeof(ab->fw.fw_features));
> +			break;
> +		case ATH11K_FW_IE_AMSS_IMAGE:
> +			ath11k_dbg(ab, ATH11K_DBG_BOOT,
> +				   "found fw image ie (%zd B)\n",
> +				   ie_len);
> +
> +			ab->fw.amss_data = data;
> +			ab->fw.amss_len = ie_len;
> +			break;
> +		case ATH11K_FW_IE_M3_IMAGE:
> +			ath11k_dbg(ab, ATH11K_DBG_BOOT,
> +				   "found m3 image ie (%zd B)\n",
> +				   ie_len);
> +
> +			ab->fw.m3_data = data;
> +			ab->fw.m3_len = ie_len;
> +			break;
> +		default:
> +			ath11k_warn(ab, "Unknown FW IE: %u\n", ie_id);
> +			break;
> +		}
> +
> +		/* jump over the padding */
> +		ie_len = ALIGN(ie_len, 4);
> +
> +		len -= ie_len;
> +		data += ie_len;

is this always safe?

can we have a case where the original ie_len was <= len but the aligned 
ie_len is > len, and hence this will lead to an integer underflow of len 
(becoming a large unsigned value) and we'll continue looping with a 
buffer overread?

the same question applies to the code where the magic is checked & skipped

> +	};
> +
> +	return 0;
> +
> +err:
> +	release_firmware(ab->fw.fw);
> +	ab->fw.fw = NULL;
> +	return ret;
> +}
> +


