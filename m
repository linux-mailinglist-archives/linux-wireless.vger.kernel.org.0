Return-Path: <linux-wireless+bounces-29484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC81ACA2995
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Dec 2025 08:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D14E3007D74
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Dec 2025 07:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A3C13DDAE;
	Thu,  4 Dec 2025 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KyfQzwWJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y9XlXtPD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A9B398F94
	for <linux-wireless@vger.kernel.org>; Thu,  4 Dec 2025 07:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764832275; cv=none; b=umitM2cebEZIEsv/G42ZSuCgcClI1gU7/zfRAGBpbjpGxhyKkWx7JzPdIYvT9/GVzm5mXXQ88Epes2MH3F/zD3npLP+BRiSiSQLyuIsQ0awWw1116SXfE7KjKY8JiuPznHww3RIBTqUf2H3PmuCzm1j5bIkUW6avdROdWi2TQhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764832275; c=relaxed/simple;
	bh=9AtL34vmVVXfglZXMU+/c1p+y/ew1mv/Jhiha+E4LDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XsPMF2M2o666ju17vM1VRzEGWu85g8q4cYy+xngCX5qKkUhi3O74RBMH3V3fDH/JrZQlvwvD5frD9on59xjl8/nQoMs0wt5qYy/O6SbV9v2d4PoLyxT4p7oEjcKmIWCEiXQNvo5RKct2XhCzFkJ5rhdGKf9vEmFQGMur654FrN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KyfQzwWJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y9XlXtPD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B4690a1735086
	for <linux-wireless@vger.kernel.org>; Thu, 4 Dec 2025 07:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=tAWzwoNFynjs6ZIdeP4ZGqOd+Qw3eBHDumm
	p8mDvPSM=; b=KyfQzwWJBLmJJgao2qY7plPo+h2ycK7OnV155g2PnTkApuXDX4x
	Rv0UMShGizTMtOUvassqX/s/6XPOrUw1l3I2wB0KgxLqS+0MAIO6JAFrtAnZet87
	wyHM64om+ji12MWLo0q0iY++GVvtt6nYBzO97CUMgKwkvcKwQMW+nurG+HDF/Uyb
	ik0TR83o1bnMih4kYKT0y+6DD6FgB8SUJNw/64V8ssjsoJkk7PK0zZpBywc5QefO
	gir1AqZFVM+maYeeZ+h07ECVI+V+DR3ShUfsN0jz8rJw7TOkzIDEIz3yO7QDMW7t
	T2nkZs8baVJBJJ/HvyorVKDSXDAzKCH2fAw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4atr7yjckt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 04 Dec 2025 07:11:13 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-bc2a04abc5aso545805a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 03 Dec 2025 23:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764832272; x=1765437072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tAWzwoNFynjs6ZIdeP4ZGqOd+Qw3eBHDummp8mDvPSM=;
        b=Y9XlXtPDq+MlDZ+TLGJ7yahP55TOAmMQkiWJXnhdbyVmTaBvHTGq2nIXtj2RmyV9dc
         AtGgntM7hnz57qMAq+CWEK9g4YvOQQ0cW3sp3x1YcttdM8YXaRiC1O++/m6WnNDkA1Bq
         OrOopL5ylJopLHSsk+NsDt1Sv9U0Dlk8j2uP8X1a40BiIdzJGhlHXkucJEyj8U5FDsuo
         G6SIaL9rLGo1tRvuYLnwJgEcJZQQXao6/mdUhFWpFx5RdSwh0A7F6Bs5WahgLpizHawv
         y4gqzAZgLjcKhB5sssaE899/uhE2nWph5d78D+L99SqBU+0y/kt6zMgtBxFLaJqMHioh
         I3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764832272; x=1765437072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAWzwoNFynjs6ZIdeP4ZGqOd+Qw3eBHDummp8mDvPSM=;
        b=gcXMfgLqZGmaKi+IsyT/v0rTtF2UFjXqi/K00pHoNclkws11eMtn+HjNIflOMBwup7
         9qCkMxE4XT4PuTvbKas76I/jnzN2RKtH3dB5w8F7sx4yXuEDyhtQXH1FkVdKFRbX2GER
         9NjpAhbud95KmRg3e+L1AMMjk0UdUIRqwD7COGLxNOaiVGSlksMWgGPgjLoGqHPp53PF
         zgfgnR5L0bp2y9O+4oc9ar9I25jMuYsflhzShFl+cv6CIsgEkLICE8InEYPli6MLEWHU
         M7ZF+83N/4WMiTZA0AtsztrMHFcIk7UTEbFge/TSa+qzHOMtIQqvK/VtcFJAIJEocgJ8
         USAA==
X-Forwarded-Encrypted: i=1; AJvYcCVFUJ7QM80khJX/ovK8T2P7GeKwjkJb2qjoI4MOARkW6C94OXMiald6likS/+gZ35++Pcs+QHaTPRJXUrGnHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwG8NfsZqw9M5ykCUpzTgFk+FB0CqLMJWtPbCk58yu0O9qEGARk
	xpf/HNoHwOWNuPv7FqPOGY7pooCRuTEbTDQ2/f702xe4G9ze+YYtDBatsLhWkFX5YVnvdlPbzn8
	7O2RYIiKwhstDmxLKiGbEY1AAM5W80CkujOC9NCl62Ca1ohsEQYogw0NbGkkVyyLla+UfSg==
X-Gm-Gg: ASbGncvzPhqdgDAzvmJDlo6iybydwidZcA9iUAosrJLggtwYEg18q7H4EY87dbTaTgb
	wkHlu7u0FVY05/o70kngwD0WIh077bTeR/69R3bWfhHTZAv0Tt57xVh87bYhYzgg9bJqVMTvf7U
	pzSf7ORrzHxxvU3VYylGXkiNwzpm6xqmSiOvqayuafQ2UuBWVZVjVe1C0DW5YE6y672cjA1v3RJ
	+vKji6zHC/Ap/nJgfoIjjg2F/c+BiHhRVS4lzIGsMRk2YbiLziSodvjx6YAj+0FlDBQevnU/psa
	77PE1rJaqdQ5IhOsi2mP/xZYS8lVvhqWUQVfe5iU6S9oeZu7ZO2Zb9t89XcWir7pbs7gdQWXX/Q
	kgWaSssycu0TAdburQ5g+w0z737dMa58BmZxPOB+Kz9oopXIuPSxweQq4nc4PXVH6+aJb
X-Received: by 2002:a05:6a20:7fa4:b0:352:3695:fa64 with SMTP id adf61e73a8af0-36403850666mr2689724637.37.1764832272285;
        Wed, 03 Dec 2025 23:11:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcoa4Jtg3mddnN5jfDiKJ9CJcD4fXyOQnrRyi7YanaIakW991CCSZnTycONaT4fOv7BPJumA==
X-Received: by 2002:a05:6a20:7fa4:b0:352:3695:fa64 with SMTP id adf61e73a8af0-36403850666mr2689696637.37.1764832271748;
        Wed, 03 Dec 2025 23:11:11 -0800 (PST)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29f2ed331sm1117470b3a.4.2025.12.03.23.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 23:11:11 -0800 (PST)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org, johannes@sipsolutions.net, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-current 0/2] wifi: ath11k: add usecase firmware handling based on device compatible
Date: Thu,  4 Dec 2025 15:10:58 +0800
Message-Id: <20251204071100.970518-1-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pbdYN5EaHIuX15eq3GWfYWLQ6ljKa3Sp
X-Proofpoint-GUID: pbdYN5EaHIuX15eq3GWfYWLQ6ljKa3Sp
X-Authority-Analysis: v=2.4 cv=ZMTaWH7b c=1 sm=1 tr=0 ts=69313411 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P9V9TY2Fav2aVMZ0As8A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDA1NyBTYWx0ZWRfX33ZoKH9HnZnw
 8I6BQXMpFh9ueI1HlYnu7MJr3Y12jGhwIn7sDqMYwLsWIZpywg7F+5ILNqccOLFnwCyUA42OGVx
 4N5A5R8YH6cilq+tpXvYKxai0JxygzUL7V71gBMNDMmONkjiEHcgZB0uh5aBVMQ8UUUmPAHuoga
 gRa/F12J7RdYrobZ6Q1H/jJf8QQr+g9pSHwMULIPmouWKiBJuw3Ah8cU8Qd6bWla3mbRF1h3RyV
 5nDHu4ygcUA7rY1dWscQWiq7nLqXeJB30v5RsbeunlrlO8cXweVH5O7ebZADj8R/qFDDv4O1CzJ
 KZ7Vmvfs/N1w+NwdLjqE207oNVyajf+zXp+5OCK6JeBBegRqGjVO7hkgA0gQBzC8hZpaiGWpIxc
 YpmM46myd72mj0hyXM6aaD9HqUx3pQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512040057

The 'firmware-name' property was introduced to allow end-users and
integrators to select use-case-specific firmware for the WCN6855.
But for M.2 WLAN chips, there is no suitable DTS node to specify
the 'firmware-name' property. In addition, assigning firmware for
the M.2 PCIe interface causes chips that do not use use-case-specific
firmware to fail. Therefore, abandoning the approach of specifying
firmware in DTS. As an alternative, propose a static lookup table
mapping device compatible to firmware names.

Miaoqing Pan (2):
  wifi: ath11k: add usecase firmware handling based on device compatible
  dt-bindings: net: wireless: ath11k-pci: deprecate 'firmware-name'
    property

 .../net/wireless/qcom,ath11k-pci.yaml         |  1 +
 drivers/net/wireless/ath/ath11k/core.c        | 37 ++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/core.h        |  7 ++--
 3 files changed, 40 insertions(+), 5 deletions(-)


base-commit: d0309c054362a235077327b46f727bc48878a3bc
-- 
2.34.1


