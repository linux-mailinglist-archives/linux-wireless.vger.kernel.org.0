Return-Path: <linux-wireless+bounces-16799-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1F69FC5D4
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Dec 2024 15:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563281883565
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Dec 2024 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C34F1E49F;
	Wed, 25 Dec 2024 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="qXXbJnRM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward205d.mail.yandex.net (forward205d.mail.yandex.net [178.154.239.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDC41CA81
	for <linux-wireless@vger.kernel.org>; Wed, 25 Dec 2024 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735138535; cv=none; b=q73JC4Gt6xDKwwu85Dn/UFCsKiul7sM12DjRvsnOk6myWW/FjPbv9+8G6GD73yEB9//cZJlVr1eSS6fzdVzIIX2fa/zm9iL69JUErd+X0Wjs0rpalvOcAdf1oIvDwNDIC2LeIdHI7FYgczpM/RbtbQNHz2fKXZyOmUAhpfsCqUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735138535; c=relaxed/simple;
	bh=7bXYzJTA1oQtdKSs5waUTZvXr91dT77Bll9albCK6CE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a0LJhqxpRpt+xt/uxflQ1/o3lvHPUNI7oh41eIjRDVEevN+TKfAocvV7WQBZkW3vGHLcUznjJNuuGuL43AOJTTO4JqlyAu1gOpjmoCt0JL/OQSNdjxlheA9P8Zd83fZGWpn7dZqR8hyrTV+rDMuljgpLA/XFJ/5wPqvfr4JYfJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=qXXbJnRM; arc=none smtp.client-ip=178.154.239.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
	by forward205d.mail.yandex.net (Yandex) with ESMTPS id 795A1634F1
	for <linux-wireless@vger.kernel.org>; Wed, 25 Dec 2024 17:47:49 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2d15:0:640:bb71:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id ACBF56090B;
	Wed, 25 Dec 2024 17:47:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id dlZIXoBOm8c0-vi8C0NAr;
	Wed, 25 Dec 2024 17:47:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1735138060; bh=xQJmwGDDbtqiIy1uEFsEG+M73l+y3BlfC3Fumwt6jDU=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=qXXbJnRMBGSRskX5De5B12AvUnkEKSYAXBimQhazzIvyWhoTHiEP0bv2MrTZmsB23
	 BtNlHRXe3dndEe3m0tVVR63MRV+8lsTeIUzg5refpbOQUAPkF3wMNQeP/iEYPJ226O
	 pye35a7O8HcydA2YAZK+0maW83BGJletyHl6XRmM=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath9k: cleanup ath9k_hw_get_nf_hist_mid()
Date: Wed, 25 Dec 2024 17:45:35 +0300
Message-ID: <20241225144535.104787-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.1
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
 drivers/net/wireless/ath/ath9k/calib.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/calib.c b/drivers/net/wireless/ath/ath9k/calib.c
index 4b331c85509c..26465c1a59e2 100644
--- a/drivers/net/wireless/ath/ath9k/calib.c
+++ b/drivers/net/wireless/ath/ath9k/calib.c
@@ -16,29 +16,25 @@
 
 #include "hw.h"
 #include "hw-ops.h"
+#include <linux/sort.h>
 #include <linux/export.h>
 
 /* Common calibration code */
 
+static inline int rcmp_i16(const void *x, const void *y)
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
+	memcpy(nfcal, nfCalBuffer, ATH9K_NF_CAL_HIST_MAX * sizeof(int16_t));
+	sort(nfcal, ATH9K_NF_CAL_HIST_MAX, sizeof(int16_t), rcmp_i16, NULL);
 
-	return nfval;
+	return nfcal[(ATH9K_NF_CAL_HIST_MAX - 1) >> 1];
 }
 
 static struct ath_nf_limits *ath9k_hw_get_nf_limits(struct ath_hw *ah,
-- 
2.47.1


