Return-Path: <linux-wireless+bounces-12813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D735976B39
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 15:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 958A6B21C85
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 13:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEBD1AED55;
	Thu, 12 Sep 2024 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoWTZglg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F80F19FA91;
	Thu, 12 Sep 2024 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149220; cv=none; b=nl0z9Npddb2N4Elg/hv8R6XULFDHZbh7WMzQ391qL5q25ou2pbS7YlVkA4ylaJqiytwsdbU2RbLWNFhnCdnlgjJVg6t0JCK7l4fp5xxJsXa5iyHn1xYGvKgI8KZYwPpJSAYTJJx6BjZcXkd/TQTfbk1w5frGY9Y5WeCzWS7yNUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149220; c=relaxed/simple;
	bh=zrZNPt5QonukQny2WMS7XcM8c81dAvEiuCu94Zb0S5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ot9eyDOH1crMfDDwnrRqFnQ7Ab3PvLw9iJOc8on+o6qufLJiWfELsL1svKZDGYmihfPE9JaWYzwFi4EAT5d2q+U9gAK6LHJLBPHZi7nQKZPexDq+YpJy1QnAa/qHVfMcwSdLOuZmGO4/V5jo4UurYlDr/yGrVGI2JaeysnP71rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoWTZglg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-374c84dcc90so720764f8f.1;
        Thu, 12 Sep 2024 06:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726149217; x=1726754017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tnrCWFAarNQ9FhphdRh3bfMZwRdSY8tJKESHBkiSHo0=;
        b=QoWTZglgPH67iuUJC3xZecbKKmTkw4aOrFuvlc23zibmqE16htRZAi+n9NdPuvD5lV
         BRxctdFp2ZcWXpZ4Gx6MoAIBFJkDmGYQ7JRIr6wzDlNzaIWmroTJKSlxlpNCfwXZFAbk
         6zj8Qtolxf+SDCd4JUviscZMmrJspGbr7sMQosZ0c71Fwelr0Pf8apuc7LyKt0FoQips
         zUgJdDUZfkpukMdoPza3z3ufmrbYRp7QYU0y7gEoEqtvorPjWUz7lVsHwaaen9FVkuU/
         r1SZznr3sNiIeetP7SlGlG0rmpPrCMk/1UeLXGjOD8RrN2stHdDwNomwmjyCnhmdQ+RV
         /dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726149217; x=1726754017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnrCWFAarNQ9FhphdRh3bfMZwRdSY8tJKESHBkiSHo0=;
        b=a5WffU5Y/SMl9w70+OLgdmD9kxmsgYi9qLfZO/cGQjlhObgFwnCMEQtzI/4UAgWRi9
         AE13yfKwSE4+RAf1vRWtfhNsGNhGCA2KJ23NxQ0NTW2P0pJX4+baSSoxQPNs8E+6n7py
         oVqpTENspvta59jb1ISiRnz90gxwCVydim8iI3wr+iagoHpJtVZR76TQ8mRscmb+qtNp
         L0exPgqzVNymx0XU1Tqx9ftL6WVpRqS1tlyQdIGp6RbONDS0O5Z9KTw+gzSSEtuAEzGo
         950tlRTRdMI/y5Uw7QUe+0V+2PWB6Agy0jBfwKUcwDjPeJYhplN/Qiv/n8hsC/BQglNl
         3axA==
X-Forwarded-Encrypted: i=1; AJvYcCULIXkIokdiaeEZ3vscKBGZiV9xh2uW9UvzhzCl0LW3OqP235awm2xBkq80/X87pNofMNOl3+76NHRzSvD3TtE=@vger.kernel.org, AJvYcCVvuXtFajfsU1wd0BQU5YKJc3WT2a2QgRyBhGhZybW/9i5Mzl7le3LMA4pvDs4QAQoCEhx+ZWqC0/c3nB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6b6vgSD4JVbjS5/kAi0OE63ZssMEzgZGDzH+yvDjPI5o/gSoB
	U4K7DJQraLQov9QMgR8/KKxU/i+3loKErWQ3w0S59dYgQiSmj3iU
X-Google-Smtp-Source: AGHT+IH0nkooPLIJ3P85N3obDRyVnvq3Vt55M2xXwEhBSW0gfYXhX1dJVuzwwz0IJ+DI6MNuoJQmKw==
X-Received: by 2002:a5d:5747:0:b0:374:c4e2:3cad with SMTP id ffacd0b85a97d-378c2d5b237mr1525655f8f.52.1726149217282;
        Thu, 12 Sep 2024 06:53:37 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956653d1sm14430067f8f.33.2024.09.12.06.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 06:53:36 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	linux-wireless@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] wifi: rtlwifi: make read-only arrays static const
Date: Thu, 12 Sep 2024 14:53:35 +0100
Message-Id: <20240912135335.590464-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only arrays params, toshiba_smid1, toshiba_smid2,
samsung_smid and lenovo_smid on the stack at run time, instead make them
static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../wireless/realtek/rtlwifi/rtl8723be/hw.c    | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
index 0e77de1baaf8..bcfc53af4c1a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
@@ -2040,31 +2040,33 @@ static void _rtl8723be_read_adapter_info(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
-	int params[] = {RTL8723BE_EEPROM_ID, EEPROM_VID, EEPROM_DID,
-			EEPROM_SVID, EEPROM_SMID, EEPROM_MAC_ADDR,
-			EEPROM_CHANNELPLAN, EEPROM_VERSION, EEPROM_CUSTOMER_ID,
-			COUNTRY_CODE_WORLD_WIDE_13};
+	static const int params[] = {
+		RTL8723BE_EEPROM_ID, EEPROM_VID, EEPROM_DID,
+		EEPROM_SVID, EEPROM_SMID, EEPROM_MAC_ADDR,
+		EEPROM_CHANNELPLAN, EEPROM_VERSION, EEPROM_CUSTOMER_ID,
+		COUNTRY_CODE_WORLD_WIDE_13
+	};
 	u8 *hwinfo;
 	int i;
 	bool is_toshiba_smid1 = false;
 	bool is_toshiba_smid2 = false;
 	bool is_samsung_smid = false;
 	bool is_lenovo_smid = false;
-	u16 toshiba_smid1[] = {
+	static const u16 toshiba_smid1[] = {
 		0x6151, 0x6152, 0x6154, 0x6155, 0x6177, 0x6178, 0x6179, 0x6180,
 		0x7151, 0x7152, 0x7154, 0x7155, 0x7177, 0x7178, 0x7179, 0x7180,
 		0x8151, 0x8152, 0x8154, 0x8155, 0x8181, 0x8182, 0x8184, 0x8185,
 		0x9151, 0x9152, 0x9154, 0x9155, 0x9181, 0x9182, 0x9184, 0x9185
 	};
-	u16 toshiba_smid2[] = {
+	static const u16 toshiba_smid2[] = {
 		0x6181, 0x6184, 0x6185, 0x7181, 0x7182, 0x7184, 0x7185, 0x8181,
 		0x8182, 0x8184, 0x8185, 0x9181, 0x9182, 0x9184, 0x9185
 	};
-	u16 samsung_smid[] = {
+	static const u16 samsung_smid[] = {
 		0x6191, 0x6192, 0x6193, 0x7191, 0x7192, 0x7193, 0x8191, 0x8192,
 		0x8193, 0x9191, 0x9192, 0x9193
 	};
-	u16 lenovo_smid[] = {
+	static const u16 lenovo_smid[] = {
 		0x8195, 0x9195, 0x7194, 0x8200, 0x8201, 0x8202, 0x9199, 0x9200
 	};
 
-- 
2.39.2


