Return-Path: <linux-wireless+bounces-27080-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD241B4886E
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 11:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795F53B7947
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 09:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7932EFD81;
	Mon,  8 Sep 2025 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lSOz04J7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6992F068E;
	Mon,  8 Sep 2025 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323760; cv=none; b=q7NfKonqx5FxlkHDtu3oZ/irC83WsTa3V63v90CvOAVPL5d9ZMRxRMCD4t7L7f3olsNhpoHj/b3zi9pAOCfrSsdmf2S0RGRjABGe4RJ7w5VmYugk+3NtXL+fPTngBE/xW6CI3ZXZm4O6X79yzOXWFV/HZ/nnWAqekSVTTpysS60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323760; c=relaxed/simple;
	bh=bG84PCIVbnvHpidwkN9OmAA2FCCs9kkn3DxkZehuz5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CbK8trRZtywYf/AcTrAaOFRJYsOZnaAO+zDgMfdMU2pH6wdOx7L3b+9rsX7ZlkDOslSlq8pGsEq/86CPGHtxE+7IggleBlgy6ErhpLqxUGobQNdYqliJ9l3bsjoQ6GGjFM0sMm2T7qTHc+21YM0qlr8ToUTf2vcFFZLSsl9OfFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lSOz04J7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5888wZeG008832;
	Mon, 8 Sep 2025 09:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jzH5e3TRkeUoqbXoi2uQG9jgA9WM+uAuto/uJGKlYrA=; b=lSOz04J7jhCYCiwz
	zbqlCIfmQhQIIjfdTdaEobDFsFNZFHCZrE4dVO29Ect4T+63rzYVGfy1R5iXDqGT
	BRXr3r8hHAJq4oVKxuisxmW5MZyLxQFKV8hPUFrQCIZAJvNlFzjRl1ibcGjfs8D1
	JknUqBDHtSPgs7uZWJF8ew7GV1+qY7BN1HJLkGF04uJoEKjW6hslkLW5/m+Z+p/B
	RyU3Mdh3O4S/kXujDEg8f2Wu8OHZqPxr61ta294EeFStHz7khY+MDV3okfTKKLpF
	q5yEJLNvYtHu7lPVMZmdub32QRz/GbZmAQ2yFRoxMp8a2K5pEZw0Ow8vpKIK85Ko
	/QNBxQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0m2ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 09:29:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5889TCmH031523
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Sep 2025 09:29:12 GMT
Received: from [10.133.33.112] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Mon, 8 Sep
 2025 02:29:11 -0700
Message-ID: <34f0689a-bfac-4363-a35b-069ae88f0dde@quicinc.com>
Date: Mon, 8 Sep 2025 17:29:06 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath12k: fix WMI TLV header misalignment
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, <jjohnson@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250908015139.1301437-1-miaoqing.pan@oss.qualcomm.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250908015139.1301437-1-miaoqing.pan@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mYBTYlZqi1K523x4r6pyJts4CTUlw5Br
X-Proofpoint-GUID: mYBTYlZqi1K523x4r6pyJts4CTUlw5Br
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfXwwQ/2EIekPbC
 hFMhjGoBXGjEpQO0c4xZQ8CZOJDG5ysjtz2hs9RLlin5RlwOk7nGVHvcGIDaFq1+89nE/qNc0KW
 7hQ1VaJHO2sEM2/auiHtn+sAhEyV8wNm+oC9LFNS0hlNa4BIGOZvjfH6v9Atz03/SifSxboc2lg
 qhqBhZPL3S6diW6u3lgXBWbU+JxIkgVGkaaWotLJaAO29WaOuetlAT3EtLddC689v+0d0c8JSql
 bQ3PempYicyplUtVIBmAFzNohZUXBpPrCpIPhUkDLp5ptiSnCws8kZOu5xciZ8uE0oVqqLDDvRb
 /lw+izJ1nAvG1MzVc00UjkMC7KzrJkqQ/we7CX2mIAhdsjWgm+fcGHueu/SaoaKe8O67zP4OaUt
 8OVABC/2
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68bea1e9 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8
 a=J7m7x4hWGeMiwygy9zQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024



On 9/8/2025 9:51 AM, Miaoqing Pan wrote:
> When buf_len is not 4-byte aligned in ath12k_wmi_mgmt_send(), the
> firmware asserts and triggers a recovery. The following error
> messages are observed:
> 
> ath12k_pci 0004:01:00.0: failed to submit WMI_MGMT_TX_SEND_CMDID cmd
> ath12k_pci 0004:01:00.0: failed to send mgmt frame: -108
> ath12k_pci 0004:01:00.0: failed to tx mgmt frame, vdev_id 0 :-108
> ath12k_pci 0004:01:00.0: waiting recovery start...
> 
> This issue was observed when running 'iw wlanx set power_save off/on'
> in MLO station mode, which triggers the sending of an SMPS action frame
> with a length of 27 bytes to the AP. To resolve the misalignment, use
> buf_len_aligned instead of buf_len when constructing the WMI TLV header.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00011-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/wmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 742ffeb48bce..29dadedefdd2 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -843,7 +843,7 @@ int ath12k_wmi_mgmt_send(struct ath12k_link_vif *arvif, u32 buf_id,
>  	cmd->tx_params_valid = 0;
>  
>  	frame_tlv = (struct wmi_tlv *)(skb->data + sizeof(*cmd));
> -	frame_tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE, buf_len);
> +	frame_tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE, buf_len_aligned);
>  
>  	memcpy(frame_tlv->value, frame->data, buf_len);
>  
> 
> base-commit: 27893dd6341b929f87d45fc4d65c5778179319dd

Reviewed-by:  Baochen Qiang <baochen.qiang@oss.qualcomm.com>



