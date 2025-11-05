Return-Path: <linux-wireless+bounces-28626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 119EBC365E5
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 16:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0CE1899CC4
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 15:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6F833BBD5;
	Wed,  5 Nov 2025 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lidao/OF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FGoe4eZ8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB2F33CEB2
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 15:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356051; cv=none; b=ffMxdVaHRm8CcClc7pSv82WVWddLRsS//YwXQSwXLpDgkuJW/IlhSRwQoJAf5Pn7Hk1MJ8xH7Pclfo4cdrbwPeA9fqKHQlpq65YpIgvFYW5Lor4N8STwjR9xI7t3ep2sQNYF07JVbtC2+RJ33xwEpAe+BiMXLDr19VtQ5OB8U4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356051; c=relaxed/simple;
	bh=3csexf3U4x+mrp1A3Ivj9bskw3Ipror5msSJDIgGTTk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FJvCYZK3RI1t+bWcYYncjlBWqA07Wt2oPf+lHcgN1SD861yE7HccJAP6deWTDjhZB53cKNQ7zgknu4Djjqh3BrqtSD2ljQ0EmLcih6PshO3E+EjbrhGB9K6fIHsC/2b5cQ5dkRTIrTgSN7VxFwVm93Ywnsa+tiyogdfymYZssS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lidao/OF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FGoe4eZ8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A599iDu356680
	for <linux-wireless@vger.kernel.org>; Wed, 5 Nov 2025 15:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WkTC+8vz9rlIGdO40HdvQrczR14lJ9vNHU0NhhLbeBU=; b=Lidao/OFkl9z1saB
	irf4GF4KCHv4T2LWzpfvRzLt1UFMJe3fWyxEwVfV3QtpzASLIF0/oWB3CODQBBw+
	LLHq+3omLqLtwqUl/yfdMcUDYRv+v3+CUl14xhoxgIprQmvpSKiiRi2iGHxvgt+g
	Nv1gjsEKvGOiAvwztKC4aqWwtxn1RNXzFl52jP1+kfsBmqBi2CTDLW25T2oXCEgR
	Z/fvNXaRcBGRL6i6PHhF+Sccwo0NMRS/aN8H6migaxh9aHDA/Ij3Jw+LhrUwYmJF
	rmAdaIcQ6/7HQqVC5C4IwtR+ogMac4Gpt7jIe2z9zkEuckBfWPH5LCx7EJ0oZBoL
	f5CO9w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a83q5h0b9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 05 Nov 2025 15:20:48 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a267606fe8so79b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 05 Nov 2025 07:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762356047; x=1762960847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkTC+8vz9rlIGdO40HdvQrczR14lJ9vNHU0NhhLbeBU=;
        b=FGoe4eZ8iAAK3DE2oUD/O8cihqHXUFQvWP8s97T30OgTpD9L4YYFFm37RXpGAwZ15/
         mUq3ejsZSWtP2/7zMquaWHzMG313iLtmai3iXda9z8YC52f65C2XgROpTLMCA7Y75cfZ
         df1qbH62YMJ7uhvfyek+MJixR12IP/Ha8C5yiCaVo4qzgA9gErVy9QwPHgxJnAi1WQVn
         geymlkwbKgyj/shZeOt+aKEi+aac8niGXYpgU8zVqwa8zbKFisKipjiXkh8L+yEXr5Dj
         FpWan+kI4DIs5EislNlXuWI6o7Y+z5FaBZ98UEn8glZMKUCLkwGQma8I6fCrJNXkO5Rw
         w3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762356047; x=1762960847;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkTC+8vz9rlIGdO40HdvQrczR14lJ9vNHU0NhhLbeBU=;
        b=GC5/OuoOg9fq0EmSHVvaxJY+nUUJYDRzIqYdZjJx6uaVNRI8qdaooUyP9CysWhLp1M
         s1xd6FewlraNO23EIWDdLFBlECZhw9BXKVU9hPndTYy+0EqfgmWSn1XJ7M6WllKmGmpf
         Lv8MPRXHOmGH2YoSG+F2aW70a7VO61oTC9F8M/nTweWrQF8BqHa9zYfpZ9+uhyt1XwXS
         yzwPOa99Of+TWIY8iTrgzsYavLDNKlJEI64K3qgThJAyIaFCMRNzu1ngyJ2ic3x2u93w
         srN/PTj7EgNb9FGN0wSRXuddqWvWsjYUEUHQeGWQSyyadaeS5sXmBKeAIct+IiLo5zqf
         2MMw==
X-Gm-Message-State: AOJu0YwXoJaDsAxa6TEmClt0yd+awSCwZOzj8b2Z8C20738kj/ar+unF
	o4ryOEBNSMrq4GKioATgzYjN2Ey5cdC70R3IAGFIg39RxYGQ9uxDDmCuEM0jdGWR4P6mWQo+GUr
	X/lk70C8aC5DO/S6o6EMzLKK9tviFgZtBLLKleAOUOMypql6sSMkGUnlCeTQ36SOsa1dF2v+nNk
	UMKA==
X-Gm-Gg: ASbGncvfqMhWf5mj0RK/4++9wpwGG9Fv9m3F/NFFbxUGLy/R4JMfZE1TFshrhif3/2D
	ZsDI5wFQ9nSk8QDoL6mDqTa4dvqmr0CnaNOxahd3a/dNrV7y00deUhrIZwP/ZQTENj7ZTYial8X
	yxXkx3mZRVCYhHr5i5Oagyr+nehuco4aYkYcOL2/7InrlFJkr81A5psS3OTlpy6hKCu2G1atS74
	bsO76vVahJ6uO/CmVbqHK6KX/sbJTZvlt3wnN0bPyxAbPhOs9/2noX5UTK2N9Q+IOC4AQPKrMZ7
	lcLRCcXvK4WQ7i1PwROfyB7oz/AWbUtmXiDhXMTB00XaqhKyXcaDLMLA2u5L3jsKYFCTUQYQWmM
	zi6D9Two4KZrNgYh8AcQBdufdM+uW6oAods8=
X-Received: by 2002:a05:6a00:4601:b0:7a2:74e5:a4a4 with SMTP id d2e1a72fcca58-7ae1eda0949mr4171048b3a.19.1762356047279;
        Wed, 05 Nov 2025 07:20:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8JDT507lZ+BZEsWZt0xVAtyRwefGvMFtqGsB/ejUTjivfmX9GhF7Yz88ZsBefY7bNJi01Gw==
X-Received: by 2002:a05:6a00:4601:b0:7a2:74e5:a4a4 with SMTP id d2e1a72fcca58-7ae1eda0949mr4171010b3a.19.1762356046729;
        Wed, 05 Nov 2025 07:20:46 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd382ad96sm6699198b3a.22.2025.11.05.07.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:20:45 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Ripan Deuri <quic_rdeuri@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20251103112111.2260639-1-quic_rdeuri@quicinc.com>
References: <20251103112111.2260639-1-quic_rdeuri@quicinc.com>
Subject: Re: [PATCH ath12k-ng 00/12] wifi: ath12k: Modularize Wi-Fi 7
 components and refactor data path structures
Message-Id: <176235604541.1854100.8439378063481655691.b4-ty@oss.qualcomm.com>
Date: Wed, 05 Nov 2025 07:20:45 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: uRNmK_sqxR5mKjLKDpnW9-2tHUyZQa2U
X-Proofpoint-GUID: uRNmK_sqxR5mKjLKDpnW9-2tHUyZQa2U
X-Authority-Analysis: v=2.4 cv=YZKwJgRf c=1 sm=1 tr=0 ts=690b6b50 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=2f47RPNSW2tIX227sv0A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDExNiBTYWx0ZWRfX/GBSNvBR0IE+
 1BS9FSDyb6OF4Rx9aDgCgyUVY1sGNjhnrBOJ8FjhVPfe/xzLkUSYLK8rwST1uBQX6y9KGvmX8Lj
 M9F6K+uThBxhFLFLVCE78UCi61+kfXTUcSixIi37pcstTxisdORUvP1/+djX33tphdTmGetVPXW
 z7yJregI/QGfMB+cfEpcR05o2Lr3GrhxImQ3B/OQjmwMzLhbFRfbp6L4yXfiCpv5pgAhoFJZTSg
 ysseXRc7IrD3Lj8ovg/8PM5ZJue888EA6AM7DKqi3TTs+iW0FALSppuAsHcftG1MKLmVTztXdHv
 IhT7kraL69MLzHK1IaA2UhVBV+i1wbU2FWdkmN9YBWV0dZtJS7NuK3kgy5EqwHZINaSzyNS9Wxu
 hR/T+uES7O4J3vI3cthgq8YRPFmtMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050116


On Mon, 03 Nov 2025 16:50:59 +0530, Ripan Deuri wrote:
> This patch series introduces a comprehensive set of changes aimed at enhancing
> the modularity and maintainability of the ath12k driver, in the context of
> Wi-Fi 7 support. The key updates include:
> 
> * Callback Integration for Wi-Fi 7 RX APIs:
> 
>    Introduces callbacks in arch_ops for RX-related APIs defined in the Wi-Fi 7
>    module. Adds wrapper functions to invoke these callbacks from the common
>    code. Enables seamless interaction between ath12k.ko and ath12k_wifi7.ko by
>    leveraging the ops mechanism.
> 
> [...]

Applied, thanks!

[01/12] wifi: ath12k: Add callbacks in arch_ops for rx APIs
        commit: 73c928346d095533ac56569bdd57c55d3ca81c3f
[02/12] wifi: ath12k: Move DP device stats to ath12k_dp
        commit: 775fe5acc18df4de4bad774faa50c88ee65882eb
[03/12] wifi: ath12k: Move DP specific link stats to DP link peer
        commit: 35fcf4fa196c9e30012b32a05c65762d5552a712
[04/12] wifi: ath12k: Add helper to free DP link peer
        commit: 05774dffb974cef9fa48ee23a2f604396c96df3b
[05/12] wifi: ath12k: Move ieee80211_ops callback to the arch specific module
        commit: c26f294fef2a4bf8c456e3d212bd7e1bd698efda
[06/12] wifi: ath12k: Remove the wifi7 header inclusions in common code
        commit: c870602510242527813843115edd31b20db06702
[07/12] wifi: ath12k: Move ath12k_dp_rx_frags_cleanup API to Wi-Fi 7
        commit: d43133a38b0ccc5e53b9efd9aa30f29f9db0b57c
[08/12] wifi: ath12k: Move ath12k_dp_rx_get_peer_id API to Wi-Fi 7
        commit: 147daefc59f007966b92e510b063d407850f2278
[09/12] wifi: ath12k: Remove arch-specific HAL dependencies from common DP
        commit: 951cca9cc68d67ff572db9de32a810a16d9bc1ad
[10/12] wifi: ath12k: Build all the files in wifi7 directory into ath12k_wifi7.ko
        commit: 219dd14992fca65c33666712939f6bdf001722e2
[11/12] wifi: ath12k: Use dp objects in performance critical paths
        commit: 96b42732bc75de66c5e10c67d6a60967004ceead
[12/12] wifi: ath12k: Replace lock/unlock with guard()
        commit: f87034a7576f918f2e60a14f17185b492e91580d

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


