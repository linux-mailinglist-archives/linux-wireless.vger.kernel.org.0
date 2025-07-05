Return-Path: <linux-wireless+bounces-24836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F41FAFA047
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jul 2025 15:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831024A52C6
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jul 2025 13:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DDF28F94E;
	Sat,  5 Jul 2025 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyY3lM4W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BBC1CFBA;
	Sat,  5 Jul 2025 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751722567; cv=none; b=H/Y/dwV5lp2R57n/Q6ICjfQCekRlxLfEfd0DEkzEUP3AKVEXnOZ3IRh4eQxGl0U37NDU2TRQ9m9qb73bnZEJMmaRD2Eb6CSohlYrz4xe1dqEZQQWh2XwZzgHT5+85aYBkTz+agpVmjDULJjMzQvMMDPhmoTkZUBjFmb3hGgRaLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751722567; c=relaxed/simple;
	bh=byEloyPvqf1nq7MO7oyaeg7ZRyoHN7+ex2bhsiYAgeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lCHCf/1CWDD6HCKheBnlgvj4AUhC2MVTYzY8E73WRAIQ9mYfUQphsBz8lGs4EbIy29AoxK/b3FQqiAO4C6r5ULCCSOkEvC874yaWO9NVnUvVWqvNTT8ajB4qIqvsBNS1SacSClCxupdWlwIRsygjiRV86cwo5de9iCQIqPNt9aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyY3lM4W; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a528e301b0so72105f8f.1;
        Sat, 05 Jul 2025 06:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751722564; x=1752327364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ynw8s9LyLhGgrm657sVw2shdcPbKUaf0m+3Cw45kKGY=;
        b=jyY3lM4W3yjYFaHycKwKDFuspltB9xGe6jkf75SyAv4raSRXUlRUUMs7xh6qJfwzXu
         xSXpIhOeFojQceTTEUmTJHgMQToJDq0YfyzidopP3pNg7YxsNpF61GJWzd1JCInfoq7q
         58HnZp74H4vp6BBSWf0G/FGEpTVDNvJhqSDH8ikuqo6jpQNXB6sApU50Ui2AuWjuo/xW
         SHAGlHRJK4jTkgNofThl/k9h6D0zjpPDvdNrTf3VmIxD6IQCy7LKR/9NyPaXTsKoWMfR
         9sXz9MH0TUgvmKFsv1i+ypMDJBKeHSIyM6Rp0U6dtKfma3hK39G7+rhYtgoXQMj3YLaA
         HFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751722564; x=1752327364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynw8s9LyLhGgrm657sVw2shdcPbKUaf0m+3Cw45kKGY=;
        b=db/ykkd9MSL2XpjkHXmKhvWVppuZV07M5c+HRzOr6KY3O+5GCD9Ksnh+KogQlXj3en
         YCXI644gjNQgid3khGRKQKlDsLRMTYlbrgzGvpQykM+rgP5vtFsfWp3q5DV4XljSD72/
         VrRK/WWbGWbptCDkHkyD0m1bKn9QUkiE6JV39qrY38q65IkfqYicE7IgQhjWF5RD9mVV
         9a9S7gIwnYPzHdzjpcnCsffGP3IjGxECeCfyvF6BfqeJlWIANaBF9z3scz0T4x1bZgUw
         85iBgSp1mu4o/N6eEdNdNAAf/2JyC8Tlm7sM3czqTck4KpaH1ssyvv2eJ16lItYUg3wg
         VNFA==
X-Gm-Message-State: AOJu0YwQZX7T/fiHnthfteuipIKyxRbhb8TqYyHQl10A+A+jVtktjZOg
	CfQyf0s0S0IJejgFFXclDwXmicFxQuFkXW65oOb8PjF83Gnif0zrT/oY7wleLDXy+98=
X-Gm-Gg: ASbGnctr/6Nmj3WihJlLkR34Dt8/aJh7IhVa98V4PM3f5vgXFRQssc+rccAGGQ/fINZ
	gieJ4yR7s2QFO2RkQ/oNlh/1TizvwStN07xRTiGLg8VVlFuwMYgssGWfVi09TyYRNUGE5Ii6YH/
	W2cvyfueB7WFgllhNKOin9T6vr3EC3HkwhgG+uKJPd6LrP7bOP2y8LXW7GKj1ePZUzOstedKOsc
	5P1uQg/KU6PyBHxyOkxtleMXjSMH0m7VKa0OIWqqNVoffYipAXKFwTcleQVm1LnAeUvls7d7lE0
	jfZ/OgA7xkYVN2p5EbZy81FzACK+ne7cQrw+fKIKwfoFBkDwMGZ55KBAc4UdgfJRlSzUtsNYjT5
	twuXwgHHglqvw0oZ6gQxyJ9HgKeJGx/SKB9Qqew==
X-Google-Smtp-Source: AGHT+IHkCjlJ1Ork2YzV2vUina+G6VUcdyH2F7b53k1VNHr+4oxJBQtqCCHmKO52hvCGKGXtvd0wnQ==
X-Received: by 2002:a05:6000:26c9:b0:3a5:7991:fee with SMTP id ffacd0b85a97d-3b496607b78mr1851886f8f.14.1751722563450;
        Sat, 05 Jul 2025 06:36:03 -0700 (PDT)
Received: from pop-os.localdomain (175.77.11.37.dynamic.jazztel.es. [37.11.77.175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030bc5asm5001457f8f.20.2025.07.05.06.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 06:36:02 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	francesco@dolcini.it,
	thomas.weissschuh@linutronix.de,
	tglx@linutronix.de,
	johannes.berg@intel.com,
	mingo@kernel.org,
	christophe.jaillet@wanadoo.fr,
	skhan@linuxfoundation.org,
	=?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
Subject: [PATCH] mwifiex: replace deprecated strcpy() with strscpy()
Date: Sat,  5 Jul 2025 15:36:00 +0200
Message-Id: <20250705133600.186441-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

strcpy() is deprecated for NUL-terminated strings because it may overflow
the destination buffer and does not guarantee termination.  strscpy()
avoids these issues.

adapter->fw_name is a fixed-size char array (64 bytes).  All source
strings copied here are bounded literals or validated inputs, so no
return-value handling is required.

Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/pcie.c | 40 ++++++++++++++-------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index a760de191fce..2aad9ab210e0 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -3098,9 +3098,8 @@ static int mwifiex_pcie_request_irq(struct mwifiex_adapter *adapter)
 }
 
 /*
- * This function gets the firmware name for downloading by revision id
- *
- * Read revision id register to get revision id
+ * Get firmware name for download by revision id
+ * Uses strscpy() to ensure NUL-termination and avoid overflow.
  */
 static void mwifiex_pcie_get_fw_name(struct mwifiex_adapter *adapter)
 {
@@ -3110,39 +3109,56 @@ static void mwifiex_pcie_get_fw_name(struct mwifiex_adapter *adapter)
 
 	switch (card->dev->device) {
 	case PCIE_DEVICE_ID_MARVELL_88W8766P:
-		strcpy(adapter->fw_name, PCIE8766_DEFAULT_FW_NAME);
+		strscpy(adapter->fw_name,
+			PCIE8766_DEFAULT_FW_NAME,
+			sizeof(adapter->fw_name));
 		break;
+
 	case PCIE_DEVICE_ID_MARVELL_88W8897:
 		mwifiex_write_reg(adapter, 0x0c58, 0x80c00000);
 		mwifiex_read_reg(adapter, 0x0c58, &revision_id);
 		revision_id &= 0xff00;
+
 		switch (revision_id) {
 		case PCIE8897_A0:
-			strcpy(adapter->fw_name, PCIE8897_A0_FW_NAME);
+			strscpy(adapter->fw_name,
+				PCIE8897_A0_FW_NAME,
+				sizeof(adapter->fw_name));
 			break;
 		case PCIE8897_B0:
-			strcpy(adapter->fw_name, PCIE8897_B0_FW_NAME);
+			strscpy(adapter->fw_name,
+				PCIE8897_B0_FW_NAME,
+				sizeof(adapter->fw_name));
 			break;
 		default:
-			strcpy(adapter->fw_name, PCIE8897_DEFAULT_FW_NAME);
-
+			strscpy(adapter->fw_name,
+				PCIE8897_DEFAULT_FW_NAME,
+				sizeof(adapter->fw_name));
 			break;
 		}
 		break;
+
 	case PCIE_DEVICE_ID_MARVELL_88W8997:
 		mwifiex_read_reg(adapter, 0x8, &revision_id);
 		mwifiex_read_reg(adapter, 0x0cd0, &version);
 		mwifiex_read_reg(adapter, 0x0cd4, &magic);
+
 		revision_id &= 0xff;
-		version &= 0x7;
-		magic &= 0xff;
+		version     &= 0x7;
+		magic       &= 0xff;
+
 		if (revision_id == PCIE8997_A1 &&
 		    magic == CHIP_MAGIC_VALUE &&
 		    version == CHIP_VER_PCIEUART)
-			strcpy(adapter->fw_name, PCIEUART8997_FW_NAME_V4);
+			strscpy(adapter->fw_name,
+				PCIEUART8997_FW_NAME_V4,
+				sizeof(adapter->fw_name));
 		else
-			strcpy(adapter->fw_name, PCIEUSB8997_FW_NAME_V4);
+			strscpy(adapter->fw_name,
+				PCIEUSB8997_FW_NAME_V4,
+				sizeof(adapter->fw_name));
 		break;
+
 	default:
 		break;
 	}
-- 
2.34.1


