Return-Path: <linux-wireless+bounces-38602-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mEULOjvbR2qGgQAAu9opvQ
	(envelope-from <linux-wireless+bounces-38602-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 17:54:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD577040D2
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 17:54:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=d5mccdZu;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38602-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38602-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9EEE30F1437
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 15:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51552F25F0;
	Fri,  3 Jul 2026 15:47:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB52E2E8B9B
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 15:47:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093676; cv=none; b=QMJCoHaHcY7PHBILTQHi/Ycei2g6LimGChkxUzrN13GWolUxvfRlsAfoN14KTkAxqE1NSJGcYz8E0NtZXWCw28gbCxJGisSlnV2WWxyTJuJxKKiTpX6MI0r0NEfGxYbQdaZ9YFC2YjQ5znP8ziwRMfpO7PRUsnChHvE5Umbn5mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093676; c=relaxed/simple;
	bh=vzMw10ajnfrWa3yILor+RP4uxiqayvDj5E1E91RKODI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4+rqH1glqI0+iaSbFEHpjgzOIeIpgciC4NNtlbgO7CN0sMNSMJtZxj/Z7JrG1Jvho8GRrZxmshWHeV5Ykns/d3pEIGdKZvRZMqixXifCZHca0f9SqH0xyoL3+ZZQ1y/EWR030zw7QNCJ6lMqQyEzvw0OQ3/itapsMNWhhL0S8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=d5mccdZu; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493c83474ddso6729455e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 08:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783093673; x=1783698473; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lV0f0Z9AD842TrMr64lEmEi+EmkXZpBoMUEV3t08QAo=;
        b=d5mccdZutkcaisqGf0D168MCO0vDvqcfsAospgLOQ3OvNz2B2/t0PaM0n9LgnIL8u1
         y24OlR1qWVGFKnIPiUC0xUwteJ4602Q2HU1pS6lFeyc+dZl3oQgYbfnWkcPeONI6I2X6
         JQpbxW9N7Oh+eEQB12tn2OCKh0MiiLxy/AYwhvZBBdnVZeuyoE6F0PqlgisFfXm7wE0p
         XvAtWz5e5CAcOIwMoeRBQw72l3aSw6wPKowiWoE/YMrJ1kFJvXN4lNA7jAvPpbeCoQiU
         R1ZVun02XIbP2bJVQw98Y5Zo0V0YZb73WbPWmjhntkgvXWF7ijxYjL98PoDbbrRAYDHF
         YtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783093673; x=1783698473;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lV0f0Z9AD842TrMr64lEmEi+EmkXZpBoMUEV3t08QAo=;
        b=bPoj1Q0eelHH0cy5R0kfrjKAJktt5kkblUkrRgFfAzijoKcWKWvtVXAqtK4bOw3Vjy
         jB/jcBFWm9eDnQvv2JOP93WG4pb0d+g3yguAJmWCbMU4ytHd91baTWnO/UHj3vwH7mq2
         a90A2JdY7hm7HwGpe4AKGe1MmguBKDCyksKUE4M5YJ5Qb7LR3krCK9gXpQRglle+uZId
         2yzodRpeFPRldVmo1mMr9ZKwEKnFCRFjavu8oi7gQchIjL7axi7D5sP7yv+1mkXgrIwb
         EiBDO7HsLtBnSXOBkIhRJgk5k0eXzSVPkj7O+DXWpKLR3hMbbIYyusAtWG/qMqSPkVrK
         LAIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+e0oV2SPe32rUsqvexjq+k5Ph27ArxdisByof/GVFkfG6VrpPztpVXS11PDpDdE6NViW7VPiqwZheSpD6RyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4FYjtRVbnG6Qq+Dj4gNd1Pql05G9FEyH3uRpwQeHdYglXABsd
	g/FZ/8Wa3mr2mT8ebeysxwuQzj/SkSHOJODqcnw6yqhTH4vdRZaglWMcL3mSf91PSYI=
X-Gm-Gg: AfdE7ck1b1A1c2EUWSlvn/GBOniPU0fvMni7nR8I3v6wxaXugU5ojNXHlacpXLXiVv4
	jrjnG/9t7HQtO09IM8AXOM86j29ghw6aRcPNMWbbbymRaQerX6lRUI2zJb7N9C6gAGka9qenuy8
	CNZOdnrT1vtM7BnMj/VzlHoyLWjFhvMRXdaFLixaKJTdFY9QyX4kJ0odEO4x/yr2Xf8Fe5V98lY
	cDjjlxFtnZfuE7HR2TRFPJScIAAoSY0NgimEItptiokvB2WKlooExo+TkxpD3hJWRZLdnOwcdIn
	Qkh5Rbmi0vRJSLz4UmrkftMj+c0IC/Zro1AQfcu7nOvXOc7ZWIQl5nzBasOqHvsgxWOSWPEJWWa
	Y8/8ffvPahFck1SbAM2WGRnyLNdApN80hoQA2TY0bCjf6lzfIN/IKhC+gKs1+R77GgPRRcvjprs
	qqxhNtqXnMNNWaCOjEoC6mRiWijq64ScyaVvkfU8EKQ/8gBaX7qQZcYE2PQ0RQuG5uorv+76JWe
	B3h
X-Received: by 2002:a05:600c:8b2f:b0:493:a8eb:5145 with SMTP id 5b1f17b1804b1-493d0f06076mr4697425e9.4.1783093673175;
        Fri, 03 Jul 2026 08:47:53 -0700 (PDT)
Received: from localhost (p200300f65f47db0472e4f1e98703de96.dip0.t-ipconnect.de. [2003:f6:5f47:db04:72e4:f1e9:8703:de96])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493bf11eba5sm144585665e9.0.2026.07.03.08.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:47:52 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: David Heidelberg <david@ixit.cz>,
	Mark Greer <mgreer@animalcreek.com>
Cc: oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v1 11/12] nfc: Unify style of spi_device_id arrays
Date: Fri,  3 Jul 2026 17:46:25 +0200
Message-ID:  <78d632098fd42dbf2846cb89d66ec83bb9e1de99.1783091699.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1742; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=vzMw10ajnfrWa3yILor+RP4uxiqayvDj5E1E91RKODI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqR9ltYtAZ1LPor7tRrqg0dN5psWngzXCqjJQGb bGNHU62LYGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakfZbQAKCRCPgPtYfRL+ ToyrB/98yLJKafF7L+qfxoxYURByf9wEdcIgtl4+ulyuFdvbrL9KW8g/yjWMVTm7sbkuRsX+7Fy q9qn3eUaOM887mRk0wt8tt9iw7pJLTXxuAWjf7NhMDJRm8R4P40QiE0U8xuxC3GVimOiIBr4Uu/ af6iU0kzobU7GBvKwax0gb7BNHDooiSPej000/7vGLBDz4OoyCZQfZ/YtZrO/FtGqHBmGk2NQtO 8lpaADEmlxZ7tpCcEg23UTFNW5OmVDHLiag/kp3u4V+xRAx2DiM0sV9VJ44hrF9ClfTW2W+H+am s99kg/FvdqWaThfqfvl65we8GJr/ps40i69ud84C0odK5JwW
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:mgreer@animalcreek.com,m:oe-linux-nfc@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38602-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:from_mime,baylibre.com:email,baylibre.com:mid,baylibre.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AD577040D2

Unify the style of the list terminator in spi_device_id arrays, that
is use a single space between { and }. This is the most common and
generally recommended style for these.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/nfc/st-nci/spi.c  | 2 +-
 drivers/nfc/st95hf/core.c | 2 +-
 drivers/nfc/trf7970a.c    | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nfc/st-nci/spi.c b/drivers/nfc/st-nci/spi.c
index 1b97b2f3f441..7948c7e0c88c 100644
--- a/drivers/nfc/st-nci/spi.c
+++ b/drivers/nfc/st-nci/spi.c
@@ -273,7 +273,7 @@ static void st_nci_spi_remove(struct spi_device *dev)
 static struct spi_device_id st_nci_spi_id_table[] = {
 	{ .name = ST_NCI_SPI_DRIVER_NAME },
 	{ .name = "st21nfcb-spi" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, st_nci_spi_id_table);
 
diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
index d4e3049d138a..321fbe8aeca8 100644
--- a/drivers/nfc/st95hf/core.c
+++ b/drivers/nfc/st95hf/core.c
@@ -1050,7 +1050,7 @@ static const struct nfc_digital_ops st95hf_nfc_digital_ops = {
 
 static const struct spi_device_id st95hf_id[] = {
 	{ .name = "st95hf" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, st95hf_id);
 
diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 673989d5c927..c12653ce7462 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -2311,9 +2311,8 @@ MODULE_DEVICE_TABLE(of, trf7970a_of_match);
 
 static const struct spi_device_id trf7970a_id_table[] = {
 	{ .name = "trf7970a" },
-	{}
+	{ }
 };
-
 MODULE_DEVICE_TABLE(spi, trf7970a_id_table);
 
 static struct spi_driver trf7970a_spi_driver = {
-- 
2.55.0.11.g153666a7d9bb


