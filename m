Return-Path: <linux-wireless+bounces-12267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5E596663A
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 17:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 414A1B257C4
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D721B81AB;
	Fri, 30 Aug 2024 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bZfInti2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE65E1B81A1
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033405; cv=none; b=nCXT8nalAYEu0uUeX2ehr19qH/Kzc+mzKjYYt1j2AMJ01KhDtiJ9hm62x4menTMQJlxGIhVbR66Eh1eftn9jGVpglsz0oeFsRNGMfIJUMlKJOuDitdCzKpcBF4+uQZycZEqV9Q6ykQZZkWXvG9jlLP/5P024rjTYyXKw0vRSNuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033405; c=relaxed/simple;
	bh=Ae5LxAkNZHRHOQ7fuoQQZYDjMyeeCDSLAMfw3mbSLQo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=ElOVqzcEATjOrHjRG5EjwKXuG6ReOaXgfamA2mtF8cBBQyFWR6onZE7sA3R3wxGhoF8azJac0aXl5T9+yxJw6KRCLaKTfG/kxy7+WUHINqhxEyErJQ8JAJVOwLskBjB+IUzG9IK8wa8CFo47poacitUR5z/PfmbYiruCCY7tNpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bZfInti2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UEip4p030353;
	Fri, 30 Aug 2024 15:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ae5LxAkNZHRHOQ7fuoQQZYDjMyeeCDSLAMfw3mbSLQo=; b=bZfInti24Xc0ESCR
	rA2AA1nczEO2HbwRB1S3DO5ius/okVe/zGA7QA+B9mVIiNvytHr4TXj2RzV3t2u4
	W1SKbunKXojimK2LyBEeFe4djywQRsurg1fZLKyWgNAwjkbXtNsG4UVGM5sdOZYP
	FyMaiMzEHPw1uiaktO49buh94D36aYEItOnCiFycv2oq65LEp3SRQatVhJjlM5ry
	Hunc0vHT8SVkk8v1OiPUHltJc6hRrB3HGkoR+QG9DoVY/6tM4u+c2aMfaKfgpurM
	JRK3u8NRjA2SuKlh5dzixJqz2IC6VOcaXKpJnU3LQUvXjQrDM3zhLxHUsYzs9Chb
	iq/xdQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419puuhbs0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 15:56:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47UFudws032270
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 15:56:39 GMT
Received: from [10.111.180.95] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 30 Aug
 2024 08:56:38 -0700
Message-ID: <1e5c40f7-d8f4-4e62-af2d-216d6e02dd5b@quicinc.com>
Date: Fri, 30 Aug 2024 08:56:37 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current 2/2] Revert "wifi: ath11k: support
 hibernation"
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240830073420.5790-1-quic_bqiang@quicinc.com>
 <20240830073420.5790-3-quic_bqiang@quicinc.com>
 <891d2bc3-9ace-4fed-92e3-192d8126c5c6@quicinc.com>
Content-Language: en-US
In-Reply-To: <891d2bc3-9ace-4fed-92e3-192d8126c5c6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6HsFRIGe-kx-DEQNwo428w6Au8tyekwX
X-Proofpoint-ORIG-GUID: 6HsFRIGe-kx-DEQNwo428w6Au8tyekwX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=607 mlxscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300122

On 8/30/2024 8:46 AM, Jeff Johnson wrote:
> I think we need to add
> Fixes: 166a490f59ac ("wifi: ath11k: support hibernation")
> Cc: stable@vger.kernel.org # 6.10.x: <hash>: Revert "wifi: ath11k: restore
> country code during resume"

Re-reading https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

I see that I messed up the Cc tag(s)
I think there should be two Cc's

Cc: <stable@vger.kernel.org> # 6.10.x: <hash>: Revert "wifi: ath11k: restore country code during resume"
Cc: <stable@vger.kernel.org> # 6.10.x


