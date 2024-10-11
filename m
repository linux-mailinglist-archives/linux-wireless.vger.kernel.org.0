Return-Path: <linux-wireless+bounces-13894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE8D99A88A
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 18:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA645B24082
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 16:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616E55381E;
	Fri, 11 Oct 2024 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fUQqb74W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B840713CF82
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662459; cv=none; b=ZuYkyuWhTTrGokd7AO6IVbJp6HXYQ5Ln4LSTY2WDgxNNQlUoTnuJoUUTZmgPD51hQvVmv8N3BFjLwlFNI50pmFMFK96gFeGFclOYIR8VtA486kBkO0zQzrzgWgJzJhmsnnjxUlRT4lI6dRquVKBxK4n2rs0CgeuvBZkotagnwVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662459; c=relaxed/simple;
	bh=JjHp8nf7IfBePfeVS8mOf3b5kiRTFWlkRXcPwY34i2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FVDWz6QTYcxjVXvzDjv28UV3x2HNqYrx7nZELa5cgGPhRlRXLiX+eOQAunxRoR1BlAFiKcpCKpbXHX6yu+TeX33jzgPAlPDOhOOJPk8tfouGFJnvmD6OIEy3+F5hEBK+RV+YRcXi8k3AJpHBHWvrABu9Hqb/wC38mFQ5AXFnxP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fUQqb74W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BDew9J029117;
	Fri, 11 Oct 2024 16:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JsZ0ZKB81vOG32I5myvjx9H1fnY5C9SDkuOxZLf8e7k=; b=fUQqb74WDxZLrdk2
	D7ebQyMgG3vNslymqjyxK3QP4KUkpDY4IUCeKrf/Qv5An8Qr40Caer5Xouu/z88l
	tIrFqRn97pO6E6v8Yt2ax5rV2u5xk4a9qK/PtyR3ifpTYRafEbOMl690057sbEsF
	lsbCyl47c4dxNznj8x1AtvuTKsSF6rfFRGO++H/XrM/PxyyDuaK7Lnxboklvc2cw
	a1IMU6l5TS4gtKID7OF71yOhPkeWOsWHxuhI/S6i9jLhK5h4rWhwQqvPRqhRL0ZK
	y83ZEOVZCmiudq58YNMNTUw9vvnCHV5v9JPx1VhPOtk+gpcl2ojYMNjSV5MJ2zGs
	BNyH2Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 426g6nbqn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 16:00:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49BG0Jee020297
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 16:00:19 GMT
Received: from [10.48.240.152] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 11 Oct
 2024 09:00:18 -0700
Message-ID: <a60830f2-0a2b-48a8-a8d9-762983ff6fe2@quicinc.com>
Date: Fri, 11 Oct 2024 09:00:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] wifi: ath5k: add two PCI IDs
To: Rosen Penev <rosenp@gmail.com>, <linux-wireless@vger.kernel.org>
CC: <kvalo@kernel.org>, <toke@toke.dk>, <nbd@nbd.name>,
        <yangshiji66@outlook.com>, <hauke@hauke-m.de>, <jirislaby@kernel.org>,
        <mickflemm@gmail.com>, <mcgrof@kernel.org>
References: <20240930180716.139894-1-rosenp@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240930180716.139894-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: S5BkvQptl9PSgzmqIJi67OQbDdigTHL3
X-Proofpoint-GUID: S5BkvQptl9PSgzmqIJi67OQbDdigTHL3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0
 mlxlogscore=610 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410110111

On 9/30/2024 11:07 AM, Rosen Penev wrote:
> These have been hanging around OpenWrt and never upstreamed for some
> reason.
> 
> Rosen Penev (2):
>   wifi: ath5k: add PCI ID for SX76X
>   wifi: ath5k: add PCI ID for Arcadyan devices
> 
>  drivers/net/wireless/ath/ath5k/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Does the upstream driver handle these devices ok, or does actual support
require patches that are present in OpenWrt?

