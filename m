Return-Path: <linux-wireless+bounces-22793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04170AB18D0
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 17:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62A703A2D4D
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 15:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92E722E3E0;
	Fri,  9 May 2025 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TiXupP/U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432DC22CBE9
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746804898; cv=none; b=TDq1CV/OhXIODDDen/cMrIKbDgq10dLDaxZtCN+k1EJ06YJQZrFQF5WbyMr1+kh8DjrGu20kYz3T8n3XxVCf18O4b2wSAA3mm3+WPyf1v7AYdviAvIst2pQO9Y6Mp+VVJPG4jlR1+7NisfZvBD43YysqZdxuiPh6WTl6kdLeYCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746804898; c=relaxed/simple;
	bh=jt5rb8d5fKE4a3vlYY5cMVaZ1rxZaincj0NA4OY4gvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KDSbVQJtdYkG2h9tET872CKox80+S57aPeIn+p/px/4vO0uS2BZF2k6NgusFUBuH8nbHVPpXXPOvaza7CJEhF/uXmXRIFD3KRTcBuhbXYtOplFwdgXd/f3EuTjDl/nAx31ozC6bpFxVYBv8jKdXjXQKjmV+6vdXLc2foztPxAxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TiXupP/U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5497mmnx019353;
	Fri, 9 May 2025 15:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hLAgz81NgOrdhBcH1vnfPBEBFEqANxBTAuyVS9y0I9k=; b=TiXupP/Ujv5tqw55
	DNYljiCk9RZ2fdQzFdUYavXhs0HaJdBGIXpkHkgRnW9e/6Uv5/Zo4VuPPmvmaokU
	nBF7xyfuVlww8XN1VErwvaX2UrVPiVWFt3XJG4I1gWZ32xcfnkhUX3FyltzZ/SZp
	nb0e4eVhHa2amKNegxwzNJ0LGWHUft7HT9HkD8QSY5rYJ7YS0KTe4E9+xBQNl5Kv
	0++2JBm8G3b3skQ8AUHHY3KdBYor6z8s9Pvke2FOiB0deeQhT1J+2l6qB6xkzv+8
	ulsTBMVAoFo7PamSRQQ75uTrK+SCV3N2aF1JEIHV8FezPi/BtxKI6FGOIuz7CMrh
	PCTW1Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gsdj4jma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 15:34:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 549FYjxb011981
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 May 2025 15:34:45 GMT
Received: from [10.216.9.250] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 9 May 2025
 08:34:42 -0700
Message-ID: <45f60f9b-66ff-6bc1-f77d-c29f255a2fee@quicinc.com>
Date: Fri, 9 May 2025 21:04:38 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] wifi: ath11k: support DBS and DFS compatibility
Content-Language: en-US
To: "Yu Zhang(Yuriy)" <quic_yuzha@quicinc.com>, <kvalo@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, Mihai Moldovan <ionic@ionic.de>
References: <20241127022742.4016870-1-quic_yuzha@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20241127022742.4016870-1-quic_yuzha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=PMAP+eqC c=1 sm=1 tr=0 ts=681e2096 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=bC-a23v3AAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=AOP5zEUh8TzVeoG01q4A:9 a=QEXdDO2ut3YA:10
 a=-FEs8UIgK8oA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDE1MyBTYWx0ZWRfX0I79IZYkpF96
 qxbTLkOVmMp9A4LNS8lfXbYzBjIBvLQ8ORzvOxWAFcZp9yzxg/BLlfUx0fFnHTv57YGOyCZ1a1M
 +MDKbZ28EzNm7xaFFPPa3aRSOzPevL55EunpQtOekDV9Z6h+BLd8g1+Ihmr7ZF+Lofmh3WC3nEX
 UVorP0vkLdwstaCvYTKi83R4xSJJaniHP71uIvLu9l+UtB2R6YlV9LSEaz8hl7C7w3HK9KnBVll
 Yh5eu6tAcesLjKM09C+PbRfy1a1FT4eOoKO1BNRdvCO1eKpcYlvymVeEi83NLV58l8UBm6xZIG7
 FS6BB2MpqG7m/ga6E8U4nSgcLWhbg/57MP3Pp5vwEAspf5oWMNaCuI/ezHVw3Mrrw8LDWGauy1y
 OYfFjjwhgjYHocmR46NO9mynQSy2vGwK01x9C9JV13zb7hB1MnxmAYBQ1qqf/zpJTGUm3nN8
X-Proofpoint-GUID: 7jPHvQtOneHefREtHzIq9j9pKHp7ynNt
X-Proofpoint-ORIG-GUID: 7jPHvQtOneHefREtHzIq9j9pKHp7ynNt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 lowpriorityscore=0
 mlxlogscore=616 adultscore=0 malwarescore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505090153



On 11/27/2024 7:57 AM, Yu Zhang(Yuriy) wrote:
> Now some chips which support 'support_dual_stations' will enable DBS,
> but will disable DFS. Restructure the ath11k_mac_setup_iface_combinations
> function to support DBS and DFS compatibility.
> 
> About 'support_dual_station' feature can refer:
> https://msgid.link/20230714023801.2621802-2-quic_cjhuang@quicinc.com
> 
> Add a ieee80211_iface_combination to support DBS and DFS compatibility,
> one combination can support DFS(same with non dual sta), another
> combination can support DBS. When running different scenarios that will
> use different ieee80211_iface_combination due to mac80211 will go through
> all of possible interface combinations.
> 
> In addition, maximum number of interfaces of these types should be total
> allowed in this group.
> 
> The chips affected are:
> 
>   QCA6390 hw2.0
>   WCN6855 hw2.0
>   WCN6855 hw2.1
> 
> Other chips are not affected.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-00410-QCAHKSWPL_SILICONZ-2
> Tested-on: IPQ6018 hw1.0 AHB WLAN.HK.2.1.0.1-01161-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04402-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1.
> Tested-by: Mihai Moldovan <ionic@ionic.de>
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-05266-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Yu Zhang(Yuriy) <quic_yuzha@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

