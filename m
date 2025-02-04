Return-Path: <linux-wireless+bounces-18334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6922A2693C
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 02:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E76B3A4453
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 01:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62AE78F46;
	Tue,  4 Feb 2025 01:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="poDe1coW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C6F3595F
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 01:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738631617; cv=none; b=uB8rqw1cq9no6K2Ttqkf2InzpboxulAI4ueWlGjw0l12ojDsMBxOw5shF+g1zBklKrvfXBg1bBFZPL1xGF0rY3p7O75HrCa9yIqoUCfIDHbw28VTh370DCDLfyhOyNpyqZKiIK6034NNDbEau+B56n63iN875RKfJ/Ya2beYxe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738631617; c=relaxed/simple;
	bh=78BVUW0pEfzVIZKPCoOKLn+9CfwQaLAzYGkFG4/bljc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=APurpgxYGN1ZYByKXzgnj8pdHH3Y4wiAilBzefBGHSDuN3deN/hjQW0bRuOdnhTfSNDz10ePGAM0tGOrah/qPoV6Nh/iYRz9M2XTn7Rq9Tgxb+FnRQjcZF97iL4s5jdYXCLHWHs9IRhvKQkbwL53BkMCkMs7rN+X1MukVgbdi+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=poDe1coW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513Ldn7s030926
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 01:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wsLAc0etCe+UgkVAauzS5bGJvK3saA4lvwusQ2VXNig=; b=poDe1coW2ikstMl9
	aQmYr7xtrEJevjTfSu+6kXwIUETqEYMnj76hkVXKKb3zAD+fnb7IuDdfZiDdtL3I
	eQ+oIJtLt41pCPEn7WAnc8zwq2i7vImg8hGDQ/aRgjiNqMA/GqT6L7WgyABp+r4o
	pKC06nbg3/JSFDGLU/1zAtFtyadaJhwC+h/G9gCzXE33uSuJTOukHzoAO9ACQpGM
	8o3+88ZhPjgK66/apRi/TIcnba/sbYv8xz86hIFOyl0X9+gMT36ceStGExkxNyU6
	suuY9Je21CT72bdvG3TPKbihT7HhagIml8pgh3epN/YCqTOJvGPdcvv/iK+jBpC9
	QEGhWw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k5w5rbbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 01:13:35 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21661949f23so164482915ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 17:13:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738631614; x=1739236414;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsLAc0etCe+UgkVAauzS5bGJvK3saA4lvwusQ2VXNig=;
        b=D93xqn+5f+a2/szQpwmGQOfMRf/6LzjEcsKatwNHFHaA5f058Xb4C7qYjhBvcJd8dl
         ujRK5zK402DEGOpefnLE78Jw572+nucjuKB1CiU5zL/MrD5zUnGcw4WDiBzwI7lIIkXo
         au5UdZoYTQmu8/R7c+MnnveuUmn9euzrR9ZOLOHSJIVKyyNNVQMJYo2GX8Nfzn3oRQVv
         MtBfnSOPEabroZRHtEYtxf0sK/QwL+3LVv4089POnW3Rh/J6YspkSA5lTOxJ7/6i8vP6
         lQzKBOAEG+z723Z+qQqofOx6BEYixWq+Hrd5KrfLh8Qx2BaAMF670kdq/9RADkQZ/o9c
         nKNA==
X-Gm-Message-State: AOJu0YwR4ms4h0GH5fNpiHmKrC3l2ZbjNjfvBDBjp6lg0DvC+iqth1Iq
	7T/VyzhUoq+GxMfBiUgTr3npU5sBkJIyPrJM/ezMrZDLeCl2gKe6DCQzpuwEFQuxBma5Gr4ZsjD
	MYz+68mS+zomQlBZ1z+1hdCz2EvrqzKiIy4Rp31D1Zh+iGpr1QF5AeinZXDUgLIZz0Q==
X-Gm-Gg: ASbGncurtgZrp/PixBoQCz30fj4Qo7xsLWhLPVl+o3/+dxWiRTtbRR2q2u/8x1pWVxL
	nYbb7HI0qiSF4kJvc1DpRu5Ctn/l3CLtPIcAOhGhn7LEK+Id3bZc2QKs1OfJDQ0pLSd4C/IkBYb
	QEyZXOtkGn8f7I1yP9i9yNeEaJgW06Zxa4gfLhN4ziGheaD+JUXSp/4eeOCVWWDbFIxBIvoEcA8
	I7AtsMTtzYX+2st7EtuMO8eXbm1Bq8OfjzC6dWwprM02udbT+4MKBMJgUe0+J9OHi1R7jW+aeJM
	hhwieAUWYxPUvhLWdWXJBbiHsi3n3qe9Hc2CaLkv5w==
X-Received: by 2002:a17:902:d48d:b0:216:7cde:523 with SMTP id d9443c01a7336-21dd7dccf72mr402190525ad.32.1738631614219;
        Mon, 03 Feb 2025 17:13:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQhirGSlYsQctVLbVfubQmXtt4uUSoxCVnrBhqmBdMP0kixjUhD8Z+iAqewDNZoH1qC9QHEw==
X-Received: by 2002:a17:902:d48d:b0:216:7cde:523 with SMTP id d9443c01a7336-21dd7dccf72mr402190115ad.32.1738631613687;
        Mon, 03 Feb 2025 17:13:33 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31f8522sm84069685ad.89.2025.02.03.17.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 17:13:33 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250130061104.962124-1-quic_rdevanat@quicinc.com>
References: <20250130061104.962124-1-quic_rdevanat@quicinc.com>
Subject: Re: [PATCH v6 0/2] wifi: ath12k: Support Transmit Power Control
 Stats
Message-Id: <173863161308.4031998.16141695262239737559.b4-ty@oss.qualcomm.com>
Date: Mon, 03 Feb 2025 17:13:33 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: -qVozxjpYcN0nVsUWeMgOiLyZMJ0r1Gj
X-Proofpoint-ORIG-GUID: -qVozxjpYcN0nVsUWeMgOiLyZMJ0r1Gj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_01,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=854 spamscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502040008


On Thu, 30 Jan 2025 11:41:02 +0530, Roopni Devanathan wrote:
> Add support to print Transmit Power Control Stats. Add support for basic
> infrastructure necessary for enabling TPC stats via debugfs. This patch
> series brings support to request stats type from firmware and dump the
> corresponding stats.
> 
> Schema for an ath12k device:
> ath12k
> -- pci-0000:06:00.0
>     -- mac0
>         -- tpc_stats
>         -- tpc_stats_type
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: Add Support to Parse TPC Event from Firmware
      commit: f0c3bb78e42f2f67403b2314486e42f40737b15c
[2/2] wifi: ath12k: Add Support to Calculate and Display TPC Values
      commit: f5c90ff80b4c0326e5fd1feecafd88718075b1b7

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


