Return-Path: <linux-wireless+bounces-9848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 161B1923E0C
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 14:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF80F1F23139
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 12:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6124D15DBAB;
	Tue,  2 Jul 2024 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frelon.se header.i=@frelon.se header.b="UUjwh08W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.outgoing.loopia.se (smtp.outgoing.loopia.se [93.188.3.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBBB15B14C
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.3.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924084; cv=none; b=GsYCxMgbWvInpRmb94dg26gMOXvz5JcUH68ZfBDYOHl9us46ONf2i2DpduiIhxmCU1+ZJgIpA43rKWuswQeyCX1EBUGxGR355gV4IEFzE7WiI6u3je4e5L6u2+pRQu+Srg+Ajcxl81aAVHDxwFpYYimFsTa3pY3KspcZBd9St14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924084; c=relaxed/simple;
	bh=3zCcAstELY1r9IVMmZDh1lUwRBnQSkuTsIIph7TQZvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WiyQ0PTpbzDks7pJBZivvo47Iszqoo5YPHZQAlNH2/yrUQnLQTPdicxJT1p6AW72ve2eB4iQC44CgRtBhK0BGa5ErSePJCtFPt6VJxlCpEbKM0QEib89KaJWIIqpDJLNzjtw2fYck19/YvdfSSeUpIvCkI4Dv/HP+e34Tt+7E8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=frelon.se; spf=pass smtp.mailfrom=frelon.se; dkim=pass (2048-bit key) header.d=frelon.se header.i=@frelon.se header.b=UUjwh08W; arc=none smtp.client-ip=93.188.3.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=frelon.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frelon.se
Received: from s807.loopia.se (localhost [127.0.0.1])
	by s807.loopia.se (Postfix) with ESMTP id A2F6E3028E6A
	for <linux-wireless@vger.kernel.org>; Tue, 02 Jul 2024 14:31:40 +0200 (CEST)
Received: from s979.loopia.se (unknown [172.22.191.5])
	by s807.loopia.se (Postfix) with ESMTP id 91CE22E2B06D;
	Tue, 02 Jul 2024 14:31:40 +0200 (CEST)
Received: from s470.loopia.se (unknown [172.22.191.6])
	by s979.loopia.se (Postfix) with ESMTP id 8FB1C10BC553;
	Tue, 02 Jul 2024 14:31:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1.2
X-Spam-Level:
Authentication-Results: s470.loopia.se (amavisd-new); dkim=pass (2048-bit key)
 header.d=frelon.se
Received: from s899.loopia.se ([172.22.191.5])
 by s470.loopia.se (s470.loopia.se [172.22.190.34]) (amavisd-new, port 10024)
 with UTF8LMTP id qx_XX6333UFS; Tue,  2 Jul 2024 14:31:40 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: fredrik@frelon.se
X-Loopia-Originating-IP: IPv6:2001:2042:34bd:7800:4e1d:96ff:fe79:894d
Received: from frelon.se (unknown [IPv6:2001:2042:34bd:7800:4e1d:96ff:fe79:894d])
	(Authenticated sender: fredrik@frelon.se)
	by s899.loopia.se (Postfix) with ESMTPSA id 150FD2C8BA98;
	Tue, 02 Jul 2024 14:31:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=frelon.se;
	s=loopiadkim1707342414; t=1719923500;
	bh=Ftj2lhmVvSVSrnHCWs3/uFd1rZPl9d1w3Yyy0lkezX8=;
	h=From:To:Cc:Subject:Date;
	b=UUjwh08WhmIiysEpdW+BtqzE5dZwjyj6tw+TBtgOQdQbo9P5qKTQC8ZCeMtIQynMB
	 qCjqo6msI9SFVl1schHYFCFH/QQOQruG19GDrXl9WxzMCQ0PIH8jX0QA+aHe0opBHJ
	 5ElIprnaFfWgaEnCRh10nKaRi52Wyo+p4uzocgQ9iExFpr9FY9iDpiv45/EYW4tNbn
	 E65VNEr5Xu9f05hhyuVeqdpnzX9hmHAYrUf5tx8jXluyhld4rr2aBEy6E3DZFq94HF
	 2nc+QVNMrfYiLYf6nZXKN0gHTRzkXi/fuX7eYPOyW/otR1cviZUOzKJ0bWZVHUgRyu
	 qNXZab2OmvVdQ==
From: =?UTF-8?q?Fredrik=20L=C3=B6nnegren?= <fredrik@frelon.se>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: =?UTF-8?q?Fredrik=20L=C3=B6nnegren?= <fredrik@frelon.se>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtlwifi: fix comment typo
Date: Tue,  2 Jul 2024 14:30:44 +0200
Message-ID: <20240702123048.14829-1-fredrik@frelon.se>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Change 'defult' to 'default' in comments in several rtlwifi drivers.

Signed-off-by: Fredrik Lönnegren <fredrik@frelon.se>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c
index 37bb59fa8bfa..35875cda30fc 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c
@@ -27,7 +27,7 @@ static void rtl88e_init_aspm_vars(struct ieee80211_hw *hw)
 	 * 2 - Enable ASPM with Clock Req,
 	 * 3 - Alwyas Enable ASPM with Clock Req,
 	 * 4 - Always Enable ASPM without Clock Req.
-	 * set defult to RTL8192CE:3 RTL8192E:2
+	 * set default to RTL8192CE:3 RTL8192E:2
 	 */
 	rtlpci->const_pci_aspm = 3;
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c
index e20f2bec45c4..ce7c28d9c874 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c
@@ -31,7 +31,7 @@ static void rtl92c_init_aspm_vars(struct ieee80211_hw *hw)
 	 * 2 - Enable ASPM with Clock Req,
 	 * 3 - Alwyas Enable ASPM with Clock Req,
 	 * 4 - Always Enable ASPM without Clock Req.
-	 * set defult to RTL8192CE:3 RTL8192E:2
+	 * set default to RTL8192CE:3 RTL8192E:2
 	 * */
 	rtlpci->const_pci_aspm = 3;
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c
index 5f6311c2aac4..1b7a08315fc9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c
@@ -32,7 +32,7 @@ static void rtl92d_init_aspm_vars(struct ieee80211_hw *hw)
 	 * 2 - Enable ASPM with Clock Req,
 	 * 3 - Alwyas Enable ASPM with Clock Req,
 	 * 4 - Always Enable ASPM without Clock Req.
-	 * set defult to RTL8192CE:3 RTL8192E:2
+	 * set default to RTL8192CE:3 RTL8192E:2
 	 * */
 	rtlpci->const_pci_aspm = 3;
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c
index 7bde20fdbeab..162e734d5b08 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c
@@ -31,7 +31,7 @@ static void rtl92ee_init_aspm_vars(struct ieee80211_hw *hw)
 	 * 2 - Enable ASPM with Clock Req,
 	 * 3 - Alwyas Enable ASPM with Clock Req,
 	 * 4 - Always Enable ASPM without Clock Req.
-	 * set defult to RTL8192CE:3 RTL8192E:2
+	 * set default to RTL8192CE:3 RTL8192E:2
 	 */
 	rtlpci->const_pci_aspm = 3;
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
index 675bdd32feb1..bbf8ff63dced 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
@@ -27,7 +27,7 @@ static void rtl92s_init_aspm_vars(struct ieee80211_hw *hw)
 	 * 2 - Enable ASPM with Clock Req,
 	 * 3 - Alwyas Enable ASPM with Clock Req,
 	 * 4 - Always Enable ASPM without Clock Req.
-	 * set defult to RTL8192CE:3 RTL8192E:2
+	 * set default to RTL8192CE:3 RTL8192E:2
 	 * */
 	rtlpci->const_pci_aspm = 2;
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c
index dd7505e2f22c..1b144fbd4d26 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c
@@ -33,7 +33,7 @@ static void rtl8723e_init_aspm_vars(struct ieee80211_hw *hw)
 	 * 2 - Enable ASPM with Clock Req,
 	 * 3 - Alwyas Enable ASPM with Clock Req,
 	 * 4 - Always Enable ASPM without Clock Req.
-	 * set defult to RTL8192CE:3 RTL8192E:2
+	 * set default to RTL8192CE:3 RTL8192E:2
 	 */
 	rtlpci->const_pci_aspm = 3;
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
index 162c34f0e9b7..0a92d0325098 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
@@ -32,7 +32,7 @@ static void rtl8723be_init_aspm_vars(struct ieee80211_hw *hw)
 	 * 2 - Enable ASPM with Clock Req,
 	 * 3 - Alwyas Enable ASPM with Clock Req,
 	 * 4 - Always Enable ASPM without Clock Req.
-	 * set defult to RTL8192CE:3 RTL8192E:2
+	 * set default to RTL8192CE:3 RTL8192E:2
 	 */
 	rtlpci->const_pci_aspm = 3;
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c
index 7b911695db33..a65503c5ae5a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c
@@ -30,7 +30,7 @@ static void rtl8821ae_init_aspm_vars(struct ieee80211_hw *hw)
 	 * 2 - Enable ASPM with Clock Req,
 	 * 3 - Alwyas Enable ASPM with Clock Req,
 	 * 4 - Always Enable ASPM without Clock Req.
-	 * set defult to RTL8192CE:3 RTL8192E:2
+	 * set default to RTL8192CE:3 RTL8192E:2
 	 */
 	rtlpci->const_pci_aspm = 3;
 
-- 
2.45.2


