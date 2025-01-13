Return-Path: <linux-wireless+bounces-17429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1ABA0BCC9
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 17:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0113A1663
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 16:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CAA24023E;
	Mon, 13 Jan 2025 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="nDl6nTUF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward205d.mail.yandex.net (forward205d.mail.yandex.net [178.154.239.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C1F84A5B
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784057; cv=none; b=iENbp4JocPq8ke7MFhIWEyHIgeVdEx/xi0II/wSeHLxC/HZNLWXonZCyvX50P9VG0x0aaJShms3T9A+b15ZHoQi5LvWHsi2si82dfzqTThReVTitzvMtMijdXbUB6205cEmMOkZPertix19vboklxRRE0/W8VmeUq18L3Yk0gcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784057; c=relaxed/simple;
	bh=vU3D55ymX5v/SgC7cidB8ss3hc0oJXc307oTPEzeOdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osg8bFRCZOyTnyz3rXPHLLSUEoIIk0QY9xRctOsn8zJDfpLKXgjR/pD3e3aa6ENsLoytm/XrEQvH0sC5RswDTZdRJuFpH6mvXuEtshBKKaxLpDQVNg3MODitiLAAxeyEapmxVh3rdujw3oWPzGBN+jLniwcyVXLWfJdso8/oKCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=nDl6nTUF; arc=none smtp.client-ip=178.154.239.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d100])
	by forward205d.mail.yandex.net (Yandex) with ESMTPS id C1A56638CB
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 18:54:26 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:108e:0:640:8d65:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id A8E286092C;
	Mon, 13 Jan 2025 18:54:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id HsQnFbLOjeA0-ZcGwUVPm;
	Mon, 13 Jan 2025 18:54:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1736783658; bh=/OlYC0nuhIImk++oD2evx8M+YOvn1MvUb7MyW/0dyPg=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=nDl6nTUFA20wVYhpmz/2E4gMLx1l4pmKvx5Ps8a1Y7u1mzvy8GqHR84CjYMX+52RN
	 a1mcPlnBLjQ8dLq/C++k4nMFIQclJN5aWmaxSD0MBnS7F/Z8uydCvBVRZ0hDmWlR5b
	 KDTTlhf2le/nYb88csqSDESft1gEHRT3Iofftwx0=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Tova Mussai <tova.mussai@intel.com>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2] wifi: cfg80211: adjust allocation of colocated AP data
Date: Mon, 13 Jan 2025 18:54:17 +0300
Message-ID: <20250113155417.552587-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <5113a67ae69d32e03934124dc077c65f6bf16fdc.camel@sipsolutions.net>
References: <5113a67ae69d32e03934124dc077c65f6bf16fdc.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'cfg80211_scan_6ghz()', an instances of 'struct cfg80211_colocated_ap'
are allocated as if they would have 'ssid' as trailing VLA member. Since
this is not so, extra IEEE80211_MAX_SSID_LEN bytes are not needed.
Briefly tested with KUnit.

Fixes: c8cb5b854b40 ("nl80211/cfg80211: support 6 GHz scanning")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: adjusted to apply on top of commit 295adaf455b
("wifi: mac80211: avoid double free in auth/assoc timeout")
---
 net/wireless/scan.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index bc77cfede492..d001272d88d1 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -893,8 +893,7 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 			if (ret)
 				continue;
 
-			entry = kzalloc(sizeof(*entry) + IEEE80211_MAX_SSID_LEN,
-					GFP_ATOMIC);
+			entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
 
 			if (!entry)
 				continue;
-- 
2.47.1


