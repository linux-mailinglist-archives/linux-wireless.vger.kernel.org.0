Return-Path: <linux-wireless+bounces-34932-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIjzGyMy4mkZ3QAAu9opvQ
	(envelope-from <linux-wireless+bounces-34932-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 15:14:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FDA41B7FC
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 15:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 789F330F892B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 13:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E00E3B6340;
	Fri, 17 Apr 2026 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Dndwzmpy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862E73B3BEA
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776431495; cv=none; b=JEiE6cCXv5qbUX2BjzP41q/j4KOzLwDseSq9n7GbLxxHQRE+h13Ai9Ak/HdPwuI//GJLy4bDaCzGtRVNfqGvcNJdJDwuyQigQYzAis+Ew/1nhdSsr6V4Nfwo7UYsjOhmzteacz6KmKiX83mTlDnUVdHussNiaIhCYQRYacagKLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776431495; c=relaxed/simple;
	bh=g/o2zj1w35MZdVu49VPAZd9P95ygaOzBdtAfyUfCa+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ux6cpS7cantbJgST6ryDLDZM8CF1U8M4etD4jsKkocHfwc1xrkv8ptxNsuVqNVuk0jDjLuATNFjP6BK7AiP/wcA1IqlXbGd8heLGPSQ7BuM7sg6q5Sz5vCXd+fS9RTGZSPQT6RXyH+AbF7Jx/zFke3tkwmiY4D/w2qyH9wvh22M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Dndwzmpy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48896199cbaso7220475e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 06:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776431493; x=1777036293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1dN0O/j7EE1Y0u7otXXkk+s6loIuCLpRRFSoniAyZ0=;
        b=DndwzmpytlSY0dcC/LWJXaDBlfcAw8XxW4mw6FUHyWvzEJt+B9RGqk5LFfISg8fG2O
         jaw4gz0ySfpa5grj0UptLLRSTtOEQhG3CdiEC/4KJ22uuH6g3C8wMackqnj14czB7Ckc
         uZEpZtTH7mZJ9Abmm+XApaySSZQQKWADe9c+dfNdheB61UmHecbrK5dTI5EP5jvVzNGg
         UGKE5/oobD01R2pcPjA6Xn7oYf76t4ZBqsiDrAfNrRNT/ez7wgEpdL14LGKIy6g02zTw
         HxIasGFcXsiCtS/NvdhhOEwyC5k1LC/eO9dNp434K2jtGEUapR8GH3pVRwH/FbFjW89r
         JmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776431493; x=1777036293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U1dN0O/j7EE1Y0u7otXXkk+s6loIuCLpRRFSoniAyZ0=;
        b=QFiV5Jz1R+yFOQbraqUOFwB5M+27NnqFeIWTPGCRysQj4BssL2dFYJQsM2JQdQscjd
         RVCG8oBaWQJRHXG9/o0N7m7M64AWYDe0AFrh3MPdnXAkB3r2HjZ7ehM0CTo0wG2pscGg
         yg7KXcGESdG5E22aw1Q7gxJC2pD7ZH3ia89ZDOfBuHyM0YfT6aAXmUpLMhVShxvRcDx2
         OLCf2S2cl0EOpUmb4AkeQVcvkAwjkFvmP309jixzVu1BUL2pNXllvoRcSOqKN4CImvnd
         IEbl+Oji6xs0DbHRAYQ2PQSWyhyuOQ3VAblYsFz8Lr/LfQJIHm4zTdchvduzGoFjMTs4
         6mog==
X-Forwarded-Encrypted: i=1; AFNElJ+dDJywLxxEEoYDmDnDdCyPm0P3/sVl51pr94xhH2qwTiZUs0bS+Mu9z4UECw2zKx/fTByMpFSZIQohmQ0+QA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoDr+qFyC6NpTmr+ONLFZw6MaCY/dZ8hkd1/MTVIZxIvu/TjWO
	L1L6C01YazOzz9Fy1CMUSV6HcDLTZIELx35J5E6EvxFZsBXqqr6E4ycU2E9KIr6mFZQ=
X-Gm-Gg: AeBDiesZGbnn9/q9/0UEI35pFmxiBkz8iGOdozrwk+2t5ogZITTkOVGmlTSkdUOCvfM
	zraU+k1zOkK60MtwsE503gT5HjGr4Foket6KQRrJtdiWU1wonA49/jx4KXw6C+QzYxkGq76aOUk
	1/RHCPRO9AAFVIi+xbu+21VyUmzsX7C7PM0QPXJ5u/XePRUp/A4/4kqz/R+rzbMVc5oOaC37HBO
	jg4tqtDSg/ief9BOac85FHWk593PmqCDcFaufhoWSiFoZ/4TnIwQ8jdVNA2GVDGMLXAKGtqKhd+
	E6deSf0i8V+j6FUdYy9Bjz+PfYiFD5mSC+7jJeiByL3PT6N3mp5zC8HUhxFfc1/V4LAyVfft3xO
	LK3TD4Xtsxtm6TGnkev6intiAiV7NI8FBXQJKkxvOnrqGeraaprvIq0+HNJ+MwtXgme8/vZzciA
	YTipp/UWbcCm49yo+wQI5ANPb4WhRxqnGjw2mM2qqNYO6pBSedzN56V9pxi/EOTz6Dtjl9nSlWT
	Mr8jdSGtUEu8UTBJeGVz6RT
X-Received: by 2002:a05:600c:4750:b0:486:fdba:f5db with SMTP id 5b1f17b1804b1-488fb6e7316mr43903205e9.0.1776431492894;
        Fri, 17 Apr 2026 06:11:32 -0700 (PDT)
Received: from localhost (p200300f65f20eb08db61cfc60d8aa232.dip0.t-ipconnect.de. [2003:f6:5f20:eb08:db61:cfc6:d8a:a232])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fc13938fsm64770235e9.10.2026.04.17.06.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:11:32 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Brian Norris <briannorris@chromium.org>
Cc: "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/6] wifi: mwifiex: Make use of driver data pointer in sdio_device_id
Date: Fri, 17 Apr 2026 15:10:52 +0200
Message-ID:  <9dbbb7a9a8ad3a12d562b589a6756baf226d5dab.1776429984.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3002; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=g/o2zj1w35MZdVu49VPAZd9P95ygaOzBdtAfyUfCa+g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp4jFmf/dqoTuKLBG7njXHUAdWAWnJmQIyguFXU lTUdfcLs0SJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaeIxZgAKCRCPgPtYfRL+ TmHGCACoRv8GMpdOUfeCIxEavNFBVl5AIT5f20krZNCiEfaFAsV9SDlTFGbtoelij6JpgeH1dBE h1y01y2BYHEZ/uYNAo2kiN/KY7T3x40lxoyckLweP9jzlLo1M/DxCnJNo7M061yLzvkUGy8dZP4 VEcSfZ7rK9lNh/iT8uyk25DmmSuAOvT+eNgEAOdV9yQxckkhEasTXt6LIaV7kSxAKM6hvuHrLut AuYXsqaXQFk5jDCviiDAmSzSWkkevyOtq7GbloInBeq6zuG3QIYuK4Wxxfm3yjffqd3luWwtIle 66L43JKtIc4wvfq0xYcIoVkRC2pcJYS984Tj38X92ONEn/ot
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34932-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:mid,baylibre.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 04FDA41B7FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Recently struct sdio_device_id gained a new member to store a pointer to
driver data. Make use of that to get rid of a bunch of casts.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 24 ++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index f039d6f19183..ea227f7685b8 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -566,8 +566,8 @@ mwifiex_sdio_probe(struct sdio_func *func, const struct sdio_device_id *id)
 
 	func->card->quirks |= MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
 
-	if (id->driver_data) {
-		struct mwifiex_sdio_device *data = (void *)id->driver_data;
+	if (id->driver_data_ptr) {
+		const struct mwifiex_sdio_device *data = id->driver_data_ptr;
 
 		card->firmware = data->firmware;
 		card->firmware_sdiouart = data->firmware_sdiouart;
@@ -955,25 +955,25 @@ static void mwifiex_sdio_coredump(struct device *dev)
 /* WLAN IDs */
 static const struct sdio_device_id mwifiex_ids[] = {
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8786_WLAN),
-		.driver_data = (unsigned long) &mwifiex_sdio_sd8786},
+		.driver_data_ptr = &mwifiex_sdio_sd8786},
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8787_WLAN),
-		.driver_data = (unsigned long) &mwifiex_sdio_sd8787},
+		.driver_data_ptr = &mwifiex_sdio_sd8787},
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8797_WLAN),
-		.driver_data = (unsigned long) &mwifiex_sdio_sd8797},
+		.driver_data_ptr = &mwifiex_sdio_sd8797},
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8897_WLAN),
-		.driver_data = (unsigned long) &mwifiex_sdio_sd8897},
+		.driver_data_ptr = &mwifiex_sdio_sd8897},
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8887_WLAN),
-		.driver_data = (unsigned long)&mwifiex_sdio_sd8887},
+		.driver_data_ptr = &mwifiex_sdio_sd8887},
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8801_WLAN),
-		.driver_data = (unsigned long)&mwifiex_sdio_sd8801},
+		.driver_data_ptr = &mwifiex_sdio_sd8801},
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8977_WLAN),
-		.driver_data = (unsigned long)&mwifiex_sdio_sd8977},
+		.driver_data_ptr = &mwifiex_sdio_sd8977},
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8978_WLAN),
-		.driver_data = (unsigned long)&mwifiex_sdio_sd8978},
+		.driver_data_ptr = &mwifiex_sdio_sd8978},
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8987_WLAN),
-		.driver_data = (unsigned long)&mwifiex_sdio_sd8987},
+		.driver_data_ptr = &mwifiex_sdio_sd8987},
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8997_WLAN),
-		.driver_data = (unsigned long)&mwifiex_sdio_sd8997},
+		.driver_data_ptr = &mwifiex_sdio_sd8997},
 	{},
 };
 
-- 
2.47.3


