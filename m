Return-Path: <linux-wireless+bounces-21202-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ECAA7E481
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 17:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E84D4441EB
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 15:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5CC3594B;
	Mon,  7 Apr 2025 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g3Wgyvol"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D4B1F9F7C
	for <linux-wireless@vger.kernel.org>; Mon,  7 Apr 2025 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744039441; cv=none; b=q3StgX2Bf4XTqKjT6WPPnJyeQGUL4uh9o6ioLlNuUFUCdQPkFO1QT9Ns0J4+qVp623mVqI39UGmiigsHeW6iQluvnuBMDS9/si5LG87YQI3+xnXLw8DZWxu2HBQWenJagEj1ivI8AeaX9gl9wWz50eC8v+YlY+uUQcAmTtA4CJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744039441; c=relaxed/simple;
	bh=SMU9In7NtwG6Krf2/NoOgS7PefsWHycLGaaW8gJxGpg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AmpHEmc8hjAGcZVN5NqShhrr77t8FQA4EuTf2/0LY6ldUH2GujuCQH1P4bEAw3sk+s1vy8OsoX+tSSRMMSeU69O27VzP9svNN2lGqszzkyJYyyJ1GMmf6Iui/f6EG9k/xpZjziB/c52NnNQAXEMN8is02cGRbMAPXzdar1Vgjzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g3Wgyvol; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378dnJZ023047
	for <linux-wireless@vger.kernel.org>; Mon, 7 Apr 2025 15:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R/WmIDBmkJ9OWpixQlYZczF//mMv6RkTX6rhwr46yNE=; b=g3WgyvolJIOZ40te
	G+ZxzwbJgZwhrtPD9E9zXdIt6iFoGbZbZ2vEGhpgZRpZVSPWlIctTlqaiLuiMuTs
	KzVXlSWHZcnHF0ugwmXYYa8TL4Fj6yTTnGKXvcZlIGeFAi+HI5Ul9ywAkFlxeBkF
	FOKhdEZ2sx8NSl5x4Twsy9FJv4Uc44Rko8XCARawWjLzHx25fTGyXK1akBHSvKXe
	jqu6xAc4vwq0tS44vyKRQVbV2INYH5X/o1y5Ypl+ORWj5L5PBqGnaXnjlcG7w0li
	DReeX4MRE8ZR9OQRXIPF0vfxYOy+KC4kU8kBf7NcfxY5O5fimO0+HxDmVsJ2pnJb
	WT+6sw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcrcpds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 15:23:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-227e2faab6dso37468075ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 08:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744039437; x=1744644237;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/WmIDBmkJ9OWpixQlYZczF//mMv6RkTX6rhwr46yNE=;
        b=uXdUe1qy6gczaFNMeor7QgeN1wepuSyqnWYk+pKWV9mbu+KP5TJzRjEn9czGRHraLC
         nmQ7m6PIo1Bi23U8qwK0WVrTc7ZjyWUfC3FudjdnnvBZq9Js+dU9rPjDx0GGhXsv23lC
         EnYK7V68sLkJFW0ecmzSaJSaR3PaLMKvfXIYxCY+1RuDlfmD5elg6OtgpPpCYvZslk6F
         VoOPrU17l/nqgwHxOnSAdC4PconS2R0wVUFRyegy72t9CMOVJfLYucN9RlwJBfdG1w3U
         c6fgk0KAiC1ge/LlAimxsUDar7ReunULI9TwhDwAQaSeokBAZhCgd7f5yUmhQqWnPaRm
         Ur/Q==
X-Gm-Message-State: AOJu0YyE4O5aGm6MxDkt5fuAYtQLKCRL3PJfpASDjYmrf8Gk3dqw0ePo
	HBZGpMLCVmANp5QA8gHC2lYm4ZaBuhDHxt9TECLI7Te98SAEAsl6dbcqAjSXPb5NOOPy/WAqiJA
	IuUxGmyWZRx33kZhNj2yrSBoRmZ3MLJHF/z1bC9CKqrgjfkYZNx3HEP71FcmcgtqQQcakSLmlDQ
	==
X-Gm-Gg: ASbGncspkkrX6Fli0u2eux5wnZ8cUPlQLnvX0OOy+A4Qi0Ew1QKiiEDn2l1rge2CsC7
	H1Nc1+MbLmyB6en2Ch+dTG4hNzxWrbJ/vC1g37Df3r6caInBqkkP5A3S4glDK9Tx4rph828D41a
	39jVjRGWCGu12KlEuOEBQGgZ06BNOCVnpwsEudwGtv/SJdzxAodl2fYeNnEaQec5pHvtn8Bts/Q
	lbKUZnjamcMpg6eFK1i/CF5COP+bqBl9I0Q0nPl7u83wkueqA9/V7TunIoU3mohhhdjnnDzzMp6
	u8JXl7nOLcHZPM+tEYe9lrQkschnhuhvAgAT+ibtD63+TYHclzPt
X-Received: by 2002:a17:902:ebc9:b0:21f:ba77:c45e with SMTP id d9443c01a7336-22a8a1d230bmr173288055ad.45.1744039436666;
        Mon, 07 Apr 2025 08:23:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtVvUgJgoESeXWEn0mznhFx7fSjezYDZxgWSyW5Zj/fYDcMecZQLSuuR50ZTUgntjs5LAYGA==
X-Received: by 2002:a17:902:ebc9:b0:21f:ba77:c45e with SMTP id d9443c01a7336-22a8a1d230bmr173287375ad.45.1744039435936;
        Mon, 07 Apr 2025 08:23:55 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0e7d3fsm8691592b3a.180.2025.04.07.08.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 08:23:55 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, P Praneesh <praneesh.p@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250402175714.2667270-1-praneesh.p@oss.qualcomm.com>
References: <20250402175714.2667270-1-praneesh.p@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix memory corruption during
 MLO multicast tx
Message-Id: <174403943537.2068408.1682750933741678430.b4-ty@oss.qualcomm.com>
Date: Mon, 07 Apr 2025 08:23:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: 2LJs0579f9ZJ-r_nh5wtFM2YNd-3JKJP
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f3ee0e cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=VIh1eF_YvHMjifF3oykA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 2LJs0579f9ZJ-r_nh5wtFM2YNd-3JKJP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=602 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070107


On Wed, 02 Apr 2025 23:27:14 +0530, P Praneesh wrote:
> The struct sk_buff's control buffer is shared by mac80211's struct
> ieee80211_tx_info and ath12k's struct ath12k_skb_cb. When the driver wants
> to transmit an skb, it caches all the mac80211-specific information from
> struct ieee80211_tx_info, then performs a memset on the control buffer
> before writing the ath12k-specific information using struct ath12k_skb_cb.
> However, during multicast tx, the key is being filled into the driver data,
> which overwrites some crucial members like link_id and flags in struct
> ath12k_skb_cb. This causes invalid information retrieval when the driver
> accesses these fields during ath12k_dp_tx(). Fix this issue by removing
> the key filling logic during MLO multicast tx, as it is not used anywhere
> in the tx path.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix memory corruption during MLO multicast tx
      commit: 6f8a27a584b23e9dedefd6cb110dd2587b84a6d4

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


