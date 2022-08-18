Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDAD599094
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Aug 2022 00:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244633AbiHRWbP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Aug 2022 18:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243034AbiHRWbN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Aug 2022 18:31:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5D4219A
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 15:31:12 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27ILu2kI025219;
        Thu, 18 Aug 2022 22:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=P9weaJudL8pHv9gHYYwBqrX/C20wa3A42CjYHd8mejU=;
 b=JcaUhyBshIkm1uw3qTtBb5n9xGIU63LeF8Vzz7vJ5A5uFtIcgW7jATlpnxeOFeA/M7N2
 HQ8OBYqu/UIgx+TGKPWvJTSEeXhWQsK/F6MjzWYZOrJvO6oVZW0fYoZDvU37xQASPYVW
 BxxYCb0HuqRK1gD3GyeKGtJJOOGYdgVomEc3oOwieFLs4IhD1S7FRus6IrtCQcsbYf+I
 nRkgflf5KIY0Nx6v1ge0zNxm5767bYyFIrA2XyBFEsgYbmp4DPvRwdIGZoEv/49o/Ihj
 nmms8lpuH67HkE7nvfAeq8NIE5yotSLjLUSAcivJJYiRNQKBMJD0mqHrnL5tkFlnyOEh Ag== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j1sjr0w74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 22:31:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27IMV2t9012827
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 22:31:02 GMT
Received: from [10.110.11.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 18 Aug
 2022 15:31:02 -0700
Message-ID: <d4d4ab35-b38c-6369-e436-5eb37c502ca6@quicinc.com>
Date:   Thu, 18 Aug 2022 15:30:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 34/50] wifi: ath12k: add mhi.h
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-35-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220812161003.27279-35-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qvQfmtxM7NBL6DXrYgB8UVDYK7rTgZyv
X-Proofpoint-GUID: qvQfmtxM7NBL6DXrYgB8UVDYK7rTgZyv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_16,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/12/2022 9:09 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> (Patches split into one patch per file for easier review, but the final
> commit will be one big patch. See the cover letter for more info.)
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/mhi.h | 46 +++++++++++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mhi.h b/drivers/net/wireless/ath/ath12k/mhi.h
> new file mode 100644
> index 000000000000..258152d3a7dd
> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath12k/mhi.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: BSD-3-Clause-Clear */
> +/*
> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +#ifndef _ATH12K_MHI_H
> +#define _ATH12K_MHI_H
> +
> +#include "pci.h"
> +
> +#define PCIE_TXVECDB				0x360
> +#define PCIE_TXVECSTATUS			0x368
> +#define PCIE_RXVECDB				0x394
> +#define PCIE_RXVECSTATUS			0x39C
> +
> +#define MHISTATUS				0x48
> +#define MHICTRL					0x38
> +#define MHICTRL_RESET_MASK			0x2
> +
> +enum ath12k_mhi_state {
> +	ATH12K_MHI_INIT,
> +	ATH12K_MHI_DEINIT,
> +	ATH12K_MHI_POWER_ON,
> +	ATH12K_MHI_POWER_OFF,
> +	ATH12K_MHI_FORCE_POWER_OFF,
> +	ATH12K_MHI_SUSPEND,
> +	ATH12K_MHI_RESUME,
> +	ATH12K_MHI_TRIGGER_RDDM,
> +	ATH12K_MHI_RDDM,
> +	ATH12K_MHI_RDDM_DONE,
> +};
> +
> +extern struct mhi_controller_config ath12k_mhi_config_qcn9274;
> +extern struct mhi_controller_config ath12k_mhi_config_wcn7850;

imo both should be const

> +
> +int ath12k_mhi_start(struct ath12k_pci *ar_pci);
> +void ath12k_mhi_stop(struct ath12k_pci *ar_pci);
> +int ath12k_mhi_register(struct ath12k_pci *ar_pci);
> +void ath12k_mhi_unregister(struct ath12k_pci *ar_pci);
> +void ath12k_mhi_set_mhictrl_reset(struct ath12k_base *ab);
> +void ath12k_mhi_clear_vector(struct ath12k_base *ab);
> +
> +void ath12k_mhi_suspend(struct ath12k_pci *ar_pci);
> +void ath12k_mhi_resume(struct ath12k_pci *ar_pci);
> +
> +#endif
> 

