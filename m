Return-Path: <linux-wireless+bounces-14101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963FF9A0E9A
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 17:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0E71C20B58
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 15:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B301854F95;
	Wed, 16 Oct 2024 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DjnbrJVx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5378B18C920
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093155; cv=none; b=jMIsBlhP1lfVaMK/HqLO7/L6J7EBuCgVWLCe61yJ7JZN8CVbuVmjU096lYayHOYM7DvRTtcmrUSpjlAfsJpjzWxM+fAA1hVk79ck8Um1hkr7CQALR+srlYLh8jojE4Pc1fxB+ZacVkUo0+Fp/pPGryiQW64lZr5nMtK7rHVCOdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093155; c=relaxed/simple;
	bh=pLOIcZq0HPF2lkMzHwgs/Flprp6FNrtej9rMdWzeYlU=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=sgGL3v3Z4/jgLQ0HaUrF+2kauevrnMDK3VYvo4lzR497rpl1CjBTjhlGaLlr8Cb6oO9rK/oNE1N+HjEkOMYf1G2ywd6vJIhKyF6a8GKqZ67MN2tfln7VumEL763evi64r6N37LmcdmcyJO34Lc/OwzH7C4iVqxWDJnEvNO261vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DjnbrJVx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G8Q2Kx002600;
	Wed, 16 Oct 2024 15:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SH3bBZN/9oAcprWisJXMyVK4cNqUwM2Chc4nWaqNOdg=; b=DjnbrJVxbWfFmIup
	6GyB+gUk6RhaUwdRpgNRGAOL3hNh0TLUf+0J55ASWTMnYpFmXKs9GuYdmXt4rJNP
	zEvOtuJOb4tlNxYSQLV7bUZvV9dUI3O+R+j4D0Wo6VIIscYvEcqdAfdpic8gX5Ht
	6LIR+tMhIvqGGa/oq5m4FxrDk5GGn621lQBmoe2pglcWV7dfPcB+l5mB/0fcCdur
	tzj8F7tMTcnmQrsj2wC93opJw5NwvrjlXv49Aa25/5eQI6BckD/9ruYcqF2SbzD4
	lJbvb34YeUq7Arz3epE1wSQ6kZGLolzSdAEgCnFwe1cmsGdxYb86sx3BNYINPtb9
	geAIGQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42a5xyj3xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 15:39:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49GFd9RE026363
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 15:39:09 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 16 Oct
 2024 08:39:09 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath12k@lists.infradead.org>, Kalle Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
In-Reply-To: <20241015171416.518022-1-kvalo@kernel.org>
References: <20241015171416.518022-1-kvalo@kernel.org>
Subject: Re: [PATCH 00/11] wifi: ath12k: MLO support part 1
Message-ID: <172909314915.475660.17863446001052139312.b4-ty@quicinc.com>
Date: Wed, 16 Oct 2024 08:39:09 -0700
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
X-Proofpoint-GUID: EFus7yCFiMeXKnuINh4DNRYISoMXJAXA
X-Proofpoint-ORIG-GUID: EFus7yCFiMeXKnuINh4DNRYISoMXJAXA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=426 lowpriorityscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160098


On Tue, 15 Oct 2024 20:14:05 +0300, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> I'll start submitting patches for adding MLO support to ath12k. There will be
> several patchsets and this is the first one (of many).
> 
> In this patchset we start refactoring code in mac.c to support multiple links.
> 
> [...]

Applied, thanks!

[01/11] wifi: ath12k: prepare vif data structure for MLO handling
        commit: 3dd2c68f206ef7020d12b9f85cbfe05ca8662cf4
[02/11] wifi: ath12k: pass ath12k_link_vif instead of vif/ahvif
        commit: 005fe43b93dedb621a0827408051f3a51d7a0769
[03/11] wifi: ath12k: prepare sta data structure for MLO handling
        commit: b89b5dbea65294e660f26e90d51ec786a7fdccb9
[04/11] wifi: ath12k: prepare vif config caching for MLO
        commit: 84c59710829411d4ad344cc6cd8a0fb2d9faa104
[05/11] wifi: ath12k: modify ath12k_mac_vif_chan() for MLO
        commit: abaadb934b30ec86065e9c8a23843d7bb8be0064
[06/11] wifi: ath12k: modify ath12k_get_arvif_iter() for MLO
        commit: 94a2712f0b152739d1f506977fc38be0da37610f
[07/11] wifi: ath12k: modify ath12k_mac_op_bss_info_changed() for MLO
        commit: afbab6e4e88da68cca94cabfc1604d71db161d42
[08/11] wifi: ath12k: modify ath12k_mac_op_set_key() for MLO
        commit: 25e18b9d6b4bfd9cb3dd32e7b081eef306cd2517
[09/11] wifi: ath12k: update ath12k_mac_op_conf_tx() for MLO
        commit: af41f908c9e4d3358b5753648e669114d9109004
[10/11] wifi: ath12k: update ath12k_mac_op_update_vif_offload() for MLO
        commit: f4adb07e0a524a35b34397ad08d0199cfe2c450f
[11/11] wifi: ath12k: modify link arvif creation and removal for MLO
        commit: 477cabfdb776b571fab425813c074f30c02a5cf6

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


