Return-Path: <linux-wireless+bounces-7691-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A228C6A49
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 18:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E97B23E9E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 16:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBF7156C62;
	Wed, 15 May 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UnfC9GOK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D7C15665D
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789449; cv=none; b=p8u+4UjnBuyYuWV7E8FGk186QNAVU94+A5jh3da0I1gZRIgEWjALnKvJsJXfpUsDTiq7LePkVae49w2g3lm/HqjnBwIdD4FFXvucvRWV+lftb8jUnkoDWGrPNS2qP8Mf1H891Z8XEUG+ItWFPEYLQkwca0K1fq4PANKKVPgXt/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789449; c=relaxed/simple;
	bh=XVvp7XAse/8dqXAozzPlmhU625fraMeMhYkOgc0tf7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A2SPdtYAsNtm0/mi6WNO52Wee335u9bmrHkxcEuG9NrqIH2FsXeu4T+pLky8PkJrl1eiIloI8AJuKJIiE3v9kkOhaj2oezXteO9GQIGVYaqhojtQ3hTOJuuJ8Abj5wW7fzXOjT48FwLltg8bK/gQfmFunjdeSf3yD0fjsJwo324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UnfC9GOK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44F90YQ6026428;
	Wed, 15 May 2024 16:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Ocnp25BKndipHW0hJDja/0FBH5DhK3l/5UBX3iyeZlg=; b=Un
	fC9GOK8Ec0MpyT3Tx+fREcuMwkVyX8EgHBGAc0+EqRKCqth4QjFmzNsPqgp1PGyB
	dJHXQ2w042fzTwUViTM7f8OxZEXfsMh3p4L937CYFAavnHfswqEebzSpLa5+c1xZ
	2312lS/S/tkw4ORdYewsNJuH/sWPFhHr/kyq31yISv/TjB4O4gYKQDTBN9TOAAT0
	U7kd5KvolL7HtGPu5+vrFMF5HXUkC+Mj5icGhJpJTYlvvbnUDSFJKKwHriS1afAm
	5GKT7kC3/pRUdkBMJWdc8HSmy82cnimR3WhsyTTziHfUEB4Xi5P5tQ+YoSOOToxW
	u/K0MHRubxJQ0K8Zc/Tg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y47egb8qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 16:10:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44FGAhQD022369
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 16:10:43 GMT
Received: from [10.227.108.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 15 May
 2024 09:10:42 -0700
Message-ID: <ce6cf9f2-d10d-4459-b894-47b08bcf7af5@quicinc.com>
Date: Wed, 15 May 2024 09:10:42 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 09/10] wifi: ath12k: add support for 160 MHz bandwidth
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
References: <20240508002055.17705-1-quic_pradeepc@quicinc.com>
 <20240508002055.17705-10-quic_pradeepc@quicinc.com>
 <4ce44353-994e-4ae5-8f5a-9bb19d31ba9d@quicinc.com>
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <4ce44353-994e-4ae5-8f5a-9bb19d31ba9d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eO7Psm5oflbqe0PGyyrFGRrroGanUDLc
X-Proofpoint-ORIG-GUID: eO7Psm5oflbqe0PGyyrFGRrroGanUDLc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_10,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxlogscore=971 lowpriorityscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405150113



On 5/13/2024 1:54 PM, Jeff Johnson wrote:
> On 5/7/2024 5:20 PM, Pradeep Kumar Chitrapu wrote:
>> Add support to configure maximum NSS in 160 MHz bandwidth.
>> Firmware advertizes support for handling NSS ratio information
> 
> s/advertizes /advertises /
> 
> (one of the exceptions where US English doesn't use z)
Sure.will address in next revision

