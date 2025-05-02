Return-Path: <linux-wireless+bounces-22323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DF5AA6ED4
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5FE21BC3A57
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 10:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979B5238C12;
	Fri,  2 May 2025 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="RvVqmUAp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C871EE03C
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746180248; cv=none; b=soRt7Asb4m/ysZADpakccGgcjcyOVsA0QjP4ClvGm9/4ZqW+Jq7mOMnAlz7DyV2+PwWfPiDjK/nxN3OCbcW4k9/CKnJY7z04EZbCQZrcIcoDzoV1WJSlCCCMAg9SOeWUAD5UXRAPJWuGwjupaSYTiDlOj4Sv4X4fJSzAEx7uX3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746180248; c=relaxed/simple;
	bh=a+4NTP7GAXZxu26Q7gR9o+DTZj2sBGxCE8Et4DTkVLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qqCDBV72bb/f+2jD+FoOm/s/Ku4LqxxzyuFO3U84AB/EWHQtN/mj/QFBQ7eObT84piHsWcyVnUweY5syKC64CmdO86uGSJU3y8ax+zOPhyZ1zubAH3LBi0G9/MpPANbszC/l96UAZ6l7HEqx/7vmA7BcBmBYHrNLL/EslD41ySA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=RvVqmUAp; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 24179 invoked from network); 2 May 2025 12:03:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1746180234; bh=JxgIDUsaIMgLK10xPZb5AYDJC+rfdHR+oalBdnFri1g=;
          h=From:To:Cc:Subject;
          b=RvVqmUAp6CEBPtUFED5hYrTeu3I5G82Vg3yfqgG5xYD4C06+YWv4JEZ4t2ORlTzsi
           abcepRhyyFjJ2Yy+QOOljw3/PdK0/lMaHnoZL0XYD7ONDbSzDJTwavsu7MY4wy1eti
           /XD7OFUQnQjJgRTzifZ0ctzCVa/QpB168biXAJrvyyO/rsqSMY4F8nHhA9/cTOl9Dt
           G2IYTt1hiJeSJt8WvOLApEiTgdp1HJ0TXQAiVwVE+WHocBO1BNLMFrC1HFJVRJKHo9
           QcHUubUqFoMujfDsEx5Y0HWQ6UgqvUOU5SBgOryUuWpzy6mUsMhbU5MSijzl7XMJxb
           kI0JNKuLLgAkg==
Received: from 83.5.150.21.ipv4.supernova.orange.pl (HELO laptop-olek.home) (olek2@wp.pl@[83.5.150.21])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <johannes.berg@intel.com>; 2 May 2025 12:03:54 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: johannes.berg@intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH iw] iw: scan: Add printing of EHT Operation Element
Date: Fri,  2 May 2025 12:03:53 +0200
Message-Id: <20250502100353.3149470-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 728dea30b0664b2579c9c2915b3f293e
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [YYN0]                               

Add ability to print out EHT capabilities from AP beacons.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 ieee80211.h |  1 +
 iw.h        |  1 +
 scan.c      |  8 +++++++
 util.c      | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/ieee80211.h b/ieee80211.h
index 1e29371..c31041e 100644
--- a/ieee80211.h
+++ b/ieee80211.h
@@ -99,6 +99,7 @@ enum elem_id {
 enum elem_id_ext {
 	EID_EXT_HE_CAPABILITY		= 35,
 	EID_EXT_HE_OPERATION		= 36,
+	EID_EXT_EHT_OPERATION		= 106,
 	EID_EXT_EHT_CAPABILITY		= 108,
 };
 
diff --git a/iw.h b/iw.h
index b8caccd..a423431 100644
--- a/iw.h
+++ b/iw.h
@@ -247,6 +247,7 @@ void print_he_operation(const uint8_t *ie, int len);
 void print_he_info(struct nlattr *nl_iftype);
 void print_eht_capability(const uint8_t *ie, int len, const uint8_t *he_cap,
 			  bool from_ap);
+void print_eht_operation(const uint8_t *ie, int len);
 void print_eht_info(struct nlattr *nl_iftype, int band);
 void print_s1g_capability(const uint8_t *caps);
 
diff --git a/scan.c b/scan.c
index 748ead1..263d2e3 100644
--- a/scan.c
+++ b/scan.c
@@ -2426,10 +2426,18 @@ static void print_eht_capa(const uint8_t type, uint8_t len,
 	print_eht_capability(data, len, ctx->he_cap, ctx->from_ap);
 }
 
+static void print_eht_oper(const uint8_t type, uint8_t len, const uint8_t *data,
+			   const struct ie_context *ctx)
+{
+	printf("\n");
+	print_eht_operation(data, len);
+}
+
 static const struct ie_print ext_printers[] = {
 	[EID_EXT_HE_CAPABILITY] = { "HE capabilities", print_he_capa, 21, 54, BIT(PRINT_SCAN), },
 	[EID_EXT_HE_OPERATION] = { "HE Operation", print_he_oper, 6, 15, BIT(PRINT_SCAN), },
 	[EID_EXT_EHT_CAPABILITY] = { "EHT capabilities", print_eht_capa, 13, 30, BIT(PRINT_SCAN), },
+	[EID_EXT_EHT_OPERATION] = { "EHT Operation", print_eht_oper, 5, 10, BIT(PRINT_SCAN), },
 };
 
 static void print_extension(unsigned char len, unsigned char *ie,
diff --git a/util.c b/util.c
index c6d5974..e285e20 100644
--- a/util.c
+++ b/util.c
@@ -1924,6 +1924,68 @@ void print_he_operation(const uint8_t *ie, int len)
 	}
 }
 
+void print_eht_operation(const uint8_t *ie, int len)
+{
+	uint8_t oper_parameters = ie[0];
+	uint8_t disabled_subchannel_info_present = oper_parameters & 0x02;
+	uint8_t eht_operation_info_present = oper_parameters & 0x01;
+
+	printf("\t\tEHT Operation Parameters: (0x%02x)\n",
+	       oper_parameters);
+
+	if (oper_parameters & 0x04)
+		printf("\t\t\tEHT Default PE Duration\n");
+
+	if (oper_parameters & 0x08)
+		printf("\t\t\tGroup Addressed BU Indication Limit\n");
+
+	printf("\t\t\tGroup Addressed BU Indication Exponent: 0x%01x\n",
+	       (oper_parameters >> 4 & 3));
+
+	printf("\t\tBasic EHT-MCS And Nss Set: 0x");
+	for (uint8_t i = 0; i < 4; i++)
+		printf("%02x", ie[1 + i]);
+
+	printf("\n");
+
+	if (eht_operation_info_present) {
+		uint8_t offset = 5;
+		const uint8_t control = ie[offset];
+		uint8_t eht_operation_info_len = 3;
+
+		if (disabled_subchannel_info_present)
+			eht_operation_info_len += 2;
+
+		if (len - offset < eht_operation_info_len) {
+			printf("\t\tEHT Operation Info: Invalid\n");
+			return;
+		}
+
+		printf("\t\tEHT Operation Info: 0x");
+		for (uint8_t i = 0; i < eht_operation_info_len; i++)
+			printf("%02x", ie[offset + i]);
+
+		printf("\n");
+		printf("\t\t\tChannel Width: ");
+		switch (control & 0x7) {
+		case 0: printf("20 MHz\n"); break;
+		case 1: printf("40 MHz\n"); break;
+		case 2: printf("80 MHz\n"); break;
+		case 3: printf("160 MHz\n"); break;
+		case 4: printf("320 MHz\n"); break;
+		}
+
+		printf("\t\t\tCenter Frequency Segment 0: %hhu\n",
+		       ie[offset + 1]);
+		printf("\t\t\tCenter Frequency Segment 1: %hhu\n",
+		       ie[offset + 2]);
+
+		if (disabled_subchannel_info_present)
+			printf("\t\t\tDisabled Subchannel Bitmap: 0x%02x%02x\n",
+			       ie[offset + 3], ie[offset + 4]);
+	}
+}
+
 void iw_hexdump(const char *prefix, const __u8 *buf, size_t size)
 {
 	size_t i;
-- 
2.39.5


