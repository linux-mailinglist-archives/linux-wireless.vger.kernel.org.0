Return-Path: <linux-wireless+bounces-38599-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pEFkDOfZR2orgQAAu9opvQ
	(envelope-from <linux-wireless+bounces-38599-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 17:48:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D713703FED
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 17:48:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=iXStWVfj;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38599-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38599-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFC263028C60
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 15:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0B52C1586;
	Fri,  3 Jul 2026 15:47:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7616D283FCF
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 15:47:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093671; cv=none; b=FWGfD9LRRbEA/ObhcowDfNAa2XakBNOUAsfXym67EZXN7jvhjS/aDnUUuCTYsZu+XBNTzrQkqn4eotsMaCAvwOhnVK21DOmpv7YvY8u1EFrPo1k6zzS6SAlVp+eibC7tSaYhkoZORmbHld/LOPay8YdPFqSY0aelk9JMQdfKa7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093671; c=relaxed/simple;
	bh=4RfI5PQzdlJp5SSDIXdOGzF9MK8F0YdVzMlT5vViNdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBhacZTobCio9SnJ2NgDJCsz5Kt7bVoeBnTROIdBHObbU7BKxXqSDIeB3p8jH0obvH5wmQjVreJ8wPUFnDVpE4H7+VIlrhFNC28683T9c4e85trqY0LHrx6Q4HqRmFIBJHYY1ReJLuwdXVYWLk2R4bKCIsOiJBfPa4eim+kFfnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=iXStWVfj; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493c83474ddso6728485e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 08:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783093668; x=1783698468; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FS4+nxD6byAOtlaenyC1bAp6p0e5dRpJe+n2ndVLOqw=;
        b=iXStWVfjx9b80IUY/uj96KuCsC++e1s00LRbWmBUAssbE5jXt31jUkhNz0t7G/rsg/
         UkS2wuVjfa55NNpe4XH5GeDg05oiVGk1PWrV5ZA+QAmZuw2xVNCxmoga9NsmHpxMcPw5
         PTVSml56qEI0eCbMCpo0eX0CN6sXKfgoMOGc7ENdW+GUZLlXPyW2BZWXiW8iJQB/hulv
         SxqxsMHfDR+vZHopJWiOI7z44LHTS2iXDCp6KdPKvukE6xcDy18jH862eQ/PRFZ2ZrFM
         QNoavDahGX9j1Yz9kjUZx1pxYLvxBGcGT8u5seYW7U9HGxG0gcj3waFW4eBO7rqrgiPv
         NoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783093668; x=1783698468;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FS4+nxD6byAOtlaenyC1bAp6p0e5dRpJe+n2ndVLOqw=;
        b=S6+nJPyGJHu8bmOOst0upqRLd+wMc00fOVTFXytsBeNoPKUuvzHAfkp+mFRIeIbsYy
         v7h/0ymevhJIFxhMq0Rq3eAI4usoLkwUNSjVnGT2J5miJbmEcYqMUiDz08mMCHFyROqF
         IPDBR3iU7tNDW7ZvgwOK2NTgkkUq0o8YtXZwMaScKGLs4k/4exareM2KaF3ravq5GxFk
         MAbFbQC/5z4dQY0/HbKqxduVZ3A/3O15uGblZ24KzpNpfw72N57/aTerfm2eGU8lyrTf
         DiYFyDL3ddKdrwdXWNEqPkqW9ss6IG9BF1TEf+XLt84DuKOqgpRbnZEH+rG7jBPneLgv
         T0TQ==
X-Forwarded-Encrypted: i=1; AFNElJ8lzldaz7HdxV+E21hYsVFEeeB80KtMUKUGZAIqB3ORVpT7FQq6AS9TgJWBkhWw1SAGRJEJEzv2viODFuucsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCJI2EFc3Zs0hGEmMF45oJzXOH9p1agQfKtqig96cJA5LPh0OQ
	floG+D0q4P2mIGU0I5vtfNvc9dybyqWMzZKu19duoFK7B/kBEpnzb6JeU0EJUdpZqgU=
X-Gm-Gg: AfdE7cnK/yCk6WAFB8YWsFiko9NIJdda6uPCe2m+c33t6Cz/tBtpkdTz4ki+R2jhQri
	QqwaonIJB7W84zFki9pqYrmxgBj2sXgAIfd6jG/hp9lfDQqTAu56OYlqVnUrlKeS0OS+PyAsXV6
	9QKHp48GhxpJj3Vtft9C+3YCSJmg/nvTQkdsH8RcFJLd3Xv7JF2Ge6WlFgJuSxoRCOMxSTkg/an
	UosFhIs0aqlFy+jjCCjxSoZbQN9zNT95sR/3nUMxxBHdj5k+kB4alzakgpQFIi5x2XQ5YBsAMBC
	WGj1UC0IDKcFZJmbpn8QaOeXxVn61ap3taKpTtLde5RqXxJff9ZGDAYXq2QMVKmcomjO550cTBL
	VMOISLUu5NYFM7Df5gzJnKiCIK9MiNttVinZFQjKziB/xxtJ1SaYatdYUZw0Mqb1+FuvH40q10t
	jCpOwzjnsk7KyjB+ME3GpJCv704sFwuSTQLL3q+ljU7VJu9sSgx31gBmiSb6uFVyT6raWnsxtw1
	Oke
X-Received: by 2002:a05:600c:528b:b0:492:5145:f054 with SMTP id 5b1f17b1804b1-493d0f38d22mr4921825e9.26.1783093667647;
        Fri, 03 Jul 2026 08:47:47 -0700 (PDT)
Received: from localhost (p200300f65f47db0472e4f1e98703de96.dip0.t-ipconnect.de. [2003:f6:5f47:db04:72e4:f1e9:8703:de96])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493c63ba971sm218684255e9.13.2026.07.03.08.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:47:47 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: David Heidelberg <david@ixit.cz>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Greer <mgreer@animalcreek.com>,
	Carl Lee <carl.lee@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Ian Ray <ian.ray@gehealthcare.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Kees Cook <kees@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Tomasz Unger <tomasz.unger@yahoo.pl>
Cc: oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v1 08/12] nfc: Unify style of of_device_id arrays
Date: Fri,  3 Jul 2026 17:46:22 +0200
Message-ID:  <583375dcd834f5edf6241b09cdd75ad4f32af668.1783091699.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7781; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=4RfI5PQzdlJp5SSDIXdOGzF9MK8F0YdVzMlT5vViNdU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqR9llSw/kj+UO60OMjmzXCwsC9LOyZKPVsIoSm K0PkfP0qtSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakfZZQAKCRCPgPtYfRL+ ToYpB/9oTXSjWZS6cfv2Qjv7mMzYXh2n7XCFASuB+rs8f1wljm2T2H9a3fgwXM9OUkmlflTD0VW vI7IQgnJwVvA0w1yHuAmlfKSoaYjPrvcufF8y2FshNtL1PFBK2ZUtr/TiZCWKPtjNEdj4ELo5l3 4bM85u7PKiv7hP0OQ9jkBTWudWqwZmhca/Wl+MgdpnvMb3VexwwwaqvIekwMh78rnTTMbeHQ+Yj TxrHvaU1TZNJ7cNsHy0+sLTa5sYCe9+NOCdiNERPExV3JqndeZrjim1zrZ14pSGYWj1uU7FCaUp jJS2Vh0+KRH/Sw65cxn61nsAKnxUIxAsX1ldS6cBwnykIw0e
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:krzk@kernel.org,m:mgreer@animalcreek.com,m:carl.lee@amd.com,m:kuba@kernel.org,m:ian.ray@gehealthcare.com,m:pabeni@redhat.com,m:pengpeng@iscas.ac.cn,m:kees@kernel.org,m:horms@kernel.org,m:tomasz.unger@yahoo.pl,m:oe-linux-nfc@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[ixit.cz,kernel.org,animalcreek.com,amd.com,gehealthcare.com,redhat.com,iscas.ac.cn,yahoo.pl];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-38599-lists,linux-wireless=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,baylibre.com:from_mime,baylibre.com:email,baylibre.com:mid,baylibre.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D713703FED

The most common style treewide is:

 - A single space in the list terminator and no trailing ,
 - No comma after a named initializers iff the closing } is on the same
   line

Adapt the of_device_id arrays accordingly.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/nfc/nfcmrvl/i2c.c  | 4 ++--
 drivers/nfc/nfcmrvl/spi.c  | 4 ++--
 drivers/nfc/nxp-nci/i2c.c  | 4 ++--
 drivers/nfc/pn533/i2c.c    | 8 ++++----
 drivers/nfc/pn533/uart.c   | 4 ++--
 drivers/nfc/pn544/i2c.c    | 4 ++--
 drivers/nfc/s3fwrn5/i2c.c  | 4 ++--
 drivers/nfc/s3fwrn5/uart.c | 4 ++--
 drivers/nfc/st-nci/i2c.c   | 8 ++++----
 drivers/nfc/st-nci/spi.c   | 4 ++--
 drivers/nfc/st21nfca/i2c.c | 6 +++---
 drivers/nfc/st95hf/core.c  | 2 +-
 drivers/nfc/trf7970a.c     | 5 ++---
 13 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/i2c.c b/drivers/nfc/nfcmrvl/i2c.c
index 687d2979b881..068c5d278a35 100644
--- a/drivers/nfc/nfcmrvl/i2c.c
+++ b/drivers/nfc/nfcmrvl/i2c.c
@@ -246,8 +246,8 @@ static void nfcmrvl_i2c_remove(struct i2c_client *client)
 
 
 static const struct of_device_id of_nfcmrvl_i2c_match[] = {
-	{ .compatible = "marvell,nfc-i2c", },
-	{},
+	{ .compatible = "marvell,nfc-i2c" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, of_nfcmrvl_i2c_match);
 
diff --git a/drivers/nfc/nfcmrvl/spi.c b/drivers/nfc/nfcmrvl/spi.c
index 8dd71fed8493..34842ecc4a05 100644
--- a/drivers/nfc/nfcmrvl/spi.c
+++ b/drivers/nfc/nfcmrvl/spi.c
@@ -182,8 +182,8 @@ static void nfcmrvl_spi_remove(struct spi_device *spi)
 }
 
 static const struct of_device_id of_nfcmrvl_spi_match[] = {
-	{ .compatible = "marvell,nfc-spi", },
-	{},
+	{ .compatible = "marvell,nfc-spi" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, of_nfcmrvl_spi_match);
 
diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index 39b43f8f3bf0..d424452934ec 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -355,8 +355,8 @@ static const struct i2c_device_id nxp_nci_i2c_id_table[] = {
 MODULE_DEVICE_TABLE(i2c, nxp_nci_i2c_id_table);
 
 static const struct of_device_id of_nxp_nci_i2c_match[] = {
-	{ .compatible = "nxp,nxp-nci-i2c", },
-	{}
+	{ .compatible = "nxp,nxp-nci-i2c" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, of_nxp_nci_i2c_match);
 
diff --git a/drivers/nfc/pn533/i2c.c b/drivers/nfc/pn533/i2c.c
index 2128083f0297..66d201c14a40 100644
--- a/drivers/nfc/pn533/i2c.c
+++ b/drivers/nfc/pn533/i2c.c
@@ -237,14 +237,14 @@ static void pn533_i2c_remove(struct i2c_client *client)
 }
 
 static const struct of_device_id of_pn533_i2c_match[] = {
-	{ .compatible = "nxp,pn532", },
+	{ .compatible = "nxp,pn532" },
 	/*
 	 * NOTE: The use of the compatibles with the trailing "...-i2c" is
 	 * deprecated and will be removed.
 	 */
-	{ .compatible = "nxp,pn533-i2c", },
-	{ .compatible = "nxp,pn532-i2c", },
-	{},
+	{ .compatible = "nxp,pn533-i2c" },
+	{ .compatible = "nxp,pn532-i2c" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, of_pn533_i2c_match);
 
diff --git a/drivers/nfc/pn533/uart.c b/drivers/nfc/pn533/uart.c
index e0d67cd2ac9b..83c1ccda0af6 100644
--- a/drivers/nfc/pn533/uart.c
+++ b/drivers/nfc/pn533/uart.c
@@ -238,8 +238,8 @@ static const struct serdev_device_ops pn532_serdev_ops = {
 };
 
 static const struct of_device_id pn532_uart_of_match[] = {
-	{ .compatible = "nxp,pn532", },
-	{},
+	{ .compatible = "nxp,pn532" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, pn532_uart_of_match);
 
diff --git a/drivers/nfc/pn544/i2c.c b/drivers/nfc/pn544/i2c.c
index 50907a1974cd..7fde3aefae70 100644
--- a/drivers/nfc/pn544/i2c.c
+++ b/drivers/nfc/pn544/i2c.c
@@ -938,8 +938,8 @@ static void pn544_hci_i2c_remove(struct i2c_client *client)
 }
 
 static const struct of_device_id of_pn544_i2c_match[] = {
-	{ .compatible = "nxp,pn544-i2c", },
-	{},
+	{ .compatible = "nxp,pn544-i2c" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, of_pn544_i2c_match);
 
diff --git a/drivers/nfc/s3fwrn5/i2c.c b/drivers/nfc/s3fwrn5/i2c.c
index 499301a6fa3f..4ba762611711 100644
--- a/drivers/nfc/s3fwrn5/i2c.c
+++ b/drivers/nfc/s3fwrn5/i2c.c
@@ -211,8 +211,8 @@ static const struct i2c_device_id s3fwrn5_i2c_id_table[] = {
 MODULE_DEVICE_TABLE(i2c, s3fwrn5_i2c_id_table);
 
 static const struct of_device_id of_s3fwrn5_i2c_match[] = {
-	{ .compatible = "samsung,s3fwrn5-i2c", },
-	{}
+	{ .compatible = "samsung,s3fwrn5-i2c" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, of_s3fwrn5_i2c_match);
 
diff --git a/drivers/nfc/s3fwrn5/uart.c b/drivers/nfc/s3fwrn5/uart.c
index e17c599a2da5..8f142a255101 100644
--- a/drivers/nfc/s3fwrn5/uart.c
+++ b/drivers/nfc/s3fwrn5/uart.c
@@ -85,8 +85,8 @@ static const struct serdev_device_ops s3fwrn82_serdev_ops = {
 };
 
 static const struct of_device_id s3fwrn82_uart_of_match[] = {
-	{ .compatible = "samsung,s3fwrn82", },
-	{},
+	{ .compatible = "samsung,s3fwrn82" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, s3fwrn82_uart_of_match);
 
diff --git a/drivers/nfc/st-nci/i2c.c b/drivers/nfc/st-nci/i2c.c
index ceb7d7450e47..152c20b6bb01 100644
--- a/drivers/nfc/st-nci/i2c.c
+++ b/drivers/nfc/st-nci/i2c.c
@@ -270,10 +270,10 @@ static const struct acpi_device_id st_nci_i2c_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, st_nci_i2c_acpi_match);
 
 static const struct of_device_id of_st_nci_i2c_match[] = {
-	{ .compatible = "st,st21nfcb-i2c", },
-	{ .compatible = "st,st21nfcb_i2c", },
-	{ .compatible = "st,st21nfcc-i2c", },
-	{}
+	{ .compatible = "st,st21nfcb-i2c" },
+	{ .compatible = "st,st21nfcb_i2c" },
+	{ .compatible = "st,st21nfcc-i2c" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, of_st_nci_i2c_match);
 
diff --git a/drivers/nfc/st-nci/spi.c b/drivers/nfc/st-nci/spi.c
index 8632cc0cb305..5e0b94050f90 100644
--- a/drivers/nfc/st-nci/spi.c
+++ b/drivers/nfc/st-nci/spi.c
@@ -284,8 +284,8 @@ static const struct acpi_device_id st_nci_spi_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, st_nci_spi_acpi_match);
 
 static const struct of_device_id of_st_nci_spi_match[] = {
-	{ .compatible = "st,st21nfcb-spi", },
-	{}
+	{ .compatible = "st,st21nfcb-spi" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, of_st_nci_spi_match);
 
diff --git a/drivers/nfc/st21nfca/i2c.c b/drivers/nfc/st21nfca/i2c.c
index 4e70f591af55..a4c93ff7c5b0 100644
--- a/drivers/nfc/st21nfca/i2c.c
+++ b/drivers/nfc/st21nfca/i2c.c
@@ -584,9 +584,9 @@ static const struct acpi_device_id st21nfca_hci_i2c_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, st21nfca_hci_i2c_acpi_match);
 
 static const struct of_device_id of_st21nfca_i2c_match[] = {
-	{ .compatible = "st,st21nfca-i2c", },
-	{ .compatible = "st,st21nfca_i2c", },
-	{}
+	{ .compatible = "st,st21nfca-i2c" },
+	{ .compatible = "st,st21nfca_i2c" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, of_st21nfca_i2c_match);
 
diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
index 1ecd47c6518e..265ab10bbb61 100644
--- a/drivers/nfc/st95hf/core.c
+++ b/drivers/nfc/st95hf/core.c
@@ -1056,7 +1056,7 @@ MODULE_DEVICE_TABLE(spi, st95hf_id);
 
 static const struct of_device_id st95hf_spi_of_match[] = {
 	{ .compatible = "st,st95hf" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, st95hf_spi_of_match);
 
diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index bc01b46f461c..3802081fb8ee 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -2304,10 +2304,9 @@ static const struct dev_pm_ops trf7970a_pm_ops = {
 };
 
 static const struct of_device_id trf7970a_of_match[] = {
-	{.compatible = "ti,trf7970a",},
-	{},
+	{ .compatible = "ti,trf7970a" },
+	{ }
 };
-
 MODULE_DEVICE_TABLE(of, trf7970a_of_match);
 
 static const struct spi_device_id trf7970a_id_table[] = {
-- 
2.55.0.11.g153666a7d9bb


