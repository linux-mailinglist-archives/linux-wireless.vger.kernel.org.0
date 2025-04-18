Return-Path: <linux-wireless+bounces-21694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA6BA92ECE
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 02:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96F98A69D5
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 00:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52F9442C;
	Fri, 18 Apr 2025 00:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCU2LtXz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F47125B9
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 00:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744936130; cv=none; b=uBHN7LlGqILv/QU5+0vteaoIVrHiFvTmrj894QjgAH9DGDANPQYe16x0COxWGx2Y6AnXOgXfTcK3FbMocAujPl6ngXcyzlEoAa/Pbe7Qw0Ljl4N93GdEWFXlKBbP2ghre9G9KtfwXiYfVHenUvNa5PLq1v8rRbwnKGTcPuRz5jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744936130; c=relaxed/simple;
	bh=3WrAK6ETBZvh8733Ts6rGsbjWkMKH9hxoX1gr4fgvHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXtIZEIUvw7RTvtpbaaY9cpV7Q6sNY0Vk7WVU5aAwWTxWd/BQz1ROsKSi2no0lNOBQBxHN0FXNeTjsdk/jlUsXpuKDYfwOSKszPvKGcCs3co0knTlrym2mqGQg7Me6FEI1c2o+F57mL2fZqJkxehy9LtW0ExLTN0nhs4BsBA4ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCU2LtXz; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so2554411a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 17:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744936127; x=1745540927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmjfnryaL/1Db85i+ddktBGEqym6N7KGAu30Cvm+lw8=;
        b=YCU2LtXzDiJwiKBQI5+aRi9CScSxF3q9IB8qA+lDrLWLb8MUfDj1+d3LUzSDQuZl4s
         ff4IhCdCvgKgvS5YmaCffDra8qEfeU6ewTShij8Ilx3PS2ftVikMLlvm/G9uohwu0249
         ZFeKdTIPMF8MIdtW159JwPH2nABeDuICb/j2WG1e04uODegVDXgu3XrHf2c/tL2gt1Kf
         c3t8HqjzUqzeBM7S2aErW+/8wCaTH2gGNZNka3eQ+ryBI6Ex8F4msMsrgdbpvDtpjh4G
         eWx0cL8FBU9opHsHdtgpnmXd4ev+AJM9xaoYA6xJNsf8lvEuGkoE0o4KH3mhDZzFPXCH
         BzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744936127; x=1745540927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmjfnryaL/1Db85i+ddktBGEqym6N7KGAu30Cvm+lw8=;
        b=AlaTtfsfsZPjdT4PiU1QhNegZGH9FgmAGnX2tJnUWw5LaxEduyuTDFiGfKvTItEirQ
         qpf2rMvQlPpAkTpP2USFGDclwSWB6dBh4drLguPWDfuvdAmxQs8uOenZRFBGizifZO1j
         vV1WpO1qbXm5X5necy/mQNHBn1I3+A7M478hfBkBbPbbmWXG206VOlnqE9ZyBa57DEkX
         X20qQH2kn6dGA6q69l1+p6RIlZm9FhtRWJLA2XGLl/swViNn8G39GYlYidIZ1vP0xh9p
         PuybP8wIYLvzXqRiZfoljk1QmvaR/XUEHzGDFXJGovjovqk51mvgip4KxW5B/grgr8+V
         vZiQ==
X-Gm-Message-State: AOJu0YzfPXWIzhYtc8QhkhlL4uA9dMi+uhh5aRmP/iGKF2YnGHPpIfwx
	VWci9DtCZ3jifoEzCbE29Pw2+iF1ZTdSGKa3tTEbijYTsHEnDgpquLyehyXZ
X-Gm-Gg: ASbGnctLBMjXobwIDrRv90lkohm/9/hEh8O4VuBchrg8N4dUOD9VqX/tcpNpDoMBcfO
	aRcBUXY8ZJKBqCF82L3TaKuUZFSpMA4GRcLSIjyBJTLXuSEZRUuT+XLgspaRCjuf70mwDKLRzUO
	mpN0ewzb6DrHgwtKjYYPjWzEqIshIKYt9c8txZnzq4HTy10ZdKVCCjPwOooS8yEyjQKB816/Kwu
	uk5SokKSXsyUg5aJii83OI1WpG4IVcXTHevRti97DMkInS8ROKV7/cBrM08n+I5TrmetCkpmzem
	hRcSLqczJl3+pOEJNdCbg0XdhPlYO7N9XeAg+KvlFcZaNiP+sY2xROwJ/rARdzpiOG5ER+gJywy
	K2MGdqwXg6NYDq/No+MLh
X-Google-Smtp-Source: AGHT+IFU86iEd9+d/kSLYr8Ym56tzjTGa7GpupEbRPDqKhNOrY04UIsZsxVJqI3o2Pk8Ch4IlYaH7A==
X-Received: by 2002:a05:6402:2548:b0:5dc:7725:a0c7 with SMTP id 4fb4d7f45d1cf-5f628503d66mr597448a12.3.1744936127290;
        Thu, 17 Apr 2025 17:28:47 -0700 (PDT)
Received: from systol.god.lan (157-21-254-92.ftth.glasoperator.nl. [92.254.21.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f62583d83bsm395893a12.52.2025.04.17.17.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 17:28:46 -0700 (PDT)
From: Henk Vergonet <henk.vergonet@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Henk Vergonet <Henk.Vergonet@gmail.com>
Subject: [PATCH 2/2] mt76: mt76x2: Disable VHT on 0x76320044 ASIC
Date: Fri, 18 Apr 2025 02:28:27 +0200
Message-ID: <20250418002827.26806-2-henk.vergonet@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250418002827.26806-1-henk.vergonet@gmail.com>
References: <20250418002827.26806-1-henk.vergonet@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Henk Vergonet <Henk.Vergonet@gmail.com>

VHT is not supported on ASIC revision 0x76320044

This fixes the 5G connectibity issue on LiteOn WN4519R module
see https://github.com/openwrt/mt76/issues/971

And may also fix the 5G issues on the XBox One Wireless Adapter
see https://github.com/openwrt/mt76/issues/200
---
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
index 33a14365ec9b..fbb337ef6b68 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
@@ -191,6 +191,7 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
 {
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct mt76_usb *usb = &dev->mt76.usb;
+	bool vht_flag;
 	int err;
 
 	INIT_DELAYED_WORK(&dev->cal_work, mt76x2u_phy_calibrate);
@@ -217,7 +218,15 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
 
 	/* check hw sg support in order to enable AMSDU */
 	hw->max_tx_fragments = dev->mt76.usb.sg_en ? MT_TX_SG_MAX_SIZE : 1;
-	err = mt76_register_device(&dev->mt76, true, mt76x02_rates,
+	switch(dev->mt76.rev ) {
+		/* these ASIC revisions do not support VHT */
+		case 0x76320044:
+			vht_flag = false;
+			break;
+		default:
+			vht_flag = true;
+	}
+	err = mt76_register_device(&dev->mt76, vht_flag, mt76x02_rates,
 				   ARRAY_SIZE(mt76x02_rates));
 	if (err)
 		goto fail;
-- 
2.45.2


