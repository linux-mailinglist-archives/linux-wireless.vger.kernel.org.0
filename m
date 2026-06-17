Return-Path: <linux-wireless+bounces-37860-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9rO1LHl0Mmr/0AUAu9opvQ
	(envelope-from <linux-wireless+bounces-37860-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 12:18:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10764698688
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 12:18:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=mail header.b=UE+GBX2c;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37860-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37860-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=collabora.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E30F3007CAF
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 10:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE0E3D904D;
	Wed, 17 Jun 2026 10:13:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F33396B6F;
	Wed, 17 Jun 2026 10:13:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691239; cv=none; b=MlLGUcmVNsHqG4A819xpTPbeHJYdY/DatMZDNotHuFfZRfLaOEYj8ToKxaq9bmm08g6ijOhfcdyM3RrNi92KYhq8/E+slDx4AzLDSY3xKKiwZi0cKJaPH7jymAqg70Zz1zh+wXLc8r9tmxx/2+MLq0zaL67C+guycKXrDuQtZUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691239; c=relaxed/simple;
	bh=rkwBjmPoD+dUzWFR7oHzelpUn+a8FZtpycObugGRr0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NBJI7L9khnyWAg0lnIqUlLun3iPIuxu4GWuxRt2WdizdmKJR1niqJTRqxZBgttBJ6bJaapipk/UQ6CT2Ob3VkUHoKCZn9kdLekKQgcSPI3o++q6P0YLn/LuZbCXnNAZ9ioKlXavE/0gE+gQwmxYN/npaPA5ige5wnpRMy+MBivA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UE+GBX2c; arc=none smtp.client-ip=148.251.105.195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1781691236;
	bh=rkwBjmPoD+dUzWFR7oHzelpUn+a8FZtpycObugGRr0c=;
	h=From:Date:Subject:To:Cc:From;
	b=UE+GBX2cPhfFqo3rMN9yx/YgyDBv1O8uZutA/3u1pKk29/9VANOxvhWAnyj3g9iHe
	 CUW/U3jYXFDErGpZNwBQd2lKCyS6OPnSUzqpcLCCGTLO4zRkJLIv8Q7XPmiAt1X0xZ
	 Ho+hhbYmy0qlyAfGL+Lj1SjKePTPU91ZDRhYB6VrlNnbavBUTqMxydDyqB/BjAxIpg
	 zqsaoTAuiV4BAjVHzkIffplWeX50bXMH2+45YDa3QCQ34NPtlP89IWCYQoOwAK8EV/
	 Cdg2lejn3+Z8l/Sm6YpTEXAtBbD5JkYedNYaKz2XUFjswA0n9Ud2pBuszuoH7cqZgt
	 EnTetpirjwO7g==
Received: from [192.168.1.156] (unknown [100.64.1.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mattl)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E1E0217E01B6;
	Wed, 17 Jun 2026 12:13:55 +0200 (CEST)
From: Matthew Leach <matthew.leach@collabora.com>
Date: Wed, 17 Jun 2026 11:13:24 +0100
Subject: [PATCH] wifi: rtw89: regd: fix ww domain blocking on 6GHz
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-rtw89-6ghz-regd-fixes-v1-1-33d744a07d16@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAyF4auQrmkyw6KpXsW4EKYMdYGmRSAQ7
 s6oyy8v/9vBxVQcrtUOJrO6vsaCWFfQDY8xC2oqhiY0FCgS2rTwBSkPG5rkhL2u4pi450jMoU0
 BSvs2+Q0lvd3/9k/7lG76nsFxnMn28n15AAAA
X-Change-ID: 20260616-rtw89-6ghz-regd-fixes-d8f816880bd0
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Matthew Leach <matthew.leach@collabora.com>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kernel@collabora.com,m:matthew.leach@collabora.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[matthew.leach@collabora.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37860-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.leach@collabora.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,collabora.com:dkim,collabora.com:email,collabora.com:mid,collabora.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10764698688

The current code keeps a separate instance for the ww reg domain outside
the static map, and treats rtw89_regd_get_index() returning
RTW89_REGD_MAX_COUNTRY_NUM as the index for the ww domain. This
conflates the "not found" sentinel with a real index and causes the
block_* bitmap lookups to skip ww entirely, explicitly blocking 6GHz on
the ww domain rather than deferring to the kernel regulatory policy.

Fold the standalone rtw89_ww_regd into rtw89_regd_map[0] and drop the
special case in rtw89_regd_get_index() that returned
RTW89_REGD_MAX_COUNTRY_NUM for ww. rtw89_regd_find_reg_by_name() now
returns NULL on miss, and its callers either translate that into the
RTW89_REGD_MAX_COUNTRY_NUM sentinel (rtw89_regd_get_index_by_name()) or
fall back to the ww entry explicitly (rtw89_regd_notifier_apply()). With
ww living at a real index, the block-list checks apply and 6GHz is no
longer unconditionally blocked for ww.

Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
---
 drivers/net/wireless/realtek/rtw89/regd.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 28466cb35ea2..698b8b7f6129 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -21,10 +21,8 @@ void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request
 
 static_assert(BITS_PER_TYPE(unsigned long) >= NUM_OF_RTW89_REGD_FUNC);
 
-static const struct rtw89_regd rtw89_ww_regd =
-	COUNTRY_REGD("00", RTW89_WW, RTW89_WW, RTW89_WW, 0x0);
-
 static const struct rtw89_regd rtw89_regd_map[] = {
+	COUNTRY_REGD("00", RTW89_WW, RTW89_WW, RTW89_WW, 0x0),
 	COUNTRY_REGD("AR", RTW89_MEXICO, RTW89_MEXICO, RTW89_FCC, 0x0),
 	COUNTRY_REGD("BO", RTW89_FCC, RTW89_FCC, RTW89_NA, 0x0),
 	COUNTRY_REGD("BR", RTW89_FCC, RTW89_FCC, RTW89_FCC, 0x0),
@@ -316,12 +314,13 @@ static const struct rtw89_regd *rtw89_regd_find_reg_by_name(struct rtw89_dev *rt
 			return &regd_ctrl->map[i];
 	}
 
-	return &rtw89_ww_regd;
+	return NULL;
 }
 
 static bool rtw89_regd_is_ww(const struct rtw89_regd *regd)
 {
-	return regd == &rtw89_ww_regd;
+	/* Index 0 in the static map contains the WW domain entry. */
+	return regd == &rtw89_regd_map[0];
 }
 
 static u8 rtw89_regd_get_index(struct rtw89_dev *rtwdev, const struct rtw89_regd *regd)
@@ -331,9 +330,6 @@ static u8 rtw89_regd_get_index(struct rtw89_dev *rtwdev, const struct rtw89_regd
 
 	BUILD_BUG_ON(ARRAY_SIZE(rtw89_regd_map) > RTW89_REGD_MAX_COUNTRY_NUM);
 
-	if (rtw89_regd_is_ww(regd))
-		return RTW89_REGD_MAX_COUNTRY_NUM;
-
 	return regd - regd_ctrl->map;
 }
 
@@ -342,6 +338,10 @@ static u8 rtw89_regd_get_index_by_name(struct rtw89_dev *rtwdev, const char *alp
 	const struct rtw89_regd *regd;
 
 	regd = rtw89_regd_find_reg_by_name(rtwdev, alpha2);
+
+	if (!regd)
+		return RTW89_REGD_MAX_COUNTRY_NUM;
+
 	return rtw89_regd_get_index(rtwdev, regd);
 }
 
@@ -721,7 +721,7 @@ int rtw89_regd_init_hint(struct rtw89_dev *rtwdev)
 		return -EINVAL;
 
 	chip_regd = rtw89_regd_find_reg_by_name(rtwdev, rtwdev->efuse.country_code);
-	if (!rtw89_regd_is_ww(chip_regd)) {
+	if (chip_regd && !rtw89_regd_is_ww(chip_regd)) {
 		rtwdev->regulatory.regd = chip_regd;
 		rtwdev->regulatory.programmed = true;
 
@@ -859,7 +859,15 @@ static void rtw89_regd_notifier_apply(struct rtw89_dev *rtwdev,
 				      struct wiphy *wiphy,
 				      struct regulatory_request *request)
 {
-	rtwdev->regulatory.regd = rtw89_regd_find_reg_by_name(rtwdev, request->alpha2);
+	const struct rtw89_regd *regd = rtw89_regd_find_reg_by_name(rtwdev, request->alpha2);
+
+	if (!regd) {
+		/* Fallback to WW domain if name not found. */
+		regd = &rtw89_regd_map[0];
+	}
+
+	rtwdev->regulatory.regd = regd;
+
 	/* This notification might be set from the system of distros,
 	 * and it does not expect the regulatory will be modified by
 	 * connecting to an AP (i.e. country ie).

---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20260616-rtw89-6ghz-regd-fixes-d8f816880bd0

Best regards,
--  
Matt


