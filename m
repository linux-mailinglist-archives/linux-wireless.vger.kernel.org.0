Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EA1599076
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Aug 2022 00:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239170AbiHRW0K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Aug 2022 18:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiHRW0J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Aug 2022 18:26:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAF3DB7C3
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 15:26:07 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IJxaC9005484;
        Thu, 18 Aug 2022 22:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iszVaAmW9X3RToKxj/pYGLOj5godrqfwPUOZSz3hae4=;
 b=YDSTVQSEukd+fbbQkAg/z/VmAZ6QFladWowuSUOx/NsBIKYHl3ab7/e+Xd8Vnr6JYJGN
 xfr/35rhYP1E0QEW0gAmg063XA8Odo6BH9adUXWgNtXZr3Jcu9Tv/Qtk47aIK9boTyQK
 oZNfBfU7wu55BKHsCNcHX99UZq+oRCoDL5rtcHv6KXyTEJZnk5fpu3gZK6oZzILDPCll
 Ze4Ht936S00cT5Q4Q26DQe8rYyyVz/qQ8aSuS8TrAWFY8VYHvzOkIW1guYSpYmFCYz+T
 KlW6h7H/Ry5O5BuB6gQFx1lN+5l+3ebi8QpDkgbUIhksSIQKelPETRjrBgHBxz9mN0sp lw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j1pwuhdua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 22:25:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27IMPpRe026678
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 22:25:51 GMT
Received: from [10.110.11.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 18 Aug
 2022 15:25:51 -0700
Message-ID: <05841a52-3d2f-8704-b885-4b02e7a439e0@quicinc.com>
Date:   Thu, 18 Aug 2022 15:25:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 33/50] wifi: ath12k: add mhi.c
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-34-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220812161003.27279-34-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aOY-R7OT4FNiYDzJ8DvzHDI6LeyuK1iQ
X-Proofpoint-ORIG-GUID: aOY-R7OT4FNiYDzJ8DvzHDI6LeyuK1iQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_16,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
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
>   drivers/net/wireless/ath/ath12k/mhi.c | 615 ++++++++++++++++++++++++++++++++++
>   1 file changed, 615 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
> new file mode 100644
> index 000000000000..f77634994d97
> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath12k/mhi.c
> @@ -0,0 +1,615 @@
> +// SPDX-License-Identifier: BSD-3-Clause-Clear
> +/*
> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/msi.h>
> +#include <linux/pci.h>
> +
> +#include "core.h"
> +#include "debug.h"
> +#include "mhi.h"
> +#include "pci.h"
> +
> +#define MHI_TIMEOUT_DEFAULT_MS	90000
> +
> +static struct mhi_channel_config ath12k_mhi_channels_qcn9274[] = {

should this be const?
in struct mhi_controller_config:
	const struct mhi_channel_config *ch_cfg;

> +	{
> +		.num = 0,
> +		.name = "LOOPBACK",
> +		.num_elements = 32,
> +		.event_ring = 1,
> +		.dir = DMA_TO_DEVICE,
> +		.ee_mask = 0x4,
> +		.pollcfg = 0,
> +		.doorbell = MHI_DB_BRST_DISABLE,
> +		.lpm_notify = false,
> +		.offload_channel = false,
> +		.doorbell_mode_switch = false,
> +		.auto_queue = false,
> +	},
> +	{
> +		.num = 1,
> +		.name = "LOOPBACK",
> +		.num_elements = 32,
> +		.event_ring = 1,
> +		.dir = DMA_FROM_DEVICE,
> +		.ee_mask = 0x4,
> +		.pollcfg = 0,
> +		.doorbell = MHI_DB_BRST_DISABLE,
> +		.lpm_notify = false,
> +		.offload_channel = false,
> +		.doorbell_mode_switch = false,
> +		.auto_queue = false,
> +	},
> +	{
> +		.num = 20,
> +		.name = "IPCR",
> +		.num_elements = 32,
> +		.event_ring = 1,
> +		.dir = DMA_TO_DEVICE,
> +		.ee_mask = 0x4,
> +		.pollcfg = 0,
> +		.doorbell = MHI_DB_BRST_DISABLE,
> +		.lpm_notify = false,
> +		.offload_channel = false,
> +		.doorbell_mode_switch = false,
> +		.auto_queue = false,
> +	},
> +	{
> +		.num = 21,
> +		.name = "IPCR",
> +		.num_elements = 32,
> +		.event_ring = 1,
> +		.dir = DMA_FROM_DEVICE,
> +		.ee_mask = 0x4,
> +		.pollcfg = 0,
> +		.doorbell = MHI_DB_BRST_DISABLE,
> +		.lpm_notify = false,
> +		.offload_channel = false,
> +		.doorbell_mode_switch = false,
> +		.auto_queue = true,
> +	},
> +};
> +
> +static struct mhi_event_config ath12k_mhi_events_qcn9274[] = {

seems this should be const
but for some reason struct mhi_controller_config has:
	struct mhi_event_config *event_cfg;

(not const) so this can't be const :(

perhaps someone can propose a MHI interface change?
especially since internally to MHI in parse_ev_cfg() we have:
	const struct mhi_event_config *event_cfg;
	[...]
	for (i = 0; i < num; i++) {
		event_cfg = &config->event_cfg[i];

so it is treated as const

> +	{
> +		.num_elements = 32,
> +		.irq_moderation_ms = 0,
> +		.irq = 1,
> +		.data_type = MHI_ER_CTRL,
> +		.mode = MHI_DB_BRST_DISABLE,
> +		.hardware_event = false,
> +		.client_managed = false,
> +		.offload_channel = false,
> +	},
> +	{
> +		.num_elements = 256,
> +		.irq_moderation_ms = 1,
> +		.irq = 2,
> +		.mode = MHI_DB_BRST_DISABLE,
> +		.priority = 1,
> +		.hardware_event = false,
> +		.client_managed = false,
> +		.offload_channel = false,
> +	},
> +};
> +
> +struct mhi_controller_config ath12k_mhi_config_qcn9274 = {
> +	.max_channels = 30,
> +	.timeout_ms = 10000,
> +	.use_bounce_buf = false,
> +	.buf_len = 0,
> +	.num_channels = ARRAY_SIZE(ath12k_mhi_channels_qcn9274),
> +	.ch_cfg = ath12k_mhi_channels_qcn9274,
> +	.num_events = ARRAY_SIZE(ath12k_mhi_events_qcn9274),
> +	.event_cfg = ath12k_mhi_events_qcn9274,
> +};
> +
> +static struct mhi_channel_config ath12k_mhi_channels_wcn7850[] = {

const

> +	{
> +		.num = 0,
> +		.name = "LOOPBACK",
> +		.num_elements = 32,
> +		.event_ring = 0,
> +		.dir = DMA_TO_DEVICE,
> +		.ee_mask = 0x4,
> +		.pollcfg = 0,
> +		.doorbell = MHI_DB_BRST_DISABLE,
> +		.lpm_notify = false,
> +		.offload_channel = false,
> +		.doorbell_mode_switch = false,
> +		.auto_queue = false,
> +	},
> +	{
> +		.num = 1,
> +		.name = "LOOPBACK",
> +		.num_elements = 32,
> +		.event_ring = 0,
> +		.dir = DMA_FROM_DEVICE,
> +		.ee_mask = 0x4,
> +		.pollcfg = 0,
> +		.doorbell = MHI_DB_BRST_DISABLE,
> +		.lpm_notify = false,
> +		.offload_channel = false,
> +		.doorbell_mode_switch = false,
> +		.auto_queue = false,
> +	},
> +	{
> +		.num = 20,
> +		.name = "IPCR",
> +		.num_elements = 64,
> +		.event_ring = 1,
> +		.dir = DMA_TO_DEVICE,
> +		.ee_mask = 0x4,
> +		.pollcfg = 0,
> +		.doorbell = MHI_DB_BRST_DISABLE,
> +		.lpm_notify = false,
> +		.offload_channel = false,
> +		.doorbell_mode_switch = false,
> +		.auto_queue = false,
> +	},
> +	{
> +		.num = 21,
> +		.name = "IPCR",
> +		.num_elements = 64,
> +		.event_ring = 1,
> +		.dir = DMA_FROM_DEVICE,
> +		.ee_mask = 0x4,
> +		.pollcfg = 0,
> +		.doorbell = MHI_DB_BRST_DISABLE,
> +		.lpm_notify = false,
> +		.offload_channel = false,
> +		.doorbell_mode_switch = false,
> +		.auto_queue = true,
> +	},
> +};
> +
> +static struct mhi_event_config ath12k_mhi_events_wcn7850[] = {

keep not const (for now) :(

> +	{
> +		.num_elements = 32,
> +		.irq_moderation_ms = 0,
> +		.irq = 1,
> +		.mode = MHI_DB_BRST_DISABLE,
> +		.data_type = MHI_ER_CTRL,
> +		.hardware_event = false,
> +		.client_managed = false,
> +		.offload_channel = false,
> +	},
> +	{
> +		.num_elements = 256,
> +		.irq_moderation_ms = 1,
> +		.irq = 2,
> +		.mode = MHI_DB_BRST_DISABLE,
> +		.priority = 1,
> +		.hardware_event = false,
> +		.client_managed = false,
> +		.offload_channel = false,
> +	},
> +};
> +
> +struct mhi_controller_config ath12k_mhi_config_wcn7850 = {

and this one should be const since it is registered via:

int mhi_register_controller(struct mhi_controller *mhi_cntrl,
			const struct mhi_controller_config *config);

> +	.max_channels = 128,
> +	.timeout_ms = 2000,
> +	.use_bounce_buf = false,
> +	.buf_len = 0,
> +	.num_channels = ARRAY_SIZE(ath12k_mhi_channels_wcn7850),
> +	.ch_cfg = ath12k_mhi_channels_wcn7850,
> +	.num_events = ARRAY_SIZE(ath12k_mhi_events_wcn7850),
> +	.event_cfg = ath12k_mhi_events_wcn7850,
> +};
> +

snip

> +static int ath12k_mhi_get_msi(struct ath12k_pci *ab_pci)
> +{
> +	struct ath12k_base *ab = ab_pci->ab;
> +	u32 user_base_data, base_vector;
> +	int ret, num_vectors, i;
> +	int *irq;
> +
> +	ret = ath12k_pci_get_user_msi_assignment(ab,
> +						 "MHI", &num_vectors,
> +						 &user_base_data, &base_vector);
> +	if (ret)
> +		return ret;
> +
> +	ath12k_dbg(ab, ATH12K_DBG_PCI, "Number of assigned MSI for MHI is %d, base vector is %d\n",
> +		   num_vectors, base_vector);
> +
> +	irq = kcalloc(num_vectors, sizeof(int), GFP_KERNEL);

prefer sizeof(*irq)?

> +	if (!irq)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_vectors; i++)
> +		irq[i] = ath12k_pci_get_msi_irq(ab->dev,
> +						base_vector + i);
> +
> +	ab_pci->mhi_ctrl->irq = irq;
> +	ab_pci->mhi_ctrl->nr_irqs = num_vectors;
> +
> +	return 0;
> +}
> +

snip

> +void ath12k_mhi_unregister(struct ath12k_pci *ab_pci)
> +{
> +	struct mhi_controller *mhi_ctrl = ab_pci->mhi_ctrl;
> +
> +	mhi_unregister_controller(mhi_ctrl);
> +	kfree(mhi_ctrl->irq);
> +	mhi_free_controller(mhi_ctrl);

consider setting ab_pci->mhi_ctrl = NULL to avoid dangling pointer?

> +}

rest snipped
