Return-Path: <linux-wireless+bounces-832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2CC81486C
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 13:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C78D285E66
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 12:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6792C2D7AD;
	Fri, 15 Dec 2023 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="aK+qwXHz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward206b.mail.yandex.net (forward206b.mail.yandex.net [178.154.239.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4472D7AF
	for <linux-wireless@vger.kernel.org>; Fri, 15 Dec 2023 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d100])
	by forward206b.mail.yandex.net (Yandex) with ESMTP id B317767B92
	for <linux-wireless@vger.kernel.org>; Fri, 15 Dec 2023 15:43:49 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:47a7:0:640:b27a:0])
	by forward100c.mail.yandex.net (Yandex) with ESMTP id 0F68360A9B;
	Fri, 15 Dec 2023 15:43:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ehk5Ww9j9W20-wk05bFhJ;
	Fri, 15 Dec 2023 15:43:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1702644221; bh=e2HQD4mudrWDZrwhKgt9BFW3NWj+RbEkZP28WFvmv30=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=aK+qwXHzK2ZW1y2gzVurF3Dhvp56V7cJ8iRnEvj5fmwzJIDA8a+rUZmaRcKrehaMO
	 2NQTejmXs27O44b2/l3jmjyYhnrM7yCtfy5APzzat8VkDOR0Xd70e+NOXZtv5PL9Mn
	 LMjxn5jZ2GNFWe4igzLuucI/+bpUD9yaru9L8KE8=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Brian Norris <briannorris@chromium.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/3] wifi: cfg80211: introduce cfg80211_ssid_eq()
Date: Fri, 15 Dec 2023 15:38:51 +0300
Message-ID: <20231215123859.196350-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since SSIDs comparison is commonly used across many drivers, introduce
generic 'cfg80211_ssid_eq()' to replace driver-private implementations.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 include/net/cfg80211.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 602960dafe0f..4d76868c954d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7165,6 +7165,23 @@ enum cfg80211_bss_frame_type {
 int cfg80211_get_ies_channel_number(const u8 *ie, size_t ielen,
 				    enum nl80211_band band);
 
+/**
+ * cfg80211_ssid_eq - compare two SSIDs
+ * @a: first SSID
+ * @b: second SSID
+ *
+ * Return true if SSIDs are equal, false otherwise.
+ */
+static inline bool
+cfg80211_ssid_eq(struct cfg80211_ssid *a, struct cfg80211_ssid *b)
+{
+	if (WARN_ON(!a || !b))
+		return false;
+	if (a->ssid_len != b->ssid_len)
+		return false;
+	return memcmp(a->ssid, b->ssid, a->ssid_len) ? false : true;
+}
+
 /**
  * cfg80211_inform_bss_data - inform cfg80211 of a new BSS
  *
-- 
2.43.0


