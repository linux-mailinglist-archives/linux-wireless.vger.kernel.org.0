Return-Path: <linux-wireless+bounces-2125-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF04830DBF
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 21:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1FB1B21584
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 20:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7565824A18;
	Wed, 17 Jan 2024 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c9CoEkNJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB45249F3
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 20:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705522210; cv=none; b=HV2XsaSsbVHQIh+7ADvjlYoczuYn2eGBJcKhiJa4XfonuXut/+GBWldWEJ0EIBaWVtQawX5hxW+Nt8H17UDQf5vRiTG5wHjVmAF3/EU+aanyHF6wZuaOB7UVnzLFkcO24RFtvLkOYHFoxksxuM4YGsIHsTstzGtgXL1hWNcRTgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705522210; c=relaxed/simple;
	bh=3WQWjgLwC19tGZ93ePrqHzzU+0y65Y9wnRofKDOzaes=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=BsYkUSabqezWUf4N752J3ExND2I5EAO5TsJRlxpdtWsm+pp/swVYzknw1johNn8yRzaBlebvXx6tC+KqAyi1SiO8AqlT+ZR5JwvFOsPW9k43hAN6bGDJuMiyikG6Rb1aeSeDN8/XQUWDukCKD0LZYbBNmY9o6JOEgriGSAddNG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c9CoEkNJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HImDHL003914;
	Wed, 17 Jan 2024 20:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3WQWjgLwC19tGZ93ePrqHzzU+0y65Y9wnRofKDOzaes=; b=c9
	CoEkNJ7t73GINp4CtXj/kg5ruR6oaH5B0OHF2molB4WFTulE7tXSD6BkVPs88cpz
	qCTGKOCXFSmMS53ANt6E8XfUt9Bl5tnTDuU2fQExxaGDCHGbxQlx9Yhm4SXWfvaI
	Vs5bxmNYSKRN9KIL1ovtVn5Tv0/8yx6j0aEF5gsvEEMQSyabt9vEZmOZuCEBrYGv
	MoWvYorb8sRmWTg3+3HgGvok5b6zQPGMKRI8iUMy6Kq8OyDUbXm9HIhqOjyGxIz8
	467dMGGxz7C58gnHhfyH0EzDWihbsE3UNwnBIf4JI3AtZRnMDtCaIF/nQEYo/HBM
	+EARSk7w9SF392xt1IWg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp6p3t3aq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 20:10:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HKA2go008786
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 20:10:02 GMT
Received: from [10.110.99.42] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 12:10:01 -0800
Message-ID: <1af2d944-0711-4fc7-bfcd-a34ebd0b7ef7@quicinc.com>
Date: Wed, 17 Jan 2024 12:10:01 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] wifi: ath12k: Introduce the container for mac80211
 hw
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240117161451.3385227-1-quic_periyasa@quicinc.com>
 <20240117161451.3385227-3-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240117161451.3385227-3-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eNXkzCBtZvbgnWkevxZQe-fuLbbDZCKB
X-Proofpoint-ORIG-GUID: eNXkzCBtZvbgnWkevxZQe-fuLbbDZCKB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 adultscore=0 mlxlogscore=703 lowpriorityscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401170147

On 1/17/2024 8:14 AM, Karthikeyan Periyasamy wrote:
[snip]
> -static int ath12k_mac_hw_allocate(struct ath12k_base *ab)
> +struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_base *ab,

this needs to stay static, currently fails ath12k-check:

drivers/net/wireless/ath/ath12k/mac.c:7897:19: error: no previous
prototype for 'ath12k_mac_hw_allocate' [-Werror=missing-prototypes]
make[7]: *** [drivers/net/wireless/ath/ath12k/mac.o] Error 1


