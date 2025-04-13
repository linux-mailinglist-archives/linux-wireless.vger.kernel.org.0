Return-Path: <linux-wireless+bounces-21476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B67A87275
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Apr 2025 18:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3DC188EFBC
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Apr 2025 16:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38F01A238F;
	Sun, 13 Apr 2025 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs23nf3x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B68A14F117
	for <linux-wireless@vger.kernel.org>; Sun, 13 Apr 2025 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744560323; cv=none; b=FN2OZlRGZdTtVDjUCVxWiaHtcgPm3VOU+q9SK27m98oosH2tpXhUSM0QjCEYZfP94SDVdNuun3pTif7JVvYgoKTak17fov/B6KSI7C0K+gSTe6NWCq6h3cWLdm0PmPEoFoW3Iylx44/HSJLmA+7Inu5HyoQjb9XzC+hk14ctQt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744560323; c=relaxed/simple;
	bh=7dnESggtRZCy7gxc9gnJc6AkNGRz7eh8i3t1/tBIcuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TLGbYgNhxytYCMfaDWzY2qDIAwSFnRzx0ayKdS3u0Eb590gnHiwi0XCaQDK2Aipcd2+ikB1PfCmnjy9ZKZmTZb0arZJuHjueYf2JwoLS82LTq2OjV4l4Ee3O34ASYFbiU+1E+M7FlVUmFV6qSWm7CrlNsFB53I7moxy+eb4GqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cs23nf3x; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e60cfef9cfso5874968a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 13 Apr 2025 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744560320; x=1745165120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7BZJG+G2t5HpGWJOSXZu7wx5YpeYXRPpYzvNol9bdI=;
        b=Cs23nf3xee9BWG/d9AlHUlvqcfgRBAhhwllKS/Ir76cTSuqISg8fYbEyjiZTPSo5hG
         wPVCRuz61m6wcodeUzaoeRRnnQ96mRs1hmfS97Lc66EnuPV+/gUS5EyU3p/QmRraI+JM
         P2x35OCUvrdCXeTowS2wGqiJTKGKqcTgIULTRQWcceGGKUsvRLu6nLlWYiicUm//p/oQ
         1BjttQVjarcOpoxRc04vqrVsdCjH4Vqm2dZn7PUuO72gzFjl4TtTDBzs7a7Ck3gwc1Du
         4j6iPKpapaU5MPKRSSNd1o3TMGDI5y4KPetEN0oNGFP0QKg8O9tiCsKG10GQEPRUmUmS
         qSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744560320; x=1745165120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7BZJG+G2t5HpGWJOSXZu7wx5YpeYXRPpYzvNol9bdI=;
        b=C3RQHQ7jw9kzYEN6QWkc3BRMTZVKHIwuNoPkYIBA4pbWrb+/yAAobZY4vce3oDFbTg
         4wCnXE62VHY+3aAEFczmX2jLC0L3sOWWik0CCHQTyvm25uL2b4h09Lr0FQVVrHdbt3+L
         ygLR9xj39/hU/K8nkRpmTXZSNLDO/88OGOwtfXDj/Ow20O5pwY2XGSMyrGN+tjtS0RHb
         3bAD8DdeX3gX6MgWO0OI16po6njzM6z+2fUpmK8zlASwIm50K0pkt9jDgu8U54O+ZQQg
         8MHCfgFbpbEZKwiDHpUGPScH75CxADGHOWHjjrdG8gkPh/lF9YzRGfvnDbPPwz6wat8L
         O/xg==
X-Gm-Message-State: AOJu0YwOUpnTpEsSTZJPaCs5LzQcp8e8o4XeycMXN2zWsOaWhysVCpls
	8IqclHE+uf7eJa/Su0hXZJsKC93FH+CFY0Ewe9HJgLZndEpODQYRp1VBmg==
X-Gm-Gg: ASbGnctndNflo45RgGSeS/tGAk0SmowkFGahOEMSENDK/fJsIWJYr9/qYDBDJ2+kPg6
	HnuBH0s3ZH7fj4gE4IzfFzc5V+W2jnshR27nx7HmyQLHbKDyf+VUmd8fKEgKObN8Nnq8SPdmW2n
	XQde2LNclbqplkMMwWr79e5EgvQ6FLpYzi+BRlZKPCRPMGOAsZ8ryiGOn2hJte8DSdLUVp4cLZv
	OLL7gDUTs62gdU5Xgz7PqJ/SWdcqC4eqIRPs1s9Zm6Rjvp1ixW/ehcSbNUV4QNIt1V+NITImK/4
	sDNC6CWeqZVLbxOHFEZE9Kt3TlziBd4uOmnG7hnjrZkNzLmb9h4Szar8TxwIWxnYhb4Gdrzjyv+
	gTF8+ROafabheqjVTamxk3NfPROBzrV90KRSQNLpmBrR43DG/wKYlvhGq
X-Google-Smtp-Source: AGHT+IHZQwWKbtApHW3LjfT/lo7eWC5ghu9m7xOBFZDdyu7Dq0LwQ+B9FrEnOeQcmULAhEzDamX3iw==
X-Received: by 2002:a17:907:9728:b0:aca:cc55:fd35 with SMTP id a640c23a62f3a-acad36d901fmr808376066b.56.1744560320012;
        Sun, 13 Apr 2025 09:05:20 -0700 (PDT)
Received: from hp.NAT.swidnica_mmp.vectranet.pl (178235177162.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb314esm758182166b.35.2025.04.13.09.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 09:05:19 -0700 (PDT)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH iw] iw: print HE mcs correctly when mcs_len
Date: Sun, 13 Apr 2025 18:03:34 +0200
Message-ID: <20250413160455.158335-1-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Print HE mcs correctly when lower layer
report correct/real mcs length.

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
Reproduced with:
[PATCH] wifi: nl80211: report real HE length

 util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util.c b/util.c
index dc84886..d567f10 100644
--- a/util.c
+++ b/util.c
@@ -1398,7 +1398,7 @@ static void __print_he_capa(const __u16 *mac_cap,
 			continue;
 
 		/* Supports more, but overflow? Abort. */
-		if ((i * 2 + 2) * sizeof(mcs_set[0]) >= mcs_len)
+		if ((i * 2 + 2) * sizeof(mcs_set[0]) > mcs_len)
 			return;
 
 		for (j = 0; j < 2; j++) {
-- 
2.43.0


