Return-Path: <linux-wireless+bounces-9876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F07E924866
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 21:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515D11C21338
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 19:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6001CB31C;
	Tue,  2 Jul 2024 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cet8ZuLH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232866E5ED
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948948; cv=none; b=fztIskXJILsrMddmvA/IIgdUHfMw2qK7dkz/P6a8PU73bIV8bgSIbyDz7bnZj16BDh5Guipl6OwCZPAGcqNtIjozFXDBK9Z1jNJi+yA0CI4PDXCl/4nxNl3PpUVmO9o5tvuMCYwxb8zEYTu74Tk7hO5cVkCzQK4ZIBeENX/2jsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948948; c=relaxed/simple;
	bh=T+dBy2dNci5RJopb9tdKqq8CsKoBE+N3egN3m9tlnNg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GEFqk0klfQmYyChVmDvpSOvOy5/Q8TRRb2SHnSOqBM0taGfxmo1i0XlMajWClGBjygHHdjZxj8cJqXAyX/wlcU41KNJrLp7AuMHqgQ/zhgv9dGbvb51FxVMqL6yaFkdcUS/V5IET9tFDi1GrB3rzJU35z+MRhPxcxbzR+VYVER8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cet8ZuLH; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-707040e3018so3314947a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 02 Jul 2024 12:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719948946; x=1720553746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Oju/bUa3Sl/6ZxW148rhD/+3/jGGQZHWr5TFVGcOCQ=;
        b=cet8ZuLHfT+Jsz7/9SIDNfBbYwzAZL/17HqtxGenfxCNyc2wZl1gyUFp6bfMyl3A3q
         EkqWUXocb6xTq22Om9nHJvEm2rJ2tKUAnWum9+IceliEYFTR71OkHfhViT/C+QIHOzxD
         3HcGaynfYdXZY5YOxuPqzXjKnSRJLt1VOZKGPuFqgFc9bv2jhtEFVtL2rPvEgTuiCnR+
         wfoAH09dFPK/NOfHIhlVHQH0GmaEC6whCnRe7iY/hJsmT8/hNDJETlMp8BA1MKcQKYvq
         IoB8M1eJ9uxjhwBQ3ZubOCuhzWPHZQoydo/tI84Negb0mOPiztrUdn9ZriaD106mXoI1
         EVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719948946; x=1720553746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Oju/bUa3Sl/6ZxW148rhD/+3/jGGQZHWr5TFVGcOCQ=;
        b=Zqnmxg9ghPP0y117ncchmf/hA2Cq5uV4Tp07OT33qSC4Dm9NlhurIdv5QBzObsbLLE
         bfDaqkAZ6KTWeMPThaem4hiGNbugqCHUTcJ9s9SNQRmIGeiB3AXG4E5lrPzE6WHD4ptq
         aWDhYFbMtwXQ5XfJJeLePuSpHFMlVfaGaWdHZzy0VPigKyglw+NKi7nLL0uqq5NBXV0P
         oasM3DSfhUp4xoQfDDLGe9REbMXfVjOPzhv46cCMrX6I/CjI7ZGidlXPfXn0MYF/qBrM
         MTk12tBoTPYlop4f0yj9eS8FnGY94dcw2A0tnIBWjcMxGmLetfj7qKERs8POKrCJwOn7
         CY7Q==
X-Gm-Message-State: AOJu0YyQLhLFwaoroq1JQ1Adnp+SSN37ePWHPbMxj1Gg1XPbcN81AwEv
	QuiyNRbtmDM2FqaVzWo2teb9WVtZqoOrhBnHOJw5QtSeciERslOGpd28nw==
X-Google-Smtp-Source: AGHT+IGUbYmysL+BLavXObq1NYu/cobNYfFTie8KLaD835B8NFKw2eFEspkKuNVVCuJvzyVW4jy+cQ==
X-Received: by 2002:a05:6a21:999e:b0:1bd:feed:c031 with SMTP id adf61e73a8af0-1bef61255c2mr16386444637.28.1719948946066;
        Tue, 02 Jul 2024 12:35:46 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce6ec6asm9316210a91.26.2024.07.02.12.35.45
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 12:35:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH] iw: fix formats under MIPS64/PPC
Date: Tue,  2 Jul 2024 12:35:44 -0700
Message-ID: <20240702193544.5984-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__SANE_USERSPACE_TYPES__ needs to be defined to get consistent 64-bit
type defines and to fix -Wformat warnings.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 17be33f..2652fac 100644
--- a/Makefile
+++ b/Makefile
@@ -17,6 +17,7 @@ CFLAGS ?= -O2 -g
 CFLAGS += -Wall -Wextra -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
 CFLAGS += -Werror-implicit-function-declaration -Wsign-compare -Wno-unused-parameter
 CFLAGS += -Wdeclaration-after-statement
+CFLAGS += -D__SANE_USERSPACE_TYPES__
 CFLAGS += $(CFLAGS_EVAL)
 CFLAGS += $(EXTRA_CFLAGS)
 
-- 
2.45.2


