Return-Path: <linux-wireless+bounces-22670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D17AAAC89E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 16:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80FC93AAFB0
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 14:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB06280A46;
	Tue,  6 May 2025 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XxjhvK+1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E80255E37
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543030; cv=none; b=cgY1VmhgB4QXRbiqzsIv4VAkhVtEWFCXTMnZxzrjAr3q2SvmqqG6ErRlWx2XnyiSfx1YlKR7GSIK9sVUcVPhOMUAdMFJfFOh2g4grjIFzRQ4C0GgCXvnyu3/EMU53aThyr0bh329rZasF3Irl3eSzI5pidlvC3j7p+ys4iaY/xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543030; c=relaxed/simple;
	bh=BcFfcdbwqCGWlJvrrHaUUiOYOj9MLNaKReP0hgB1fWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kfTQ+iUslA5lfUEyfLwghhLAuouKQgX0JSpwKLLnbMb4KSJiQhCyzfPAhEoEYtSPbSM+OJVA6B7dDNP2g2XJltENezqP/E/d1aE9ALRRvLwD/Ru/h3+6FHsBKO10nrtkcRDnpt9/KgTuxBeQ2od+hPMCw64T/Bj1ROgOtv6DqaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XxjhvK+1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54686vXb020658;
	Tue, 6 May 2025 14:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pNSHOTQLjdwTA/W/nykcMJ8n05qI50/8o1zJqPAqh5k=; b=XxjhvK+1t/dNUYSG
	fxum3DTrbBsPRuWJ6fuvOf1VAMV5EwmUGgl1O8xLeIQl6egACFdD/1Gx88AMo5UZ
	a6MwboRntWhfBgTlvczPHlE6iaCxsDEtJJu8Mw/z3B+v73ShX03C7Sq1v9KsYw9g
	xumX+lWH8UV+t4jhxnJqjYTG4HotHvsR56tFn1gs1v8UCv3VHnc82ElSNDixXAeA
	FztiqUqoPUsbBiPLArtcFUlPFDx40rrEsEn1nMjFdv6AZlpHeTFkJpUkWjdNojdn
	DoZrWL2vA9QJVnqM4sW02rjSUJzlgNRH2QPvIAJcWVg8/n+UY04YYxyRtDpKkhaV
	nw8QiQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46dbwfqv9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 14:50:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 546EoPvw011112
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 May 2025 14:50:25 GMT
Received: from [10.216.13.49] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 6 May 2025
 07:50:23 -0700
Message-ID: <2006c77c-8e29-61f4-c988-cfbc921adc02@quicinc.com>
Date: Tue, 6 May 2025 20:20:20 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v2] wifi: ath12k: combine channel list for
 split-phy devices in single-wiphy
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250506105624.466019-1-rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250506105624.466019-1-rameshkumar.sundaram@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: g_7cq_Kiq6pgFu6fhj8NChS4TzblTFI6
X-Proofpoint-GUID: g_7cq_Kiq6pgFu6fhj8NChS4TzblTFI6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDE0MyBTYWx0ZWRfX5JFchGmpyO6p
 xmzBf2SJeoVcAp098ByPyN2FBuG2Q1WrpaRvP0QIbJNlgGcPn4Nvj12H6u8R10y7uSBePtO2LXJ
 FiaeFVFETqTtfVTW47XxrTz/gPTee7AYgu/vs/KBma8Pk5/eXcd9GXUSU1bIirrpnoolTaGuW2+
 z8+BRLdlnS6sYIoNuTgQCXCZnXP0f0YVMkBOyuLNNgSqnuy+os5ru2Q1Rg5OxuCfoi4aX/k7mMU
 DVNK1nWkrRuGG0bQ3eRAaLfhf+5fkUKjq/5jgk+n5R0vyBrMk08SDGo+fmcyZ+Eh8gpWeBeTfnL
 bOcZBJvaWAyy2fC164ey+Rmh775ZdB9ZyE2BkMWvIJROjP5D+Zw2xZIvUasaytCJ3BhdXuknhed
 5E+a95PUdDqRv8CQjqpjZFHwQEW4J9cL0VYFJw9ZYUY/bhaE8l31TggVnCVRh6z31WKMxYjE
X-Authority-Analysis: v=2.4 cv=AfqxH2XG c=1 sm=1 tr=0 ts=681a21b2 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8
 a=2LzJI_1lXDcI7TO63KoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=835
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060143



On 5/6/2025 4:26 PM, Rameshkumar Sundaram wrote:
> When two split-phy devices that support overlapping frequency ranges within
> the same band are grouped into an ath12k hardware (HW) setup, they share a
> common wiphy instance. Consequently, the channel list (wiphy->bands[])
> becomes unified across all associated radios (ar).
> 
> For reference, the devices are:
> 2.4 GHz + 5 GHz Low Band
> 5 GHz High Band + 6 GHz
> 
> The first radio probed within the 5 GHz range (say 5 GHz Low Band) updates
> its sband reference (&ar->mac.sbands[NL80211_BAND_5GHZ]) within
> wiphy->bands[]. However, when the second 5 GHz radio (5 GHz High Band) is
> probed, it replaces the existing wiphy->bands[] entry with its own sub-band
> reference. As a result, wiphy->bands[] always reflects the channel list
> from the most recently probed radio in that band, restricting supported
> channels to those within its specific range for upper-layer.
> 
> Fix this by updating the wiphy->bands[] to just enable the channels of
> current radio when there exist a radio which already has set it.
> This will make sure wiphy->bands[] holds reference of first radio which
> got probed in 5 GHz band and subsequent radio just updates the channel list
> in the same address space.
> 
> Since same sband memory space is shared between radios of a band, while
> determining the allowed frequency range of radio, its frequency limits
> (ar->freq_range.start_freq, end_freq) should be used.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

