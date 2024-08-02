Return-Path: <linux-wireless+bounces-10867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF16945F8A
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 16:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5902852C6
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 14:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3481171C;
	Fri,  2 Aug 2024 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZbFAe87W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD60D2101A0
	for <linux-wireless@vger.kernel.org>; Fri,  2 Aug 2024 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722609691; cv=none; b=Atub8U/yXPxqk/KSXr0wN/5fo4sHx4Xa1+3VNL92fu0IO0nyN/q6f9gOIgGM1xR0iPctoFa7faBI47fh1jSqZIH11e5c80jrAEzp6naBcPCMnBfLA9kovCz4Y/cpc76wV6wmf2PiI9Qw5BkSEsTfKZGzylxWin5648OSVI1i6F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722609691; c=relaxed/simple;
	bh=/4zyYUn328+HxINxnBmP9nSrnFVwsF8jV2yYDogpjlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UvVX+vt33pVQOIzthFVzslBWJyLcD5P5X8bw0LHTPWuX8g26Xe78IulPwMG35r9+Y4LZ/sCdr12t0vas7duTKgY+kN50uT6kMxhIasPJi9nDkRxOd3TrkRJYUrW8FG18LApMo2l1CSXLov52aMzA6WNB34G6iaTMuA3wRirGg6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZbFAe87W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4723vXZn025235;
	Fri, 2 Aug 2024 14:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BZBI2HUmMwEuCy9Fw+NCi5mEDYXwZxhcquXiWYycqUM=; b=ZbFAe87WZhML/rM+
	tdzpGiTJkCMuB5ru4Gv8gsVvi7GVajUtLBG7AjOfpyjIRCouij7QLdCRlYguEFcr
	SXtLxV8EV6H48SWcVbvNMhr66hjEcfFGUwOskcGJq6qXAKWEBYpsjESAA9hOzclK
	r3bCrCMesu7oj+C1RDcgE3j8a+8GS1KIv8mv4+ZsaTshE7A/8NNiXnQxMe1QyIdN
	8I3bUljKcW/3i9iW3HXiBk68btmrikkh4s3f14A1HU0myOaoXkX56W66EQLu4gqK
	pco1224/DJErEZ1W0sJdxOCEaS0Zo0WYR8rsQ8B+dARlfPcpr+SAowlHFhszZrWy
	dB5ouA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40rje31w30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 14:41:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 472EfRpm022632
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Aug 2024 14:41:27 GMT
Received: from [10.111.177.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 2 Aug 2024
 07:41:26 -0700
Message-ID: <02612131-8172-49eb-ab07-fdcaa4d05e40@quicinc.com>
Date: Fri, 2 Aug 2024 07:41:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] wifi: ath12k: report station mode receive rate for
 IEEE 802.11be
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240801112853.85508-1-quic_lingbok@quicinc.com>
 <20240801112853.85508-3-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240801112853.85508-3-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DzK6tT-R6WLo4A-Qa-4dmwx2Z665be-I
X-Proofpoint-ORIG-GUID: DzK6tT-R6WLo4A-Qa-4dmwx2Z665be-I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_10,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=976
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020101

On 8/1/2024 4:28 AM, Lingbo Kong wrote:
> Currently, the receive rate of EHT of "iw dev xxx station dump" command
> always show an invalid value.
> 
> This is because ath12k does not pass information about the rx_status of EHT
> to mac80211. So, mac80211 not calculate the receive rate.
> 
> To address this issue, add logic for handling rx_status of EHT to the
> ath12k_dp_rx_h_rate() function.
> 
> After that, "iw dev xxx station dump" show the correct receive rate.
> Such as:
> 
> Station 00:03:7f:12:03:03 (on wlo1)
>         inactive time:  48 ms
>         rx bytes:       59226
>         rx packets:     320
>         tx bytes:       26556
>         tx packets:     191
>         tx retries:     99
>         tx failed:      0
>         beacon loss:    0
>         beacon rx:      79
>         rx drop misc:   68
>         signal:         -95 dBm
>         beacon signal avg:      -20 dBm
>         tx bitrate:     688.2 MBit/s 40MHz EHT-MCS 13 EHT-NSS 2 EHT-GI 0
>         tx duration:    0 us
>         rx bitrate:     619.5 MBit/s 40MHz EHT-MCS 8 EHT-NSS 3 EHT-GI 0
> 
> This patch affects the station mode of WCN7850 and QCN9274.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



