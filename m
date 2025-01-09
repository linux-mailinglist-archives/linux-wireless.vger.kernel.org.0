Return-Path: <linux-wireless+bounces-17230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05214A06FB6
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 09:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2FB5167885
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 08:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8082144DD;
	Thu,  9 Jan 2025 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="mTMcZ6Kd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward201a.mail.yandex.net (forward201a.mail.yandex.net [178.154.239.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E25710A3E
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736410053; cv=none; b=p62wJc7OjSXhk5BI+0djZFE9i1CpNToPd6t+9lRN3hkbX9po0m5FethX2XDK2/tSia+kqgoVQgClUWzCKeDVXD0At8n7FfL5xCEsy/zGtxHu+uLkqRv7o4IquYuaiqWayyADbKXxk2ct/mWippdPupQU3rER9MdjvuRKJhNqX/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736410053; c=relaxed/simple;
	bh=eEhXqP30R6WZ0Ld7WaJ0aWZy0bQyAExHS/FPMnjKgH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/Unc92YRl0Bbb8Hb3rqQeLAdJNurk8MWyReFigxWlJ6NOYsRJ2F4jnOXcZdNyW1FBYzMks8eMVRihKy/MNwElFr0tQvQg/Ig+uYRfICiAeLP63XTXcHOmLrA1BN8ta4yVcIMKmpcRFk6L/1uensMDwMPK92/tRJlWnlZLllpdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=mTMcZ6Kd; arc=none smtp.client-ip=178.154.239.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward201a.mail.yandex.net (Yandex) with ESMTPS id 3CBC669CF8
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 11:07:22 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:2f03:0:640:5d54:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 780EE60FD3;
	Thu,  9 Jan 2025 11:07:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id D7i2qL0OeCg0-rhhg2EVX;
	Thu, 09 Jan 2025 11:07:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1736410033; bh=uktSsVncFSYudkRr0+TpCuaF4NW4XzF6BraH+i0u7ZE=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=mTMcZ6KdTyiUeKVLaHWtbnq0DXJhHu2WL3c5Lvl0yvdkyd4k5/56SRwUzpgfzBjHW
	 HcM2438+IiVqi5y3I2BI3pQWMQRavHMqS6ZwuTJpOvh7CgJCOlOu51776qeFOU3J4X
	 XWr9I0gIBHhW6ZLmndU5k+Jtqf2JJFjlaSp4KvlQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2] wifi: ath9k: cleanup ath9k_hw_get_nf_hist_mid()
Date: Thu,  9 Jan 2025 11:07:03 +0300
Message-ID: <20250109080703.106692-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <87bjwp8ax0.fsf@toke.dk>
References: <87bjwp8ax0.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'ath9k_hw_get_nf_hist_mid()', prefer 'memcpy()' and 'sort()'
over an ad-hoc things. Briefly tested as a separate module.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: as suggested by Toke, do not mark 'rcmp_i16()'
as inline and pass 'sizeof(nfcal)' to 'memcpy()'
---
 drivers/net/wireless/ath/ath9k/calib.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/calib.c b/drivers/net/wireless/ath/ath9k/calib.c
index 4b331c85509c..b4ab85bd7895 100644
--- a/drivers/net/wireless/ath/ath9k/calib.c
+++ b/drivers/net/wireless/ath/ath9k/calib.c
@@ -16,29 +16,25 @@
 
 #include "hw.h"
 #include "hw-ops.h"
+#include <linux/sort.h>
 #include <linux/export.h>
 
 /* Common calibration code */
 
+static int rcmp_i16(const void *x, const void *y)
+{
+	/* Sort in reverse order. */
+	return *(int16_t *)y - *(int16_t *)x;
+}
 
 static int16_t ath9k_hw_get_nf_hist_mid(int16_t *nfCalBuffer)
 {
-	int16_t nfval;
-	int16_t sort[ATH9K_NF_CAL_HIST_MAX];
-	int i, j;
-
-	for (i = 0; i < ATH9K_NF_CAL_HIST_MAX; i++)
-		sort[i] = nfCalBuffer[i];
+	int16_t nfcal[ATH9K_NF_CAL_HIST_MAX];
 
-	for (i = 0; i < ATH9K_NF_CAL_HIST_MAX - 1; i++) {
-		for (j = 1; j < ATH9K_NF_CAL_HIST_MAX - i; j++) {
-			if (sort[j] > sort[j - 1])
-				swap(sort[j], sort[j - 1]);
-		}
-	}
-	nfval = sort[(ATH9K_NF_CAL_HIST_MAX - 1) >> 1];
+	memcpy(nfcal, nfCalBuffer, sizeof(nfcal));
+	sort(nfcal, ATH9K_NF_CAL_HIST_MAX, sizeof(int16_t), rcmp_i16, NULL);
 
-	return nfval;
+	return nfcal[(ATH9K_NF_CAL_HIST_MAX - 1) >> 1];
 }
 
 static struct ath_nf_limits *ath9k_hw_get_nf_limits(struct ath_hw *ah,
-- 
2.47.1


