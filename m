Return-Path: <linux-wireless+bounces-24540-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CF5AE9B24
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 12:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C06169005
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 10:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CB723815D;
	Thu, 26 Jun 2025 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EttGbDxX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7C0231826
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933418; cv=none; b=ncg/pvuaTktseaTC4rDslY34rOda6lXzoiVjGVT7eopXwZQVIvzxh2qQBweMY5piqwb6cRDOpDYhhaxR55qqKVvMCwpO7qKBHBkUPv6cExugsbZMNNe9A5iIhYrhmVsMBbb92CJBhHybsL/b5f8Gobc/ARWAcjN+FAEn5KDUhLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933418; c=relaxed/simple;
	bh=NlRFCGFTEI7oOPtRlgvi/xbayIk43qr+3acOBw7CPUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DV5ui/1mLIUWVCOpHvQz5uHXaSUTASnHMWqU5KccKq7MsC7UPwFv0Ej8wPHZYUmZpAW028d/Gm2H17v77Ijz+hvYGrR3EqVM3eyPw9xw6p3nS2S9GObmnrWQT9Z8BU8fzYjrLHZMde4nBIjimG47AS+iRvmMlxApi5+WfkUoiSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EttGbDxX; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-748e63d4b05so561194b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 03:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750933415; x=1751538215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DO75ulnW7xXYDrGEbMAJCg2w9pcEpi3b41GUw2MbQI8=;
        b=EttGbDxXkASgXqSPc/74WXXfkDwQ2Q0s9hIalD5AS20JLVb0WEqb247Zk4m+Z0GfBV
         9RuRoAcgfguxafHd3EscmqNFCFSIpUdyxqEYkcRvaUNnSpLBWmB6RjtPzLaxAU4ouoaZ
         LsJ2e8iaovPztHBXXl+3iXXriqLqEywKnryZad5TnR6IxOAIT4Y+6zl4yxevVHIQNqa+
         shiw9GNSdwT87YunRLEIIx5KhsGL1jjQE77zYD9VUMsiRnsjhnVyJOobA7DJ9Y80aEko
         3FpIs8pIv/PZmmcxMFRiTdFoMD49QdI96ojgKh67ZqcamcPSazxjC/4YhLHWB4Hlt7mS
         +D4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750933415; x=1751538215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DO75ulnW7xXYDrGEbMAJCg2w9pcEpi3b41GUw2MbQI8=;
        b=YYJsPWdVAEPtaCne2FENNR2YRrvEjl+/al9s5LItWTNtTKooR7VFrdNS1zf9+dJawo
         44E+oMD8TeTyBe7MlTFr0jUp5szGmqR8SbhGum2uDX+3443DlHlQRvOh61SEgAkqDIst
         8Yr4WG01X5cTEsPE3RL+LAFtb9KKrk/fk30Ll5X4xBa2MABZB+OwTpO51OIp9k+vCsdn
         6i6fzsUPHjkjOG9YiJJanVd7TkkdBhqE2LLJ+YYGitlse06qlKZ53BzxBRvnnIopXAkA
         Ru7qGNoMveJojz+HjxBN9MFrsq9gkPkVIVkomFjhdK1cbl6CSN1HFYhT2xBGlWWpr+ag
         Lbaw==
X-Gm-Message-State: AOJu0YxUEWs1TqrI6y1MEUeCH9yb0Hs1s/1KDUMaUZ6A1lZm/zHusCQn
	SMgc+EWGBBWBTjEAjmeVNovfW6VHtqCOTmSSlwbztoZ7O1ou8oP2pj3B5BFMcXDc
X-Gm-Gg: ASbGncuPj9BX0I85DrYBgMt86xUFu/I2fFVdyZEJ7yt6YkKEXxGHx/r6W5u97EEFps+
	a8+RaGNOBk4tWG5/7zR3RZAmEwYy0lGAbbI73Le/7BaWvYx/9RyiT0rDOVdyRfmjzFHtNaO9wr5
	9TlxwnEj1YM23sA95WqZykiSjM5AQQWXdte/GqOB/ntntpjzZOTf1q9ViRv1zFLqDl1Xun5HVS1
	r4S22j3JJQIvionj1iQSq0vOU8yWggIEMoF4ZScRBPEd0701rMyORI8ZDhTQjLLO54t5UkBHCY/
	YmtFZVqtk6LR3huo1lDDbtUaC0qM71eYsnz3WNWNcAPYi2O46D5yGrcoV2NT0AeFBkw=
X-Google-Smtp-Source: AGHT+IHPUL04I+VRkptG15LMRvwHepnAhOlrBZ82Aon1QGUZsrRUA1EuNY2NemaW+3nyZp1l/8Tbvw==
X-Received: by 2002:a05:6a00:228d:b0:740:aa31:fe66 with SMTP id d2e1a72fcca58-74ad4408651mr9694889b3a.4.1750933415315;
        Thu, 26 Jun 2025 03:23:35 -0700 (PDT)
Received: from glados.lan ([2804:d51:4975:7202:7e03:331b:6be0:eea6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c8852f0fsm6814096b3a.117.2025.06.26.03.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 03:23:34 -0700 (PDT)
From: Marcos Alano <marcoshalano@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: wens@kernel.org,
	wireless-regdb@lists.infradead.org,
	Marcos Alano <marcoshalano@gmail.com>
Subject: [PATCH v4] wireless-regdb: Update regulatory rules for Brazil (BR) on 6GHz
Date: Thu, 26 Jun 2025 07:23:26 -0300
Message-ID: <20250626102326.3815520-1-marcoshalano@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602121434.3011282-1-marcoshalano@gmail.com>
References: <20250602121434.3011282-1-marcoshalano@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change rules for 6GHz on Brazil removing `NO-IR` since it's
not mentioned in the normative.

Change the comment to point to the newer normative.

Signed-off-by: Marcos Alano <marcoshalano@gmail.com>
---
 db.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/db.txt b/db.txt
index 803f1bc..4283ff1 100644
--- a/db.txt
+++ b/db.txt
@@ -322,7 +322,7 @@ country BO: DFS-JP
 # Source:
 # https://www.gov.br/anatel/pt-br/regulado/radiofrequencia/radiacao-restrita
 # https://informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-resolucao-680
-# https://informacoes.anatel.gov.br/legislacao/atos-de-certificacao-de-produtos/2017/1139-ato-14448
+# https://informacoes.anatel.gov.br/legislacao/atos-de-certificacao-de-produtos/2021/1510-ato-1306
 country BR: DFS-FCC
 	(2400 - 2483.5 @ 40), (30)
 	# The next three ranges have been reduced by 3dB, could be increased
@@ -331,7 +331,7 @@ country BR: DFS-FCC
 	(5250 - 5350 @ 80), (27), NO-OUTDOOR, DFS, AUTO-BW
 	(5470 - 5725 @ 160), (27), DFS, AUTO-BW
 	(5725 - 5850 @ 80), (30), AUTO-BW
-	(5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
+	(5925 - 7125 @ 320), (12), NO-OUTDOOR
 	# EIRP=40dBm (43dBm peak)
 	(57000 - 71000 @ 2160), (40)
 
-- 
2.49.0


