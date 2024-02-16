Return-Path: <linux-wireless+bounces-3679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558A8857F9B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 15:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86619B238F7
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 14:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D027112E1FA;
	Fri, 16 Feb 2024 14:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LQcVhgoA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB2412C542
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094561; cv=none; b=S9FsRqLbagdrfuHZoJgI2Kg25oUo9rM/xoH3jJ+I4vMWXliXglh12cckiB1UEuyueQsphEhI1T4GXdDUckfIoni3CaaQoq9kB/Hl7h6eZo48pkdyfURcEq6TVvkUvH0JgynaFsJyZK8JU8WHsBAVTKMuiNaFBM1zfXK+6EGLn3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094561; c=relaxed/simple;
	bh=XHSbBrRYzP1sCc9ouUti5xpk+AIk9vPgKu1H+6X79Ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o5O4cdH+qf/o4OB3ySZjOPj9Ip4BypZ5tqze++XrbrDY0HILESwqxdmLdGTb7x7tSaPu+oGPYSC3fYrT/CMyD/vuYKP90poE4wSvCNykzIqQUqfqzHReztacBdAz+IVWlukyh4izs8z5yRTOUL2uIjLIBRATd767cB9j7dGOiJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LQcVhgoA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G9HhKf024108;
	Fri, 16 Feb 2024 14:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ctEWOvKq85cJ+racNeEMeTD5jw+6JVTg0cNLy06H7Kk=; b=LQ
	cVhgoAQE3NOMAu60OorGX+4Yc8J9z6mU97I2rt8t1Kjzh4LkGaD9FFpbj6j3mdxW
	qylMAnvZxbmhMnKQ6tA7siMGK1phKGyEtvfnEMVW2xyST991vodydNFYGQu7G686
	iQqGlHD9/zIl5PhggF0QXJbIKzIzXYd+vri5mpMtPfEIfOFKq1vyLPMAoW6PXWHo
	ybN6cfN6jAokvMLulMWxTzFz4m1rr1I0IYSG5oPXTyEtFh+E4pgiw44VnUxww4Te
	fQr20/QT77nlHKsaJoGhkRlZVP5757vC+eE1ae2Lx/f9jRgjnqrbWEsHbUFA2PHh
	Le1RhvTCDjqW0US0S1nw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9xv9h79q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:42:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GEgZKt006539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:42:35 GMT
Received: from [10.216.11.141] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 06:42:34 -0800
Message-ID: <ea5ca96c-6143-45c3-ab30-a35c127f1a64@quicinc.com>
Date: Fri, 16 Feb 2024 20:12:27 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] wifi: mac80211/mac80211_hwsim: support MLO CSA
 test case
Content-Language: en-US
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240216143918.514140-1-quic_adisi@quicinc.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <20240216143918.514140-1-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HsTFEi7VqO8FdJ1vCnKsZHmkl8ei59mv
X-Proofpoint-GUID: HsTFEi7VqO8FdJ1vCnKsZHmkl8ei59mv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_13,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 bulkscore=0 adultscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=847
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160118

On 2/16/24 20:09, Aditya Kumar Singh wrote:
> Recently MLO CSA is enabled on the stack. Add test infra support in
> mac80211_hwsim in order to support basic MLO CSA test case.
> 
> Aditya Kumar Singh (2):
>    wifi: mac80211: check beacon countdown is complete on per link basis
>    wifi: mac80211_hwsim: add support for switch_vif_chanctx callback
> ---
> v2: handled all mode cases of channel contexts in [2/2]
> 
> ---

Kindly ignore this series. Sent v1 again by mistake. Will send v3.

