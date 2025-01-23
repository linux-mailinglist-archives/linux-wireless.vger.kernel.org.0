Return-Path: <linux-wireless+bounces-17863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0271A1A598
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 15:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB27188BBF5
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 14:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A9120F09D;
	Thu, 23 Jan 2025 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="JecMAe7o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward205d.mail.yandex.net (forward205d.mail.yandex.net [178.154.239.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBDA13212A
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737641828; cv=none; b=igIL3S6KB1JEYfyctdK0zbifyFDQ7D/p+NuLt3c6IZaASLVScNNN43IcwIMnNQBhjVO3vXrDiZRgOk8KgNkho0NebmJ3WZQt/Itkuf4wpCIfV4fRm+axXM3VWBdzV2n/7VL00fCPSKI2ayCHOiDW7DbgUAqUAveIHEqLHyaEKqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737641828; c=relaxed/simple;
	bh=/8r8RznJhlsXfS03D52arltqejKLrc1Ghi2vsK6IVs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kZSDBkz+72kem3odry6j5mU3UQvRsUowP5HkgH5ZEEGBEaXAqTNdoyEy/Hij8pDUfdraw8QlaldWzt2Om3getkYNY5Y2pp4qnXPevLVJCW2q7GAQ/BL85yODs6hauoT9ETS5neiqiWveObaQYd6haPA2LgNB/8UY44HPXHb8PT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=JecMAe7o; arc=none smtp.client-ip=178.154.239.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
	by forward205d.mail.yandex.net (Yandex) with ESMTPS id BB7236568D
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 17:11:08 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-35.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-35.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3ba4:0:640:5b85:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 02B7660B2E;
	Thu, 23 Jan 2025 17:11:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-35.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id xAZbSl7On0U0-1fLZZ2gl;
	Thu, 23 Jan 2025 17:11:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1737641460; bh=spJJBq+LaCn6WYucXQwU4gq0j98gO8AYxxMn341Jz/A=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=JecMAe7opFhDzYh4mY+OawT/3onQgD+FmMdnXPBpljjkrE2Ir6omviWE02/AVkZ6i
	 3W0syogDPEcMFLZ7wj7I/Mi8dRrWquDcoaK5twuxdd/HwVyJDL42ZbWKro5SYW9DXZ
	 aNkHN8vsVeY9XfOn+JheCT0KeICtvO/z+krIqo84=
Authentication-Results: mail-nwsmtp-smtp-production-main-35.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath9k: do not submit zero bytes to the entropy pool
Date: Thu, 23 Jan 2025 17:10:58 +0300
Message-ID: <20250123141058.1696502-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'ath_cmn_process_fft()', it doesn't make too much sense to
add zero bytes in attempt to improve randomness. So swap calls
to 'memset()' and 'add_device_randomness()' to feed the pool
with actual FFT results rather than zeroes. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath9k/common-spectral.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/common-spectral.c b/drivers/net/wireless/ath/ath9k/common-spectral.c
index 628eeec4b82f..300d178830ad 100644
--- a/drivers/net/wireless/ath/ath9k/common-spectral.c
+++ b/drivers/net/wireless/ath/ath9k/common-spectral.c
@@ -628,12 +628,12 @@ int ath_cmn_process_fft(struct ath_spec_scan_priv *spec_priv, struct ieee80211_h
 				else
 					RX_STAT_INC(sc, rx_spectral_sample_err);
 
-				memset(sample_buf, 0, SPECTRAL_SAMPLE_MAX_LEN);
-
 				/* Mix the received bins to the /dev/random
 				 * pool
 				 */
 				add_device_randomness(sample_buf, num_bins);
+
+				memset(sample_buf, 0, SPECTRAL_SAMPLE_MAX_LEN);
 			}
 
 			/* Process a normal frame */
-- 
2.48.1


