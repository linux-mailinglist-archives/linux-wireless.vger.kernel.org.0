Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06863598A5F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Aug 2022 19:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344657AbiHRRWd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Aug 2022 13:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344724AbiHRRVy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Aug 2022 13:21:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A458D2A95F
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 10:21:17 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IGLnBX024138;
        Thu, 18 Aug 2022 17:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=A7xd0DPIco4eZGH13JBDsgQbZCffdTmHVtZ/LsjdIcQ=;
 b=oBt7KaedLNsurYKsttmBHXwqv0x8sVbrH093mcyf+nm0dC/MNMwdI4jz7aAF/P8+v3Uq
 0aKOlLHHLUvnFwNjmMuH+QQZXAEI1JI9AT9fcwxXHwWRAxojpmWClJ1mnYeSvlqLoVaM
 O1SRDAblMsAXUN+jJJ5V6qJLMDL1qSZ8NHrCZQAFI1yuak5/4n29DbfraBH3rWRFrEWC
 nv2u9BjlQJuUzO45PnyLi4DAeqrEJfn+AY95f0SVTevhX9qiOiRCg47J6Z/008RPBWtn
 6aooAt5vvX8QKsVgJG/VIQ33odbanwgTIgPozAwOY0E3rfNiAf8MXGdSHNRv48qTognb pQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j1rvb0865-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 17:21:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27IHLAjv014887
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 17:21:10 GMT
Received: from [10.110.11.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 18 Aug
 2022 10:21:10 -0700
Message-ID: <a48aef94-027f-562b-76ca-8b49c15c5c9c@quicinc.com>
Date:   Thu, 18 Aug 2022 10:21:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 24/50] wifi: ath12k: add hal_tx.c
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-25-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220812161003.27279-25-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ybHIG23hTNOB8wqIZKryvo71rtyNIADr
X-Proofpoint-GUID: ybHIG23hTNOB8wqIZKryvo71rtyNIADr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=954
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180063
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
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
>   drivers/net/wireless/ath/ath12k/hal_tx.c | 137 +++++++++++++++++++++++++++++++
>   1 file changed, 137 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/hal_tx.c b/drivers/net/wireless/ath/ath12k/hal_tx.c
> new file mode 100644
> index 000000000000..ac6f83ec06c2
> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath12k/hal_tx.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: BSD-3-Clause-Clear
> +/*
> + * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include "hal_desc.h"
> +#include "hal.h"
> +#include "hal_tx.h"
> +#include "hif.h"
> +
> +#define DSCP_TID_MAP_TBL_ENTRY_SIZE 64
> +
> +/* dscp_tid_map - Default DSCP-TID mapping
> + *
> + * DSCP        TID
> + * 000000      0

this comment confused me more than it helped me
IMO this would be a much better comment like:
  * 000xxx      0

> + * 001000      1
> + * 010000      2
> + * 011000      3
> + * 100000      4
> + * 101000      5
> + * 110000      6
> + * 111000      7
> + */
> +static const u8 dscp_tid_map[DSCP_TID_MAP_TBL_ENTRY_SIZE] = {
> +	0, 0, 0, 0, 0, 0, 0, 0,
> +	1, 1, 1, 1, 1, 1, 1, 1,
> +	2, 2, 2, 2, 2, 2, 2, 2,
> +	3, 3, 3, 3, 3, 3, 3, 3,
> +	4, 4, 4, 4, 4, 4, 4, 4,
> +	5, 5, 5, 5, 5, 5, 5, 5,
> +	6, 6, 6, 6, 6, 6, 6, 6,
> +	7, 7, 7, 7, 7, 7, 7, 7,
> +};

is a lookup table "better" than a simple:
static inline u8 dscp2tid(u8 dscp)
{
	return dscp >> 3;
}

> +
> +void ath12k_hal_tx_cmd_desc_setup(struct ath12k_base *ab,
> +				  struct hal_tcl_data_cmd *tcl_cmd,
> +				  struct hal_tx_info *ti)
> +{
> +	tcl_cmd->buf_addr_info.info0 =
> +		le32_encode_bits(ti->paddr, BUFFER_ADDR_INFO0_ADDR);
> +	tcl_cmd->buf_addr_info.info1 =
> +		le32_encode_bits(((uint64_t)ti->paddr >> HAL_ADDR_MSB_REG_SHIFT),
> +				 BUFFER_ADDR_INFO1_ADDR);
> +	tcl_cmd->buf_addr_info.info1 |=
> +		le32_encode_bits((ti->rbm_id), BUFFER_ADDR_INFO1_RET_BUF_MGR) |
> +		le32_encode_bits(ti->desc_id, BUFFER_ADDR_INFO1_SW_COOKIE);
> +
> +	tcl_cmd->info0 =
> +		le32_encode_bits(ti->type, HAL_TCL_DATA_CMD_INFO0_DESC_TYPE) |
> +		le32_encode_bits(ti->bank_id, HAL_TCL_DATA_CMD_INFO0_BANK_ID);
> +
> +	tcl_cmd->info1 =
> +		le32_encode_bits(ti->meta_data_flags,
> +				 HAL_TCL_DATA_CMD_INFO1_CMD_NUM);
> +
> +	tcl_cmd->info2 = cpu_to_le32(ti->flags0) |
> +		le32_encode_bits(ti->data_len, HAL_TCL_DATA_CMD_INFO2_DATA_LEN) |
> +		le32_encode_bits(ti->pkt_offset, HAL_TCL_DATA_CMD_INFO2_PKT_OFFSET);
> +
> +	tcl_cmd->info3 = cpu_to_le32(ti->flags1) |
> +		le32_encode_bits(ti->tid, HAL_TCL_DATA_CMD_INFO3_TID) |
> +		le32_encode_bits(ti->lmac_id, HAL_TCL_DATA_CMD_INFO3_PMAC_ID) |
> +		le32_encode_bits(ti->vdev_id, HAL_TCL_DATA_CMD_INFO3_VDEV_ID);
> +
> +	tcl_cmd->info4 = le32_encode_bits(ti->bss_ast_idx,
> +					  HAL_TCL_DATA_CMD_INFO4_SEARCH_INDEX) |
> +			 le32_encode_bits(ti->bss_ast_hash,
> +					  HAL_TCL_DATA_CMD_INFO4_CACHE_SET_NUM);
> +	tcl_cmd->info5 = 0;
> +}
> +
> +void ath12k_hal_tx_set_dscp_tid_map(struct ath12k_base *ab, int id)
> +{
> +	u32 ctrl_reg_val;
> +	u32 addr;
> +	u8 hw_map_val[HAL_DSCP_TID_TBL_SIZE];
> +	int i;
> +	u32 value;
> +	int cnt = 0;
> +
> +	ctrl_reg_val = ath12k_hif_read32(ab, HAL_SEQ_WCSS_UMAC_TCL_REG +
> +					 HAL_TCL1_RING_CMN_CTRL_REG);
> +	/* Enable read/write access */
> +	ctrl_reg_val |= HAL_TCL1_RING_CMN_CTRL_DSCP_TID_MAP_PROG_EN;
> +	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_TCL_REG +
> +			   HAL_TCL1_RING_CMN_CTRL_REG, ctrl_reg_val);
> +
> +	addr = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_DSCP_TID_MAP +
> +	       (4 * id * (HAL_DSCP_TID_TBL_SIZE / 4));
> +
> +	/* Configure each DSCP-TID mapping in three bits there by configure
> +	 * three bytes in an iteration.
> +	 */
> +	for (i = 0; i < DSCP_TID_MAP_TBL_ENTRY_SIZE; i += 8) {
> +		value = u32_encode_bits(dscp_tid_map[i],
> +					HAL_TCL1_RING_FIELD_DSCP_TID_MAP0) |
> +			u32_encode_bits(dscp_tid_map[i + 1],
> +					HAL_TCL1_RING_FIELD_DSCP_TID_MAP1) |
> +			u32_encode_bits(dscp_tid_map[i + 2],
> +					HAL_TCL1_RING_FIELD_DSCP_TID_MAP2) |
> +			u32_encode_bits(dscp_tid_map[i + 3],
> +					HAL_TCL1_RING_FIELD_DSCP_TID_MAP3) |
> +			u32_encode_bits(dscp_tid_map[i + 4],
> +					HAL_TCL1_RING_FIELD_DSCP_TID_MAP4) |
> +			u32_encode_bits(dscp_tid_map[i + 5],
> +					HAL_TCL1_RING_FIELD_DSCP_TID_MAP5) |
> +			u32_encode_bits(dscp_tid_map[i + 6],
> +					HAL_TCL1_RING_FIELD_DSCP_TID_MAP6) |
> +			u32_encode_bits(dscp_tid_map[i + 7],
> +					HAL_TCL1_RING_FIELD_DSCP_TID_MAP7);
> +
> +		memcpy(&hw_map_val[cnt], &value, 3);
> +		cnt += 3;
> +	}

since everything used to create hw_map_val[] is invariant, why not just 
have a static const array of the final values and get rid of the loop above?

> +
> +	for (i = 0; i < HAL_DSCP_TID_TBL_SIZE; i += 4) {
> +		ath12k_hif_write32(ab, addr, *(u32 *)&hw_map_val[i]);
> +		addr += 4;
> +	}
> +
> +	/* Disable read/write access */
> +	ctrl_reg_val = ath12k_hif_read32(ab, HAL_SEQ_WCSS_UMAC_TCL_REG +
> +					 HAL_TCL1_RING_CMN_CTRL_REG);
> +	ctrl_reg_val &= ~HAL_TCL1_RING_CMN_CTRL_DSCP_TID_MAP_PROG_EN;
> +	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_TCL_REG +
> +			   HAL_TCL1_RING_CMN_CTRL_REG,
> +			   ctrl_reg_val);
> +}
> +
> +void ath12k_hal_tx_configure_bank_register(struct ath12k_base *ab, u32 bank_config,
> +					   u8 bank_id)
> +{
> +	ath12k_hif_write32(ab, HAL_TCL_SW_CONFIG_BANK_ADDR + 4 * bank_id,
> +			   bank_config);
> +}
> 

