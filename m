Return-Path: <linux-wireless+bounces-28430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19080C231F3
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 04:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5F43AAC4A
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 03:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46676223DE9;
	Fri, 31 Oct 2025 03:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J/zyMo1u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XpMquuVa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2A62F29
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 03:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761880077; cv=none; b=fPhZ8qTiTfc1SId3E+Nmyw6+qqCt7hhk/2ZhVrag6Kq8emcufhLtfGXJxSf5wYFyaWavAFV6kS+OSx3O06I6FnuNeiSHvOuXGAP7ROCa9wjj6OORbd2+RXx6NaVh2OwwnkbwANAGS1/JXwAdPG3j+tsmaMJ0cdqqoNEUVq83BVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761880077; c=relaxed/simple;
	bh=AlQFOeG6qBp/IZa1XIlT/ZwDrJ18EDxlCLELqD9fKqY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LExHE/J7kpLapq2OeCShrxc/vIW+Yfd3DHo/v5bezE/b4LALIHdSETYZqEmNLOB8F6wVDrTK43yL8caIB28uKZHIaIv23rkYjSNuTROHrvB4gmTg/TVlvepbt6l0jbPkyFCsXKlVn3W91Yy8YW1bLpaeOXlbGeWVp6EETlpIaBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J/zyMo1u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XpMquuVa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UKsQCc832852
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 03:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=BmH3pcPhOTTTOYQXQB1oim
	v6NytBEUq6qCdsRdB4HKA=; b=J/zyMo1unph/Wwd2N6m7bRTl6951Q1rt+ZT7Jf
	bPe9dA3bA1DmPLC283aYNcbjD8x5TbWTpMJuxsPuAJlLUbiGxu96/jwJVXpgQmQg
	opCHG7sErTbtF+3Azws5fgBrFbIn339VlyYn4xhHDnbNyfbj1Shx/ImmZmBh40hp
	ElhN/SPkRybBYkuWSGqgoZauH4xbIhhvQYEBs72VEp8G1Z8VgjZ0wdOxb4P5JujY
	52wtrETefORmBzuQOZ9Tja5nWwNt8aUQeebPrAmX10zVzImdIuMFq6xjSD9ukAF/
	CrCqCneIJccznH7IxkCaW2r+d+PGYTgM+0WcmtIU9G3/q1RQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ffb0rpr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 03:07:55 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a267606fe8so1530015b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 20:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761880074; x=1762484874; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BmH3pcPhOTTTOYQXQB1oimv6NytBEUq6qCdsRdB4HKA=;
        b=XpMquuVaKdM6p5mYy6GWbsZ60CwlZCreT2H/50EqzhlEU1zWq6ee1UL/Exf0JosAYs
         /NZ/Xm6GcCv7c4dO9GxRc/f/FVLBNjCgAw7QSFw5p/UAaODLsCorcwOnPBVo+m/xnxB8
         rzHTd4ME85SiR0vRB+EAFcCi2Wb9oaX5b1w5RjrJVbBUuSXLq2pcZefkbYb4QXyZsJ/m
         x71ZTxqD7uMlY0nE+Kh4Vx6PFdEX09hz/XwsRIs+K9PbL1F+mlkSyq1zQNzoq9Vs7/UU
         GsJKl0Dadi2JmIghoqZXTCdJ0edSbwKsZUGszBGiTWYankOVho8fQAzd28KDIlvScjrO
         iCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761880074; x=1762484874;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BmH3pcPhOTTTOYQXQB1oimv6NytBEUq6qCdsRdB4HKA=;
        b=Ml+VOWdTw4JFduALL9XK68komaObD72ixDGO+Wi0WZNxiNMAwFEFQVNJqMJLIvmkyY
         IWKuFr10vFnfMDL7KvjM/gAGGCDAjmixkBxU3FjSYjs1DXZXOm7V4j+p0+FaB01+l1aK
         sdV840OnqNBDzJhClG2ltuMQ/28DUHYhfeiHEEHdFy64Aag699BiGtj3d0mEy/dJr31a
         i/dEv3EmogCbmhJzdBYuyxdD+FFuD8FSJZcadF4uVjKitYG0eVuAa7thxKCu/Q6uKfp8
         JvtTFyc9BgRTb57lu5NPEz1rAh0h6WyvAEmxOmCjk6P/1uOeu7RUtEwxU52OV5/8Omlo
         wW1A==
X-Gm-Message-State: AOJu0YxcnqJVGsT5tYBl4j/w1Y19tSoQbMKwGfzAn2pK7BjF9w9cShk0
	zqiJOuUHODzZktAZCNET51Gu8t/MEnIS8UrcGpa3Q19S09bliUqcqKvQSAvzF42SCg8I1UvpiXp
	+8iET+srtjm/LN4VcXsbYW8ZAsztRFvI4trX7jllStBkKqo+e08en8Lp2jI1FMNUjUMahJRxDf0
	dnHw==
X-Gm-Gg: ASbGncu6geSxjdnBjpT7OLMCUeSx8w2ZO/XmNUofg4M/Ljtt6BzmPPD1Ywa3WGGIx6u
	iCuI4sjovMZXUJ1GhXXGkOEWtGb1BD54/V6IzpufZVrtVBGfry7XWJMsgeUwnvHq5Tuga9gELQW
	xh6KWpV2pQEUGKfyVC5/q+prlA7NgdpYOeToe9QnR8GYv3VoYn1LyaXmBm0oDiVpd3wbtj7u2MJ
	qnCYGY+Gkw3Fl/BNbdeD9ZbxaGlJLaH526dTVAW9FjCLRjPmo/27DRXhInkL9aaKV+ergSj9N+x
	rNluRV2edy+OjT6ex8FoV3q8rhK6v5hGTb03hfyvdPfWjSuvDa8gWooHUKLtD29n8X3ZqWYaIxi
	0vn19uCJnKZvJ+tAyG6cXWWT/PHq9v2xUgdFLHh+OWirVxiIvZsItN7lGE+gvWG+MPw6h96Auu4
	HmEw9Kt+2R2j5pqNXzQuTfIv4KL8hF3so=
X-Received: by 2002:a05:6a00:17a8:b0:781:1e91:fd8c with SMTP id d2e1a72fcca58-7a77737e223mr2284015b3a.11.1761880074066;
        Thu, 30 Oct 2025 20:07:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWPTnPWh4mvc6Vms1nEPRjN5fCn5IDjmyLcVDgLCd1AVmOMfCBwxjB8u0zA4cxnZWTwkrPWA==
X-Received: by 2002:a05:6a00:17a8:b0:781:1e91:fd8c with SMTP id d2e1a72fcca58-7a77737e223mr2283972b3a.11.1761880073515;
        Thu, 30 Oct 2025 20:07:53 -0700 (PDT)
Received: from hu-mdharane-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db0a2663sm372130b3a.48.2025.10.30.20.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 20:07:52 -0700 (PDT)
From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Subject: [PATCH ath-next 0/2] wifi: ath12k: Address issues during beacon
 stats retrieval
Date: Fri, 31 Oct 2025 08:37:44 +0530
Message-Id: <20251031-beacon_stats-v1-0-f52fce7b03ac@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAoBGkC/22NywqDMBREf0XuupEYH5Gu+h9FSozXeqEmNUmDR
 fLvDa67GTgMc+YAj47Qw7U4wGEkT9ZkqC4F6EWZJzKaMoPgoq24kGxEpa15+KCCZ63qG121TS1
 xgjx5O5xpP3V3UGFhBvcAQ24W8sG67/kT5dn/V0bJOJt6HMVcd2PH69sWqNw+6qXtupY5YEgp/
 QBjXbnKuQAAAA==
X-Change-ID: 20251027-beacon_stats-5a84c15437ed
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Proofpoint-GUID: SAE_0VUihY6Kh3-X1ixVodlDbLGBzxP2
X-Authority-Analysis: v=2.4 cv=fpjRpV4f c=1 sm=1 tr=0 ts=6904280b cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Oz2bAxMnwZ808XUxOPQA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: SAE_0VUihY6Kh3-X1ixVodlDbLGBzxP2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDAyNiBTYWx0ZWRfX4R3IXdTzuTVU
 WUEpLEvjI2uYLr3wok9JsbzeMRR6UC49xF67gJyld34q8rTe6oaw8UoN7A2CuVwW0YqMCbAfoqU
 KhZl3tBBGmCBbxnUR+3vYTMTF2wGz704fnF7JI3S3xBXNIJlswFp9i8vJC+HWSMRbBXyzoeKHgQ
 C0vJVJObpDbaS7wnHRNE4uWa3cHSY1rv4K4ncd6MeF9qrZJ5tToKDLBi9GkHm9ID586idwKtiFA
 VOlold/WB0X23BgZX9UycdquO/TuRu1Bf4UUtX8fv07/hV/YGtdN1tER39yXg60MEqIylyKKp/A
 OcMOX5zgNhVkemp/mjVAxHu8xS0dbWOr/fsfC2/NQLfH0s7f3j57imGrgDIxykhGGQx6XaXfJBr
 Of+GqCE9lCBI4Cr+CxBekA2UVieu4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310026

Currently, retrieving beacon stats is getting failed with timed out error
when multiple BSSes are enabled. This patch series tries to address the
mentioned issue by the following,

#1: Reset the firmware stats only after retrieving the complete stats
 #2: Remove the wait timeout to get stats for all enabled BSSes during
 beacon stats retrieval.

---
Manish Dharanenthiran (2):
      wifi: ath12k: Make firmware stats reset caller-driven
      wifi: ath12k: Fix timeout error during beacon stats retrieval

 drivers/net/wireless/ath/ath12k/core.c    |  2 --
 drivers/net/wireless/ath/ath12k/core.h    |  1 -
 drivers/net/wireless/ath/ath12k/debugfs.c |  9 +++------
 drivers/net/wireless/ath/ath12k/mac.c     | 15 ++++++++++-----
 drivers/net/wireless/ath/ath12k/wmi.c     | 12 +-----------
 5 files changed, 14 insertions(+), 25 deletions(-)
---
base-commit: 197498315de711140bcc4722fdeb7c1761777100
change-id: 20251027-beacon_stats-5a84c15437ed


