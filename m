Return-Path: <linux-wireless+bounces-14095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8C49A0DE4
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 17:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0211F1F232B3
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 15:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A0D207A3E;
	Wed, 16 Oct 2024 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SpRgkFop"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDAE54F95
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091882; cv=none; b=piVvfl9ZSU64qpEeKU/mitnkOdP7dsAhjoP83caVKqYdgKN8EmvDu647nxqjb/2vn9i3HO/DO54n9RpoD0apbwF9BlR51b0i/V8/WzXo7LEg37wSjdv5wZ2MpNKlt5RtyGQ8bvZ43sOtViBv8AWqqxd6Ff9x6xu1AIM0HU4yUgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091882; c=relaxed/simple;
	bh=WhJZFWruXkc08Rk7Vhc6A7hgqcdnzAZNlwWTb/RFWwQ=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Y7PnIxqKb/9D1XLJ8wLy0zFmydMxinfGXeOSGy2asnnW/hJ5NJIss1U5B8ImidT/rpqajhn5M2dtZvzyVpEusFzllCFe7EF3f28BC2w/p6L/yt6Lmpx7LQNl1VuFKRsBXBOp2dg3AFBRYSvMoEqW8lYFUiKfeQEQBlQFNLGQHPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SpRgkFop; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GAI0PI011211;
	Wed, 16 Oct 2024 15:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yodT7FICiIW0rCw1Keg6+Pyf7e5GDnbOJwbunkzAy1g=; b=SpRgkFopPKTeQLUx
	43lN8Wil1zZ9uPdp2tUpG4ElMzTOHShtcX1lE9sS2xADPf9VDnHKhOVhcA9H+mjk
	43FR0TWTuOFRo59mcd0uJcarq8jy739zT06znIB7STt75Serwm4m94PnYpngrYpn
	/C802WKWXQcqghwDQT6dL+51dECoK/ZCT3O6IEwurr2XKiBNPeYWrJ7f5/a2gRAh
	6o3vdYp93HBSS+HU4f0nDJhaWb6kpzMmQMlK34/QsvffHyey47S0b7+AP33RDgrX
	FiUjcivlNCA0is9gAKyiBRD9UCk+rojU/gwPZtFZ3TdMo3Lx5xCHe8ghSAPh0clu
	rwJYXA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42abm5h0v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 15:17:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49GFHuO9011664
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 15:17:56 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 16 Oct
 2024 08:17:56 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath10k@lists.infradead.org>, Kang Yang <quic_kangyang@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
In-Reply-To: <20241008022246.1010-1-quic_kangyang@quicinc.com>
References: <20241008022246.1010-1-quic_kangyang@quicinc.com>
Subject: Re: [PATCH] wifi: ath10k: avoid NULL pointer error during sdio
 remove
Message-ID: <172909187624.412681.7966986946619521130.b4-ty@quicinc.com>
Date: Wed, 16 Oct 2024 08:17:56 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O3YDfKPodeSNh70q_x4XpPkvYDa1JjJS
X-Proofpoint-GUID: O3YDfKPodeSNh70q_x4XpPkvYDa1JjJS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=493 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160096


On Tue, 08 Oct 2024 10:22:46 +0800, Kang Yang wrote:
> When running 'rmmod ath10k', ath10k_sdio_remove() will free sdio
> workqueue by destroy_workqueue(). But if CONFIG_INIT_ON_FREE_DEFAULT_ON
> is set to yes, kernel panic will happen:
> Call trace:
>  destroy_workqueue+0x1c/0x258
>  ath10k_sdio_remove+0x84/0x94
>  sdio_bus_remove+0x50/0x16c
>  device_release_driver_internal+0x188/0x25c
>  device_driver_detach+0x20/0x2c
> 
> [...]

Applied, thanks!

[1/1] wifi: ath10k: avoid NULL pointer error during sdio remove
      commit: 95c38953cb1ecf40399a676a1f85dfe2b5780a9a

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


