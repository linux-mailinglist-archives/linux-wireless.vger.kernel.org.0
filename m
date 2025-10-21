Return-Path: <linux-wireless+bounces-28134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56634BF600A
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 13:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C6519A1212
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 11:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34572F5A1D;
	Tue, 21 Oct 2025 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YtZQ/DOx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548DA2F5A05
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045757; cv=none; b=bjcCZRTJuq9ncYJFgI3MiFwB9VguwtuPdiJTadKaZhv5sUgJIwpOpctnBngDdVW0NeUGMZQmj+LvgP+hrwgFbrNecxmXwhCr+BHfjXMMlO7PKu6L52Dfd/i8tqe4fLsbrdIWr3bOysjcuhQj4Z13LHYM2YF9x1VAca8OufQ7a0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045757; c=relaxed/simple;
	bh=+VvHDkXIf8SuGCYrcG1Vih56498sBzu8X9TeQ27wvmE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tmmCJ97tcye6s2C/tpLp0oYE0eV/uHGBsJ7ea5IdXLUk1QgUkOtVriUBC/JrCkmiDAvTfb3rW0llYYZ8Velihm2MCh8x6XDbEKeVXQL6PgnwV419lEnMLikYghLT9bUMbeMIlgAZue2IBqDFnuPNmsXHROrthKCFBbYsa7CW8kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YtZQ/DOx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8PMds026906
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 11:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=r7ZO70HMHOWnnxq6ajsx8ZJ9zshp147NM8I
	le3iuuIQ=; b=YtZQ/DOxnVcJ6JQKMqEoMkAl/NrClushLvHEXff6g1zyI9L8zfW
	wvyFywAiXyerZ5XGwaTdzpbQJQKPUvC+7PvuJ2auQtwDQTJJKfKEpjo1APzimJgj
	x7EQZwz4QlMnUFhE28J89a0htRK22avmXnFLQpdkgMau6vA9wFNgwFy2ZkBZuCFe
	dBGp22Bfs0Kk3GyIECMtcIUB8ZUN9jDFT0ZTttgpNPy7F+gyhq7B8PU1wRrEXdI6
	nrsoaEPs9QkET9HXf6z2Der8FkkCKNttzpiP3XXon+CwBxI24PVowZRsx/acf+WO
	6P8PYiQG5gf8C1EdNRuFlIjHI7C61UNiU/g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pgqjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 11:22:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-290bd7c835dso52202335ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 04:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761045753; x=1761650553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7ZO70HMHOWnnxq6ajsx8ZJ9zshp147NM8Ile3iuuIQ=;
        b=i5Wj7NXJKMnEj53aTYUN42Qxmw7LU2hcd8UjAYtQA2gLalpZG9lkwXu5IiPbqj+Ej5
         xaPkADHTANi6L/q1TiUSwgNzZDe9UDClbpspLFxhl49tP+x/4kuRoFiNI7gmJMZqsQaE
         uPaVoPrSkNDylrwnLj9lV5PxwcjL+DFTmnDL9v3UfolKxpSxbUDz+HM8/ZsNFmcRBrvE
         chGuQDWuRXHVsMi8PNICNxk9ire8ofKTTPp9n0OhF5yxYP64gQFr/Dzc2yqdtWvDWwK4
         ZkGd0E0c06oGAGMG0z10pPIoVAip2UO8Iw9ur1yHJQl6okj1njo55mfmYZ0SFDSQ03Ap
         ikeA==
X-Gm-Message-State: AOJu0Yw6RzuYM4S8GE8pFCDMIq96WJ6dtPO6zUdcaJVWaNm2Pig1X+2t
	KlztC+yIXmT0CFJQFLFiLwinP7IGYVasRiQwDcGXLSTieDiEMhGIutbDOhri+RQpAzYgJp8LU46
	m/c+jpbJaFc4M71cdGeK/mtWUsn5Xj7UtIr3Raxnh5lUN6dNRXxqFPrKR5gMkWZG5RdIWKORawW
	GiVA==
X-Gm-Gg: ASbGncvb2brDi6/ru8XrX2T3tCfl2JN/4I6bZoAwljEEj0CvHskIo0TUZ3L/jZOIFvd
	AJC4F4L0+aD6Hql3NBVJ0EFSTqbty/xH2Jb7Lb0cMWekPyVSmnm9falUlKyKd2RmEXNExTBF8//
	avz3BCVjAXlznnx0h2ZZQpET1pyUEwoAX63FdTTIsIrz7lWRf5O3Q8UZJ9JMh+spIhZMmHL5+k0
	lGs6yz1oI0y9o2daOw0b50qJk04xX1Fggth9iM6veAkLb6V+KISVdRV8qGPpVZMi7S/YBoeDM/F
	44d+VKoa/ur7M0MvgQ9+lrBq5O8KSyb3sgO+YcM0/WxZ1QTZPXhZeq2G73HyLRJd74lavgaUegn
	U5iHt/Ye55MyOQFJZsJd8QYQtGrIGz2nqWYaGtXU5egNu2RuwaT6Omfe0NQ9czGeh2z49kI1XRA
	C2kahbAHVSg9kmTwek/O70
X-Received: by 2002:a17:902:ce0e:b0:266:7871:37dc with SMTP id d9443c01a7336-290ca1216abmr233600505ad.36.1761045753435;
        Tue, 21 Oct 2025 04:22:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHi+oQttV3TYHZaN0FeSIPPyIr+nQMgp1Zb8WomxjhTRaua0soPu8uVi14kW8IsqrQOyrQpQ==
X-Received: by 2002:a17:902:ce0e:b0:266:7871:37dc with SMTP id d9443c01a7336-290ca1216abmr233600225ad.36.1761045752964;
        Tue, 21 Oct 2025 04:22:32 -0700 (PDT)
Received: from hu-sarishar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fcc795sm106782015ad.30.2025.10.21.04.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 04:22:32 -0700 (PDT)
From: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Sarika Sharma <sarika.sharma@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Assert base_lock is held before allocating REO update element
Date: Tue, 21 Oct 2025 16:52:04 +0530
Message-Id: <20251021112204.323242-1-sarika.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfXwIH8P8wZi0uQ
 kgmUo6ByY9euKeF4Xk2jsFcV1H4yn8DlQ4qKpKQ3vOEUsIchqbLwmMvgumshSNRtDgpp1xpnDVi
 wguXQ3v4ZqPrF7BY7QMcOseYHeFNiAnYjzCkOiSgvp0O6ybvS92lpvSkqgn4EzlW7GAzKc4VRhf
 4pPENWNukDDD1UEdPvX5ky5jJC4BNF01dQ2OExCTPCvgj4M3OO55Svg3gNZo06KdJ8V+h7qV74J
 +lP+yqbTtX0YDOhon2UzYzXwKTZlrJUO0SVGcvRBq+j/VIksEWvkWNehW9PWF4rxSOm8zPC7SAX
 /Oqs1Zfi6alLrZmm1nSW7gLszxrujf6rPApf/C6BXjfWMDAIapYjJJlCgJQniWvkvzSU+uWoAge
 US7VE361eapqTfKu/6xCBrd40ksOKA==
X-Proofpoint-GUID: p0dvmqPgqicetN3NBKfdfKC_j3-LDg6K
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f76cfb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=yAyZDWbmfds-XO8zeWMA:9 a=zZCYzV9kfG8A:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: p0dvmqPgqicetN3NBKfdfKC_j3-LDg6K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

Add a lockdep assertion to verify that ab->base_lock is held prior to
allocating a REO update element in ath12k_dp_prepare_reo_update_elem().
This helps detect potential concurrency issues during development and
improves code robustness.
Compiled tested only.

Signed-off-by: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 6c9f0839c83a..d28d8ffec0f8 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1089,6 +1089,8 @@ static int ath12k_dp_prepare_reo_update_elem(struct ath12k_dp *dp,
 {
 	struct dp_reo_update_rx_queue_elem *elem;
 
+	lockdep_assert_held(&dp->ab->base_lock);
+
 	elem = kzalloc(sizeof(*elem), GFP_ATOMIC);
 	if (!elem)
 		return -ENOMEM;

base-commit: 2b306fc6b1d00dfe85b3b80eb257256e2b5ba610
-- 
2.34.1


