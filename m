Return-Path: <linux-wireless+bounces-669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7087A80D398
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 18:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2731A1F21675
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 17:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D464D589;
	Mon, 11 Dec 2023 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ALm9lrsE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F82BD
	for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 09:21:07 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BBEgpar024067;
	Mon, 11 Dec 2023 17:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=IDy0yyCxa4c+6BBOBc1lc0QHmo5dj/OLAxxkTBuCR/M=; b=AL
	m9lrsEcUlOyn00XAX/kQSpQnjYlv12rmZCZ3C3FGQjMndJDbAzK4U0j3SP6EReH1
	5sBL2vfzH3tmRAiKqD80RM7SbBg4X9xYep9iMFYwO5DwjdyBC3nhckWH4L3AZyQy
	24ZvWDQEhtYZP+bQgkS11BcnUjBSWWKtvlY/ug4z0BtgZTfw35gaCUDvpIYXP6Ub
	QqwcQ4/vLvxebssMFc1rt74zGf61EM5Y3VFSVhh7f9WmlxjRkFUAAsyRzIL5Rlzg
	ptXbRyHH3U3XsVjdNM/kI7THaYyD2BC/JWEZyzTehR4x3rHkPK+Pe9fqGLbnUADv
	22eD0G3BlEBUgmNvDNzA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uvnv8bw32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 17:21:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BBHL1in019044
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 17:21:01 GMT
Received: from [10.216.30.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 11 Dec
 2023 09:20:59 -0800
Message-ID: <87882ad2-496b-4e7d-80d1-39d121f04ca3@quicinc.com>
Date: Mon, 11 Dec 2023 22:50:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/12] wifi: ath11k: update regulatory rules when
 interface added
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20231211062216.382164-1-quic_bqiang@quicinc.com>
 <20231211062216.382164-5-quic_bqiang@quicinc.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <20231211062216.382164-5-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QgcmX7jP602PQekJJBE89B4MUmHUH4qn
X-Proofpoint-GUID: QgcmX7jP602PQekJJBE89B4MUmHUH4qn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=712 suspectscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 mlxscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312110142

On 12/11/23 11:52, Baochen Qiang wrote:
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index 7f7b39817773..1e314fcab41b 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -6943,6 +6943,14 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
>   				    ret);
>   	}
>   
> +	if (ath11k_wmi_supports_6ghz_cc_ext(ar)) {
> +		struct cur_regulatory_info *reg_info;
> +
> +		reg_info = &ab->reg_info_store[ar->pdev_idx];
> +		ath11k_dbg(ab, ATH11K_DBG_MAC, "mac interface added to change reg rules\n");
> +		ath11k_reg_handle_chan_list(ab, reg_info, IEEE80211_REG_LPI_AP);
> +	}
> +
So we update the rules by default for AP. Then in next patch 5/12, once 
STA connects to AP, we put the proper power mode and refresh the rules.

So if user wants to bring up 1 STA interface alone, in total 3 
regulatory updates will happen from driver to upper layer -
1. During initial boot time
2. During interface create time (above hunk)
3. During channel context assignment (5/12 patch)

Does this seem good? 3 times we would be changing regulatory rules and 
first 2 times we are doing the same thing.

