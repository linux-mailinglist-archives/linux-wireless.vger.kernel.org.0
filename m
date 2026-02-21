Return-Path: <linux-wireless+bounces-32075-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CVpALjbdmWl5XAMAu9opvQ
	(envelope-from <linux-wireless+bounces-32075-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Feb 2026 17:28:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 923F216D42F
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Feb 2026 17:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6711301FE52
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Feb 2026 16:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889EF318EC5;
	Sat, 21 Feb 2026 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=puri.sm header.i=@puri.sm header.b="DfJjJKAa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ms.puri.sm (ms.puri.sm [135.181.196.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C450F2D73B4;
	Sat, 21 Feb 2026 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.196.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771691313; cv=none; b=upf5p3qxs3qmv6IhsAFRWkc3BjJzaN5HsBwOzH7q1YkVFm0TCTsv3L5ujtFHhCWXCpCeEy8zKfcrVFSpQZivp7lnKFuC39/fP2gGdpnYmPBwpsjQS3MsoZpMULww78mnE8RBsGaAzEwazhCvrZt09XIVU/4Q7HvhBRH3LQIoIes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771691313; c=relaxed/simple;
	bh=o6QbvuW0GmLPBhKatAKrTEsSkkUr6YK5yBb1rTKId9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZcCY7rOMEXF2xH6SplV69cHqfO4WTo9Z9OsC7BOz0PP4SczMSEgkC1ThhZU2mru3WNVmGDlBieHgkeLFDE9sybCJDowNfCndSucyrQ2vtcLeciYsmjjuLjrpGbZP8Gm2jdgdcrWVw9Y/MnDK3EwY7vEbWjpug2+QQKnl7OikOZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=puri.sm; spf=pass smtp.mailfrom=puri.sm; dkim=pass (2048-bit key) header.d=puri.sm header.i=@puri.sm header.b=DfJjJKAa; arc=none smtp.client-ip=135.181.196.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=puri.sm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puri.sm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=smtp2;
	t=1771691309; bh=o6QbvuW0GmLPBhKatAKrTEsSkkUr6YK5yBb1rTKId9Q=;
	h=From:Date:Subject:To:Cc;
	b=DfJjJKAaRdNpc5oZGzi7ixZT7zwMBuz0UUDRg9XVE+tJgHi3k4t1P0nQX8Q0vISOn
	 RKrH+goUa1zm5x43rkkdlLriC6d+bpDa4boVSORCszaB8C9bgWZZiIULTSM5zRtGXe
	 GUH6aVRfVxKBrD+8TkIGlSZt0CZVkWAOSi7ZsYN92hLmpqFjl7RaYvWkoJGdFHhbdn
	 wGckb8awn/npRgvvj8hvrziNKOncesJup/ZI9UpV2fMm0XZbXCJAFfusrYJ8L3Zakd
	 tZHDB3g/ZM7xwdKrGLfm730eko+dfrgJ/PuCIhQq2l/Qy+SKRK4ZL1IT5YrzZdu8Ec
	 7H0zlVVvbd9wg==
Received: from pliszka.localdomain (79.184.40.11.ipv4.supernova.orange.pl [79.184.40.11])
	by ms.puri.sm (Postfix) with ESMTPSA id 4D8FA1F6B7;
	Sat, 21 Feb 2026 08:28:29 -0800 (PST)
From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Date: Sat, 21 Feb 2026 17:28:04 +0100
Subject: [PATCH] net: wireless: rsi: Don't default to -EOPNOTSUPP in
 rsi_mac80211_config
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260221-rsi-config-ret-v1-1-9a8f805e2f31@puri.sm>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQ6CQAxA4auQrm0cisGfqxAXZSzQRItp0ZgQ7
 u7o8lu8t0KIqwRcqhVc3ho6W0G9qyBPbKOg3oqBErWJqEYPxTzboCO6LNhSc6B05pM0RyjR02X
 Qz3/YXYt7DsHe2fL029zVXrF/cCzisG1fOatqXH8AAAA=
X-Change-ID: 20260221-rsi-config-ret-6234209a8e37
To: Johannes Berg <johannes.berg@intel.com>
Cc: kernel@puri.sm, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113;
 i=sebastian.krzyszkowiak@puri.sm; h=from:subject:message-id;
 bh=o6QbvuW0GmLPBhKatAKrTEsSkkUr6YK5yBb1rTKId9Q=;
 b=owEBbQKS/ZANAwAKAejyNc8728P/AcsmYgBpmd0tisaTLGXqFoQr/a7i46ONANGOp6duF5kh8
 O3WYRwHWBKJAjMEAAEKAB0WIQQi3Z+uAGoRQ1g2YXzo8jXPO9vD/wUCaZndLQAKCRDo8jXPO9vD
 /5jJD/9Mqv+IbViY0DdjhDL2DD44AGMlzlfqjTEPyDv2hBzy7iIuPoGSUbkJOshk4EgWYXcX6v/
 YEYrj3s0UdaCPGmjUswhOGJ5Ft06veRAf7Jed4P/J1HtZPebH6VDlkHX0RwzoXjwHK93fQH5Y7+
 LdRw3CyCzlACl2QXScyTfKXXIXUbfKN8KYHgudLc20Z9eSkoKmgvQVBRbwGb7FzypbzBTh7bbAK
 y6SGuOMxl+pb/5UJAa9QYXkfZeY95/wtvR5jwQenBoyxrA6pnnlIeMAVQBPITM1dEuU1eJY8VQK
 Zg91WVzJBlxwK1m9G5+saip069DRGkVfKImdINNgkzNA7+A09jar6aY+SdBdjb2ljEZkV3ug14r
 bWgZI33ilWCYGqvxQWyZGxkHauI5opkKB4vglrxEtDheiOqjpYGj8Dqqj4OA7CVScg/2D6WR/oB
 LaJDZxYffHlwGxG9Xn6zLvHApR3B5sBfIPlO59XHHd33IY+9msaZKL1F2INprWKoPKOdT9K5Zrx
 UspkKLieqGu9Xhuaz2bga+6yaiZ6kqL5gyGQvDY3PeHDDukPeWKmJUlX11B2zVAZEf0zzPWiXG6
 RcAY892c22ZplKtDnLv4RV8ZTu1ATj/YhXv6ICyLAZBm03P8c+YF4MSetH/MBdWQeeHwVOts2gs
 u4EHPgJYj8PUc9g==
X-Developer-Key: i=sebastian.krzyszkowiak@puri.sm; a=openpgp;
 fpr=22DD9FAE006A11435836617CE8F235CF3BDBC3FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[puri.sm,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[puri.sm:s=smtp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32075-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[puri.sm:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.krzyszkowiak@puri.sm,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 923F216D42F
X-Rspamd-Action: no action

This triggers a WARN_ON in ieee80211_hw_conf_init and isn't the expected
behavior from the driver - other drivers default to 0 too.

Fixes: 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")
Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/net/wireless/rsi/rsi_91x_mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index 8c8e074a3a70..c7ae8031436a 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -668,7 +668,7 @@ static int rsi_mac80211_config(struct ieee80211_hw *hw,
 	struct rsi_hw *adapter = hw->priv;
 	struct rsi_common *common = adapter->priv;
 	struct ieee80211_conf *conf = &hw->conf;
-	int status = -EOPNOTSUPP;
+	int status = 0;
 
 	mutex_lock(&common->mutex);
 

---
base-commit: d79526b89571ae447c1a5cfd3d627efa07098348
change-id: 20260221-rsi-config-ret-6234209a8e37

Best regards,
-- 
Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>


