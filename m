Return-Path: <linux-wireless+bounces-30952-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1879ED3A6EC
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 12:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6042F3002D1A
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 11:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA42C31282D;
	Mon, 19 Jan 2026 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuVXEnM0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C79312835
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768822402; cv=none; b=mqF2sRTwc4AAs1C+lZzZYWQBZ2XAlDKqVnmnuOwjAhHOB1sZccZOgY2p63T/ohlEe9aSEuL4ZaxQC7Tj5V0+krh3pWQFaHBqvGyqUXp/RdW1mk436eQkFwqK+UXfPQ6JiQt/wScQg2B73zH/arkZ9n5BqLL1LqdtMBviGvb4YtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768822402; c=relaxed/simple;
	bh=cDjyrzQ56DNaRE9lAeVPM5w/qTBydYWAO5nNwoznZn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uy/ThyL7o2g+mf+RlTW1stmk7NwCnjYXX/YIV4jeQ94RBLxg0xGbpebuMmCLBKcCeyHNvktSy9O8cl0YB+asdDFSiDx5bpibHpWdi7Vp4KZEgeHNTpWR8kbOFqa3LFuDhGhIl4rY6CQGhrtQ3oltxhudE/+Ps3Tq31xiZqO/nLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuVXEnM0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b86f81d8051so694614066b.1
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 03:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768822400; x=1769427200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jwBK6AZaPzGdovVFSWV9sDTCdheN7IXtWZT7jcQOxKQ=;
        b=QuVXEnM0FfpDuRMhSiJujTNDLVTeI+pP7nNhtWM61BFE0rnzf7/Tld6y8Y0Le8zlbi
         aF/4DrQu7qKBMmTAhN/+pDIkKuFrKn0YsCh4GPv5knR+00nBsEz1PYMvM89DcTmI+oln
         xwH4mG+M+fBo73mk8VMhTApYjDA0HttyEHAbR2KX4sOPRZuqQGUBO+HGIe1oS6OD77lC
         AjBsTqc3hGHAD3NRU77t1gP6itNOc2x352dlnLYQOUM3cuDgbQM7a7S3bXB/wpxVFJHe
         AiPvT6jhK0miMKW3Gzsv+6qXyPcnigtEp2W4CDOMSn4Y/mIe4mHK1XIbuAlg02/cnu+a
         5j3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768822400; x=1769427200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwBK6AZaPzGdovVFSWV9sDTCdheN7IXtWZT7jcQOxKQ=;
        b=ijRLF5nZ6elK2BcE07u/avPDNy2sM4Vm01lYAeSJkP09FqyWfz55JIrp43t3zroDMe
         QVeL8y/hnuw0+GGo9Dqiu60bWRBr8qUqZ0aOeC9Hj+FHuPap8rT0tqQ/MnLRVjjX9yQI
         XdjR9gDOT/SDEZWUrVQpX/rX1Za950USG31N5aRo3sww//eqKRVaqbEUdjz2lZIUIauD
         fUnGXIlkDSAlmf1NdHuCHvyXNx5pmibn3452JQNIm0WMun2mIebPk8F/ZlmQkBB4l9ts
         lHTMfK8q6Wt2HciRN/BtUU46qPgatl07Tw5SESyA4xTAENYe235o8nJ6FssY1eFwUjQM
         2jxw==
X-Forwarded-Encrypted: i=1; AJvYcCVm4A1ZNWyonT6bEAdTLvp8MzTWDwJ7EcjXpAvDizQbko6vsAAdaZGAyB3ANpT812K9l4+JbRby0KkWmu62QQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5HLVSCpQjqAYew9MK9YCPEIfbNg2rtI1C9l+cBjU/SExZfK9I
	/3b6IhTv1jvX63IKX922hnN7+7ykQh9k6nLUfBXn1++SFWGI+JP8czw=
X-Gm-Gg: AY/fxX5wyWNf4g9lOqpDJWxN2Mz4x7NtgHxcfKWsNGBy37o5u1ikNVkHyQK6tf4kLsI
	4yJcQuicd1pSLKnY04E5BTazje9hD8wDJ4EyaYof/jORRQwhMcglx0ZmXPUWfgNMfGzeG/YMxkT
	PjjqGwnJDTEITGs4dvB5Pg+NHhfKbIzFglwINxIlV51ErNxJQVzymodNvXLxqQL8k44sP/UgT2s
	0Xbu9q6uEy8RtC0fYACoYs8cSAMzYmvUF2uZ50dKc0uM6+DNVarnuj4GogoNO92/TIyyqc2htrN
	iKAPqX/VI73EbFLp4Xm+p3WEUSBZ6Lmico9G3S6W2ihwuCm+C0IkRwEw5wU5C5kYuV/3PekjaxS
	AJIGm+7FR2z9jjMjPLdUNP/HaAY1hZzAPqeN3s9BJN6MtSVN6h8/uk7s9sajGgNEJUCm+53ZML8
	iKUhl4JqDhO7/5kBtQIwo7o3JFKToBGfP7ljqtLA==
X-Received: by 2002:a17:907:2da7:b0:b79:eba9:83b4 with SMTP id a640c23a62f3a-b87938586efmr1148569066b.6.1768822399465;
        Mon, 19 Jan 2026 03:33:19 -0800 (PST)
Received: from cachyos-x8664 (public-gprs367335.centertel.pl. [37.47.66.40])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b8795168e6asm1141447466b.22.2026.01.19.03.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:33:18 -0800 (PST)
From: testuser7 <frut3k7@gmail.com>
To: 
Cc: Gautham Kumar Senthilkumaran <gauthamk@qti.qualcomm.com>,
	=?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	Jeff Johnson <jjohnson@kernel.org>,
	"Yu Zhang(Yuriy)" <quic_yuzha@quicinc.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ath11k: Fix the WMM param type
Date: Mon, 19 Jan 2026 12:33:01 +0100
Message-ID: <20260119113305.30440-1-frut3k7@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Gautham Kumar Senthilkumaran <gauthamk@qti.qualcomm.com>

Since FW does not support the 11ax EDCA parameter in WMI TLV command.
FW was crashing as host was sending this parameter, now changed the
WMM parameter type as default zero before sending to FW.

Fixes: b78c02f7c710 ("wifi: ath11k: add support for MU EDCA")
Signed-off-by: Gautham Kumar Senthilkumaran <gauthamk@qti.qualcomm.com>
Signed-off-by: Paweł Owoc <frut3k7@gmail.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 451cc4c719ae..2779ebb5e88b 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2700,7 +2700,7 @@ int ath11k_wmi_send_wmm_update_cmd_tlv(struct ath11k *ar, u32 vdev_id,
 			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
 
 	cmd->vdev_id = vdev_id;
-	cmd->wmm_param_type = wmm_param_type;
+	cmd->wmm_param_type = WMI_WMM_PARAM_TYPE_LEGACY;
 
 	for (ac = 0; ac < WME_NUM_AC; ac++) {
 		switch (ac) {
-- 
2.52.0


