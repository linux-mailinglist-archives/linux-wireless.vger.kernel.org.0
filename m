Return-Path: <linux-wireless+bounces-22729-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B42A1AAF5F0
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 10:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8D24604E2
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 08:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B789215070;
	Thu,  8 May 2025 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a53iweil"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91E71DFE0B
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746693842; cv=none; b=nu1SFhfYHvfBciwxbsk7FI7Zpw+FMPGc1FO0gD/SYCvEMYbDWfimIFRTHac1DOkgf4VmRa04UGkjjsU7pUIPu6WzaOADmwIj20dQQ9vY2ulS3lNEMqqs/JfDSVxflGjLqKVamX/GIW/sR/+jyD4aYn86o1xUPkkmgdSTSg2oHsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746693842; c=relaxed/simple;
	bh=rtsXDeVencC2Pbm7WEobj/CuGxo/4LJ1N9fyfvRjYwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fA6cJ82NZo93yZYGvi0BZkOH36AvpsVqCur28BgDr7ILSD9Jd+YWlWBg59f/Arb3E7GyFKx7sks+8MDs+v5vt8Vq/y8vqnxQGUVq4FMFQbfY/PbrDCc2WVfsOE4ZhMVcYWn1QPGeKu2psnbAx1XxBJQcPfRWjMHMLRXpbjvwjkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a53iweil; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5484Wwmu010511;
	Thu, 8 May 2025 08:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ct1dYrWOK8wK7mcGePDTd5Yb5Q5n882Ewdz4vm3nRmk=; b=a53iweilGnrvYpwA
	HiekRJiSfLXs667FK02jIPprrq0z+ElMyQeAoCSaib2l8Uw/v9XZqvguO3uX92mZ
	kU0NtA/juJPp8Z0mlpalJQ+XmXNfwa1gMMTtOq3cCDrJ6AHPYDOyX2Ed0MZi6eZx
	tF+lruNrYYiHT4nXXDXVt0ailr1N2bWNxECqZrbvuU1sVeC9uCKVGyYpmahApwlD
	V9UhZ/I9wJBgoeBuqs09OL8B1FG4koJbO8negDWG+K+KfIwaVrZmyxpg83kiQpx+
	/e+ZVa3vmW8lmImTSp8dkjZ/bfvq6YSgooqsdXCrPP+vyxu22brYIiq5NjM1/m6a
	ns4RdQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnp78mjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 08:43:56 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5488ht1J006608
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 May 2025 08:43:55 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 8 May 2025
 01:43:54 -0700
Message-ID: <d11264ac-f52c-49bc-9a5f-40d35c192dc2@quicinc.com>
Date: Thu, 8 May 2025 14:13:51 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v6 05/11] wifi: cfg80211: extend statistics
 for link level in sinfo
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
 <20250415042030.1246187-6-quic_sarishar@quicinc.com>
 <e647806c45cd9ef846fa693253e60e45edfa7786.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <e647806c45cd9ef846fa693253e60e45edfa7786.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA3NyBTYWx0ZWRfXzCVpfhRv2msU
 q/x1W4dmubeQRxnMGFJZlLXtbh4JvYD7iFOdZ/A85EdiRFvGRKo3aMwEwa6ILcHMZDx1RigP4st
 WRtzSdxxXOWupYevBsOSA6wXTWTgTjrtWz/fa9UoMf5N34xaTYmNETuUmGYjY3Yjxc5Qx9OL+P7
 Pt6+ig4ZloZZ2hiOHvrtP5P4T3tMrjctUIT0NaNxs+N1C8HHYNhDr6nPaFXj1cneCUgVIDKbb1J
 gXowckdslITjtPRl4dXE5wElpwZZ6IEuyNE5LwdNtjsC+NKLvs5Row3hBaEINxxxKI0Ueip9I/g
 4JiR7vCPCdiqhlq2rV+hMmzvOhbJ0Gc6ITUf1GWRA+/WoRUoeVqIC426T3qlkBVTcCSe5WvqhGA
 YCySiA5h4h+WLc/OTXA2QgErZoLaIL8uWaIi2ELKNAh58QWabInc1Syt0F07nR8y2z3Z1Wx1
X-Proofpoint-GUID: 18py1Fs-OGDMjisd5yNkcQ7hcDEj_w0V
X-Authority-Analysis: v=2.4 cv=B/G50PtM c=1 sm=1 tr=0 ts=681c6ecc cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=xBXg3zwXL3iKZp2-uNgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 18py1Fs-OGDMjisd5yNkcQ7hcDEj_w0V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_03,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 mlxlogscore=851 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080077

On 5/7/2025 6:23 PM, Johannes Berg wrote:
> On Tue, 2025-04-15 at 09:50 +0530, Sarika Sharma wrote:
>>
>> The statistics will be embedded into NL message as below:
>> For MLO:
>> cmd ->
>>      NL80211_ATTR_IFINDEX
>>      NL80211_ATTR_MAC
>>      NL80211_ATTR_GENERATION
>>      .......etc
>>      NL80211_ATTR_STA_INFO | nested
>>          NL80211_STA_INFO_CONNECTED_TIME,
>>          NL80211_STA_INFO_STA_FLAGS,
>>          ........etc                              // <--- here
>>      NL80211_ATTR_MLO_LINK_ID,
>>      NL80211_ATTR_MLD_ADDR,
>>      NL80211_ATTR_MLO_LINKS | nested
>>          link_id-1 | nested
>>              NL80211_ATTR_MLO_LINK_ID,
>>              NL80211_ATTR_MAC,
>>              NL80211_ATTR_STA_INFO | nested
>>                  NL80211_STA_INFO_RX_BYTES,
>>                  NL80211_STA_INFO_TX_BYTES,
>>                 ..........etc.
>>          link_id-2 | nested
>>              NL80211_ATTR_MLO_LINK_ID,
>>              NL80211_ATTR_MAC,
>>              NL80211_ATTR_STA_INFO | nested
>>                  NL80211_STA_INFO_RX_BYTES,
>>                  NL80211_STA_INFO_TX_BYTES,
>>                  .........etc
> 
> FWIW, this seems fine to me. Maybe at least we can quickly agree on the
> API here.
> 
> I think NL80211_STA_INFO_CONNECTED_TIME might make sense for individual
> links as well, if we track that, since we can use multi-link
> reconfiguration to add links later after the connection. So might be
> interesting to have that per link in that scenario.

Yes, I added connected time, for link level as well in link_station_info 
structure.

> 
> You also add later the accumulated statistics where I put the "here"
> marker.

Yes.
> 
> johannes


