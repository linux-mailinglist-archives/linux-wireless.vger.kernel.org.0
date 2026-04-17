Return-Path: <linux-wireless+bounces-34930-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OXEBeQx4mkZ3QAAu9opvQ
	(envelope-from <linux-wireless+bounces-34930-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 15:13:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A60E41B7DB
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 15:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C49C7303AB0C
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 13:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430A33B2FDF;
	Fri, 17 Apr 2026 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="MsBVlhNF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BE93AC0EE
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776431493; cv=none; b=r+1ZrB/Yks5PKcFKQ1UjNG53+egYto7ZH+2OoowwzyKUbH1wYSKVTfUm7fh8i4XuUyyHpaCQIPvnrbdPkKUMQQlTwbDvNEdNlEoz7eT8QfTBKu1xtSu/uxz/HBNBg1AejqOv81y4GRA4rqlG1Hcu/CjpGFcd2vOiO7wT97jxx8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776431493; c=relaxed/simple;
	bh=4L2vpwuwg5+ZoVv8BbyxcrgDvBKdVsNcYCWmNsvZZXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDNlHoUQGza/LFiqNfWLAaFZzSheK0souSdmdneZzh9QU5+W4qYdcpvxEkbg8e+tN4EoNjw2qpBHeUDezVgJOFRLKQ7EDx0JCS4YhIiSGxXaDQ7ffMN4rm3+9l8I4AXbEZLa+Q/5pdPR1H2GMTY0AzEJT+90Mopp+j7j6obfSsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=MsBVlhNF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d7650202fso602829f8f.2
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776431490; x=1777036290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3QUZ/jlQvGQi3TuVUmjigtPfN9idBRKMmXw1pwrDWs=;
        b=MsBVlhNFLAWaSubnYdxk2GObt6HWxD5EraVq/uWJte1iy5dmC25Ss5W57r90mXITzw
         JRh+F5A8fUSPld7y9yg0LAD/9gqH8iJN4tWjbVDCq99WPh/To4sSUwtCp5ETeSpqHBIs
         6d4FzGjqoONvUxQZxZ8S5o7ZyMEGtJJfgnfenibFVlJfVYi9uiLx/Mr2zNWW6amznzRq
         ZQsKJzf7zgfbDGqFxzQO7MmQX39BlDFrmUQ0m9sJedlc3sytzjUm/aGov33Nm2JQyKOU
         Ul36wgIlDTXIOXMdPRfXBUsMjySA3+wcEOF04RKQqF61p7HwyVxIEtbPaOLS3cJUfQUt
         gCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776431490; x=1777036290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x3QUZ/jlQvGQi3TuVUmjigtPfN9idBRKMmXw1pwrDWs=;
        b=oDpIOoGXHocaC+8A1RrjMHtepL4rM7+XRsuNzZPPjJSxhQet5kA04TyP3IUSCtPTpe
         D4sZe6+YtzgEDs+GKtD0n0rPX4xxjG9g31EhcZrw8TtpjGuNzSL72q4092Qvpzbxiom1
         W/44jDOn2L8MDJZCXGAQgNzmkbyuXKTSxAG6wrwgC51vhw3G8avkng/1uOERTor6Mgab
         57Qv3tkhJdCUpgyFaOFgDuh18MmMkcUyTqSepg1CiyHejQFghY/uDZ4iyk6lQhXzAQNI
         LeaBe5O2SX41KnLsM5fkjFCHaFzHZpPVY3gJqxBNqxJ9XsYoI+WUIXTyQShvaVz1VBLS
         Catg==
X-Forwarded-Encrypted: i=1; AFNElJ/qQxdic2EyxVrjN/en8jE6qlqeG1gdaohUv48NGhOenWh/wPNfCfDuvLU0tz+YM7azmivAKM3dlIf/SLqaiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGv4C2lifpFznpTe+UNylXZqs0p3MkOd0HefCQf5lcdPPlNeRt
	Eyh0j33zqu6WoVm098mhF9TT7NvFfvIifExCpCNYbCIbeJHT8peBlYJI46KjQMlIVu8=
X-Gm-Gg: AeBDievtJjFind9+dKw8/K6ynNr+HqAmyr59ZgNh/PYK1L7TLIfYzn0umGg0XzP4Bk6
	wardsmIssp41CN9AwII3U/WjFymzhRINzZMHF7hqSm8Jf/9OkIXFjuRARHZ9Azm5MVRnmdEODPd
	whdPDwJsrvNicBwI2a7Rx3CzCRGqROqMJ6XXCyayHZVV+0j+0hfDcdaWCc30MK7pCDBZZlHwTIP
	UTNnK2YzWmuwCTk4WbtrxsiKhYRo7G86sRwDrkrAwh20tphSJ6D5JrgGWyEstl5TRyx5BYqT+Nl
	Empknpul90QmIIN5dsK/v96OINP8YuKFQT+gSXGByzBD8l9AjsDs4VOcWWNh8rMsZJg/EGzkxwq
	E4ggt2rMHgQrt7WtrBNMm0pN0GqqXPg+QUc+gEfV7G0XQ73JWlb9RDKihVpgZCHQDX3tR4KndJp
	fYGGGU5GsDh9LS8NZFYixhdsquP4Dm9k14TEnJoQS80xWI2qlu+ChKPO2nCWj6t7sszwyDWg8JS
	qTFqR+U9dfZdPFKzwtVJYsRQEXez7wmgA8=
X-Received: by 2002:a05:6000:4201:b0:43f:e7fa:a6f1 with SMTP id ffacd0b85a97d-43fe7faa7admr1780435f8f.24.1776431490120;
        Fri, 17 Apr 2026 06:11:30 -0700 (PDT)
Received: from localhost (p200300f65f20eb08db61cfc60d8aa232.dip0.t-ipconnect.de. [2003:f6:5f20:eb08:db61:cfc6:d8a:a232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4dc24cfsm4613648f8f.16.2026.04.17.06.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:11:29 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/6] wifi: rtw88: Benefit from sdio_device_id::driver_data_ptr
Date: Fri, 17 Apr 2026 15:10:50 +0200
Message-ID:  <eca8679e2145e698ed674e343ca357788c3d6de6.1776429984.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4107; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=4L2vpwuwg5+ZoVv8BbyxcrgDvBKdVsNcYCWmNsvZZXY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp4jFhaIU+uhdPpMFbsoO1FjHc7Ers/Y/bIwBlb OCMCyAz3aaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaeIxYQAKCRCPgPtYfRL+ ToSTCACrNjSx5dPN6SYUCLXu7uarnUutY0MJqTE7Dc5ISaEQVu1OwrK3ay61ZPJRr6+Ck3CMXt2 I9wGBqgwOv0U09IZwLYsJ0UuQgtJS4Lf2IhRIWBuqrwWxlk+Hg9cwpzd/mpCeqc7EWQ8V5Sjbnv 7lwsvOuQ/xRPblt36kxRo8Im/R6rXuNYDQBFZvoehOSKDZfU39sWz+lvA3LuawhWZzapOTScqPO l5yPD4ydBOtQr56FyEBvsJPiGQpK+ruJNvYa+NsIwqTyfFxs2Mh/DeyMiiuyIGu5ZKxsx3WlNoj PsYnBFjV/ozLQ/9/NSys36O3NsxTagBLh0MzXiDKr1NUxQiG
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34930-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre-com.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,baylibre.com:mid,baylibre.com:email]
X-Rspamd-Queue-Id: 3A60E41B7DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Recently struct sdio_device_id gained a new member to store a pointer to
driver data. Make use of that to get rid of a bunch of casts.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8723cs.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723ds.c | 4 ++--
 drivers/net/wireless/realtek/rtw88/rtw8821cs.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822bs.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822cs.c | 2 +-
 drivers/net/wireless/realtek/rtw88/sdio.c      | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723cs.c b/drivers/net/wireless/realtek/rtw88/rtw8723cs.c
index 2018c9d76dd1..dbe2ba989160 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723cs.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723cs.c
@@ -12,7 +12,7 @@ static const struct sdio_device_id rtw_8723cs_id_table[] = {
 	{
 		SDIO_DEVICE(SDIO_VENDOR_ID_REALTEK,
 			    SDIO_DEVICE_ID_REALTEK_RTW8723CS),
-		.driver_data = (kernel_ulong_t)&rtw8703b_hw_spec,
+		.driver_data_ptr = &rtw8703b_hw_spec,
 	},
 	{}
 };
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723ds.c b/drivers/net/wireless/realtek/rtw88/rtw8723ds.c
index e38c90b769a2..2d1872c97e30 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723ds.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723ds.c
@@ -13,12 +13,12 @@ static const struct sdio_device_id rtw_8723ds_id_table[] =  {
 	{
 		SDIO_DEVICE(SDIO_VENDOR_ID_REALTEK,
 			    SDIO_DEVICE_ID_REALTEK_RTW8723DS_1ANT),
-		.driver_data = (kernel_ulong_t)&rtw8723d_hw_spec,
+		.driver_data_ptr = &rtw8723d_hw_spec,
 	},
 	{
 		SDIO_DEVICE(SDIO_VENDOR_ID_REALTEK,
 			    SDIO_DEVICE_ID_REALTEK_RTW8723DS_2ANT),
-		.driver_data = (kernel_ulong_t)&rtw8723d_hw_spec,
+		.driver_data_ptr = &rtw8723d_hw_spec,
 	},
 	{}
 };
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821cs.c b/drivers/net/wireless/realtek/rtw88/rtw8821cs.c
index 58e0ef219cdc..7fb2d892e52d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821cs.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821cs.c
@@ -13,7 +13,7 @@ static const struct sdio_device_id rtw_8821cs_id_table[] =  {
 	{
 		SDIO_DEVICE(SDIO_VENDOR_ID_REALTEK,
 			    SDIO_DEVICE_ID_REALTEK_RTW8821CS),
-		.driver_data = (kernel_ulong_t)&rtw8821c_hw_spec,
+		.driver_data_ptr = &rtw8821c_hw_spec,
 	},
 	{}
 };
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822bs.c b/drivers/net/wireless/realtek/rtw88/rtw8822bs.c
index 2de9b11540c5..08ae86e7ccbc 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822bs.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822bs.c
@@ -13,7 +13,7 @@ static const struct sdio_device_id rtw_8822bs_id_table[] =  {
 	{
 		SDIO_DEVICE(SDIO_VENDOR_ID_REALTEK,
 			    SDIO_DEVICE_ID_REALTEK_RTW8822BS),
-		.driver_data = (kernel_ulong_t)&rtw8822b_hw_spec,
+		.driver_data_ptr = &rtw8822b_hw_spec,
 	},
 	{}
 };
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822cs.c b/drivers/net/wireless/realtek/rtw88/rtw8822cs.c
index b00ef4173962..9a6124ea2afc 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822cs.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822cs.c
@@ -13,7 +13,7 @@ static const struct sdio_device_id rtw_8822cs_id_table[] =  {
 	{
 		SDIO_DEVICE(SDIO_VENDOR_ID_REALTEK,
 			    SDIO_DEVICE_ID_REALTEK_RTW8822CS),
-		.driver_data = (kernel_ulong_t)&rtw8822c_hw_spec,
+		.driver_data_ptr = &rtw8822c_hw_spec,
 	},
 	{}
 };
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 1318e94f8524..f444a8f5902d 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1334,7 +1334,7 @@ int rtw_sdio_probe(struct sdio_func *sdio_func,
 	rtwdev = hw->priv;
 	rtwdev->hw = hw;
 	rtwdev->dev = &sdio_func->dev;
-	rtwdev->chip = (struct rtw_chip_info *)id->driver_data;
+	rtwdev->chip = id->driver_data_ptr;
 	rtwdev->hci.ops = &rtw_sdio_ops;
 	rtwdev->hci.type = RTW_HCI_TYPE_SDIO;
 
-- 
2.47.3


