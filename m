Return-Path: <linux-wireless+bounces-34928-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGV/F58x4mkZ3QAAu9opvQ
	(envelope-from <linux-wireless+bounces-34928-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 15:11:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B707741B770
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 15:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2F5530954AA
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 13:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C80F3A380E;
	Fri, 17 Apr 2026 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="kgat+i2O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7AC397E8E
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776431489; cv=none; b=D5cCFzLsCzpYGff99+CMtdb5fJmUBChHT/rSOlvXBjnGQt4mwyEfY0w1jiXP2RnCg4BoG/kKuPZCVtbtR214pRUh0/avV5YuovjdmoCzOolIESGMna+tR+w8FsjLAZFhyqkoG/wyIcqKnLUqbJ57IChVOawVtozKpEHlW6t4Bno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776431489; c=relaxed/simple;
	bh=Klkglyq/jaqn07LVoY+DygFKlFSeY4mf3uyDS+66nUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thqQJVaFPNJvnaOK26kMxQzzotGzfwY/vg60GT5JJ9Pxih/TP3iuPpuMoXyTq171BlLgZGqPMQk3tQwRCg13oxWN4qZ6+sJpFWbcfz7Jvz/hDiBVg11eJD4cgUQR0OAvUocrdXKjZgPTzkeMe5rFgILABG0eQsdoFS9WarMEWbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=kgat+i2O; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d77f60944so499499f8f.3
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 06:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776431486; x=1777036286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLBJQur6L6abrgINbvpQqXST9x1YXfxN6XkkI5ZCGzQ=;
        b=kgat+i2Oa6Wy9zEOI65gHK3Zn9aMLrxwt/mf7bc7zAHG2PcE2wWKWhs+3MjkbcCAuz
         sd9N3EZ9kSFwUmKa20GXjKUvoKsXqum9lZAHIMOR+mVXLGphlnSmAjNKK776hHo3meip
         EXzDLnetciMhyrijIbsYGXjGhtibipFdHPOOjbaNzwu7LYQpF9lH8Jwt5JK3mGczK6Bw
         6NMX4UmX0cqrdoitSk2b/Bn/QR89mLBjpoLJKkTwMKYlKX9gXxl5GQJ6mBjICKg6OsGp
         mbr1S5TM5yOF0ZQyapKPlZJnpvZnFqeGo+JZAE9NUYV0WczLVAnuxj7fFSOYRgbknC+a
         IGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776431486; x=1777036286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yLBJQur6L6abrgINbvpQqXST9x1YXfxN6XkkI5ZCGzQ=;
        b=Lo3oi+19UInTXOgHXPyflJI2oQsucy3ce9MbhXvYB/jeqhhxx59KlfuaNgu/2LxOye
         y8YcK2BV4WeNdWUchVJQ6StBhhsgLlr9CKILPaQMDrxECGYIXtGcrO3/r9Fki4A0VfdL
         J0e1dhf3Osf98HlaAEjSZGFQO2VwlvjePxKBiiPrswGJt/WMCLMctPiaGsMw6HyuPSZ5
         WaOEF0mCVVVgUjKOTjwsViCdhAFJWUg7bXEXy4C7Lm9JUxTitIWEEsrdEOekP5QojpXR
         UIl42Z6TLGbxNzqnSED/BR5mfbfnwKK22UewTQ44siQWydpjDMO7hTfbhvQ8xT5kKP8h
         5XJg==
X-Forwarded-Encrypted: i=1; AFNElJ+ceoUVzfOOC1aZLONRHom7j2qnsY5Eb/nchQnEkbYwqe8G+o0dHPsXQn//W+haqY1Za0lRHEd3C+yDYDEgxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7B79vPttf0BzN+xqXU6RzPE2Z2jZRuj0Cs2YVKbzWHP8FZRhZ
	io0jkhyCU1q6IbxfT4WJVVGp6TYFjey9RNMlLPfb3HZyH6+iMyTRWOVQ2VNkpmwdF3M=
X-Gm-Gg: AeBDieuoRnGiJNjJFt/Hq8U2j2YvvawUBH7qbbB9B0tiqVckACmB8MT+QsgT9ZVs1El
	7SdYYPEZwLM4Inotr+bvKi3QyJYJ3LjuweZKK2OXPFRWIw5hQpD4FRKGi3lmSr+fwoShG2KnvKV
	XHRHnpq6oYv8vVYFA3j1FQIiYM0KfGQ8BNXIemJG0jc4vtps2sVlEWfI85Ep2tTfWICs4uZmer3
	b21F59NRNd8tLzz6Pw9th5obhR0mA+Lt005D8hjjl4IGUzvCybq4qFz0XnZWTSXRJGQsV6kEGsP
	dgTN/QPOH3s3zRROmsizWRBOjoefGNeLFmvZhsxnz3nZ7ZgPYd9VW37eKPPE+XZTCAD+T8e9ky0
	lL1eQghP8Fk1iNLOYsCjJrqldEx8/vyjuM1TJM+2ycc1hdMWEQLR0LkG/OsQ75AhiGKliO3+Raf
	dWay5qKdoVhz0SKMlTQenTMqdQ413Ct4xYyKb9v55Pmxlu38mMpVHdHHhe2WDsNByrQHmvAIzBS
	QOeV5aliHIutpegw+HWlj5E
X-Received: by 2002:a05:6000:420a:b0:43e:a69b:d813 with SMTP id ffacd0b85a97d-43fe3e0d459mr4571980f8f.25.1776431485775;
        Fri, 17 Apr 2026 06:11:25 -0700 (PDT)
Received: from localhost (p200300f65f20eb08db61cfc60d8aa232.dip0.t-ipconnect.de. [2003:f6:5f20:eb08:db61:cfc6:d8a:a232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4e4daf2sm4238766f8f.33.2026.04.17.06.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:11:25 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	linux-mmc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in sdio_driver_id
Date: Fri, 17 Apr 2026 15:10:47 +0200
Message-ID:  <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1594; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Klkglyq/jaqn07LVoY+DygFKlFSeY4mf3uyDS+66nUI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp4jFZkxQbj+KYt4Q9fEkJxuokeQF4k0Z8QVO3Q 7wAQaupW5KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaeIxWQAKCRCPgPtYfRL+ TtZtB/0YGCqVt5rVpLrWqCD44F5LfNFUgv/+TGPxayzQfsH7zoCBqE9UgsVpBkFZprUwAzLBPWG MPbj74nUaxJfky/T/6x/bsJ20CXFl14Aky5oeSqWXwpx/STsvR1t7BH1meFZ1chEsexFTdIwswa 8F2lrrBsAe+eGHk4UdYwOcEBLke8MRKu7X9WInf8735NDYlo6VkX6TwaQTxpOcTlNIDfwZlA6ON nlrxK4GTkQYXCmaFZYylJBpOTDYLdH8GJZthPQhYPW5w9D8jVeVUIanYYaSikHt0R/zyWaylAij O7+GqKklrjT08jMFR3/4DzejRKFhjlyBUA+HrbH74dCapvBS
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34928-lists,linux-wireless=lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[codasip.com,vger.kernel.org,linuxfoundation.org,sang-engineering.com,holtmann.org,gmail.com,collabora.com,lists.infradead.org,realtek.com,nbd.name,kernel.org,mediatek.com,chromium.org,dolcini.it,linux.intel.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:mid,baylibre.com:email,baylibre-com.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B707741B770
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On all current Linux architectures sizeof(long) == sizeof(void *) and
this is used a lot through the kernel. For example it enables the usual
practice to store pointers in sdio_driver_id's .driver_data member.

This works fine, but involves casting and thus isn't type-safe.
Additionally with the CHERI architecture extension there are machines
with sizeof(void *) > sizeof(long) for with the traditional approach of
storing a pointer in .driver_data doesn't work.

By replacing the plain unsigned long .driver_data by an anonymous union,
most of the casting can be dropped and it yields a working solution for
CHERI.

All users of struct sdio_driver_id are initialized in a way that is
compatible with the new definition, so no adaptions are needed there.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 include/linux/mod_devicetable.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 5b1725fe9707..0eb5d196f5b5 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -414,7 +414,10 @@ struct sdio_device_id {
 	__u8	class;			/* Standard interface or SDIO_ANY_ID */
 	__u16	vendor;			/* Vendor or SDIO_ANY_ID */
 	__u16	device;			/* Device ID or SDIO_ANY_ID */
-	kernel_ulong_t driver_data;	/* Data private to the driver */
+	union {				/* Data private to the driver */
+		kernel_ulong_t driver_data;
+		const void *driver_data_ptr;
+	};
 };
 
 /* SSB core, see drivers/ssb/ */
-- 
2.47.3


