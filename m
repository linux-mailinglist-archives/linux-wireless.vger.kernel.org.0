Return-Path: <linux-wireless+bounces-4189-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FAA86B01B
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 14:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D645C1C257EB
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 13:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150183BBEE;
	Wed, 28 Feb 2024 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Zh6vIBIw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward201c.mail.yandex.net (forward201c.mail.yandex.net [178.154.239.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75C6149DE2
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126400; cv=none; b=Q3vE8bqzpztbYUUUDhuRY4pL+xO3XxpnIJChQbiEelMrEp7hBOrwXQG6o1aS3KR+xUZPWktW9ymmf3ihjp4st5zftrOhbvub5RErHiKKAp1wX98TY+pllyYWhApoohI+mUhxCpGKGHOBsmsi1x0lyzcizM1dvO0wNCaEtaZdmXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126400; c=relaxed/simple;
	bh=uLiJjCAL4NrQGVPz9RxXPebySmm7585inFNecGAQGpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=anO8aVyS9+LLC2JcGAKxzEehbJZOuL7b83aL4qdNL3r3YCi/m+OnMqsuC/xgv4BTKMXHzchxw/12elWyiqO4u2LC0+DmnZIzURxZ3PdGJqpSvjDJG3gVXru+oiKwNzQZseN9/dUkDRwjuqRjOQsL1DQdQep9wl8AAP/6OXfDfG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Zh6vIBIw; arc=none smtp.client-ip=178.154.239.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d102])
	by forward201c.mail.yandex.net (Yandex) with ESMTPS id 0C01865FF2
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 16:14:39 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:440b:0:640:fa3a:0])
	by forward102c.mail.yandex.net (Yandex) with ESMTPS id 4158D60A9D;
	Wed, 28 Feb 2024 16:14:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id TEZITt9GcOs0-3Rndb7bc;
	Wed, 28 Feb 2024 16:14:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1709126070; bh=BKd6AYY/qyTKWtkQvGPqgumRbX+7Xt8jtiNMbeWZso8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Zh6vIBIwD3HKf9QXIrjO+8dxj1pcdIn9cM52S56TGPK+j8f2ohMsArG9Hrg2bvWM+
	 QRbCArehx8ZXhYeVYtG1rVpfTsHGfRFUcNKIMdDz3R6naDJkDfJvJebX3XuMiYhw7z
	 7OCVP8Ft/flXLxBlFn30noMdVXAfTbzMZ+JVgdVA=
Authentication-Results: mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <kvalo@kernel.org>,
	ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath11k: fix few -Wmaybe-uninitialized warnings
Date: Wed, 28 Feb 2024 16:14:06 +0300
Message-ID: <20240228131406.165786-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling with gcc version 14.0.1 20240226 (experimental) and
W=12, I've noticed the following warnings:

drivers/net/wireless/ath/ath11k/mac.c: In function 'ath11k_mac_op_remain_on_channel':
drivers/net/wireless/ath/ath11k/mac.c:9230:12: warning: 'ret' may be used uninitialized
[-Wmaybe-uninitialized]
 9230 |         if (ret)

drivers/net/wireless/ath/ath11k/qmi.c: In function 'ath11k_qmi_load_file_target_mem':
drivers/net/wireless/ath/ath11k/qmi.c:2401:16: warning: 'ret' may be used uninitialized
[-Wmaybe-uninitialized]
 2401 |         return ret;

drivers/net/wireless/ath/ath11k/qmi.c: In function 'ath11k_qmi_load_bdf_qmi':
drivers/net/wireless/ath/ath11k/qmi.c:2494:17: warning: 'fw_entry' may be used uninitialized
[-Wmaybe-uninitialized]
 2494 |                 release_firmware(fw_entry);

And a bunch of them traced to uninitialized fields of the same
variable, e.g.:

drivers/net/wireless/ath/ath11k/spectral.c: In function 'ath11k_spectral_process_data':
drivers/net/wireless/ath/ath11k/spectral.c:700:47: warning: 'summ_rpt.meta.freq1' may
be used uninitialized [-Wmaybe-uninitialized]
  700 |         struct ath11k_spectral_summary_report summ_rpt;

Fix all of the above by using 0 and NULL initializers where appropriate.
Note there are few more (less obvious) -Wmaybe-uninitialized warnings
still remains, but they're hardly possible to fix without running on
a physical hardware. Compile tested oly.

Also noticed by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath11k/mac.c      | 2 +-
 drivers/net/wireless/ath/ath11k/qmi.c      | 4 ++--
 drivers/net/wireless/ath/ath11k/spectral.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index a6a37d67a50a..b89bc7ceaaa7 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9201,7 +9201,7 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	struct ath11k *ar = hw->priv;
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct scan_req_params *arg;
-	int ret;
+	int ret = 0;
 	u32 scan_time_msec;
 
 	mutex_lock(&ar->conf_mutex);
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 5006f81f779b..4477f652e068 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2293,7 +2293,7 @@ static int ath11k_qmi_load_file_target_mem(struct ath11k_base *ab,
 	struct qmi_txn txn;
 	const u8 *temp = data;
 	void __iomem *bdf_addr = NULL;
-	int ret;
+	int ret = 0;
 	u32 remaining = len;
 
 	req = kzalloc(sizeof(*req), GFP_KERNEL);
@@ -2406,7 +2406,7 @@ static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab,
 {
 	struct device *dev = ab->dev;
 	char filename[ATH11K_QMI_MAX_BDF_FILE_NAME_SIZE];
-	const struct firmware *fw_entry;
+	const struct firmware *fw_entry = NULL;
 	struct ath11k_board_data bd;
 	u32 fw_size, file_type;
 	int ret = 0, bdf_type;
diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
index 79e091134515..4c826b539404 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.c
+++ b/drivers/net/wireless/ath/ath11k/spectral.c
@@ -697,7 +697,7 @@ static int ath11k_spectral_process_data(struct ath11k *ar,
 	struct ath11k_base *ab = ar->ab;
 	struct spectral_tlv *tlv;
 	struct spectral_summary_fft_report *summary = NULL;
-	struct ath11k_spectral_summary_report summ_rpt;
+	struct ath11k_spectral_summary_report summ_rpt = { 0 };
 	struct fft_sample_ath11k *fft_sample = NULL;
 	u8 *data;
 	u32 data_len, i;
-- 
2.43.2


