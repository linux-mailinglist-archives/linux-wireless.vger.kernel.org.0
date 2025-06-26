Return-Path: <linux-wireless+bounces-24565-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86153AEA3F6
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 19:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F854E2DCC
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 17:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E6A1C9DE5;
	Thu, 26 Jun 2025 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Sa780RSl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E74720A5F2
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957484; cv=none; b=urL5WlFX7jl6ikTzU1kmoMGZE9pC5Kw/gNHHZ7337fSsi5sgWpfS1l0ZpqKrSxZFEpJKjZAa3Yg8Y5vHKAkEMJqViUtEkhJMeJQe4RxG5xnpDlHaP/RLuio8S8PNUdYtnuppHBQggPg97YOFVTkiVagwm8vkeq6sikboZFLcIYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957484; c=relaxed/simple;
	bh=lw4XcbbehO4sWhnUzJtq3KTcXlVLfuffpeoO9uvunnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rfZmebDsISwV+p4ghsXAWIkLNOgB34xXSCA2zQTwOxvWIRo9tOJT8j7FsQaK72i2b5oBFlr/Rp/RfqgSu+4uWuoY0AmDFDS4CRnLaSOD6ihi88rsO9xdNMPL2PEMC3UiGYKeq2Mbpxtwv4MsJSluvrb5RId9M5XpweJsY5dmhYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Sa780RSl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9VPXH002543;
	Thu, 26 Jun 2025 17:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dg0mBkYT+QP2ktU/kqKfkv3uIhcvoU3fAutbeg0ijN4=; b=Sa780RSlVRtRsngO
	hHieL4QDCkPzzDvhoxe6ajZfx/fMDF5qe6j0h4oxGM9NpjpbvEPjVuaWAtMt03fH
	NYWmUS1RxKFUFi6fkHHHF/mHP7Vu4l+XPCmhrPPa43/7HLe0I+5j0b2OWCDg1AJF
	w0/Jfy1OfMMjoHVRs9LONNiBYKhs632qiVzsA6w9P6rbVRxik6VsJBpY/RVNcdPb
	PDgQlxZn6rTxlWrELKIxOt8+wcuZmIMgDSUiP5wZMmqCrQ1AjcFbbxmBEzw9+Hh8
	PHxQ0dg4pjCqMKoHQqTKqSUUyTmTxSsB6Q8pa45aGUzgHL03VQhUpTxbfRnyUA+p
	3fgn4A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47emcmwu20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 17:04:36 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55QH4ZQe003555
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 17:04:35 GMT
Received: from [10.216.56.23] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 26 Jun
 2025 10:04:33 -0700
Message-ID: <3580ebae-c37f-566a-c60c-d7d38869d055@quicinc.com>
Date: Thu, 26 Jun 2025 22:34:27 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: Add memset and update default rate
 value in wmi tx completion
Content-Language: en-US
To: Sarika Sharma <quic_sarishar@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250603063512.1887652-1-quic_sarishar@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250603063512.1887652-1-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pGkOC5BTLJC6EhKer9jkK44YYblPMhps
X-Proofpoint-ORIG-GUID: pGkOC5BTLJC6EhKer9jkK44YYblPMhps
X-Authority-Analysis: v=2.4 cv=J+eq7BnS c=1 sm=1 tr=0 ts=685d7da4 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=Z5984wXlbp5v_7kiN_0A:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDE0NSBTYWx0ZWRfX/fJsR+zy0lxZ
 fAYjLwU60oEqjJf6i0Bu/pXL0bwqeqHMpWdT2JRkU8r7NabBm03iP/q+5wEm70QPWrA063OBYNf
 bwQ1ZwhczKR8u3PBAhyuNSFtwZiPF7mffDpO2Xfp+c9jmB+DsWRDBY7fVAl/bqWtIkI+8wVwJOI
 5gNQmkScdhsTx6HcXGgZnxwFSl5XXfA2z1vkIlw7aBZ0izw88LeIx+BedL3Pehoi1VOMa1PpTbs
 zrtqDJG1xe5mtmIGFc6k23qx3RhuQUQi5AkujLpB6cxVhRWC5crbIP7rIUL2eG+xXopT6dQ0dVc
 6sYQf2i+X+avtaa1IDys7ClBZooblQojSNO9tJijF8+keLwW4/8I8JmkKFqdFYTOtp9iGA5yA7B
 huB0pjx36orIKnCRu8953pHU3nh86y52Id+D2ynIv+FCyUBMzAOcn4YqInWfZwlVCbKBp+nx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=821 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260145



On 6/3/2025 12:05 PM, Sarika Sharma wrote:
> When both AP/STA and monitor interfaces are enabled, ieee80211_tx_status()
> is invoked from two paths: the TX completion handler for data frames
> and the WMI TX completion handler for management frames.
> In the data path, the skb->cb is properly zeroed using memset, but in
> the WMI path, this step is missing.
> 
> As a result, mac80211 encountered uninitialized (junk) values in
> skb->cb when generating the radiotap header for monitor mode, leading
> to invalid radiotap lengths.
> 
> Hence, explicitly zero the status field in the skb->cb using memset
> in WMI TX completion path to ensure consistent and correct behavior
> during WMI tx completion path.
> 
> Additionally, set info->status.rates[0].idx = -1 to indicate that
> no valid rate information is available, avoiding misinterpretation of
> garbage values.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

