Return-Path: <linux-wireless+bounces-14885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8779BB937
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 16:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F02BFB22AAB
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 15:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0890C1BFE03;
	Mon,  4 Nov 2024 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FBbbYCJ5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718E01B6CE8
	for <linux-wireless@vger.kernel.org>; Mon,  4 Nov 2024 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730734989; cv=none; b=p2CtGCKvmIe3HxjElD26epjO8SxKIxCuwgRe1wwJchWd9cR/1NWjgvbKm52TqTGXQtylMNzqX3ZSIbfaPEb+PkPBM0k9RS+lgCwFgEbPZE2KKpXSxYhNBcx6Nk556aRn1twR6PjLhto4+p7iG5AZpoEZ/l1bz2kC8p7FLooAfEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730734989; c=relaxed/simple;
	bh=5G/T8gvMQBhWquYMhqPbt57MmlOiM6Er6pdZSzTrgww=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ghmo5Gwl2WQX3vKinhvhZU/sS+cS2kyKftvt2VB7gWCCnN3wWsyetvU7lqfTNadkLMTxfaN5O6i4CSNlFYR952iXrv8QPXkXV6hXeGisCS+1OXRM05oOLLfYCYQnU0LYeCw0dS7wCHsELP8sLpHSfZxFbI7eYUNfyGk+c3jwr70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FBbbYCJ5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4BVZRM029772;
	Mon, 4 Nov 2024 15:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KzW5P3qb3Z1GMZlfDiqZUQ5ix7xIJXt7+iLEPXs/j+U=; b=FBbbYCJ5C04flBaA
	IZr43wx6eCK6Nl207tS+rirCQpOyXZ7q2wpps2YLE4qTpZ7mYiOqoFlz7thw1Xjs
	yMgbxaaTo8XOsnrvHWlY+s9tbgMMAyM6nml22+AsO4b8deiWbqElzjRMCny35nQY
	Bym1tvmQ5cvsIeUq7DKgQQXHa1KaXtS4oW68t4UjUH67syaz8fxAmezywyuIUPBw
	hdMGt5NbwHLEPa7J3YB6UsHlFwRxKFVlaLzU6V0x7BHrzLcnKk0rxrjhJ01Pihbv
	1pf79Pc4ZFpCc61eFGFG/v1BQOGgNTjDcrss447emwgMzWpc5Wkn42NHBWYIyC8M
	DeLxmQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd2r4p0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 15:43:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A4Fh33x011720
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Nov 2024 15:43:03 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 4 Nov 2024
 07:43:03 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath11k@lists.infradead.org>,
        Balaji Pothunoori
	<quic_bpothuno@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
In-Reply-To: <20241029083340.3010798-1-quic_bpothuno@quicinc.com>
References: <20241029083340.3010798-1-quic_bpothuno@quicinc.com>
Subject: Re: [PATCH] wifi: ath11k: Suspend hardware before firmware mode
 off for WCN6750
Message-ID: <173073498333.2435998.1800878061133992125.b4-ty@quicinc.com>
Date: Mon, 4 Nov 2024 07:43:03 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: U8mZ8uLNTwDe0flfUc7gqx5xDRI39yWc
X-Proofpoint-GUID: U8mZ8uLNTwDe0flfUc7gqx5xDRI39yWc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=727 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040135


On Tue, 29 Oct 2024 14:03:40 +0530, Balaji Pothunoori wrote:
> During rmmod, the ath11k host driver sends a QMI MODE OFF command
> to firmware.
> As part of this command, firmware initiates WLAN de-initialization
> and accesses certain UMAC registers during this process.
> Currently, on WCN6750 WLAN hardware, the system is in a sleep state when
> firmware receives the QMI MODE OFF command.
> This results in a firmware/hardware reset while accessing the UMAC hardware
> registers during sleep state.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: Suspend hardware before firmware mode off for WCN6750
      commit: b39f8deb8df9664f34aebd9c6c8e234a7417041b

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


