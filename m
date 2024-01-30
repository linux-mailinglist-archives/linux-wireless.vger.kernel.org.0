Return-Path: <linux-wireless+bounces-2839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C97B2842A53
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 18:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4231F26389
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 17:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55CB4C91;
	Tue, 30 Jan 2024 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Oppb0o/e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215AF1292C2
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634202; cv=none; b=qN2DJnzBAf/0qgX5so4u0+twyW7sTtQeEfVl9VTd5ci4gEuruiQq3zNRCcN/keDIt9wzmG8W3mll0oAnOK7HMK7W0g7EnV0dj0dFa3dzFUHy1JBoc3zOcghwKvBEetLMh1fgEgRl6DUON3/lVxSOgC77yZoM3f1OW7LpSXn9fKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634202; c=relaxed/simple;
	bh=Op6hzq8Oiv7WLg9MVOG3ViB/ncv1rx+IRb0dQIW2OtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PUtq3gxHSCy4yfgWQhIH6QeAnmH1FvvWtJuTitawZwa7DCMrENU5d0Oyp27HEDqDe9IRQNPxGNvxlDACIKKSjdB5x3/BBxw3Teiec6x9xvgi6SZuuX7Q53U+1sGH9oCw2d+SnTKf6SJj2Zm89urLF4juQNAxwqZXV1FOAL+csY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Oppb0o/e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UDw6aR023962;
	Tue, 30 Jan 2024 17:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=R91xTAZZLScQein94RfA/1kNt+S9K1rKtqX2d0Y6oPA=; b=Op
	pb0o/el6tugu6MsH0jQj+7TQzxZvfoI1EDoGC94ClMYk0R9ed0o4M+a3E1dMecj5
	z4Dv5c7T3sOxEaa8RFxGt+1M7Edh2N07sIA4eml3S451yMV2vKLowmj6SDq75SUv
	W1VVfPnsr1DB3H70Ifm9IpBi4WSQCVONCplBGlRafj9GGTBzdZuskeReePMOBmzh
	rcZbGoafMhuTglGKO6vD4c290HyUOxXeDo81Z6NZ9Q2qh66Yca4AzUDRxBSFGDY0
	5tmsrfT749nVytPiAX4ppk6CPKzFm6E7Mp0lnXsbF7iovebPR5ODqRD9N+g13lGI
	wyhu+OPlPn9tFLfJG/ZQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxvwqs9c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 17:03:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UH2t2h023579
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 17:02:55 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 09:02:55 -0800
Message-ID: <f947f804-6fd1-41eb-8b6f-c562d51e5441@quicinc.com>
Date: Tue, 30 Jan 2024 09:02:54 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/11] wifi: ath12k: add P2P IE in beacon template
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
 <20240130040303.370590-5-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240130040303.370590-5-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JRMmqsgLw1jy_BiyDBaE4YlGh47vGPJS
X-Proofpoint-GUID: JRMmqsgLw1jy_BiyDBaE4YlGh47vGPJS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_07,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=981
 spamscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401300126

On 1/29/2024 8:02 PM, Kang Yang wrote:
> P2P Element is a necessary component of P2P protocol communication.
> It contains the Vendor Specific Information Element which includes
> the WFA OUI and an OUI Type indicating P2P.
> 
> Add P2P IE in beacon template, and implement WMI interface for it.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---
> 
> v6: no change.
> v5: no change.
> v4: no change.
> v3: no change.
> v2:
>     1. add Tested-on tag of QCN9274.
>     2. update copyright.
> 
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 85 ++++++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/wmi.c | 39 ++++++++++++
>  drivers/net/wireless/ath/ath12k/wmi.h | 10 +++-
>  3 files changed, 131 insertions(+), 3 deletions(-)
...
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -1713,6 +1713,45 @@ int ath12k_wmi_send_bcn_offload_control_cmd(struct ath12k *ar,
>  	return ret;
>  }
>  
> +int ath12k_wmi_p2p_go_bcn_ie(struct ath12k *ar, u32 vdev_id,
> +			     const u8 *p2p_ie)
> +{
...
> +	ptr = skb->data;
> +	cmd = ptr;
> +	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_P2P_GO_SET_BEACON_IE,
> +						 sizeof(*cmd));
> +	cmd->vdev_id = cpu_to_le32(vdev_id);
> +	cmd->ie_buf_len = cpu_to_le32(p2p_ie_len);
> +
> +	ptr = skb->data + sizeof(*cmd);

IMO better would be: ptr += sizeof(*cmd);

Kalle can probably adjust this in the pending branch

> +	tlv = ptr;
> +	tlv->header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_ARRAY_BYTE,
> +					     aligned_len);
> +	memcpy(tlv->value, p2p_ie, p2p_ie_len);
> +
> +	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_P2P_GO_SET_BEACON_IE);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to send WMI_P2P_GO_SET_BEACON_IE\n");
> +		dev_kfree_skb(skb);
> +	}
> +
> +	return ret;
> +}

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



