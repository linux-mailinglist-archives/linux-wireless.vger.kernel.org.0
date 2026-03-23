Return-Path: <linux-wireless+bounces-33725-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ByQGYVLwWlbSAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33725-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 15:17:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C84B52F41BF
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 15:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D7FA3153BA2
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 14:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7243B19CC;
	Mon, 23 Mar 2026 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="mKI69JpI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D16D3AC0D2;
	Mon, 23 Mar 2026 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274839; cv=none; b=euqPE2mwA5jw2afQlkW52YkCLgINo0Eo+YgWg50o9dQm88cdEnA7DKMe+RfcWRqy3kQBTmEiYwaN+sDWVpXE0J2tabf8fABr75s153H7dNAclk1A7M4C7wvMDIM0U2SoRMdvo7D6jllLuojvz52SjwlJllVO2n08mmSWM/ftbgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274839; c=relaxed/simple;
	bh=+I1+6PxqhYf86XCLZ40wyK98BC8FoxyinMdcwiQiJmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ia91m4rWLXONfsSN5/j2ocNIe8mbgoiTk8YbBl140h6Ua4WzI4BMJpkz249VFDYZXrKuQBjnQz3u4O1qyM+ZYyTlmzopfhA6Tf0I/K3Y2+niWegMdJMpxXxuGI2ZJqxwdYAaGgjHjX/Xp8qYZQwnP++iJQq6V/UMJ2oXh2eXBdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=mKI69JpI; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from VelichayshiyPC.. (unknown [77.93.122.67])
	by mail.ispras.ru (Postfix) with ESMTPSA id 4B51D40737A2;
	Mon, 23 Mar 2026 14:07:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4B51D40737A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1774274827;
	bh=TXuvhvqO8/RORLWwG95KkfO2E0kCst0dKdFKvFqtWto=;
	h=From:To:Cc:Subject:Date:From;
	b=mKI69JpItPh3eXCOLlLXckzYfWr9puy2SmVIi+T4wNkrRA+PSNX/GQDHrcJMgG8Bf
	 jkDFuZfthsQM4GRZszwaEhUsZsOlKwDuB1kzsqK7TpMvet2qgGWmq/OuPOqnPb67KO
	 P7h/owJ6ErQXbB97NNliP3l1ZUgc2qBNR5cVhE24=
From: Alexey Velichayshiy <a.velichayshiy@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Alexey Velichayshiy <a.velichayshiy@ispras.ru>,
	Yuan-Han Zhang <yuanhan1020@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next] wifi: rtw89: phy: fix uninitialized variable access in rtw89_phy_cfo_set_crystal_cap()
Date: Mon, 23 Mar 2026 17:05:53 +0300
Message-ID: <20260323140613.1615574-1-a.velichayshiy@ispras.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33725-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ispras.ru:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.velichayshiy@ispras.ru,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C84B52F41BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the rtw89_phy_cfo_set_crystal_cap() function, for chips other than
RTL8852A/RTL8851B, the values read by rtw89_mac_read_xtal_si() are
stored into the local variables sc_xi_val and sc_xo_val. If either
read fails, these variables remain uninitialized, they are later
used to update cfo->crystal_cap and in debug print statements. This
can lead to undefined behavior.

Fix the issue by initializing sc_xi_val and sc_xo_val to zero,
like is implemented in vendor driver.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 8379fa611536 ("rtw89: 8852c: add write/read crystal function in CFO tracking")
Signed-off-by: Alexey Velichayshiy <a.velichayshiy@ispras.ru>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index ee6ab2136b9a..ee8a36003e5d 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4860,7 +4860,7 @@ static void rtw89_phy_cfo_set_crystal_cap(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_cfo_tracking_info *cfo = &rtwdev->cfo_tracking;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	u8 sc_xi_val, sc_xo_val;
+	u8 sc_xi_val = 0, sc_xo_val = 0;
 
 	if (!force && cfo->crystal_cap == crystal_cap)
 		return;
-- 
2.43.0


