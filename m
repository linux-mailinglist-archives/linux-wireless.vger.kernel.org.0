Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F90598C9E
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Aug 2022 21:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345579AbiHRTd1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Aug 2022 15:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237765AbiHRTd0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Aug 2022 15:33:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E91ADEA
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 12:33:17 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IH8wDV029356;
        Thu, 18 Aug 2022 19:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tiaO5wAkOZaltS8Kv1W+zxw75ASGHi2FprBar7GebA8=;
 b=QtvP35ECVMo1rrFiBGNBLCdQCp9FOeyC5yVBG8JNHs5RVEDKRcKsYvoFMy2PalJ5uuCm
 8Fw3ypwVkmQTYTydHFS/Y2wXmJE5/V0OumQsCg6F8ssjjueh72ecuVxPyRNY4t2/2yRj
 mIbk5yOB9rVhj/v1Xsku5JW/LVhpactLovUCYxrjMf+dBezcxKkKsGrM+0DPufeUltWj
 Iht02Y0XXtkkSyXuzz52J//lx6QrUVjI/ITQ5yke83uDZmb128hZV3B6c2yXSufNHWfZ
 YGemmT44vokbV2Q4vnIxJ74tgYSaxbwEZVMDDcXWY14Ly+lQj4xR9I4d9Yn+1XoLTci4 dw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j1sjr0jcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 19:33:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27IJX7WT024124
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 19:33:07 GMT
Received: from [10.110.11.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 18 Aug
 2022 12:33:06 -0700
Message-ID: <8ebc4b7e-6b65-8443-eac6-13b940337166@quicinc.com>
Date:   Thu, 18 Aug 2022 12:33:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 27/50] wifi: ath12k: add htc.c
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-28-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220812161003.27279-28-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: i3zuArDT8p8m6jc8imCx92zhn_LtXP9S
X-Proofpoint-GUID: i3zuArDT8p8m6jc8imCx92zhn_LtXP9S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_14,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180070
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
>   drivers/net/wireless/ath/ath12k/htc.c | 789 ++++++++++++++++++++++++++++++++++
>   1 file changed, 789 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/htc.c b/drivers/net/wireless/ath/ath12k/htc.c

snip

> +static struct sk_buff *ath12k_htc_build_tx_ctrl_skb(void *ab)

why void * instead of struct ath12k_base *?

> +{
> +	struct sk_buff *skb;
> +	struct ath12k_skb_cb *skb_cb;
> +
> +	skb = dev_alloc_skb(ATH12K_HTC_CONTROL_BUFFER_SIZE);
> +	if (!skb)
> +		return NULL;
> +
> +	skb_reserve(skb, sizeof(struct ath12k_htc_hdr));
> +	WARN_ON_ONCE(!IS_ALIGNED((unsigned long)skb->data, 4));
> +
> +	skb_cb = ATH12K_SKB_CB(skb);
> +	memset(skb_cb, 0, sizeof(*skb_cb));
> +
> +	ath12k_dbg(ab, ATH12K_DBG_HTC, "%s: skb %pK\n", __func__, skb);

does this log really serve any useful purpose?

> +	return skb;
> +}
> +

snip

> +static u8 ath12k_htc_get_credit_allocation(struct ath12k_htc *htc,
> +					   u16 service_id)
> +{
> +	u8 i, allocation = 0;
> +
> +	for (i = 0; i < ATH12K_HTC_MAX_SERVICE_ALLOC_ENTRIES; i++) {
> +		if (htc->service_alloc_table[i].service_id == service_id) {
> +			allocation =
> +				htc->service_alloc_table[i].credit_allocation;

should you break from the loop here, or can there be more/bigger 
allocations for the same service id?

> +		}
> +	}
> +
> +	return allocation;
> +}
> +
> +static int ath12k_htc_setup_target_buffer_assignments(struct ath12k_htc *htc)
> +{
> +	struct ath12k_htc_svc_tx_credits *serv_entry;
> +	u32 svc_id[] = {

static const?

> +		ATH12K_HTC_SVC_ID_WMI_CONTROL,
> +		ATH12K_HTC_SVC_ID_WMI_CONTROL_MAC1,
> +		ATH12K_HTC_SVC_ID_WMI_CONTROL_MAC2,
> +	};
> +	int i, credits;
> +
> +	credits = htc->total_transmit_credits;
> +	serv_entry = htc->service_alloc_table;
> +
> +	if ((htc->wmi_ep_count == 0) ||
> +	    (htc->wmi_ep_count > ARRAY_SIZE(svc_id)))
> +		return -EINVAL;
> +
> +	/* Divide credits among number of endpoints for WMI */
> +	credits = credits / htc->wmi_ep_count;
> +	for (i = 0; i < htc->wmi_ep_count; i++) {
> +		serv_entry[i].service_id = svc_id[i];
> +		serv_entry[i].credit_allocation = credits;
> +	}
> +
> +	return 0;
> +}
> +

snip

> +int ath12k_htc_start(struct ath12k_htc *htc)
> +{
> +	struct sk_buff *skb;
> +	int status = 0;

nit: initializer always overwritten by ath12k_htc_send()?

> +	struct ath12k_base *ab = htc->ab;
> +	struct ath12k_htc_setup_complete_extended *msg;
> +
> +	skb = ath12k_htc_build_tx_ctrl_skb(htc->ab);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	skb_put(skb, sizeof(*msg));
> +	memset(skb->data, 0, skb->len);
> +
> +	msg = (struct ath12k_htc_setup_complete_extended *)skb->data;
> +	msg->msg_id = le32_encode_bits(ATH12K_HTC_MSG_SETUP_COMPLETE_EX_ID,
> +				       HTC_MSG_MESSAGEID);
> +
> +	ath12k_dbg(ab, ATH12K_DBG_HTC, "HTC is using TX credit flow control\n");
> +
> +	status = ath12k_htc_send(htc, ATH12K_HTC_EP_0, skb);
> +	if (status) {
> +		kfree_skb(skb);
> +		return status;
> +	}
> +
> +	return 0;
> +}
> +
> +int ath12k_htc_init(struct ath12k_base *ab)
> +{
> +	struct ath12k_htc *htc = &ab->htc;
> +	struct ath12k_htc_svc_conn_req conn_req;
> +	struct ath12k_htc_svc_conn_resp conn_resp;
> +	int ret;
> +
> +	spin_lock_init(&htc->tx_lock);
> +
> +	ath12k_htc_reset_endpoint_states(htc);
> +
> +	htc->ab = ab;
> +
> +	switch (ab->wmi_ab.preferred_hw_mode) {
> +	case WMI_HOST_HW_MODE_SINGLE:
> +		htc->wmi_ep_count = 1;
> +		break;
> +	case WMI_HOST_HW_MODE_DBS:
> +	case WMI_HOST_HW_MODE_DBS_OR_SBS:
> +		htc->wmi_ep_count = 2;
> +		break;
> +	case WMI_HOST_HW_MODE_DBS_SBS:
> +		htc->wmi_ep_count = 3;
> +		break;
> +	default:
> +		htc->wmi_ep_count = ab->hw_params->max_radios;
> +		break;
> +	}
> +
> +	/* setup our pseudo HTC control endpoint connection */
> +	memset(&conn_req, 0, sizeof(conn_req));
> +	memset(&conn_resp, 0, sizeof(conn_resp));

is this better than having = {} initializers?

> +	conn_req.ep_ops.ep_tx_complete = ath12k_htc_control_tx_complete;
> +	conn_req.ep_ops.ep_rx_complete = ath12k_htc_control_rx_complete;
> +	conn_req.max_send_queue_depth = ATH12K_NUM_CONTROL_TX_BUFFERS;
> +	conn_req.service_id = ATH12K_HTC_SVC_ID_RSVD_CTRL;
> +
> +	/* connect fake service */
> +	ret = ath12k_htc_connect_service(htc, &conn_req, &conn_resp);
> +	if (ret) {
> +		ath12k_err(ab, "could not connect to htc service (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	init_completion(&htc->ctl_resp);
> +
> +	return 0;
> +}
> 

