Return-Path: <linux-wireless+bounces-24928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9C1AFC91D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 13:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A2A168109
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 11:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A7D215F48;
	Tue,  8 Jul 2025 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b="NYDKt7F/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3616C261595
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 11:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751972489; cv=none; b=E7r5L1JnOUjLiWeJGIfuRlCVBsgiDjWj0MznhdeRKyBSZstfZ4rdtLNuTz8fP7gSx8qKs6Sf5wmsrmjsCCjupEnxH60j/p1GvegGRUMktRynYs9eBTu85AGMfOswv/Vgvry5DR681Thi51nj5RtiOko5F9tllMag6MQN3rXaF8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751972489; c=relaxed/simple;
	bh=wxoUfJD/LjYTnrcYKiqhQtnjgwYaJTHafVyXEeF8XbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H6rRapaFx1FKpiFdZzi4slokzdm2jhT5IpSBd5s6GVQsICs64bXDd8zi0UqZtCozwWWWdnoJ6nTbb+QH0rcJuhjqCRDL+X4b4TYLqaxDGXL0UFQuYlCNyfT9ViJMaJX2xDrZthJ5w0ixrG9YAZyh54EpbDrNRv+NSv4dJi8Yg7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me; spf=pass smtp.mailfrom=0upti.me; dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b=NYDKt7F/; arc=none smtp.client-ip=178.154.239.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0upti.me
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:2f3c:0:640:7ca0:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 319E060E21;
	Tue,  8 Jul 2025 14:01:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 61fFSplM6eA0-VmTTjdGi;
	Tue, 08 Jul 2025 14:01:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0upti.me; s=mail;
	t=1751972475; bh=xzCowVZAkVLlB6K9r1YTa9/vbKlrCX9BPKZEWgetdyk=;
	h=Cc:Message-Id:To:From:Date:Subject;
	b=NYDKt7F/KJ9MhqDKTEVT1r6IRnatXBrYyiuLtKNVhirgLG4GHAXmSvcDbLUtDEgdy
	 FcU13l3uP4i+p6WZvr1aTs0FBCg5BJg5e5yIRdHVXVWUbsj2nXGcZKonTT3/beNIZ9
	 Z7ZHb52yL4m3MV4OvDwbnLLD2CN8XHNH7MgjCikU=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net; dkim=pass header.i=@0upti.me
From: K900 <me@0upti.me>
Date: Tue, 08 Jul 2025 14:00:38 +0300
Subject: [PATCH] wireless-regdb: allow 320MHz channel width for Russia
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250708-russia-320-v1-1-53641e8dd417@0upti.me>
X-B4-Tracking: v=1; b=H4sIAFX6bGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwML3aLS4uLMRF1jIwPdJAPTJMM0I8sUS8M0JaCGgqLUtMwKsGHRsbW
 1AHFEhSlcAAAA
X-Change-ID: 20250708-russia-320-b05b1f29d91f
To: Chen-Yu Tsai <wens@kernel.org>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org, 
 K900 <me@0upti.me>
X-Mailer: b4 0.14.2

The entry was added before 11be (and thus 320MHz) was a thing,
and there is no actual legal restriction on channel width, so
update it to allow 320MHz channels.

---
Signed-off-by: K900 <me@0upti.me>
---
 db.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/db.txt b/db.txt
index 12ac14766a698fc774bf2920bdbe3ff5533d4d5c..22de7b00be60445e49a612eb86a1f1d976039d26 100644
--- a/db.txt
+++ b/db.txt
@@ -1726,7 +1726,7 @@ country RU:
 	(2400 - 2483.5 @ 40), (100mW)
 	(5150 - 5350 @ 160), (100 mW), NO-OUTDOOR
 	(5650 - 5850 @ 160), (100 mW), NO-OUTDOOR
-	(5925 - 6425 @ 160), (100 mW), NO-OUTDOOR
+	(5925 - 6425 @ 320), (100 mW), NO-OUTDOOR
 	# 60 GHz band channels 1-4, ref: Changes to NLA 124_Order №129_22042015.pdf
 	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
 

---
base-commit: 5a8ced5ad3135d72a53260282e760325e26e07a9
change-id: 20250708-russia-320-b05b1f29d91f

Best regards,
-- 
K900 <me@0upti.me>


