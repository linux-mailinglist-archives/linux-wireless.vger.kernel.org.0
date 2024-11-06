Return-Path: <linux-wireless+bounces-15006-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E08C9BF34A
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 17:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03DD4283ADF
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FE2205AAC;
	Wed,  6 Nov 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f+F2ug57"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDA5203706
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730910818; cv=none; b=EFnM9imZpcw8WER509XsmkvYM4/usq76N1JtmEgNU1tVSndX/0zya3DKyRx2CYUfDBRyjcFs/7gNaREcnlruJ3waMlZbq8CD9fCwK46/wIqgkuI8S6b8frc8JHFyrhVEAnbNwScD+QvE8w1XJGaVXAnK6uhozfak3sIQ0fqx0QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730910818; c=relaxed/simple;
	bh=+WVKCrX3qUvkgXb38+X16smUa/t96+Z2j5DHxQCoYGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TlSa23F+NUMzKap6BFDP6s2xP3/2d7QXU5THNkDoHD/U/ToB3KHjbOIi1ZDUZIR7/jWKI7YlM4QKkDv1kx+77bvVCp5rRPChGJ14uM8hgODYGAD9MfTF2dbIPAHHgxRIaKazSwvfOMpxQX2k55GB1ppXvhsTtHe2gCYcwRSDO3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f+F2ug57; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6ERRpc002169;
	Wed, 6 Nov 2024 16:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4k37186Jjrf1YEYU93z1Umnye1L6hFQEO9ORFBh4iVU=; b=f+F2ug57t0oTerDO
	AeX0fArlslqjqU6/M0iagoffMlB6dEJDygDSwB2Wis3UdquscoMnDPOJipKVcKXm
	BcEAgXAgZ/xEdly+FJd4RbwZQIjua7ruayBM71jCK/DnL3IWtvpgK6NZP8bQGHZy
	ZTccLrxsoJFYhAUnhn0bWUZm99MwlDaCQo8uvIehub47fxk0jtEeHNm7RhG2ft6R
	di4WyiMtsyNiTXO7SQ7+TlwbSOl5oqiLxNt3uvfeGr+eeR7mlenDBU2bEvWHtzB8
	QEN7XiiRmIYcrv6jIQGeVxJv3zbROnQf+05fpusshbT5pXvvO8nzLpb0JdOQaPUD
	rWWe5Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42r072hyc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 16:33:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A6GXWXD014978
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 16:33:32 GMT
Received: from [10.48.242.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 08:33:32 -0800
Message-ID: <50cfd92e-ca96-4dcd-9787-0f1d7d705c7d@quicinc.com>
Date: Wed, 6 Nov 2024 08:33:32 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] wifi: ath12k: add reo queue lookup table for ML peers
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241106142617.660901-1-kvalo@kernel.org>
 <20241106142617.660901-6-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241106142617.660901-6-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pjAqySWZotCRwxS0xNVB_6mzvjuxXWzL
X-Proofpoint-GUID: pjAqySWZotCRwxS0xNVB_6mzvjuxXWzL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 suspectscore=0 mlxlogscore=987 spamscore=0
 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060128

On 11/6/2024 6:26 AM, Kalle Valo wrote:
> From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> 
> Currently reoqueue tid setup uses lookup table (LUT) during peer association,
> but for ML peer there will be multiple link peers (belonging to different
> underlying firmware) affiliated to each other. Hence the reo queue should be
> setup only on one of the links which is the primary link.
> 
> Add changes to create separate ML reo queue lookup table for ML peers and use
> the same while setting up rx tid for ML peer's primary link. For ML peers use
> ml_peer_id instead of peer_id to setup/lookup the reo queue entry in the LUT.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



