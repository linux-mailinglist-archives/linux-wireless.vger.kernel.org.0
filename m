Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFCD598F4F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Aug 2022 23:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243007AbiHRVSK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Aug 2022 17:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346824AbiHRVRx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Aug 2022 17:17:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF943D41A1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 14:11:04 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IKuWZl002875;
        Thu, 18 Aug 2022 21:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=p6enczkGghM1lldbfNj5si3H4rzLzMZ4iCbsyRb+PQQ=;
 b=QYMA+e2gtH5tBNa3cu9L5EA5zqZDibr0xlZAart+oKeayLxtHLLXUTQ5bAvRhQw7nvtw
 1PsiXM8rZXuccsftGNO/75XH/xpUuysGhDX4vgBjsYh5F/f5gmwwWPV1vqFZbU+odDNr
 p9y12yKJL6ik5ZHCFAcguzBgcOULFsEg+q1+wQXFz0C0/iGlQuIrbIiGk4MfmUH8HiIF
 rvHzLNHRId8ffYdIB8Y6jFZNh7Cn6GA4P6Yb2+5SdXr8ZBcMszqJKUaSwYnmNIVOoKf6
 p1ZnBacMPTGb6b+Keou9rUo7UQsSgtbiVjJfEnGe7B9WoADEBzw9tKeI57YSj+f/8poB GA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j1ttq8cvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 21:10:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27ILAseB006022
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 21:10:54 GMT
Received: from [10.110.11.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 18 Aug
 2022 14:10:54 -0700
Message-ID: <b46f6c1c-0b3d-0960-b655-46567ede41d0@quicinc.com>
Date:   Thu, 18 Aug 2022 14:10:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 28/50] wifi: ath12k: add htc.h
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-29-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220812161003.27279-29-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cYB2dDpNSM3NXEi3_2B0y4YPKS0rMnzc
X-Proofpoint-ORIG-GUID: cYB2dDpNSM3NXEi3_2B0y4YPKS0rMnzc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_16,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxscore=0 mlxlogscore=895
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180076
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
>   drivers/net/wireless/ath/ath12k/htc.h | 311 ++++++++++++++++++++++++++++++++++
>   1 file changed, 311 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/htc.h b/drivers/net/wireless/ath/ath12k/htc.h

snip

> +#define ATH12K_HTC_CONN_FLAGS_THRESHOLD_LEVEL_MASK GENMASK(1, 0)
> +#define ATH12K_HTC_CONN_FLAGS_RECV_ALLOC GENMASK(15, 8)
> +
> +enum ath12k_htc_conn_flags {
> +	ATH12K_HTC_CONN_FLAGS_THRESHOLD_LEVEL_ONE_FOURTH    = 0x0,
> +	ATH12K_HTC_CONN_FLAGS_THRESHOLD_LEVEL_ONE_HALF      = 0x1,
> +	ATH12K_HTC_CONN_FLAGS_THRESHOLD_LEVEL_THREE_FOURTHS = 0x2,
> +	ATH12K_HTC_CONN_FLAGS_THRESHOLD_LEVEL_UNITY         = 0x3,

it seems strange to call a 2-bit field a flag

> +	ATH12K_HTC_CONN_FLAGS_REDUCE_CREDIT_DRIBBLE    = 1 << 2,
> +	ATH12K_HTC_CONN_FLAGS_DISABLE_CREDIT_FLOW_CTRL = 1 << 3
> +};

and it seems strange to have an enum which incorporates the values of 
the ATH12K_HTC_CONN_FLAGS_THRESHOLD_LEVEL_MASK along with definitions of 
other mask flags.

perhaps these would be more logically defined as macros just after 
ATH12K_HTC_CONN_FLAGS_THRESHOLD_LEVEL_MASK:
#define ATH12K_HTC_CONN_FLAGS_THRESHOLD_LEVEL_MASK GENMASK(1, 0)
#define ATH12K_HTC_CONN_FLAGS_REDUCE_CREDIT_DRIBBLE BIT(2)
#define ATH12K_HTC_CONN_FLAGS_DISABLE_CREDIT_FLOW_CTRL BIT(3)

and then rename ath12k_htc_conn_flags to be more specific that it just 
has threshold level values?

> +
> +enum ath12k_htc_conn_svc_status {
> +	ATH12K_HTC_CONN_SVC_STATUS_SUCCESS      = 0,
> +	ATH12K_HTC_CONN_SVC_STATUS_NOT_FOUND    = 1,
> +	ATH12K_HTC_CONN_SVC_STATUS_FAILED       = 2,
> +	ATH12K_HTC_CONN_SVC_STATUS_NO_RESOURCES = 3,
> +	ATH12K_HTC_CONN_SVC_STATUS_NO_MORE_EP   = 4
> +};
> +
> +struct ath12k_htc_ready {
> +	__le32 id_credit_count;
> +	__le32 size_ep;
> +} __packed;
> +
> +struct ath12k_htc_ready_extended {
> +	struct ath12k_htc_ready base;
> +	__le32 ver_bundle;
> +} __packed;
> +
> +struct ath12k_htc_conn_svc {
> +	__le32 msg_svc_id;
> +	__le32 flags_len;
> +} __packed;
> +
> +struct ath12k_htc_conn_svc_resp {
> +	__le32 msg_svc_id;
> +	__le32 flags_len;
> +	__le32 svc_meta_pad;
> +} __packed;
> +
> +struct ath12k_htc_setup_complete_extended {
> +	__le32 msg_id;

is there a reason this isn't msg_svc_id to be consistent with the other 
htc messages?

or even have every htc msg begin with a struct ath12k_htc_msg hdr?

perhaps also consider some naming conventions similar to what were 
adopted for WMI?

> +	__le32 flags;
> +	__le32 max_msgs_per_bundled_recv;
> +} __packed;
> +
> +struct ath12k_htc_msg {
> +	__le32 msg_svc_id;
> +	__le32 flags_len;
> +} __packed __aligned(4);
> +
> +enum ath12k_htc_record_id {
> +	ATH12K_HTC_RECORD_NULL    = 0,
> +	ATH12K_HTC_RECORD_CREDITS = 1
> +};
> +
> +struct ath12k_htc_record_hdr {
> +	u8 id; /* @enum ath12k_htc_record_id */
> +	u8 len;
> +	u8 pad0;
> +	u8 pad1;
> +} __packed;
> +
> +struct ath12k_htc_credit_report {
> +	u8 eid; /* @enum ath12k_htc_ep_id */
> +	u8 credits;
> +	u8 pad0;
> +	u8 pad1;
> +} __packed;
> +
> +struct ath12k_htc_record {
> +	struct ath12k_htc_record_hdr hdr;
> +	union {
> +		struct ath12k_htc_credit_report credit_report[0];
> +		u8 pauload[0];

s/pauload/payload/?

s/[0]/[]/ per 
<https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays>

> +	};
> +} __packed __aligned(4);
> +
> +/* note: the trailer offset is dynamic depending
> + * on payload length. this is only a struct layout draft
> + */
> +struct ath12k_htc_frame {
> +	struct ath12k_htc_hdr hdr;
> +	union {
> +		struct ath12k_htc_msg msg;
> +		u8 payload[0];

s/[0]/[]/

> +	};
> +	struct ath12k_htc_record trailer[0];


s/[0]/[]/

but this struct makes no sense. you can't have a variable-length payload 
that isn't at the end of the struct

if this is just supposed to be some sort of pseudo-documentation then 
perhaps put it in a comment so that the compiler won't see this?

or perhaps even better draw an ASCII representation?

> +} __packed __aligned(4);

rest snipped
