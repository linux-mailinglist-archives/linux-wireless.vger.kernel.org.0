Return-Path: <linux-wireless+bounces-12965-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7047B97BF04
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 18:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1EFE1F21D99
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDED381D5;
	Wed, 18 Sep 2024 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m2aqMEBW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D3E1C9850
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726676024; cv=none; b=h2qDop7ZipVzNui7UizPVmPBAnsanPZaI7tALz7nEGeMU9nHPEtcT05ZYE2IDFe3GC2jJ7uhJFM9v4Xo6Qovpbctrhr/8dktXTlckK60Pr2N2dLwAedAOF7s25Edy7DUW8bwz8wsTvP9JPnAAIptKxr5iNNJU6s6VVpgRW7iBQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726676024; c=relaxed/simple;
	bh=EDFD4b+LAScir+1CzYt4YF9kWou90/PksHp7F3TuPWo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=eD04UqIR3wCSYsageNESoGXKW0/GKSal5ezt+aOEMsaoh4PITUYHYAKP9kRoUSH8C053nW4OMPWR/wTxI99QLaCKS8uT5tIfrGFCPTXV6ZAu+jHPtaTtb1StyUv+LVG+H2ssHXvn/9fjxns6j8CppGFR8EOzzpbeMSX6oBy185Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m2aqMEBW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48I8SUFv007470;
	Wed, 18 Sep 2024 16:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aVnm8pzpgUmPRta6CbBOTGNENlJd31VLF4WUsdc2WvM=; b=m2aqMEBWSU9JSwtz
	PMhiZ/vEx4J1M5g1wwFD61EoaZOxcJIbQdv28wdcVeT7d3cDoYTgbKUJHmoZZILD
	E/4+NmlYGJF94sbnoRyDv6pw6h3WRHuCiIP1pT3VEL0SOLdbM+m+gMv6/4rpQwOh
	C6MYu/xeokNAXVxn5yZ8eGiqRvTcSaZAwQTq5KpePMH0rk16TA05Q3Jpten0kYjm
	fiCBjDm0O5BabWs4KfxDmuLCJgkQE09howopotfAhIHuonKL0HA//eMR5Rda5yWK
	jzMTZAhQ3DrjRhxTHM3rbfzwi4/JWLVKQpCQQqhRNf0hmPiIZjgR2OVXXVOFdsfZ
	Xv3qHw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4jhtnhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 16:13:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48IGDZaQ017078
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 16:13:35 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 18 Sep
 2024 09:13:34 -0700
Message-ID: <6d3f1f33-2a9a-4b62-a0a0-02e65bd1b461@quicinc.com>
Date: Wed, 18 Sep 2024 09:13:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k - HTT timeout error with NCM86
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Dieter Knueppel <dknueppel@online.de>, <linux-wireless@vger.kernel.org>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
References: <14e17e9a-638b-4bfe-8a2a-99b524a20acf@home.xx>
 <1MvJjz-1s0CoP3EEz-00rhmL@mrelayeu.kundenserver.de>
 <7488ed13-82dd-4b41-97c7-5692cacfa631@quicinc.com>
Content-Language: en-US
In-Reply-To: <7488ed13-82dd-4b41-97c7-5692cacfa631@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YF6fY1ajhHg36v3BmqHSyH2r8kmDMGTX
X-Proofpoint-GUID: YF6fY1ajhHg36v3BmqHSyH2r8kmDMGTX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=870 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409180106

Resend since I had a typo in the ath12k e-mail list

On 9/18/2024 9:05 AM, Jeff Johnson wrote:
> On 9/18/2024 7:40 AM, Dieter Knueppel wrote:
>> Dear developer team,
>>
>> I have to admit, the earlier post "HTT timeout error with NCM86" is my
>> fault, sorry for causing confusion.
>>
>> Due to earlier tests with legacy cards, the PCIe slot was still forced
>> to Gen2 :-(
>>
>> Putting it back to <auto>, with "MSI HERALD-BE", similar to "Gigabyte
>> WC-WIFI7" i
>>
>> consistently get: "Unknown hardware version found for WCN7850: 0xf"
>>
>> Which nails down to the question whether any of these adapter is already
>> supported?
>>
>> The M.2 NCM865 card as such seems to be supported.
>>
>> I'm wondering about the difference, as there seems to be no additional
>> logic compiled
>>
>> on one of the two PCIe boards, just bit of glue logic.
> 
> For better support on ath12k driver issues please include the ath12k driver
> list (I've added it to this reply).
> 
> In your original e-mail you said:
>> I'm trying to get "MSI HERALD-BE NCM865" up and running within a kvm
> 
> The ath12k driver does not support running in a VM. Even prior ath11k-based
> hardware doesn't support it.
> 
> For ath11k there are some manual steps that have made it work, so if you are
> adventurous you can try doing something similar with ath12k. Refer to:
> https://lore.kernel.org/all/adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com/
> 
> /jeff
> 


