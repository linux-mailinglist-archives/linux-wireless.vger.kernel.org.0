Return-Path: <linux-wireless+bounces-5477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6635C89062D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 17:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DE31C30368
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 16:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863D882894;
	Thu, 28 Mar 2024 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AW5yfS33"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591744437B
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644017; cv=none; b=bax7x6latEuVrjsp9hOAqFLfrr6tGZwgQUZRh0VB3FKYYNObLKrTMDeGrhqV/u0nJVEzB2bJddbG70H4fJsIcu6dv4zDYVN59mneoGd3xWFiXpKyMKg1zfypvwODJXcptVxhorzeGOrUk+OJI4tPH7TTXUR1BMNmAuQVYkeGfjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644017; c=relaxed/simple;
	bh=yr4JEmcLAZfVav3gXQyZ/EMgnf1R26J5E0Wv2UEyo9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L/JGXhvxq4x0+VIUMPyNIanPt2mUiWlOo4thCs22FKcj/yVd/xvSvQ51kf1XUcSJE7tSNgmoREmeeQ8WifGNonj9/CJRA29SpEZ7plDJng2kLHgjlxopUc7yQg5ztZ4MBbkcscBuJh/8XoYezp9uqx1WsuYBjgQzZUq62fYv18I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AW5yfS33; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SGV60T001709;
	Thu, 28 Mar 2024 16:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=yr4JEmcLAZfVav3gXQyZ/EMgnf1R26J5E0Wv2UEyo9A=; b=AW
	5yfS33gCX97+GSCJ2w3WIkRLc4/vlr2ezFDub0/RwaIyN/VbucrnXGVDreOqT78m
	6RPcB83hOhy02edzorkK30e9vq1jwCoi4f3Yc+cN1r1sbVN9mVnxZGSIZJD8gRxC
	ratIbaoQrsi52wERAPTARxYcKKiaJ/11LQj88v8OFvZw8Aj1I6BqarBXQ8c9eews
	21jRIjNo1Z0pSmuqBDtgyBtLY3Cq7scpEWwVuwcMWZHf/65DYn/8drZMLplQYpoA
	ico36+ybz9EwWg7HvNe7+vHS9afWsAVTr4DZmFW+krJa3OMmYQK3LJRgIuXuYw/N
	6E9b8mLJiJPbf9dnvlkA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u1wm23r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 16:39:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42SGdhKJ011287
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 16:39:43 GMT
Received: from [10.110.124.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 09:39:42 -0700
Message-ID: <2498ac14-564d-40d9-b911-feff57d6770c@quicinc.com>
Date: Thu, 28 Mar 2024 09:39:41 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] wifi: mac80211: Add multi-hardware support in the
 iface comb helper
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-12-quic_periyasa@quicinc.com>
 <ca70eeb3cdee1e8c3caee69db595bc8160eb4115.camel@sipsolutions.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ca70eeb3cdee1e8c3caee69db595bc8160eb4115.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zqLI35EgeO_VYq_xE50mnwvghielyJKs
X-Proofpoint-ORIG-GUID: zqLI35EgeO_VYq_xE50mnwvghielyJKs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_15,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0
 mlxlogscore=641 mlxscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280114

On 3/28/2024 7:41 AM, Johannes Berg wrote:
> I was almost going to write "links" instead of "interfaces" there, which
> reminds me that none of this really even works well for MLO yet. Not
> sure if that's better addressed as a separate first step?

we are following the sequence:
1) go from per-hw wiphy to wiphy that supports multi-hw (multiple patchsets
under review)
2) add hw-to-wiphy grouping infrastructure (hopefully coming soon)
3) add MLO on top of the grouping infrastructure

So we consider this to be part of the 1st phase

