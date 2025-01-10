Return-Path: <linux-wireless+bounces-17344-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E737BA09C48
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 21:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F362316B382
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 20:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABA2222587;
	Fri, 10 Jan 2025 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GxP6tFGC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB70207A22
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736540268; cv=none; b=rgdD6PxjCpgtZf+J7qMfshiClXUISpvDTjRnYWD7mvpO5b4pSTrVGHVe4l/U1L2lhnDJtROHwIbu3iMJFK6PIb8zVq+a3lMKjJvyzXRdUGMkoEo2VjzZKZ2IuzRjDwZiItNwiEgvloR9JIJ7xI1ftz/Rj6qW8PsN5aVMNRNg4ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736540268; c=relaxed/simple;
	bh=bj1jBydqggQW5rUJmNMRjpF7KPMQ/1fhcM7xKHzjrU4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YJcCOxE0ntLfy+e/oHzmCsl7uYpEwkZ3MjwFD2RDNuSJ76aKBgmrEXITGHAkaJRT1hgR9fBSTeJM+evhQMY4Oi/7hmAtkU4CPGFUaeQq7D+YGZ/lynv6OxKN8qGqg9iuBkjBUFtCpy4urRFmGjF+lqIm8JvMdkWiByNN3be/vIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GxP6tFGC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50AK8SaW004360
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 20:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LXXAMjGMNexv8TaN0EpUXvOt3eg+aZuPHF5Bxj/TzGs=; b=GxP6tFGCrIxsUZ+p
	cKREn8NQA0xpZkjxCqbC/nwHOQj8GmAh9l54kBQp7KbmbG0qgmadSXJMF/KS7FG+
	ILeQQVEOlgqSJ/5XdfAvulOb5XJJ5p3clJsIvTI7ZIVRzwNsLCZVGp0Wb38hQQdR
	DC+HIH/O0KgKcemxdCJzlfVXkdYEoNxtzIxuGRISINpCNkpkqFhjtgB5T7ZJ29zz
	lvIPXOGoxZDWuAVwCs1YCaNtgomXsV5rkcqkDO93PdgqBGYZVAXjc1zdFdXyjtNg
	4nG2kmrooA7DigBPVY2QCLAcon/dqjnRIWzDbdVhr/lkZTb9UX5bq6+GaTONV6yK
	vXWvkw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 443aah80nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 20:17:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2166855029eso45362165ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 12:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736540264; x=1737145064;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXXAMjGMNexv8TaN0EpUXvOt3eg+aZuPHF5Bxj/TzGs=;
        b=MtMSBb6IQWF+QOlMg7FXHLRXS96CDMr+tJkNsxNG9YNvJdn07wVoZQJe5RlqaRaJGU
         MyCkNHo+47d9mWIAOfoBJa4BIFwdvWR59pkBDWiSwjRmH5xqh+Qs4q1I+IpNok7req6O
         V/rbkFcisGdaGbdspykv1berY+XEYG+ntdOqldKwO5ktQb6INXI0bxiPjlq3kanp6FmO
         ukvP4hw6v2wTDdfs8JvXjZxRYu5/KrimPorlKX4+oXRFJ2TacqIE/VuCWD9KWXCShRnq
         YexJ1vAucHuyMYyZfqq3LPkq4xRPtFNPXDCNpjX7NUMiBvZpIIc8xA1GN6hRkyapBrRR
         4l2w==
X-Gm-Message-State: AOJu0YxD9ZTeGbQ7Dbk/wmvJAnTEm3azsOsmTORUBIqVG+btjK9A8JML
	LbbMxUi7iK9DhaqhpwP5yaJ+9BbkBTJuC7GyVcMTRKoDpMKwtl0oXz5AfmqISIy7laEMG2A4YGS
	NvWA0Z9lbo7HmTzFBUYdmfYAQ0x67mcTLhLWwxMqIdxzcENddU2/F55kryRW0POw5871vtiq8sQ
	==
X-Gm-Gg: ASbGncuOkc1K6gLk3DiouwnpJ7XMOGITllTyiAIc5Hr5yIRWoxTCQJsqde5EOZpxMwE
	qBcyDEDMPC5nFoD5+LDBSj/S/QdsM0kaD1hA/03wK9GnM5HJuW55bv2eVdHLhLEw6W/EPn0WkGk
	OcIWcmOEol4DGhFomTy9usw4dM1mI43f3ZzjYnmNhsFIaOpJjwspGwSs3hS6PpthFFaLjPvkf7J
	913oJ16qDpL1pKdZ0hXEcQaqo+1pvaFbVOb0zoUJ+6J3m4+8Spb+wnZAR6KN4sVrFjJWaBgj5Bt
	Yg4YQKIImXWxUZOyyQ==
X-Received: by 2002:a17:902:ea05:b0:215:a2f2:cfbf with SMTP id d9443c01a7336-21a83f4e503mr149887325ad.18.1736540264035;
        Fri, 10 Jan 2025 12:17:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFusvrmhMaXoMuoC6Tq7x7SOrk1x/7gv2OK3fHfd7R5VV+UxYqlS7/5LIaAbXvsgwb20oOXMQ==
X-Received: by 2002:a17:902:ea05:b0:215:a2f2:cfbf with SMTP id d9443c01a7336-21a83f4e503mr149887135ad.18.1736540263669;
        Fri, 10 Jan 2025 12:17:43 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10f97csm17208985ad.16.2025.01.10.12.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 12:17:43 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20241218035711.2573584-1-quic_rdevanat@quicinc.com>
References: <20241218035711.2573584-1-quic_rdevanat@quicinc.com>
Subject: Re: [PATCH v5 0/2] wifi: ath12k: Support AST and Puncture Stats
Message-Id: <173654026300.2979765.6510975811832948073.b4-ty@oss.qualcomm.com>
Date: Fri, 10 Jan 2025 12:17:43 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: R5vhIFN8g15O7kNHCY7K2-iPYiVQW2CL
X-Proofpoint-ORIG-GUID: R5vhIFN8g15O7kNHCY7K2-iPYiVQW2CL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 mlxlogscore=775 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100156


On Wed, 18 Dec 2024 09:27:09 +0530, Roopni Devanathan wrote:
> Add support to request HTT stats type 41 and 46 from firmware. These
> stats give Address Search Table(AST) entries stats and pdev puncture
> stats, respectively.
> 
> Depends-on:
> [PATCH 0/2] wifi: ath12k: Support Rate and OFDMA Stats
> Link: https://lore.kernel.org/all/20241128110949.3672364-1-quic_rdevanat@quicinc.com/
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: Support AST Entry Stats
      commit: 89699f029cd42ddf913a201c917ce4f7b213b068
[2/2] wifi: ath12k: Support pdev Puncture Stats
      commit: f647dc6512efa88bd1a3dc2444a9d1ea170f4045

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


