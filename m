Return-Path: <linux-wireless+bounces-30704-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65227D13C92
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 16:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A26ED303ADCC
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 15:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F113624C4;
	Mon, 12 Jan 2026 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oZbvcZAe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9C8346AE6
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232837; cv=none; b=ax3irCiME7T7L4ABac7D5tQAUfQqGfeuVNr1bIY9mabBZ9uGCK7Eu0oy/GUdteW+spQnfgIH/D8qOsk5JqJf7gb+TBoEQmr5SBbevyqGsIvhnoi0xV2tPcpzbCF4imX22A7ga9dDnuuGWSmnLHlbJVK5AkL2DrerJ5DT0+G19FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232837; c=relaxed/simple;
	bh=ZRl9U2eWNBrBGlVV90s5iYJcQXBiMXawJuqIetzdtkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpZNc3pADEK6JejuUGy738fPu6afQtLLT94+DXRYhQtSY9zo8YPJw4taIw69zAW1YxJegBWdcx5ri9++wMARREoJN86ZvxA13VUtj3beIUu0kYUtaKZabq0d8xmh0DmMgVYeDAezdoUq/lnrB13Bjg/1ceJNbzpM24LCCFn4k1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oZbvcZAe; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43277900fb4so2314635f8f.1
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768232834; x=1768837634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEicXomtf6TLRidf/WjHVwpRlXa9+6h/7rckG81TX6A=;
        b=oZbvcZAeOiE7GKnKqzRTg3EOAkm6nDHrEkBvfb7/EyjOkj0MgdINnMvWYq4oBSLfR4
         Oo163g9ugqZt/YAKYn78FfMBm6AgYRptb38Ah01p/f/R3DUzSFwKKlGEHyWyxrsKNXBL
         +WlprEGj/xqeOr0cj5FjC2t0IAEUyuaMp8jxBbpt/f8tYlZID+IRNMnICIW7MgAf+aa0
         31RwmJZ9lbVIYD2yPcu9g5wUvOkcWTMrROdhFLtd5dHA5Z7k3j5a5akfCFL+oiKegCHp
         hdvDGMntCcZx3bORlDX1lLubV8WSJzM/7eIU50Y0YcaEnEWfU+mtlLyVa5UmMNe7OTNu
         eDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768232834; x=1768837634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QEicXomtf6TLRidf/WjHVwpRlXa9+6h/7rckG81TX6A=;
        b=EuHY6R8eheNzdYa7Hsrf9lPphmLHTnF0G8MPemYbhFi2jzY9bd+tNqgkq35/Vsn8w9
         LBoYCQ5eS7n3ZIQfY8XFBjplq6Wcgw98/8+uA1AeICVn/CGLEa6BYdgSakpm9b2XTHCY
         zUp11pjL5oyZo3FFpBmrJ52ULUwMuYQcoK5GnkJQTjZnV0eYdA4vKjuaqtGnM0Omdnn8
         OGlgkVlf1WzSdWe6+t3V+Pp5Yll70IV67WpWjbmf7tceCV8Ph13UJEyKpsE6n/HINVti
         qb0fsmLtyZpAetocYR7Xz2IKxQtFF6W5poPN5cO8SQzvKWsb2tLqq7U7gdYDSCBCSE4L
         vRnw==
X-Gm-Message-State: AOJu0Yy3w6PSz7CVfvcPI2ttty2Xw9Z6SNhbNh7U+Pn0Rp5pzaG7azgk
	QpWOjAAszsL3XfgXcoYemJuLeLyWSbtd0/I0gv7p+3h/PqxEzscnL8jmexDOfykHmNWi8QZ4Hnb
	F3Uhg
X-Gm-Gg: AY/fxX51o3K9+5AAf8kKmfklQbQ9qIzq9hqOZ2P4e2eN1RMWNk0CuW9cFRahqi7ssHD
	9ixJCNZryXlGcXjMUckIqthVVqmEYeUiwMYK6paeko4aWe6DZG9xHk2U9jNN81OUuFrwE2G1Ijj
	VDjzfGr4jzBcjkhkvj8+PBOfsLWxphUzL1z/pN13QnJPCEvYCnOzPMhfYbux7A53cgJRUuM/I8e
	BfLtN2i8drVpcxc/NoVnhx5p3wDnsxkYtAy1ci1opR3ZB8yZkEzCM1UFEaL1s9BS+TvkXwblwIA
	0sQdbYuiiyerWSrkH9626c8FH2FS7x85crMDKNhRq0NXRMjDRDbpGNyvPkQ0hXWpmyB/FzIabV5
	7MAkd1D3lad+T5BCGgj2XFzS0fTd9W9WInSdsls9ifBfCuz4DdLQ0rtF+/bHckeL8d3KNb5h9Cs
	cXxFhYLbp/wI4QTa/csWJpu7IkBOQj7XNQR9wqX7zco6FByXDFnwSJUtpD0wJ+elYz4SItd4fH
X-Google-Smtp-Source: AGHT+IHMZ85csB50BO2m87ENQgmCB8Ih1xeLjmd1v22N/Cw65kTyEtKJRa0ovnk859ikxMf6kzUdQA==
X-Received: by 2002:a05:6000:24c8:b0:432:86e3:84ec with SMTP id ffacd0b85a97d-432c3763569mr21308142f8f.23.1768232833662;
        Mon, 12 Jan 2026 07:47:13 -0800 (PST)
Received: from localhost (p200300f65f20eb047d7efe6100b35af4.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:7d7e:fe61:b3:5af4])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-432bd5df8besm37343069f8f.26.2026.01.12.07.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:47:13 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 2/3] wifi: rsi: sdio: Migrate to use sdio specific shutdown function
Date: Mon, 12 Jan 2026 16:46:58 +0100
Message-ID:  <2909323889b8ad4732ef6a8e05b5c40487a6c4bb.1768232321.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1768232321.git.u.kleine-koenig@baylibre.com>
References: <cover.1768232321.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1221; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=ZRl9U2eWNBrBGlVV90s5iYJcQXBiMXawJuqIetzdtkA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpZRd2k9HsNgMP1d8tgsYl76HQQonJMxu1W2WJl Fm3PuV5l6+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaWUXdgAKCRCPgPtYfRL+ TsOBB/437Bp3D5ceQFgc5rPHTqw+pJSX93vqGKEyLVuYDXgvdGTfAXaKXc0lMRjJM0UMz9cRaNH o9a+fX9Kvj2M8JQc1xp7ph8ZTmP6B+3fzEASE1aQ/nZch5CGLBdM6L5NecaLP7axlJ0TJnbr901 2VGfM5eo9eEH5aE7qDUgxY+xD9PmrZvtewzBAoa/ATilJZVUuQlpvi4wekN/PWTeTuWgxfwO1t6 jrcfzAmLoAX06/k1b3ZXfPL3LJRpXjO+xzsG9vAb7lNfZXhrxtrIbgxps5sGc3iADXsEvIdLvvM 4S112SfyJgOyWuLN8X+CKRqqknR3NobyHU5KbxVc/QAoTex4
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This saves a cast in the driver. The motivation is stop using the callback
.shutdown in rsi_driver.drv to make it possible to drop that.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/net/wireless/rsi/rsi_91x_sdio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless/rsi/rsi_91x_sdio.c
index 1e578533e473..ee7ad81c858d 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
@@ -1443,9 +1443,8 @@ static int rsi_thaw(struct device *dev)
 	return 0;
 }
 
-static void rsi_shutdown(struct device *dev)
+static void rsi_shutdown(struct sdio_func *pfunction)
 {
-	struct sdio_func *pfunction = dev_to_sdio_func(dev);
 	struct rsi_hw *adapter = sdio_get_drvdata(pfunction);
 	struct rsi_91x_sdiodev *sdev = adapter->rsi_dev;
 	struct ieee80211_hw *hw = adapter->hw;
@@ -1513,9 +1512,9 @@ static struct sdio_driver rsi_driver = {
 	.remove     = rsi_disconnect,
 	.id_table   = rsi_dev_table,
 #ifdef CONFIG_PM
+	.shutdown   = rsi_shutdown,
 	.drv = {
 		.pm = &rsi_pm_ops,
-		.shutdown   = rsi_shutdown,
 	}
 #endif
 };
-- 
2.47.3


