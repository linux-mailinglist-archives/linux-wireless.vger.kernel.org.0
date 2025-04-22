Return-Path: <linux-wireless+bounces-21836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995D6A966F0
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 13:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE5817CF0B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 11:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA32F25F96E;
	Tue, 22 Apr 2025 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dExsegdr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C748277811
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320054; cv=none; b=WUlcOz0aRGojAuKTocRN8TW9/RFYgqu5OlpnNXP3I0p1DEF4q8Eqrg6OZ57rcUZpC9Law0MrDy51KZ/hPFyO5ZoEcDXnWvccx2kGrbFXXoPawdWeW6lrQ+8+BVOLJgx10nKr/YoaM3uURYGVFVjazhZRBQf+sTr9HrYcEkqXZFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320054; c=relaxed/simple;
	bh=TouWVjbGffNrtrRP5iV9DbB4TRvaRs+3WtaettV0NHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sYn5keZm8ehK/WWXq/pDQyfkrEy482HyQNFvYlMaaU/zweCTZUaYfg8u0zVa5eAve4AeHdDDd0nDVjkySmVJ7++FvF2We+Fm3NjAb3pQvBvppeZG5e3wE6qU9YiBPC7ApwwpSQYj3vAUsP3s2+3B0rvGrg1bn75kMATAdihnnjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dExsegdr; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so6829063e87.2
        for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 04:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745320051; x=1745924851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vmPuBb3+UknR7FOhL3DZlaVIw06CMJ2npLrBifmc0i8=;
        b=dExsegdrVMZl7yidWAkEcGzYR4dAEhNy9OQZS5gQyRW2ZhXz8a4Q75adxPkvcTStx0
         FpLDyKGu5af15XFoEYTxuQZ2T3xR//ItU7ymfPGmfvSDv3O1tQA2mhsEwV/eF1zc/4Qu
         8XV/ZcBOGZXsxTnd5wsXamXPrvX1c1Y3cKon6fIxCov3eFyVJQRiIbHevgYlotCRZlHj
         CZyMnl8khj4EOy0HLcWDsRs084frYyl6ChV29n3HbilDtDrPyJSuHsZeHX0wmeyhh8iE
         Rm/+RuitOuiXw2ANIkEXo9A94jEt18KgZubrq+nce/o+NxSjZvaO3arfxTq2wKjogKOn
         I/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745320051; x=1745924851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmPuBb3+UknR7FOhL3DZlaVIw06CMJ2npLrBifmc0i8=;
        b=KeuNrCM8HdJw83D+SHdSo5t5+vyswaML5DpcI0kghSJwLefLAlCNYH8mRMehRluPEB
         QRE47tg6xTi22oytF6T55LvjcDpKHWd74pwK24Yq0zr0UcrLMpg1OACYXpSgXxlcvL3N
         gXZ+V4D6LRplSET0gY8QG9vo3l7wLeIRHMBKsNAB309mGTBrpEU/Zjyb8xRglaaohl/q
         DZ6adyj17aPHeFiQb+XMFMooGwTJqZOlUCQHLobUaa3QceEJSKAB68xKHXfcqUaO3Sen
         tsb6QhOOqQf1BouqHVrn3oExC3HkAdgN9rL1KVxcrM6cnonSQGvFoLEBriPkQ3LUVqNb
         TC0A==
X-Gm-Message-State: AOJu0YzwCqFOQtrD37TCJQ+En9F3rR+Ae07FEV6lHoFzEKH1qpwRmgow
	eUd6YQMDoLt+WAM3UPaLkM9K/bxvM4aDSfOTBnG2O47XzmbvRna9
X-Gm-Gg: ASbGncs2lLp+5sm/gOW17CKOd+Vt9cGA2PIdv9hOBtyfuhVt/bSAQoFFv+WxsZpo9ou
	qtkl1aV6xEfTsFGxFvvnrvhll96ymdzV4GriidE/4YtmD1q/MUQ+dbYhM6v5RI7R00aos4nSZGW
	nkFkKBPxmUe6m1WNvhf2pWP02GpXQf2Xh1hOE7bWZ379QA1ocOgTt9b5e+m6ZwOvKHxo89DQvuw
	w87hMrSsSq9Ivu3Gj62gDQ2XsAD/YZqxNuCOXRQ34YHCnRU076kjzQmpirrsUfMlLrsZ5GUKS23
	8Bg59CQCqxF8nj1aboQLzOMn9WSKYi3nBiXo/xJQ7Y99FwQixm8EGw==
X-Google-Smtp-Source: AGHT+IFNzjTG0p08Yng3aMyxBR7sGg1lJGrsBmvEb6Ibe7csDMvPs73zveX1ymK5bL9Y443NQ0akrQ==
X-Received: by 2002:a05:6512:12d4:b0:54b:117c:a3b7 with SMTP id 2adb3069b0e04-54d6e66da7amr3975783e87.57.1745320050743;
        Tue, 22 Apr 2025 04:07:30 -0700 (PDT)
Received: from localhost.localdomain ([185.201.30.223])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d6e540f6asm1188001e87.86.2025.04.22.04.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 04:07:30 -0700 (PDT)
From: Dmitry Kandybka <d.kandybka@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] wifi: mt7601u: fix possible index-out-of-bound in mt76_init_sband_2g()
Date: Tue, 22 Apr 2025 14:07:26 +0300
Message-ID: <20250422110728.1274143-1-d.kandybka@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'mt76_init_sband_2g', add return with '-EINVAL' in case of register
channel start bound exceeds size of 'mt76_channels_2ghz' array.
Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
---
 drivers/net/wireless/mediatek/mt7601u/init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt7601u/init.c b/drivers/net/wireless/mediatek/mt7601u/init.c
index 5d9e952b2966..d2e0f2af4f79 100644
--- a/drivers/net/wireless/mediatek/mt7601u/init.c
+++ b/drivers/net/wireless/mediatek/mt7601u/init.c
@@ -562,8 +562,9 @@ mt76_init_sband_2g(struct mt7601u_dev *dev)
 
 	dev->hw->wiphy->bands[NL80211_BAND_2GHZ] = dev->sband_2g;
 
-	WARN_ON(dev->ee->reg.start - 1 + dev->ee->reg.num >
-		ARRAY_SIZE(mt76_channels_2ghz));
+	if (WARN_ON(dev->ee->reg.start - 1 + dev->ee->reg.num >
+		ARRAY_SIZE(mt76_channels_2ghz)))
+		return -EINVAL;
 
 	return mt76_init_sband(dev, dev->sband_2g,
 			       &mt76_channels_2ghz[dev->ee->reg.start - 1],
-- 
2.43.5


