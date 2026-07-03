Return-Path: <linux-wireless+bounces-38598-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lz0cKb/ZR2ohgQAAu9opvQ
	(envelope-from <linux-wireless+bounces-38598-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 17:48:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 124FE703FE0
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 17:48:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=oRqXcW4Y;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38598-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38598-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04CBB302BFC1
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 15:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF5026F29C;
	Fri,  3 Jul 2026 15:47:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4541270EC3
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 15:47:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093669; cv=none; b=aGGFeCMzJu5kuDvJwHQK+2xaD9QIjXvVqeTog6wgfIvtFBk75TUKPrH6Poiv7wMML0D7qk0NjtLZHZyYzrPlZ4e+FTvCzgaLi3XYdq89ZRnO1QHS66GSV1sI/r4W4uKC2qESMP/X9PCThClndrhMvtE4iCWURJhZovxqbO7pYKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093669; c=relaxed/simple;
	bh=TWSNEV6HROmBG8r/fIAmoG7NoNWcNjFAZmGRLvamtZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RgpykUMgAPIe90QEWdyld849qA5wy3nv1FU3rBkPOKNfCPZoxYq53deYNx66A2Fdw0hiyHy7cj8SDujQunLoFBdw6reR7/6NK7IqAudHs/odGIOZEVohy6T4ZVnGyx5YD3Wm0/wUIRvIq0VhaKch9hBdBCV6PI/tpDsY6CqahmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=oRqXcW4Y; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493ba701891so5101915e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 08:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783093666; x=1783698466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A6s1jVW0tBl7XsSZdcqCAwoY/xGB4Q5j39SHmo5OdEQ=;
        b=oRqXcW4Yw8hkSuN+GPFTuRwlLjC52b4g8paz1e0/4gOj8NAyKsJo/JFGA9E1M1mFBm
         qQFWqI5AWSKybQ8HGHWw7W0w7Dy6a5/FJKtM0o5yIwy3MN5ZUdlH8N0lLmXRn9SVs0GK
         ekQgKdOL7IA92Ev4EIkMff7dJQIR4YzlA165rcJwJxvu+sxvhp//CN3jTffzC5+1mfbQ
         MSJfnnY3eT6FE9shx8LE2mM2DsXxEWml/BB/V33LpHVBa4di3xHQn033O8ELlPs25eP2
         AvFo2TSphIIonaOwWiPbCb/o98Z6WJ2rf9cj99tOKwAosTVhXI5vDrKBGsjyyzwV1uc3
         SToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783093666; x=1783698466;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A6s1jVW0tBl7XsSZdcqCAwoY/xGB4Q5j39SHmo5OdEQ=;
        b=kq1apMZOvan4YSbBGG2XMFZTwuPyZ6dmnqGaTxJCy8LTv74/gB8kqTYwyTYzoKl6Yp
         7xa7YtbOyvWkSf1QcN01FStxiDowulSp9RF0qkXMiyLXkX0IdIc14n/AuOxiyzeL64Lj
         9Mzqwtn+WpluZuY3O6M3NuFhi90aa4hpx0jvFMoEs0J/Gd9ooOaVeC/dPgF4aRQI+E1p
         EdGdTeLMkvgcwKg7NT9YNk2pInBxbz1UzZsK+ZCCgqsKGIXZenyjj0o4FgU+l3ffc//4
         IriCjy6xkJK/0riUSoXG9bklEUCZXB+mF5CJtqOFv64h+K22dK07CUsK34pkz7VUnwfP
         EWJg==
X-Forwarded-Encrypted: i=1; AFNElJ/+k2ue+/D8hDvfCHmpmUBWel96L1BtGogCq+frvgqLHDy8Rvfru/nl6nekK5y1G2opQtI3mgK/i9gEf8Uygg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzKKjyXOIzikeCFx2LrMnVUXyDSGIEmL7wk4iJAg3YeR6LJ1K/
	2gOkkOIeoPV9+4+DE2pemA2q21OZWnSykLdzrukEAHUfTLIz/b0FFLH/Pi6OmdCVisE=
X-Gm-Gg: AfdE7cma0PnUy+qOiRLwDX22ML+QT92I5IeFF37b/B50Ca9LU6iugtpGhP1Di37hGr+
	Fr3dB8PXqZNQLmhgplr+LA78E0iECu1JF9Eu3JZFPGUZlFUl1CArF9DC+fVCfJCKOq78o5QYnNJ
	2/wRiRl67Vt+n8BpsDvAkXjM1t+YFBxPgpqDB6SL3fR2otVOH7bq6b+c2UKK0VZQr1nj3NO1zUW
	CRqH/vk6nAS/boiV6dKYU84HbnI34kHjaPROAlf4xdTXsv9XPHK/YDCEgpxTAHu6ILnF7V0rmBe
	0yDqw/Mj8RBOcyvLBP5eiU0+wumYBwvlcyjOeHzoVARFdm50wp3QKARfgiZveq/njzh9Vb1s9t7
	tilmWiUBafZgMkkqLWDevbPQheOctCkhBZ8ExVYwBoMVIYu6fu0JaK+rw7LDN49/HKwgRM5Ga1z
	MkqY/Yx2kUfkiQqy27sfg6tDQJhbeBwIlME4qOTk0znJV7pllbtDaC0NFB0cHvbJlNH0ycDXpWQ
	Pvk
X-Received: by 2002:a05:600c:154f:b0:493:c845:bc20 with SMTP id 5b1f17b1804b1-493d0f0793amr4673825e9.4.1783093666048;
        Fri, 03 Jul 2026 08:47:46 -0700 (PDT)
Received: from localhost (p200300f65f47db0472e4f1e98703de96.dip0.t-ipconnect.de. [2003:f6:5f47:db04:72e4:f1e9:8703:de96])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493cce12c40sm96650805e9.13.2026.07.03.08.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:47:45 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: David Heidelberg <david@ixit.cz>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Greer <mgreer@animalcreek.com>,
	Simon Horman <horms@kernel.org>,
	Tomasz Unger <tomasz.unger@yahoo.pl>
Cc: oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v1 07/12] nfc: Drop __maybe_unused from of_device_id tables
Date: Fri,  3 Jul 2026 17:46:21 +0200
Message-ID:  <031ea0ae38838df3261f844eb13e9841769b49a7.1783091699.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1783091699.git.u.kleine-koenig@baylibre.com>
References: <cover.1783091699.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5888; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=TWSNEV6HROmBG8r/fIAmoG7NoNWcNjFAZmGRLvamtZw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqR9ljaFLF44dumHi+7/WAE/b9IH/HX2t6ecATi Xh44elrfoyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakfZYwAKCRCPgPtYfRL+ Tky3CACt1+H9/r260UQeKogAXpy2JHC7Cz25jgaDpgYL+yZNCpeGegTX59Ul9v92LXVajQWZdjM cpzd7EO+zOfI0b50jBi6lBlW+/7XEcz3ZdIiRXu+TutvpEVzjSn6eCM6rNzO+F85aAqYp1/g7L5 63WKvg27vx4q+0HxEkGYkuC1aDofCLAPZgxtYaZxNQYyttSmjirc7RyqPWK6w8K2qsCuiAQO0Sm CJe2EoXOGOFtCDsFCcCWeLtn682K0TwUoyFVuSGtv6n0uKEY7a9IaUX/vomGAfelZd5fSj6U8rQ VfyC2GoKXB21vleviLirxhskwIBxCJjdGnQ/pG8gd1eCLgNY
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:krzk@kernel.org,m:mgreer@animalcreek.com,m:horms@kernel.org,m:tomasz.unger@yahoo.pl,m:oe-linux-nfc@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[ixit.cz,kernel.org,animalcreek.com,yahoo.pl];
	TAGGED_FROM(0.00)[bounces-38598-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 124FE703FE0

Referencing these arrays in MODULE_DEVICE_TABLE() is enough to convince
the compiler that they are used even if the drivers are built-in (since
5ab23c7923a1 ("modpost: Create modalias for builtin modules"). So the
__maybe_unused marking can be removed without introducing a compiler
warning.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/nfc/nfcmrvl/i2c.c  | 2 +-
 drivers/nfc/nfcmrvl/spi.c  | 2 +-
 drivers/nfc/pn533/i2c.c    | 2 +-
 drivers/nfc/pn544/i2c.c    | 2 +-
 drivers/nfc/s3fwrn5/i2c.c  | 2 +-
 drivers/nfc/st-nci/i2c.c   | 2 +-
 drivers/nfc/st-nci/spi.c   | 2 +-
 drivers/nfc/st21nfca/i2c.c | 2 +-
 drivers/nfc/st95hf/core.c  | 2 +-
 drivers/nfc/trf7970a.c     | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/i2c.c b/drivers/nfc/nfcmrvl/i2c.c
index 66877a7d03f2..687d2979b881 100644
--- a/drivers/nfc/nfcmrvl/i2c.c
+++ b/drivers/nfc/nfcmrvl/i2c.c
@@ -245,7 +245,7 @@ static void nfcmrvl_i2c_remove(struct i2c_client *client)
 }
 
 
-static const struct of_device_id of_nfcmrvl_i2c_match[] __maybe_unused = {
+static const struct of_device_id of_nfcmrvl_i2c_match[] = {
 	{ .compatible = "marvell,nfc-i2c", },
 	{},
 };
diff --git a/drivers/nfc/nfcmrvl/spi.c b/drivers/nfc/nfcmrvl/spi.c
index 9c8cde1250fb..8dd71fed8493 100644
--- a/drivers/nfc/nfcmrvl/spi.c
+++ b/drivers/nfc/nfcmrvl/spi.c
@@ -181,7 +181,7 @@ static void nfcmrvl_spi_remove(struct spi_device *spi)
 	nfcmrvl_nci_unregister_dev(drv_data->priv);
 }
 
-static const struct of_device_id of_nfcmrvl_spi_match[] __maybe_unused = {
+static const struct of_device_id of_nfcmrvl_spi_match[] = {
 	{ .compatible = "marvell,nfc-spi", },
 	{},
 };
diff --git a/drivers/nfc/pn533/i2c.c b/drivers/nfc/pn533/i2c.c
index 94aca9119f0f..2128083f0297 100644
--- a/drivers/nfc/pn533/i2c.c
+++ b/drivers/nfc/pn533/i2c.c
@@ -236,7 +236,7 @@ static void pn533_i2c_remove(struct i2c_client *client)
 	pn53x_common_clean(phy->priv);
 }
 
-static const struct of_device_id of_pn533_i2c_match[] __maybe_unused = {
+static const struct of_device_id of_pn533_i2c_match[] = {
 	{ .compatible = "nxp,pn532", },
 	/*
 	 * NOTE: The use of the compatibles with the trailing "...-i2c" is
diff --git a/drivers/nfc/pn544/i2c.c b/drivers/nfc/pn544/i2c.c
index b731d0b02f52..50907a1974cd 100644
--- a/drivers/nfc/pn544/i2c.c
+++ b/drivers/nfc/pn544/i2c.c
@@ -937,7 +937,7 @@ static void pn544_hci_i2c_remove(struct i2c_client *client)
 		pn544_hci_i2c_disable(phy);
 }
 
-static const struct of_device_id of_pn544_i2c_match[] __maybe_unused = {
+static const struct of_device_id of_pn544_i2c_match[] = {
 	{ .compatible = "nxp,pn544-i2c", },
 	{},
 };
diff --git a/drivers/nfc/s3fwrn5/i2c.c b/drivers/nfc/s3fwrn5/i2c.c
index e9a34d27a369..499301a6fa3f 100644
--- a/drivers/nfc/s3fwrn5/i2c.c
+++ b/drivers/nfc/s3fwrn5/i2c.c
@@ -210,7 +210,7 @@ static const struct i2c_device_id s3fwrn5_i2c_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, s3fwrn5_i2c_id_table);
 
-static const struct of_device_id of_s3fwrn5_i2c_match[] __maybe_unused = {
+static const struct of_device_id of_s3fwrn5_i2c_match[] = {
 	{ .compatible = "samsung,s3fwrn5-i2c", },
 	{}
 };
diff --git a/drivers/nfc/st-nci/i2c.c b/drivers/nfc/st-nci/i2c.c
index f43ae8e92070..ceb7d7450e47 100644
--- a/drivers/nfc/st-nci/i2c.c
+++ b/drivers/nfc/st-nci/i2c.c
@@ -269,7 +269,7 @@ static const struct acpi_device_id st_nci_i2c_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, st_nci_i2c_acpi_match);
 
-static const struct of_device_id of_st_nci_i2c_match[] __maybe_unused = {
+static const struct of_device_id of_st_nci_i2c_match[] = {
 	{ .compatible = "st,st21nfcb-i2c", },
 	{ .compatible = "st,st21nfcb_i2c", },
 	{ .compatible = "st,st21nfcc-i2c", },
diff --git a/drivers/nfc/st-nci/spi.c b/drivers/nfc/st-nci/spi.c
index 9303217acd7b..8632cc0cb305 100644
--- a/drivers/nfc/st-nci/spi.c
+++ b/drivers/nfc/st-nci/spi.c
@@ -283,7 +283,7 @@ static const struct acpi_device_id st_nci_spi_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, st_nci_spi_acpi_match);
 
-static const struct of_device_id of_st_nci_spi_match[] __maybe_unused = {
+static const struct of_device_id of_st_nci_spi_match[] = {
 	{ .compatible = "st,st21nfcb-spi", },
 	{}
 };
diff --git a/drivers/nfc/st21nfca/i2c.c b/drivers/nfc/st21nfca/i2c.c
index 13fb6f5533e0..4e70f591af55 100644
--- a/drivers/nfc/st21nfca/i2c.c
+++ b/drivers/nfc/st21nfca/i2c.c
@@ -583,7 +583,7 @@ static const struct acpi_device_id st21nfca_hci_i2c_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, st21nfca_hci_i2c_acpi_match);
 
-static const struct of_device_id of_st21nfca_i2c_match[] __maybe_unused = {
+static const struct of_device_id of_st21nfca_i2c_match[] = {
 	{ .compatible = "st,st21nfca-i2c", },
 	{ .compatible = "st,st21nfca_i2c", },
 	{}
diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
index ffe5b4eab457..1ecd47c6518e 100644
--- a/drivers/nfc/st95hf/core.c
+++ b/drivers/nfc/st95hf/core.c
@@ -1054,7 +1054,7 @@ static const struct spi_device_id st95hf_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, st95hf_id);
 
-static const struct of_device_id st95hf_spi_of_match[] __maybe_unused = {
+static const struct of_device_id st95hf_spi_of_match[] = {
 	{ .compatible = "st,st95hf" },
 	{},
 };
diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index f22e091019de..bc01b46f461c 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -2303,7 +2303,7 @@ static const struct dev_pm_ops trf7970a_pm_ops = {
 			   trf7970a_pm_runtime_resume, NULL)
 };
 
-static const struct of_device_id trf7970a_of_match[] __maybe_unused = {
+static const struct of_device_id trf7970a_of_match[] = {
 	{.compatible = "ti,trf7970a",},
 	{},
 };
-- 
2.55.0.11.g153666a7d9bb


