Return-Path: <linux-wireless+bounces-1855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3B382C8A6
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 02:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE140286D35
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 01:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD661A28F;
	Sat, 13 Jan 2024 01:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D0llb2ea"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31AA199D0
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jan 2024 01:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40D1Fe2e027336;
	Sat, 13 Jan 2024 01:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xd2j6VY7tEU0mG3+tnI03NPSq/5S2pr/cayR+Dn8gc4=; b=D0
	llb2eao5AKtM/oRYH0OshCLJd2DpB2vvnDkC+KYqFMWDaKSM2qXJBEFO6g9AE29s
	dmEIIEyhH79Zbdh8FGrOf+jjzvhaqKtwz+jq4YeWq+axVhN21bYz8j1vGQF1jrPo
	BrK/q9MnDB7dZfYic8qARNfNWDGmwcMCEZ5QFRUQ+DsV1wosXI6DKuTd/rxCJfyz
	83Poz/MTOym4CGs7zrttKxf7ZZ5FPXBLMU1/F4ylDdF2y66cPs9Ue9Wzg7OI3DkR
	MHq/qQsopJA7kIktm5eMOvONbJY+fA9nBSDBxBKe6q6pKd4jjRLQYWt3B3ZZW3+C
	u2j69cV9CNCPcemPmIxw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vk1x1a5w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jan 2024 01:22:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40D1MbNg030165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jan 2024 01:22:37 GMT
Received: from [10.110.118.97] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 12 Jan
 2024 17:22:36 -0800
Message-ID: <046cbe98-0577-4c42-8b2d-37fd9d4b8802@quicinc.com>
Date: Fri, 12 Jan 2024 17:22:35 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] wifi: ath12k: implement handling of P2P NoA
 event
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240112092824.7664-1-quic_kangyang@quicinc.com>
 <20240112092824.7664-4-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240112092824.7664-4-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: U-OMz1IboRrAXwoaYanw73r0RnGi9D9E
X-Proofpoint-GUID: U-OMz1IboRrAXwoaYanw73r0RnGi9D9E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=992 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401130009

On 1/12/2024 1:28 AM, Kang Yang wrote:
> The NoA(Notice of Absence) attribute is used by the P2P Group Owner to
> signal its absence due to power save timing, concurrent operation, or
> off-channel scanning. It is also used in the P2P Presence Request-Response
> mechanism.
> 
> The NoA attribute shall be present in the P2P IE in the beacon frames
> transmitted by a P2P Group Owner when a NoA schedule is being advertised,
> or when the CTWindow is non-zero.
> 
> So add support to update P2P information after P2P GO is up through
> event WMI_P2P_NOA_EVENTID, and always put it in probe resp.
> 
> Create p2p.c and p2p.h for P2P related functions and definitions.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---
> 
> v2: add Tested-on tag of QCN9274.
> 
> ---
>  drivers/net/wireless/ath/ath12k/Makefile |   3 +-
>  drivers/net/wireless/ath/ath12k/mac.c    |  25 +++-
>  drivers/net/wireless/ath/ath12k/p2p.c    | 142 +++++++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/p2p.h    |  23 ++++
>  drivers/net/wireless/ath/ath12k/wmi.c    |  51 +++++++-
>  drivers/net/wireless/ath/ath12k/wmi.h    |  31 +++++
>  6 files changed, 272 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath12k/p2p.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/p2p.h
> 
...
> @@ -6667,6 +6672,47 @@ static void ath12k_probe_resp_tx_status_event(struct ath12k_base *ab,
>  	kfree(tb);
>  }
>  
> +static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
> +				    struct sk_buff *skb)
> +{
> +	const void **tb;
> +	const struct wmi_p2p_noa_event *ev;
> +	const struct ath12k_wmi_p2p_noa_info *noa;
> +	struct ath12k *ar;
> +	int ret, vdev_id;
> +
> +	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	if (IS_ERR(tb)) {
> +		ret = PTR_ERR(tb);
> +		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ev = tb[WMI_TAG_P2P_NOA_EVENT];
> +	noa = tb[WMI_TAG_P2P_NOA_INFO];
> +
> +	if (!ev || !noa) {
> +		kfree(tb);
> +		return -EPROTO;
> +	}
> +
> +	vdev_id = __le32_to_cpu(ev->vdev_id);
> +
> +	ath12k_dbg(ab, ATH12K_DBG_WMI,
> +		   "wmi tlv p2p noa vdev_id %i descriptors %u\n",
> +		   vdev_id, le32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_DESC_NUM));
> +	ar = ath12k_mac_get_ar_by_vdev_id(ab, vdev_id);
> +	if (!ar) {

missing kfree(tb);

> +		ath12k_warn(ab, "invalid vdev id %d in P2P NoA event\n",
> +			    vdev_id);
> +		return -EINVAL;
> +	}
> +
> +	ath12k_p2p_noa_update_by_vdev_id(ar, vdev_id, noa);
> +	kfree(tb);
> +	return 0;
> +}
> +
>  static void ath12k_rfkill_state_change_event(struct ath12k_base *ab,
>  					     struct sk_buff *skb)
>  {


