Return-Path: <linux-wireless+bounces-38502-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0dIDLbo9Rmp1MgsAu9opvQ
	(envelope-from <linux-wireless+bounces-38502-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 12:30:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FC06F5ED5
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 12:30:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cROne60q;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38502-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38502-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06659301A121
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 10:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860CE3A7F6B;
	Thu,  2 Jul 2026 10:23:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A2439EF1F
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 10:23:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987813; cv=none; b=B9lDnxf88noUCK7/NjfVaNNFYteAVW7YbSTWhjJytsKUOpMsRuwmx6l+RSYBMQotFpIKebeQd3WDBlDcPy0/hv/ehgLOhIHAjUcTLuaARUy2b8GJy7+49qA5lF/RufTghpFoOVvlLZqgb0pxsrQhBBODs1Fx5+fExFig7FNYZ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987813; c=relaxed/simple;
	bh=zNvlmUSyCfX7u0VWteYENB+XdW+CzhRqGvjSkr1qFV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZH9a7/yrnZUV/K/EDzGzo/YEZRvfprIFTTDPgqMtmPzcgwRViwift2bhCDqNe3yszjmqyjeLJvoyEKTQVvDeQFGKxQfCa7v4+j9TIKFu+8mhpe8BVH9bvZl2+DcW4FZPJvEwRmJujFe9dyosFtjh7DrqNpOPfZZEY0niVMccalk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cROne60q; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c32d1350so1277085ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 03:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782987811; x=1783592611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6px/ZW+0aFyM0KcX8ZnnKmjgK4r3/XXlwGu/+cQTNrg=;
        b=cROne60qZEBUniR9/Q7hkBVZj2lRntGISEHqtNrijdBs0M8dful7rEv55Pf77so+2J
         Tk59mcIEky8hc2dYT+HWUS19hIJlLfnfQcxUQG2ijrutsfPXth7H5DqapEE3vCaG5C/7
         P2pC+5ulbnPqOUJgi4Gi0J52KNB6RFOmeT6yEX9GAMiuxU8ObjqXPMgOGCft1BoK+RHO
         qH12KtT0e0v3urPaohjg2B0H2bOS+9zjaW0ceYvw/GTUsodAbw0WcT4taSCgVJN0JDLN
         F9zqaMdUmeLNJ6IRRHxdlyvFBYQVqzfd43yfcFTgu/1eaVCm2m0byHxhHDYsnSME+0U+
         SZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782987811; x=1783592611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6px/ZW+0aFyM0KcX8ZnnKmjgK4r3/XXlwGu/+cQTNrg=;
        b=iksQhnJ1CMU8Kl6TdIzir236Wf57b9yQkaEffezvx3ugu6XxRDLNSR7hyy5Bp/ysuF
         EfvEHt6ldthj3v4lzU8Tg/DDxUUUmwUe5o32MEkyKs3Pw/wm9qMOjkNE3w0rNMDzRPPr
         5tNhY6JLdBeNDHHjXrMcb+F0UiLb5KePt/IEcnra6aj0SuvTrNCIo4vg9LeX5pYTev5g
         cY04Yk7bG0iXRtflGpZ4NyC2D+VvNEcztwkHCtaHg3sqC1jpU2JmTwzc4mjFCbuoq0iW
         GJZnRjYEbLU5jqkCT6n0KT5R2e3t32lCc+TPu0pRKmVSNtmI3jktJWB/UC9OviRG56zw
         jwqg==
X-Forwarded-Encrypted: i=1; AHgh+RrDsbjrjPZmVsFAOwJ1wgRyPm2PAHhXAZqNhXVfzS/1a3TNNeUoSo1+OpF7u1x2fhfLKBWQEvJ2minyoBJbOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv/z2aG3+imsZuIP/NkTDeWOdq0WzYBsoMLqH6bWjBCLvKVkDE
	Gd7rnA86cRn26TRDBamglwK9ULYDbt3X8CPI//98VRiwF1qsb9KH100l
X-Gm-Gg: AfdE7clRXEvkM26nBKnRj+8aggx4ppeKjht059kKubsDSY85hBUxoDXdeIJHZdd4qss
	7LEi2GCTM/CAY07WFdVDyGw5RJ7G+inHDz5MAOTMFKN6nA6h3qCdHol/Vp6St38XLf3FtG+D8uM
	LUlau3u7n9/Y98gHu5IWLelHtMcjCZx7A9UqFHmHx+lDxUcBKRFZRYJ/rvMM8tkJpNYR97UvPgd
	ShbqAO42VIAjDuP/4LGSVsQuJAeTAyamZ01R7v8rYjmlw4kdhLYPHzlObuAItHiyU9dAGZ3PEC8
	W0OGk0jb8O7g26yIxqTuWvrcrJOk4vphhxrUPAn/+L9NOmsD3TfQOulgVAX2MCPdQG5Frc3CJwh
	aCIi7XHauUJVQotwA/r3P16EUBmf1kY0BqhbyB+XdGJBV4otiJf7pxkfDt308jNCkWrIgpsPqhS
	47vltvmtQ+udSC5tX03NVFX15+abGirAKee3wMHSTnz56WAiIBCjGwY2fPkGW6V0akMY1rpMlC6
	rLR509WbyRWhNtKy4UgEWGVkCXRyq6vVl6njZTERm6J3r+E+XZK9EePJsjvsWSFaJo4XXL2+P/n
	PFqLapF/ydA82eMfDhuv1ceUT1U+R0KkYom6M3fOFXK4rLKb
X-Received: by 2002:a17:903:1d0:b0:2c9:ed4a:c3a4 with SMTP id d9443c01a7336-2ca7e53c218mr36708925ad.0.1782987811346;
        Thu, 02 Jul 2026 03:23:31 -0700 (PDT)
Received: from midnightair ([2401:4900:1c94:62e8:bc10:77d0:2fda:415d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c870effsm9278030c88.12.2026.07.02.03.23.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jul 2026 03:23:31 -0700 (PDT)
From: Anas Khan <anxkhn28@gmail.com>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anas Khan <anxkhn28@gmail.com>
Subject: [PATCH] wifi: p54: update stale wireless wiki URLs
Date: Thu,  2 Jul 2026 15:53:25 +0530
Message-ID: <20260702102325.63955-1-anxkhn28@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-38502-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:chunkeey@googlemail.com,m:kees@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:anxkhn28@gmail.com,m:chunkeey@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[googlemail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[anxkhn28@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anxkhn28@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51FC06F5ED5

The p54 wireless wiki links (wireless.wiki.kernel.org) return 404; the
content moved to the Sphinx documentation site. Point them at the
current wireless.docs.kernel.org pages.

Signed-off-by: Anas Khan <anxkhn28@gmail.com>
---
 drivers/net/wireless/intersil/p54/Kconfig  | 6 +++---
 drivers/net/wireless/intersil/p54/fwio.c   | 4 +---
 drivers/net/wireless/intersil/p54/p54usb.c | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intersil/p54/Kconfig b/drivers/net/wireless/intersil/p54/Kconfig
index 003c378ed131..44b0f1a724aa 100644
--- a/drivers/net/wireless/intersil/p54/Kconfig
+++ b/drivers/net/wireless/intersil/p54/Kconfig
@@ -10,7 +10,7 @@ config P54_COMMON
 	  also need to be enabled in order to support any devices.
 
 	  These devices require softmac firmware which can be found at
-	  <http://wireless.wiki.kernel.org/en/users/Drivers/p54>
+	  <https://wireless.docs.kernel.org/en/latest/en/users/drivers/p54.html>
 
 	  If you choose to build a module, it'll be called p54common.
 
@@ -22,7 +22,7 @@ config P54_USB
 	  This driver is for USB isl38xx based wireless cards.
 
 	  These devices require softmac firmware which can be found at
-	  <http://wireless.wiki.kernel.org/en/users/Drivers/p54>
+	  <https://wireless.docs.kernel.org/en/latest/en/users/drivers/p54.html>
 
 	  If you choose to build a module, it'll be called p54usb.
 
@@ -36,7 +36,7 @@ config P54_PCI
 	  supported by the fullmac driver/firmware.
 
 	  This driver requires softmac firmware which can be found at
-	  <http://wireless.wiki.kernel.org/en/users/Drivers/p54>
+	  <https://wireless.docs.kernel.org/en/latest/en/users/drivers/p54.html>
 
 	  If you choose to build a module, it'll be called p54pci.
 
diff --git a/drivers/net/wireless/intersil/p54/fwio.c b/drivers/net/wireless/intersil/p54/fwio.c
index 3baf8ab01e22..a3d9053f043c 100644
--- a/drivers/net/wireless/intersil/p54/fwio.c
+++ b/drivers/net/wireless/intersil/p54/fwio.c
@@ -131,9 +131,7 @@ int p54_parse_firmware(struct ieee80211_hw *dev, const struct firmware *fw)
 
 	if (priv->fw_var < 0x500)
 		wiphy_info(priv->hw->wiphy,
-			   "you are using an obsolete firmware. "
-			   "visit http://wireless.wiki.kernel.org/en/users/Drivers/p54 "
-			   "and grab one for \"kernel >= 2.6.28\"!\n");
+			   "you are using an obsolete firmware. visit https://wireless.docs.kernel.org/en/latest/en/users/drivers/p54.html and grab one for \"kernel >= 2.6.28\"!\n");
 
 	if (priv->fw_var >= 0x300) {
 		/* Firmware supports QoS, use it! */
diff --git a/drivers/net/wireless/intersil/p54/p54usb.c b/drivers/net/wireless/intersil/p54/p54usb.c
index c0d3b5329f4e..b88a3dadddc0 100644
--- a/drivers/net/wireless/intersil/p54/p54usb.c
+++ b/drivers/net/wireless/intersil/p54/p54usb.c
@@ -36,7 +36,7 @@ static struct usb_driver p54u_driver;
  * Note:
  *
  * Always update our wiki's device list (located at:
- * http://wireless.wiki.kernel.org/en/users/Drivers/p54/devices ),
+ * https://wireless.docs.kernel.org/en/latest/en/users/drivers/p54/devices.html ),
  * whenever you add a new device.
  */
 
-- 
2.54.0


