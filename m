Return-Path: <linux-wireless+bounces-10242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9537E931E92
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 03:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5D82831D8
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 01:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94453A943;
	Tue, 16 Jul 2024 01:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UMvhwIuq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0238814
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jul 2024 01:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721094634; cv=none; b=JJmYgb05SlTcjHfyAOIPdbUDO9TE+kRYxIcJjj1O6cqpO/8TBncUjXCoyvEIwv8GGSXD9W6Dtqb4Y8ps45t8RTpSDz/wKBIzQWIJtzJtNTrBzc253c3mkIPt8j+KYzECQytlHcrnXTbLCvbPv6jox+n+AIguS+udPVYyjZHp4Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721094634; c=relaxed/simple;
	bh=yXe0n48eSa8f0xPEy1ifK2Xzm7DaXSH3DKjoPjBNGIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d6Cf4UxzNeqgiscn2e+glLfJ4y3d0T12gK75sPtoc5nYxYJGl4noDU/A8/pm6rv+GPsbqn/O3I90BBWASQPk/aeRO8RxxsL40rcbKqEz8r4DtVCPqRw8JefZd8G7QX4ZlDflHvyh2kvEyPuXjTgnp6QmTwGN8z8MvPE0jNmyjnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UMvhwIuq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FH8klh014100;
	Tue, 16 Jul 2024 01:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sXIDYE0of5tGAtHdTG05aHneMx/Z9aqNnOmIrL+8ehA=; b=UMvhwIuqVjOhXzfV
	6pcx02fQNwGTqgasH2cb0klx9Kpn6lmdgaqprQM/fAc/fuX1t2Lqy4qFA8NlVt5k
	cu7c8bBfjOkTSGXjeDWWR1Y1hhQKsp6YJO1mXPBJagNgxUT9+EnMjmX8L6Orv1Fs
	XywmMEW2+fjn1qEzLpEUPZFojRopUnNObxTr31+uWtjD+fGOp/C124ILCVnuu5os
	WOxmuhPtzw/qf5pzn6OzWugi4XK5sq4+AMIac34mLeYbfjof/4IMvQ7b8qw+IrbI
	L5ddsyK5EVCRG6z7HuGeHqscZJJ4MxT6LSYy+jQdzisOV4P/QVX7miGrJaFJZXUo
	8I+pXQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bhnuns9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 01:50:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46G1oJ99021767
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 01:50:19 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Jul
 2024 18:50:18 -0700
Message-ID: <f2fe83b8-d973-401e-942c-11bd9e29e888@quicinc.com>
Date: Tue, 16 Jul 2024 09:50:16 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix invalid AMPDU factor calculation in
 ath12k_peer_assoc_h_he()
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240710021819.87216-1-quic_bqiang@quicinc.com>
 <47d0d6f2-ca36-4e56-8019-ace2304d40bf@quicinc.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <47d0d6f2-ca36-4e56-8019-ace2304d40bf@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: d3MRVTCkcvUBVV0ZK_wOPs3lz-b1A8DQ
X-Proofpoint-GUID: d3MRVTCkcvUBVV0ZK_wOPs3lz-b1A8DQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407160013



On 7/16/2024 1:31 AM, Jeff Johnson wrote:
> On 7/9/2024 7:18 PM, Baochen Qiang wrote:
>> Currently ampdu_factor is wrongly calculated in
>> ath12k_peer_assoc_h_he(), fix it.
> 
> You have 70+ columns for commit text, use them
Thank you Jeff for pointing this, do I need to respin for it?

> 
> What are the user-visible ramifications of this error? Just curious if this
> needs to go into 6.11 via ath-current or can wait for 6.12.
not sure of userspace ramifications. I think we can wait for 6.12.

> 
> /jeff

