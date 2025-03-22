Return-Path: <linux-wireless+bounces-20693-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD23A6C9D3
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 11:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628F1485B69
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 10:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3361F8F09;
	Sat, 22 Mar 2025 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezbYVJ7n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAD01F3B83;
	Sat, 22 Mar 2025 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742640667; cv=none; b=RABBNxM9Cuv2J07LkzL+yIKFAzc0CuwNpbpId8m1rxUIN+Un4Jb8qEeiENokbqpQgaYXQaQFJyE1r7m2aHYBkyj98MUfLFf21g4ITf5ji+5ZRWEW9Qpf31NQ28Ym//SaCgNJASsFv5HDAilCew/z1fr/a/6K20Qttz6JAPdZ3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742640667; c=relaxed/simple;
	bh=JYyPCCShCHfqLDYAr7Vse/ZmJyZOdOWrV3Z1YVZd7hM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dw6BGh3owKwgwaUmvNJr2SeyN/pJnhG40IlUf5KPBfcq9Cu3PySNssUxvZZ7dnGnwrlZccOEh9i0ylNtjPP1ALzY08QwVTaXi0qnjr6gGImYcwBeW42H6rAql4PGVWtXc+s0zWgScMWzdowS1acSUWcQlEVen3gk5+L2aOpdHWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezbYVJ7n; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3913d45a148so2299178f8f.3;
        Sat, 22 Mar 2025 03:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742640663; x=1743245463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KrpT+jmLuV0pMig4xoM27D18t14gkY3tPjFQzNc4T6g=;
        b=ezbYVJ7npzl65MrNr32HdyVNZgATQNAYGPZZHTqAwCdKx8dQ7VDOvhisL2h5Yr2Vn9
         sc/9deXTMryldnEJCenoiU57RKWdCjlC6v6XmVa9J49V95hAo5dHikvQpvnTxseuFAy0
         YrU7i/kH7G85/lmgpQNmvs/JkVPBoqVH6CMkw8Db2Hkz3mWm3s28RBxZuezntEvwRobY
         QuLMPKNDtSu+uH3Gt2n0hrMX3vNsPAHrfhQz/SeCBKQgminhoawL7DlYAAEAb9isVvj4
         0u4Dg/zt4AXewgkHmGGStHEVqk7MRDYCu256fRh3Mv0ByvkD0hOUSD7SWmjsWeYRctgJ
         XJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742640663; x=1743245463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KrpT+jmLuV0pMig4xoM27D18t14gkY3tPjFQzNc4T6g=;
        b=BNnZPwXQnxSHPdK2hMupb8AYyAH66Hp0Jmy0Gwl+AcflAEeTLSavQSp29kDgSMo6q+
         POL1JlwPV9dHrz2w9LBE/iHkWxAOJuNkQaH40EyYXZjshB0x/jqmw7e8QCkhO+cC4gBJ
         Vv1duabiAa+iSiTwwFJEWhW0K6dQjRfj+jKoQzLTVNRP6JmmMiln8f7fUYmTc/5Q4RRf
         fXuAOzehwv7aDkHYpnmQRYD2H1VJsKyQIbMzyp8pRcQAR7zVb2LAqq8SaT6W+QogLSEU
         6pT7UyqT++Ii/zjyuoiPBNOy+7C38zMOQ2w5PKtLd1fVP0QDI6HHAornN7d6zMjKt5LZ
         i8DA==
X-Forwarded-Encrypted: i=1; AJvYcCXwA6ZBs9L/bI0mjwnUPI1xzjRi1hsAdeEeb5srJp64zVZvtCGFRE8LAAGG738TJX24Y5TgxLQZK2Og3vo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywps8T/L3WF6AN3y8c/nDjj6km4TRwwq5ocqlaNpwgrWu8Z99gS
	LOKd9j6URtz+W432tq25uqorYINR9ocji6OsBpmufGVhuRWZBPaJ
X-Gm-Gg: ASbGncsboOpcrlLdKhzT2mXSwXmDfBewUFic9Vxvjl3whhxcEOlTHBLLuiv3q4GTjJR
	OvexpRbx8BTAQBIZ8osDzbEYs3l9kWGlBqPURUQth8uxHj16gyEC3YCGaKPyyFj+TJQU38wlS8D
	50bfUg8076RFPUsS0FAVjeVV3V6IdcG1A18Uw+DAcdTnM+UkCE74+W0Bos09GFd9K8xUSbI+CFw
	prk23wyWRhd1aWjYNs1V/AFndhu7VXBtYo1oS64m7Qldxf1L/HkixADpN8uHHxGKa2dRdmzvTkH
	+kbEUTlUKFAPDjzYAQQUEP4VRzpQtrAJv6WlKEIMieN41Q==
X-Google-Smtp-Source: AGHT+IEEaToUvEuqHUrucs2Mab5X6FQNEQACh4ItoD1rm1rGxrSkcKlwnmFnT1AV+XPhtU7H5TrVBg==
X-Received: by 2002:a5d:47a2:0:b0:391:47d8:de25 with SMTP id ffacd0b85a97d-3997f937634mr5851686f8f.41.1742640663277;
        Sat, 22 Mar 2025 03:51:03 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:924e:a190:c73a:b6bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9efe61sm4906161f8f.97.2025.03.22.03.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 03:51:02 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chui-hao.chiu@mediatek.com,
	Bo.Jiao@mediatek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] wifi: mt76: mt7996: avoid NULL pointer dereference in mt7996_set_monitor()
Date: Sat, 22 Mar 2025 10:50:52 +0000
Message-Id: <20250322105052.19136-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function mt7996_set_monitor() dereferences phy before 
the NULL sanity check.

Fix this to avoid NULL pointer dereference by moving the 
dereference after the check.

Fixes: 69d54ce7491d ("wifi: mt76: mt7996: switch to single multi-radio wiphy")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 91c64e3a0860..66575698aef1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -414,11 +414,13 @@ static void mt7996_phy_set_rxfilter(struct mt7996_phy *phy)
 
 static void mt7996_set_monitor(struct mt7996_phy *phy, bool enabled)
 {
-	struct mt7996_dev *dev = phy->dev;
+	struct mt7996_dev *dev;
 
 	if (!phy)
 		return;
 
+	dev = phy->dev;
+	
 	if (enabled == !(phy->rxfilter & MT_WF_RFCR_DROP_OTHER_UC))
 		return;
 
-- 
2.39.5


