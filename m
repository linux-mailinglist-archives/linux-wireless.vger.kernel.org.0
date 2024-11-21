Return-Path: <linux-wireless+bounces-15566-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9F59D5087
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 17:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F351F23BC3
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 16:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE3D1A0BF1;
	Thu, 21 Nov 2024 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IJWiAJlj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D851A19F462;
	Thu, 21 Nov 2024 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732205569; cv=none; b=Lmp0lpj7qp337odSR2MK7ex2joucPso7Vw39hlPdGeE+v4gM2G06JImQ0BnAqQ3hS27TuLU6JUdJOQWb+/fHTa3Mw6bFkYjKjFkfrOWXTUi2m3m04uzBQKPPL6zQ1p9p0D5m6q2cMBvSBKDcYFChNT4hly6wPO801BUNYw20c88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732205569; c=relaxed/simple;
	bh=G6mmK9iummfI8uqVJR64iMtuLmp55IUdmP6l8CMAXXc=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=syuWdfyBsqp0bO4mfhbYYVvHlrMvtsN6g+0feviqIwjMHyFQeOpD6toF7dsGf79COpZNap3jgeERj4c4QgKQfG/AUZ8OA4FWULMWt4jJHqhF03zAW8UpUHCYG4dmlqwg0mVzcduKDk86kybNgt8/F7fnxoeXa7qYp9FjWNua+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IJWiAJlj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALA8OKo020278;
	Thu, 21 Nov 2024 16:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ybsTrJGwpSAEtFJASHXO/mug9DwdeoX34GKgIEcllZA=; b=IJWiAJlje3s4iExl
	q76KQS5v8osTB3/UafTzitrAS+345/qkJ+JEvOH2RAsMElzVuNVQ+C40AVjv4cZB
	DSAua3lH7USXKwsxLgnAtn/lIQqsowoGote9WsX31ALzwzNDLtUSDh8NWOx3Al8t
	cAeX/J5Wgj8Ppp1c76Byq2a39zoBUNy7HuFKRaM34Hg6LVLve9L51YkQ7AXVLigA
	53potx18sEFaHm//qz5GNHdYbaYIrSDB+AEBAXB3CRlVLy5tB5qqM1rLp4bZkvRm
	Pd6W/9S1liuqHzMEL7RdMFOcNegLg44Wt3xp7coxE9HBiBgcFBJ46hnjvK8uLL5X
	Z9sM0Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431sv2jeak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 16:12:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ALGCeJt002134
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 16:12:40 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 21 Nov
 2024 08:12:40 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        "Nathan
 Chancellor" <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
In-Reply-To: <20241119-ath11k-noinline-v1-0-4ec0a8aa30b2@quicinc.com>
References: <20241119-ath11k-noinline-v1-0-4ec0a8aa30b2@quicinc.com>
Subject: Re: [PATCH 0/3] wifi: ath11k: Fix clang+KASAN stack frame size
 warnings
Message-ID: <173220556011.3016923.10367972856606077534.b4-ty@quicinc.com>
Date: Thu, 21 Nov 2024 08:12:40 -0800
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
X-Proofpoint-GUID: -XETNq8xSJeBI4CoWdqMO6J2ZYGeYV4_
X-Proofpoint-ORIG-GUID: -XETNq8xSJeBI4CoWdqMO6J2ZYGeYV4_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=826 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210124


On Tue, 19 Nov 2024 07:47:37 -0800, Jeff Johnson wrote:
> Fix the following stack size warnings observed when using clang with
> KASAN enabled:
> 
> 

Applied, thanks!

[1/3] wifi: ath11k: mark some QMI driver event helpers as noinline
      commit: 8ea1d2072ad1a9c24b326b50ebdc2c810c4b2cce
[2/3] wifi: ath11k: mark ath11k_dp_rx_mon_mpdu_pop() as noinline
      commit: 500d7ec88652ba7316e7fba334754e39e3177e4a
[3/3] wifi: ath11k: mark ath11k_wow_convert_8023_to_80211() as noinline
      commit: 4ba72ff2919cad90e1963b708ce23b92120613ff

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


