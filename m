Return-Path: <linux-wireless+bounces-17171-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D93A04E21
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 01:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD516165450
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 00:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3111096F;
	Wed,  8 Jan 2025 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F6P+g6Be"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4155BD530
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 00:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736296349; cv=none; b=CM+8UdCf9GEklVz/h217lJaPNgaG2oOYCBwmpWdTH/r1uNbXHMM7TBDRs+cm9+bz9pSQQ9KdPxh6azK77ndt4sNE/Vh88vs29OZANrUXWHvBHku7eD4b349Gu8Rp5TTQlZiSySGId4JYLXRQDTEHjGC/4+VzTcqG/J4lKiNJ5io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736296349; c=relaxed/simple;
	bh=SIlXe4DPtQ3U/9Lfmd1cymC6dednbdGyUfDk4/8+/ZA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rMWvQN2HUJDO2ccr4PZVDgBAaTM1IdCpr3m17SVLqZgmPyf1VGFGCdpcIwdd2IrNg8EirgyJTW/I38gt0HEGjm9S5le1PbN/KQX1yjttNy4h8onAUfYaV6N6r1z/ywfcd6O2FlEESbBjauJ4GMJrz29S2MvnK8fyH5q0KIxGCV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F6P+g6Be; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507Fbb3t031350
	for <linux-wireless@vger.kernel.org>; Wed, 8 Jan 2025 00:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9Kr58GMuCHF2yomdZqxAr7GwLs9jKgl881I8HQqfF7o=; b=F6P+g6BeSNEkpAJs
	JE2IB/1lhHcBMSJiOcNxiNY9k0FOlMtO4bfXpEBhLy+qPXIQlttEYypQbfT3M2lw
	mrTxLsx6xrsX7Ro4/O/0c7K7QDhu1Rz5xMZrfdSFkmJ4ZtaP6jbCz5lsDWZccoAI
	5azj+fQPSN+SU3zJ1Ck3sZdbWBjmHgv3UyCtiE0s0uVX/OaeMo4/9CPoCgF/huPN
	um9FzCpB6701RIAcoNtCvYWQX7Lg+I3cn/NXYI6a31otN3OZP5uvQryE51Y4Mf5/
	00IHANlMxq8XnvUWmPSipIuumnGJaulxCQMWso+Y7QV0gYVFy3T4NPF+c2gCvKED
	CNY1iA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44172xs47h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Jan 2025 00:32:26 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ee9f66cb12so24237237a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jan 2025 16:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736296345; x=1736901145;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Kr58GMuCHF2yomdZqxAr7GwLs9jKgl881I8HQqfF7o=;
        b=tR1cPOjnA3PoQFAoxSQbzgeWR4lSRLKfMpg8K+vLEJEwYKEc6LAtCt2mqVv5iBzLI0
         QYfTAvYD9tH9MImXD2o65m0Lf8beRs9Mcg4WENTrGuz24KuPInPqWuKGAJwqkYn/tXAy
         VKtNcDNbBes4O0Qr6rIgZbedyWlPh0KsMFeKQ7NkGtlBJ/rmNGjAuWm+cImba2dBndi3
         4wJp3auI7VAk6AEYgo/l+E/qilQbKiRyTZGy+te4r4qxiIjx64av0YdeL035ufdrYtdW
         DzaYxzDhE4sxEsgDQrzK/XP7N1pqVNgdHF3zWnuLodPPjr9LktsvAD0ahjzk481ZzhF2
         BR0g==
X-Gm-Message-State: AOJu0YzhBQXhvwfC9z4WMM2Oj4/lVQbzI/2I/Vt65lopXipE4GoM57s9
	AmyBevTk8I8MTUaXjgfSmJw6QCo25aS/ennPPYzkjnQoMmyYWvlb78znba/FFKBpEODVEAiM5cV
	FfNLI+OOg42XRHAErt8wDFu6G/btgFLKYtg+Mx2/oR2qWYrtrTM7HJ7pv5HJhVp3BLtLJk6XcJA
	==
X-Gm-Gg: ASbGnct7tkkeQDkYwND9yDxtH8RXxrMTCGs/+Hg0SZ3WvM2wPxqMw8Iut1EQ7lqxpA7
	vHg8UH6Ocbe1uK3nfSXpIkPoYKheMYSY9Duqgae+8LxCujL9aPefTjwmeb3zDNKF+kBZiUQ3vCb
	EW2QziRukuIFmd//st1YPF0nOw59F0NMwmVZ4mtc2z7ZQE5iwqoWVxp9o3btg25bqz4i3XpyMyG
	TjlxaBnp3HYkbl2xFpWCwHfiCW/k9vNHXPGOU5vCoEuEKQBGtnduScHQGnAm72SlZD2LdGLPXpv
	SloAYPAaYoPY5n3tsQ==
X-Received: by 2002:a05:6a00:3a01:b0:727:3fdc:c653 with SMTP id d2e1a72fcca58-72d21f321c9mr1265618b3a.6.1736296345485;
        Tue, 07 Jan 2025 16:32:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGn3B6PzMNDMugyTRN0xn0ybwwH/dEdElXFmsxOIHGLif031F9OTsMzDHv0gp4R/WFKr0Qp9A==
X-Received: by 2002:a05:6a00:3a01:b0:727:3fdc:c653 with SMTP id d2e1a72fcca58-72d21f321c9mr1265588b3a.6.1736296345055;
        Tue, 07 Jan 2025 16:32:25 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dba83sm34041162b3a.116.2025.01.07.16.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 16:32:24 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20241218-ath12k_mlo_dfs-v1-0-058e783bcfc7@quicinc.com>
References: <20241218-ath12k_mlo_dfs-v1-0-058e783bcfc7@quicinc.com>
Subject: Re: [PATCH 0/3] wifi: ath12k: add MLO DFS support
Message-Id: <173629634423.3079396.13009681696003625791.b4-ty@oss.qualcomm.com>
Date: Tue, 07 Jan 2025 16:32:24 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: 7vu1BsapOxFja8onE2qqwj542S0mwNVj
X-Proofpoint-ORIG-GUID: 7vu1BsapOxFja8onE2qqwj542S0mwNVj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=948 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080002


On Wed, 18 Dec 2024 09:11:31 +0530, Aditya Kumar Singh wrote:
> Patch 1 is fixing naming inconsistency in CAC_RUNNING flag.
> 
> Patch 2 is not directly related to MLO but fixing the CAC handling in
> non-MLO cases as well.
> 
> Patch 3 is adding the MLO DFS support in ath12k.
> 
> [...]

Applied, thanks!

[1/3] wifi: ath12k: rename CAC_RUNNING flag
      commit: d31241cbd9c5d74eb19192e57806e9c9ee3378f7
[2/3] wifi: ath12k: fix CAC running state during virtual interface start
      commit: 11b86e2ce94278332af8da9c0b560a15c17efd26
[3/3] wifi: ath12k: handle radar detection with MLO
      commit: 40562e84e262dcc1c7226a0094761f6b5eec8153

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


