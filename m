Return-Path: <linux-wireless+bounces-20198-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45169A5D2CD
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 23:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068F4189D12B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 22:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D944C226545;
	Tue, 11 Mar 2025 22:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpwGlMr2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1DC1C6FFD;
	Tue, 11 Mar 2025 22:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741733769; cv=none; b=gmvQfKBBFdGYU1ummM/ZGCBitIK8HZQlI1OdX1+PufGE6MX375oF+3c/7pBCr3qh3l1BxUXnB9O1Kfrg0XzJnXycHW5R/cF/DqXbTw07E3Wt6nzR5V+d+4ExYAbmkIzsGw4US+vAIERN03WsJtk872NLW2WSuZRsqB0Q2AIKQM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741733769; c=relaxed/simple;
	bh=XxAgClsxKPG2KmlxHQuyMZEpZ99q9TU35MBOea//jvI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wsaw/CbQvgLqRV+L74/qBHh/VrildJNSsGxzuUjpUCzAtzkD+lQR2kWg29c41Q6l76TSYyOsrue1mqxuo6lZ8yzFBorfksRuGgNNxP8wY69cZ6fP3V5oQkmi4BwnXODPWvwa3nd7qV4JVrp7M0x3pTA7CJ3v2Rty+M2CvjvClp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpwGlMr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3B1C4CEE9;
	Tue, 11 Mar 2025 22:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741733769;
	bh=XxAgClsxKPG2KmlxHQuyMZEpZ99q9TU35MBOea//jvI=;
	h=From:To:Cc:Subject:Date:From;
	b=OpwGlMr26zqb+vRuXVzpw/FhE32HmjpQdcf8hOvnFr1s3CM/ZiibCT748ozyLeDlZ
	 YWMbSf1ihwQ0DhefwJV7k/AZfkn0EKGpUh2ZAP1H4Gsj4jVhuQX3r3YwzGGKcuLi4F
	 aAU/RxrsXGgb63p6oANUx1h0kXPpk7HpPiBtmf3dhOxhlEOivSIT1boAe2gF809QY4
	 WvCnG/YR23Uy2zZnP+D7HkacUOKzxgLoirHQD1ec8ot7hW8dsej++8mC+K5W2UBKt4
	 rO2H1a2iZ+D6cITFrX7mbh5XW45fLSW+i5jgn6kbBWSC2yw61laOgGMzfv0ykIs6j5
	 fJB1tSwE3GHfg==
From: Kees Cook <kees@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kees Cook <kees@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	En-Wei Wu <en-wei.wu@canonical.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] wifi: virt_wifi: Add __nonstring annotations for unterminated strings
Date: Tue, 11 Mar 2025 15:56:05 -0700
Message-Id: <20250311225604.it.926-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357; i=kees@kernel.org; h=from:subject:message-id; bh=XxAgClsxKPG2KmlxHQuyMZEpZ99q9TU35MBOea//jvI=; b=owGbwMvMwCVmps19z/KJym7G02pJDOkX9rf0fvk/9XYCx74v2Vv8Z1yoVPdSKC8XjVG9HCcbu bnMTPl5RykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwER2XmP4p2a1y16mc45/5c1P p7+o523NY+G0/hrAuvNX66uqZ9tvrGP4X/qNiWnaaz89iR0Py2L+VmpaSS2wNv0w48juPcb3tOf uZAYA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When a character array without a terminating NUL character has a static
initializer, GCC 15's -Wunterminated-string-initialization will only
warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
with __nonstring to and correctly identify the char array as "not a C
string" and thereby eliminate the warning.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v1: https://lore.kernel.org/lkml/20250310222318.work.395-kees@kernel.org/
 v2: correctly split and fix subject
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: En-Wei Wu <en-wei.wu@canonical.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/virtual/virt_wifi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
index 4ee374080466..fc122b79301a 100644
--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -146,7 +146,7 @@ static void virt_wifi_inform_bss(struct wiphy *wiphy)
 	static const struct {
 		u8 tag;
 		u8 len;
-		u8 ssid[8];
+		u8 ssid[8] __nonstring;
 	} __packed ssid = {
 		.tag = WLAN_EID_SSID,
 		.len = VIRT_WIFI_SSID_LEN,
-- 
2.34.1


