Return-Path: <linux-wireless+bounces-28406-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF099C2023B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 14:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2B1461C09
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 13:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39032FFF9B;
	Thu, 30 Oct 2025 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cE7pe2jp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FENLG4sR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7D2620DE
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829230; cv=none; b=b1gfiu/sTdSvinM1eisWK9tkd/J9F7Fa2P00JLwOBHGqy+uZhRzc+96FUCuTSB2ru2AKllZN1SoBn6cGhVUQkFAOfbhFzbzu1+pKV153uX1pIyvhhmjWHysGjm/KwWRo+/OAQXgW569BfqT+CdhekW4DKK7uap/zSXa8zDyc3xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829230; c=relaxed/simple;
	bh=Uom8V/YfuN/7Nw8amHiJnoa2AsDN4tgm566EKh85FUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OTLHR5bVT2dQoK3lP7RVp4sPhENCpbpRQConFiLpkmSFUj+ZP7y1xf6xxMklt1HDdr1gaaaHE9lP3N1CuRN34ZsTlO7E+2U3WtikjTIXXdHBgo1WAdcdN5FJyJGfVpEGyPD9F1t7b2wAjhCs6nYIM/vgJ8Q53bwRBjezY4ZNMyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cE7pe2jp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FENLG4sR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U9PEUf3508948
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 13:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=hB4YVQpNrgVLXtIFDYO2m3A6urjOI3oWMSt
	1zsIO0ko=; b=cE7pe2jpFUXafII/UxYCBRZ6JrjSRcQiAbPJefiRgvkAyZLPglT
	n2sWaOlxclAvSPLZsuxDqdnGKmgM4VATern9TmdcfM0FFgCf/XRKy8uR+uGFwMw5
	BBUyY5DgMS8NJQt3FbBJn8pj1ZvmdKPfac5Oj7q/K+CKYU9XVt6wZ2Afd5IIeAwk
	3HwHwWyqXPr4TCHTmT2X61bs0FqhUnj+TWsuHBKySqy94JwW2C7PwLkAGmg4uNDo
	lSRn1TBdgS+fhVbOoQnhyd3IGyeEWd6+RFGCWYLspqw2QUrFprUf1mD9jpvG6nns
	sH5Cq0niP3ElV6wfO1YTCmb5xdEUAGdEIwQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45cdgk10-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 13:00:28 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a264d65dbeso882825b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 06:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761829228; x=1762434028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hB4YVQpNrgVLXtIFDYO2m3A6urjOI3oWMSt1zsIO0ko=;
        b=FENLG4sRlFgmd5YPCAIMLigdXKKP/lk2FMcI78rW76pfkFnTiqTrtzNALbfWuBsAE9
         9vf796/cgHVt8AAI/H2Kw39+mVftS6w0QgaCVCzqReArmL5i037iev5liisETaPR1WgS
         de1fy6c5QAiisobUNZvaSfnE64sfaiteuwB+wBHa6edgMtzhIzJFq7N4tj2k5U8Vy6at
         DSnbWmBRtlwVZP8lmbU4pMCZrLlSbit1dVN9X84tkDJnlCJd7vXoDOur1RR7OHuOE+qB
         sfttFE4sFEljYwjXwkGsKSWVDZgvtcDq64NX7EWpiZ6aSXzxtorjiG9hXTHYl/4MBZb7
         ezcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761829228; x=1762434028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hB4YVQpNrgVLXtIFDYO2m3A6urjOI3oWMSt1zsIO0ko=;
        b=hBOoq7tTRqg2YUd7DUzmNHhs+Mk5pi6887YyYm+FBSQPns8Br92UrXWLIlpe/gTjFi
         VthMvDIfV8gLURZoKSTH4zHKchPK4iA+GHh+B76+Uv5wHC8qQ/UKErmwCwTaRVT7UULb
         Pud5GSudGx3wLf2HQBAUnH4xpvWwZHaP3uiQLyJjKpVrYxDocl4wExwosvMP2ayQCjJv
         HygzX1ICtwPSSVr+jkX7+jBwyEC4lo82F5XSM8yeNhFmfaxXTRIiozeNKvP6hkfkhmcY
         DtCUDa9+OTP349aJsi67exgzyq9Vi3uTo4vo1Du7jnEEwcg0jGbnsLQfuGgcYTVXkhEm
         jcFw==
X-Forwarded-Encrypted: i=1; AJvYcCXVhlMkRDa/EYT5eNSt8pYgt+hnldgnoRFsMGzJH4B1uBVkNhjyiAqEN/sQldrdgb1CSxDMF+HVTj7QCZvJ7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPp46fMJLIlbK5IujaOn8u/N101l7SAUAKS0hm0uLY5oq7Xsjf
	Nlpsr3E7MT9S5ZSzWNEMY4ug8vkJI7jYxbAnQRmiYIpxOQ1+ZOJE5PFf9H/Y5HKqSowzC5XGzUf
	fh6kJbME7bNao68XfpiBWj7KtfuQgl6iW8fp+qesRfCxKIlahw+p3VSBAJgeO69oXC49niQ==
X-Gm-Gg: ASbGnctnizGVR9G1Sr7owoppUiGBL7bij3WZvWw10SFumvUG+SREKcTx9oKNeGLblIc
	nDKxlcdkn4QgyatJCy/wYX72ieaF8yCaFubK4KciH+zibDYG2C6jJA7t8/SIpDV0dOvWoGkLP8i
	qLGU/gNR2vsZxM1jJuvU8vq4QY9wyoLU5ngSz9qwTPnJjbJEH5wR9K1Od4PdUvpwPYxjrtjbkSc
	hOr9uSVqOZq3oipFM+bftlLfwqoIvdVHb917vZiyNR1dH7g/2lfD6XWM7VXWyhx0XH6QiUlVjbx
	ZmGTbjLWOyA5Cr4nwMVTcSgaUO1Mn/aYkd++URp0GuZufXE5trCdDwhoxrsW99AVhF9E14xrrLY
	LUJGcjRvS5BdEzXpLP4AI6SW55ZPYWJBpO4SPRt0h27Q7C1PIj1MmsBj4+zc5lhDrXg==
X-Received: by 2002:a05:6a00:2d14:b0:76e:885a:c332 with SMTP id d2e1a72fcca58-7a4e59d272bmr8952748b3a.32.1761829227505;
        Thu, 30 Oct 2025 06:00:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7jPHh0c1uibK0ShPcz0qwGkhJCFIROjLJpHtxaloxQisZrlsEnpM36w+1oNBnie8yyuXrCg==
X-Received: by 2002:a05:6a00:2d14:b0:76e:885a:c332 with SMTP id d2e1a72fcca58-7a4e59d272bmr8952656b3a.32.1761829226853;
        Thu, 30 Oct 2025 06:00:26 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414068addsm19078757b3a.44.2025.10.30.06.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 06:00:26 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
Subject: [PATCH 0/2] wifi: ath10k: clean up structure initialization
Date: Thu, 30 Oct 2025 21:00:21 +0800
Message-ID: <20251030130023.1836808-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GdmXrjFwoaexN8LdZv1OxT9D9MFMQamj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEwNSBTYWx0ZWRfXw/CKGqXYnyJS
 +nDM6NoXkXYSrrnmIymFSBWkznYSr8Q6E/igSSgxbIBMamn1qJPs0glToU8v/BCG4M34IsPNeGj
 mruzsQycFdgrnx/9E5NxqZWT3iX04ogp9kfBqWBgRbz5xNUFAK7v1ki+fJwlCl8Ki0f5E/YAq/u
 3rysuQ3kisB1JHf0wsd4PC1U3mhnk2RFlK8Rx7eE1kOsMIu0Ad2idGLoYgwS7deD1crmu7sEwqA
 RU/1uV78LJgb9m0GoeSZVKzgG0wGo1NCUiIb1EJIzE6QuW3PbUpkME4NLnCnqqsNML8L1iReZY1
 h4qlR5CaYIF4MkAvgXBLhETYvw1zUmpdkW9dBiFqJp23735UjZx0yYxbTlWGyPa1YC5QauqCSp0
 NpM8VvszBnru/Nf12tVQUmJHKXNKEg==
X-Proofpoint-ORIG-GUID: GdmXrjFwoaexN8LdZv1OxT9D9MFMQamj
X-Authority-Analysis: v=2.4 cv=ItUTsb/g c=1 sm=1 tr=0 ts=6903616c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=j7ZLb4g6lzcXWYqKbDQA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300105

This patchset simplifies structure initialization in ath10k by replacing
explicit memset() calls with zero initializers (`= {}`) for local
variables.

Patch 1 updates the initialization of `pm_qos_request` in
ath10k_download_fw().

Patch 2 updates the initialization of `bmi_target_info` in
ath10k_core_probe_fw().

These changes improve code clarity and efficiency by avoiding unnecessary
runtime memset calls.

Zhongqiu Han (2):
  wifi: ath10k: use = {} to initialize pm_qos_request instead of memset
  wifi: ath10k: use = {} to initialize bmi_target_info instead of memset

 drivers/net/wireless/ath/ath10k/core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

-- 
2.43.0


