Return-Path: <linux-wireless+bounces-38600-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ul6AM0HaR2pDgQAAu9opvQ
	(envelope-from <linux-wireless+bounces-38600-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 17:50:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB67570401A
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 17:50:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=oHsES5eo;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38600-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38600-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D96C30238D3
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 15:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E9E2E1722;
	Fri,  3 Jul 2026 15:47:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC2C2D7DC6
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 15:47:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093674; cv=none; b=D33B8uwbtEUn+zagIIw/SOs5Gyw+zxPDbcz4Yo9iVnAIOEHKmsun1n8gGyqqEjUXnIKsVvbCY42uLy0SZXwcQpziyJvrGCn0gTQEK07TUv8DN7FWU1yEq8zqP7CEKLJ97uFA/KYFkHT3BtlZJ44E+YfH3LMSQdC0SkBT2g6XfDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093674; c=relaxed/simple;
	bh=/05CrF/2SzP5JuGbrxM/FXT+JGkfk+pdRkCjznb7Lyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkPL3AwjsJhgH9tnzcc+cNqSZK/NTtAtcrU+3Qmb99dmjMewsu0mpCy9p2s6PWGz9qnrUuCmrc5lLWowx2s3gp/kjj/e9qUpfr9+HOHAn+NeN2zNbGvyv3bbCdKYuYA8ldVD4g3cOImKhAzcCqs/msIExjauR58vlmK2qXcLyBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=oHsES5eo; arc=none smtp.client-ip=209.85.221.45
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47488efcf30so469381f8f.3
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 08:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783093669; x=1783698469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XObmSid5rWVDs24+y2Z1pazYwKHrVLxvdlmXq4NkD6E=;
        b=oHsES5eo7FNwAuUKW1t88qzrzErpbjPXk0N4CLqZnlsL6N0WvN17EmuEKkGTqA1Xh8
         8/v2uFfKFnv7JDIn6c3tSpJDeLldF3W20uyLhLX24bESNHcByn008QCSm898ve7f7jAq
         uM6/NRo4MpxStqoQEx47PZ2Qe6qiaSUQJMpp5co2Exr51oc6WaCodR55jzNqpHLJ3g9c
         aOsioQsWQvmSsjgGoSnRTl0syrWM9tnDGxC4aw/bbXLESd2rF6vwec9KrfPR9zAkcQtw
         aDRBRYpgKGXymRa3LXToS1jLCECoWd1xJiHU8JlC+SKUeyEoKvBzA1IEgUm0qM+KIlok
         iTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783093669; x=1783698469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XObmSid5rWVDs24+y2Z1pazYwKHrVLxvdlmXq4NkD6E=;
        b=q3vddd6/CpECPMSj/KaVYp43ZkpIgFFD0qy/57+6BjwGcnL4gSjVM/JDlAgJa/mZ7l
         QcZWUVvJG0Y4ZrpPC6ZVX9qouquYEwQMv1osLSqnm1MLZTIbxvRIpt4OZZy72QkyzLzE
         019jIU5XgAV4zan7SFPbEwZNttyyDqBULiFdQVkVIFvMsdlXjx46y8Jwgye1VyyJz80k
         XctoeQqaSWg/2O0+SdqelEWRZaw8Vbi+VJJ1GrUBLET/1wgH9CmWJCxZhJGY6GfsIBqC
         QHv3+U9o28bdb0hGv6K86EBIIaU2SQSBa36Ri/e4GQTqm5+NnyR6bOvSYheYAYjim+7N
         p0oA==
X-Forwarded-Encrypted: i=1; AHgh+RqgvaJRoEB7WIwEXKWJfqD7nkh3PipIqR9V2Feiwuvyj58bLcZfGpH3mpir/a1H+W195U8REzICLY5RNd6Q3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHUsxR1IFOvCEJWohlMcLOvEkC9fTf5Kk1mcix3PDMGIP4hQiK
	+Xr1qlMwA4UXeEs9efzUKIkp60vYpug+6FsKbxpBAcajajmRsRJ+zYMhSV2hd+FrW/U=
X-Gm-Gg: AfdE7cltY/OPL9HC3SvshZH6VLoTDt1zFtP3q/cssig+hUwylHRjSSZ40bixeIZpd/O
	SSUHaZHlrg7C5ZruG1qFnVM9Xkn0aYgpFKsKcgqFG1CbX41YSYnLLAJyiz7Ar90fAcCpha6HVFk
	hmOkJvSooXW5yW/LsgkuwM3x71NpSCGGQ2ITpVSiDx2SVDGaksek31hMZalotiNANzjUJdPjrbG
	jHwOyveQvB6pdAlhmMfyIsZeVT7dxRZCILFJK+2zI+YfKZGMHY7qxEZ5f7Vxvqct29aSdlwO1Z8
	yitE7L1AvEcdOwnCs/fenhxp91i8mpupMQR/CQUIRXbxKjVNCQTMXT6XZyS2C6eTu0QgwASw/JK
	3ctqdIPTwX0lsPqjV1wJS9UumopkzkBALD6WynRL1xNuuNlVZ3dYWulVY+HrGAQ7rIupV5EJ9Jy
	CZd3yPy2cHrle8IPGz7RH9EypKumdLfTsK/mENinMBFczofeSGxVk8zgxuaUtsD4nawDPRPoV4W
	SXO
X-Received: by 2002:a05:6000:2c0f:b0:46f:7d90:8121 with SMTP id ffacd0b85a97d-477583280e8mr16112347f8f.14.1783093669050;
        Fri, 03 Jul 2026 08:47:49 -0700 (PDT)
Received: from localhost (p200300f65f47db0472e4f1e98703de96.dip0.t-ipconnect.de. [2003:f6:5f47:db04:72e4:f1e9:8703:de96])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47aa0960816sm204810f8f.29.2026.07.03.08.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:47:48 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: David Heidelberg <david@ixit.cz>,
	Mark Greer <mgreer@animalcreek.com>
Cc: oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v1 09/12] nfc: Drop unused assignment of spi_device_id driver data
Date: Fri,  3 Jul 2026 17:46:23 +0200
Message-ID:  <c645d5855d26307d6164122412335533febbf8b9.1783091699.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2337; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=/05CrF/2SzP5JuGbrxM/FXT+JGkfk+pdRkCjznb7Lyg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqR9loglMTx+4sYWE7/1hQ3OeE8HuPWClyE12lY oBI1NW8EJ6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakfZaAAKCRCPgPtYfRL+ TpDVB/oCrhbM+rnbVWuPSxRJyQsOwuc0QCEQ6j4ysYXuFXJ6qRpSyvZkqc/ekKzkZ5CU8S177x9 WbTD14sLzWQ2z69z2jD/WUYY2qcQ9bCSe2GlqM99wN09oWXqZrBSv9i/Wy3FHjmGmbvy7AEb4bI i1YZDk/VXsrDC3etmgrmX40jD6lpeWNPHY3h4WwFpEnaL8QL5i4s+T1P5ZAVGs9/WcTXoVgrXBt aDtL6n4tTqF8doyh0J4QIcsMSp5tgX+91EHKvgDK1iWoDdwl2hThG4P7GozyajTq3aStS16aIVI jPzSxZjBo0cr+OG1+AL394Anl3ZjREKibIjHwJQgjXSa9BzI
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
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
	TAGGED_FROM(0.00)[bounces-38600-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,baylibre.com:from_mime,baylibre.com:email,baylibre.com:mid,baylibre.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB67570401A

The drivers explicitly set the .driver_data member of struct
spi_device_id to zero without relying on that value. Drop these
unused assignments.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/nfc/nfcmrvl/spi.c | 2 +-
 drivers/nfc/st-nci/spi.c  | 4 ++--
 drivers/nfc/st95hf/core.c | 2 +-
 drivers/nfc/trf7970a.c    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/spi.c b/drivers/nfc/nfcmrvl/spi.c
index 34842ecc4a05..f873f5380017 100644
--- a/drivers/nfc/nfcmrvl/spi.c
+++ b/drivers/nfc/nfcmrvl/spi.c
@@ -188,7 +188,7 @@ static const struct of_device_id of_nfcmrvl_spi_match[] = {
 MODULE_DEVICE_TABLE(of, of_nfcmrvl_spi_match);
 
 static const struct spi_device_id nfcmrvl_spi_id_table[] = {
-	{ "nfcmrvl_spi", 0 },
+	{ "nfcmrvl_spi" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, nfcmrvl_spi_id_table);
diff --git a/drivers/nfc/st-nci/spi.c b/drivers/nfc/st-nci/spi.c
index 5e0b94050f90..1bbda3d0a7dc 100644
--- a/drivers/nfc/st-nci/spi.c
+++ b/drivers/nfc/st-nci/spi.c
@@ -271,8 +271,8 @@ static void st_nci_spi_remove(struct spi_device *dev)
 }
 
 static struct spi_device_id st_nci_spi_id_table[] = {
-	{ST_NCI_SPI_DRIVER_NAME, 0},
-	{"st21nfcb-spi", 0},
+	{ ST_NCI_SPI_DRIVER_NAME },
+	{ "st21nfcb-spi" },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, st_nci_spi_id_table);
diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
index 265ab10bbb61..52fe81a557a0 100644
--- a/drivers/nfc/st95hf/core.c
+++ b/drivers/nfc/st95hf/core.c
@@ -1049,7 +1049,7 @@ static const struct nfc_digital_ops st95hf_nfc_digital_ops = {
 };
 
 static const struct spi_device_id st95hf_id[] = {
-	{ "st95hf", 0 },
+	{ "st95hf" },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, st95hf_id);
diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 3802081fb8ee..8f36ff82be8b 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -2310,7 +2310,7 @@ static const struct of_device_id trf7970a_of_match[] = {
 MODULE_DEVICE_TABLE(of, trf7970a_of_match);
 
 static const struct spi_device_id trf7970a_id_table[] = {
-	{"trf7970a", 0},
+	{ "trf7970a" },
 	{}
 };
 
-- 
2.55.0.11.g153666a7d9bb


