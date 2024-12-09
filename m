Return-Path: <linux-wireless+bounces-16028-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C55A9E8D8B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 09:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C53164823
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 08:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E83215077;
	Mon,  9 Dec 2024 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HPt8TGyY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A007314A4CC;
	Mon,  9 Dec 2024 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733733221; cv=none; b=KixOa5unSarCWvorPdvgVYn7slBnwwOumHOfsA8/2BpSxZnErslKcsy5hSuFAD75u0OKBU0q1J+TFvBZ9b0++dd/nTdXkf5sAjZBUZhqXk/V0X8oQk7I7MYgOjmrc6KBIpa2Ssk17QwZEBDwpzEfzlKw+5/ccJguuReupMnQRDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733733221; c=relaxed/simple;
	bh=3rApvu6Vlx6umbtMEVp5wPSh8cFzVClVQdvrD5Ws9qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NH5mV9FHKpq9yHTlextxgDUmw9kuiLSDUKyx29BIvztoGXJDYLD9z1mui2linNLgUINu4L1KWNFWyaF41aBbSK/CgbBXV9ocr8HSvtbEobfCdKNoO2DiX5WDK+4tv5r3dGrsyMLSIrXUt3TiaWGUVerIWY8YOM/jMTbK9BTkzrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HPt8TGyY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8Nb9K2020900;
	Mon, 9 Dec 2024 08:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wy5JiN4iK/NB5DS6NwLdv5SpBYGQjC81RwRdjZEYyMc=; b=HPt8TGyYGv7XPvQi
	VpVVFKSrmeqPFLhuEUzcA+73fGmnt8BP4otnb2xJsLKimNJmzEZNhZO9MYvkP8zo
	Bhu0bkD3Sk6dzxhNUwjV/A/qyLuOkakUGjC8ZPwt48tp4hbuvtG1hxxY+NUUPgsw
	/Yu4HUcQb8YMUz0s545WMxjrM4K7KbMTNDb3P9nUZ2pizj1yGxv8MVtc/n/uVDrx
	zAIMyKV/k+C9IYl4Xdsul7xCJDfIXHqK+bCcC8Tdjr56ZlrD/E06hJJiCQyGaS0k
	bK2a8FI7tEoKaJWNvsrfB0NFKUHPEfMvqSGhjKCuxwO8wuDQUqNa4qNJEoPIRwuL
	k94BgQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cf4e3tmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 08:33:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B98XVNW016642
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 08:33:31 GMT
Received: from [10.253.9.59] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Dec 2024
 00:33:27 -0800
Message-ID: <db61f998-2524-4623-8b0f-143661507e38@quicinc.com>
Date: Mon, 9 Dec 2024 16:33:24 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: allow APs combination when dual stations
 are supported
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
CC: <ath11k@lists.infradead.org>, <jjohnson@kernel.org>, <kvalo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <quic_cjhuang@quicinc.com>, <vbenes@redhat.com>
References: <1123551c-1a6d-4d0d-b3c7-f65c15509280@quicinc.com>
 <20241209080334.5989-1-jtornosm@redhat.com>
Content-Language: en-US
From: "Yu Zhang (Yuriy)" <quic_yuzha@quicinc.com>
In-Reply-To: <20241209080334.5989-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ggIUJ-0qEaolru1NlmEDIsvhnHUWBZrq
X-Proofpoint-ORIG-GUID: ggIUJ-0qEaolru1NlmEDIsvhnHUWBZrq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=870 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090065



On 12/9/2024 4:03 PM, Jose Ignacio Tornos Martinez wrote:
>> So you can't up with ap type or can't up with managed interface?
> Please, let's go to focus and not repeat the same, due to the reasons
> that I commented before, I can't up my scenario with aps using your
> proposed inteface configuration.
Yes, Can you pls share the complete steps and commands?
> I am going to remark again, I can do it with the old configuration
> previous to the commit f019f4dff2e4 ("wifi: ath11k: support 2 station
> interfaces").
> Thanks to my patch after 019f4dff2e4 ("wifi: ath11k: support 2 station
> interfaces") by means of a parameter I can do it too.
> And that's all.
> 
> Thanks
> 
> Best regards
> Jose Ignacio
> 


