Return-Path: <linux-wireless+bounces-3855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842B885D7D8
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 13:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240011F2164A
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 12:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89454F8A1;
	Wed, 21 Feb 2024 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZtpX9JXV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1899947A7C
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708518127; cv=none; b=AUgEZRde9ECro8ARYoF5uELvKzE0m3TlRNgaDxoqB37JVRWVYMC6F//DN3d/Q5PpvOtjczcNJqxNjS6qNOqDuzjgW4Yg2nk4/LTy6Mg+CpOjKrhFqI8Pq85TYCTxMg4hmIng8m13WokbFJh156J+8NNHQwETWfmz1MJEqdnHJG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708518127; c=relaxed/simple;
	bh=JGdEIcPQGy/Sir8hQ341cNHsh0QNRfA516KOCnA18PY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O6p9wHqzMfmfXey5yfPAcdoUdeJj8H/GRutgnmPeEXSISCBIn/wspVxIUMwMO3dmhYz83TZbmmWOOPZiIRzXUn9i7TRFGUIn+NMkUSp6ONVldei9gAMXx07cP/efl3Tv01baiGUW3Kp9jzHCwPLdarBlrq/aeu7r4qe7+nbBZ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZtpX9JXV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LAdEVj008215;
	Wed, 21 Feb 2024 12:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=x6HMu7TxnoXkCiykrnQTuuwUsNLEmNF/wdkCe73YyvQ=; b=Zt
	pX9JXV7RCPTfR6I5fIB/+F2PLj8dC82m4bvLgLA7eUd3ZwJnw7AWLFHpT7sje26C
	grmpx5o0QJH+M7tlvTURca7+IEgN74u4DYp9ieENly4UGNvMagEoRu8sLFbhfijw
	0oz6jMF1fRDuhJs3V0vfyV1qvjvSmtYci/ki7BWKo8NNyvmCbg6a9UogMAkQzC8L
	zl84gDOcX1Iz3FqB1V/ouC5paKK6XPURlik40DiVJBEPdtdwv1rVvUvE+vtl/MYj
	JucuH847dxjk/pa1vtmWmbH8UzJet8lRyRPoWjZYB4FOnbecuAzhyeX8IpZNtINA
	CXtALB7uJPe22NtB0Phg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdfm38711-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 12:19:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LCJpvN020509
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 12:19:51 GMT
Received: from [10.216.12.189] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 04:19:48 -0800
Message-ID: <21083553-c646-4471-9e5b-49f2d0727ef1@quicinc.com>
Date: Wed, 21 Feb 2024 17:49:45 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel switch
 on link basis
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Ping-Ke Shih
	<pkshih@realtek.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>,
        Ilan Peer <ilan.peer@intel.com>, "Jouni
 Malinen" <j@w1.fi>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Arend van Spriel
	<arend.vanspriel@broadcom.com>,
        Felix Fietkau <nbd@openwrt.org>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
 <20240130140918.1172387-5-quic_adisi@quicinc.com>
 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
 <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
 <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
 <b2cf5c1d-7842-4e59-b25a-904a6879fa9c@quicinc.com>
 <f7174207668cac149246cafa0e4b4749ee3289f0.camel@sipsolutions.net>
 <ac5825e8-0cb1-476e-be5c-ad0170122f77@quicinc.com>
 <fe2100dcfe9ae9b4517f239faf25374c27f473a5.camel@sipsolutions.net>
 <5c0fd2eb-eb19-4b69-a325-ad9eef633336@quicinc.com>
 <bc81466177afd0014ccdd9030c5807339bb288db.camel@sipsolutions.net>
 <18c0d4de-392a-420c-8a05-466a83cd2eb8@quicinc.com>
 <3c550ae335a9762a9cbd0c8109b6dd99faeb8f6f.camel@sipsolutions.net>
 <5a89e63fb7644d12be72154c90c96199@realtek.com>
 <32b5e358f7b54f4921e0a9e44a71f3a791f0d0da.camel@sipsolutions.net>
 <df711a5978b84856a54953a32e4b05923b48870a.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <df711a5978b84856a54953a32e4b05923b48870a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xhiTJw6Kunuy7LDXbWfnbV4pC2p9T0j6
X-Proofpoint-ORIG-GUID: xhiTJw6Kunuy7LDXbWfnbV4pC2p9T0j6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=906 bulkscore=0 impostorscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210095

On 2/21/24 15:12, Johannes Berg wrote:
> 
>> I guess then for Qualcomm we'll need to just add an extended feature
>> flag for "FW_HANDLES_PARTNER_LINK_CSA" and then hostapd can just not
>> update the parter link templates, or so?
>>
> Or then again ... Maybe the other way around, since it works for
> Qualcomm now, assuming it all works at all? Doesn't really matter, we
> can call it "WANT_PARTNER_LINK_CSA_TEMPLATE" too and have it inverted
> logic.
> 

Yeah anything is fine. Basically this flag should be visible till 
hostapd (so probably some wiphy level flag), so that it may skip forming 
beacon templates of partner links in CSA case. Based on the flag, those 
drivers which want it, it should form and send.

