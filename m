Return-Path: <linux-wireless+bounces-22101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77245A9DD19
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Apr 2025 22:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55CD4625D7
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Apr 2025 20:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A601F3B8B;
	Sat, 26 Apr 2025 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2Vugnic"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFE01EA7DD
	for <linux-wireless@vger.kernel.org>; Sat, 26 Apr 2025 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745699243; cv=none; b=kWb8li50eJAXoz0KX6odu7Z1rTytpjBMVTp7pirgwvQ+O3XmnULC8nfDxw5NvT0284KuSWBhMsfzXJdvB49k31zfIoUaJW0Yp0lp5RywbNi7WJFA1YGdAxwZKpvObqCLdLYSKssiVw928B1RCL2bs71DalECm54Du2ty0soPOB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745699243; c=relaxed/simple;
	bh=47viKrJ06wefziWd0nR3v1borq4SwPMPeWa28MhV0k4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tNh/4lvfyeHDaFf/hXlYxGJHGitdw7TXRwjRQMrvXk9gHu0lXqF2dxQrLxQVGLDeUg0dTg6YYeRM1V50y6FU6wOW0vUHV5/khzSHeM9OEcetRpxV1AwLQs9nKZslotCK8M+3QIHzx84L9GtE43ZbotOiIiqK6NOqGrQgxYZHJHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2Vugnic; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso734880566b.0
        for <linux-wireless@vger.kernel.org>; Sat, 26 Apr 2025 13:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745699239; x=1746304039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PoC+KF50VJ4AzNjYTDphbT/eoTPimlkMf/gxxvjVKxA=;
        b=k2VugnicqLFqslrDyd6mP/5nPgQsa62f3T+v1DDQZDKw9uLC6mS2yGzgTeGf7fq/Hb
         ZnUIqc2OGzB19mqRUS3OvEedl8vFkXC8lziA5c5D7vRHbtlSM+p8eF72Jm3y2VhJ7Xvw
         pOf18+PvEcoRMTb9w9MMKM0EyF7syOngoaVCtAjeZv0G3CVwCiYWSOfO6KSyecM0CBaU
         dPQlHwjeMGrF4F1AHZdJVUVqD/mD43UGHDINv84Bj9u7gVqdbGyazhy4nRgJspv6tKY1
         j7+XWSzoRDQfVvPO7FCJFNbnEq23508GO2RZRC5HJm6lh/MmEi5fkPpD30wFGgKeK4bj
         3A6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745699239; x=1746304039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoC+KF50VJ4AzNjYTDphbT/eoTPimlkMf/gxxvjVKxA=;
        b=HZ07RBmb/rDNb9tNiUOnei9Fq4n0ZO4OKOft7sPiEBZoetYdrKwDGRuPmwjn1VdBeH
         MdvoBTDtmovkWJV2VTqelI/nOnBlOFYaGhmhoc7Nx2GJdrtF+A7+2j/s3rpQ5RxRToEH
         t6LFnt4hG+K1xpsKPK8XPVtFEUWNEYRFZbqBGHBBr3ljLMLwUU/ZRz+r6eowUz4vupsc
         0d2Rk2PZg9+hkLpWNUqHiUyZlbKzI70uuc9xKep882CWRJYNK7qdtUZzY1nSD5ohq0aq
         bf15yrHCJo/8Axati/G0MdNYOAPoLs3sSls6kvywtJ+hkO5m/Nv+nha4GvQmT6Xwe8We
         zdsA==
X-Gm-Message-State: AOJu0Ywm9xsq8kopw/u2hCRcgN4VsDllxdgc2vIwdJsztaDeUUiXAz5L
	08pZ+zt9oUlLkOfRYQgDQqlsyRKsjA6O8NejCqVpFcgNMVZblSBOCnHJ8Q==
X-Gm-Gg: ASbGnctwf4uXvf36hOVwlNHdqZbccIoEJqaEQPtLLy2z4ClH//Cty//fzVfbb5ElGFs
	E0D0J3exgsmh4b2FdvKOFn/CGIkpOnhzhBJvQcAeTdITNXhViOsuaFrPma9o1NBqAKIJHzwIKGX
	xOK3V4oRRU1nJlHXT+CJPA+w2LNcusICkU82f6LcZiwWh9Q2owYBJawKRBNEIDzhBl0X/tKbFd1
	3BMXBu9I082TPBXI4LoWTDE8C3Bkgm49keo9Dftn8HAOywVvscFvHy9aWdXE6ji3i0cXv3fqOjr
	8/HyZwlT1wIusM1iB9BvWFDM1v+HM0/z7gysK6UOPkWmyXwuP+r+WttkFvZEA/jUCAxG29NuGQ6
	OzhyO
X-Google-Smtp-Source: AGHT+IEeo0+9AOc0Iu6COpWRV3BiQ3+6SMEmgdjccppvcU4pWa/X+D1nATNZCjZ3RYLUYNYtPs3veQ==
X-Received: by 2002:a17:907:9812:b0:acb:5070:dd19 with SMTP id a640c23a62f3a-ace7140871emr557015566b.61.1745699239257;
        Sat, 26 Apr 2025 13:27:19 -0700 (PDT)
Received: from hp.lan (109241135220.swidnica.vectranet.pl. [109.241.135.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e587093sm336388466b.80.2025.04.26.13.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 13:27:18 -0700 (PDT)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH iw v2] iw: print HE mcs correctly when mcs_len
Date: Sat, 26 Apr 2025 22:26:48 +0200
Message-ID: <20250426202702.913342-1-janusz.dziedzic@gmail.com>
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
 util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util.c b/util.c
index c6d5974..e0bb513 100644
--- a/util.c
+++ b/util.c
@@ -1399,7 +1399,7 @@ static void __print_he_capa(const __u16 *mac_cap,
 			continue;
 
 		/* Supports more, but overflow? Abort. */
-		if ((i * 2 + 2) * sizeof(le16toh(mcs_set[0])) >= mcs_len)
+		if ((i * 2 + 2) * sizeof(le16toh(mcs_set[0])) > mcs_len)
 			return;
 
 		for (j = 0; j < 2; j++) {
-- 
2.43.0


