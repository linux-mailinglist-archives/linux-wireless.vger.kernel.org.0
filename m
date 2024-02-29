Return-Path: <linux-wireless+bounces-4243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CAF86C3ED
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 09:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77282898A6
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 08:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0F052F8C;
	Thu, 29 Feb 2024 08:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="YVWJWqBz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward203c.mail.yandex.net (forward203c.mail.yandex.net [178.154.239.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B93152F65
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196072; cv=none; b=AYQUJ97qgeQxKlrrfR/QlunMvbqZvoHQPUcSykmQQoRfFO2plawuLCNHjvl6CRWb10i9etIgRgEeqbjwToiv1sKW9VNUW7aFa019JP8crK2icTgqWAUx4PhbyARfDrAkbkzdTKRbvGjqP8AVtlrmKMRmHMuaf9Dg+V7zuzZp9lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196072; c=relaxed/simple;
	bh=32vgW31IsGnFpXY0jSvBWmEx0mmTVKtOzYQKYUV5jLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACg909McrYnrEzl+zIXRYZwZdjGiE0khfA8adSOjTPZ8N9Mp3J/6urPoheWrDIaaBND/3ZNSKiX0SqKexRlw0Xu2IdgkcBaWL80sC0+swBP/7HjgXH4/NcSM7cjKFKCRLXsUIw1TeaYk7aRhgjBAuGQ8t48MEwNyVeVaeUMVzYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=YVWJWqBz; arc=none smtp.client-ip=178.154.239.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward203c.mail.yandex.net (Yandex) with ESMTPS id BE7D16338A
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 11:41:06 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:6e01:0:640:627f:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 814E560A7A;
	Thu, 29 Feb 2024 11:40:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id teVSqmLJiW20-ppqodj5g;
	Thu, 29 Feb 2024 11:40:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1709196058; bh=etD7nXdUPW+wM9En1JEoPr/6++ncac2+Uo/5yHDDw2w=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=YVWJWqBzZPFo39FdY5QZJ0WeKhxQhrd54W3PQ4T/d8hlnf4+GBEshzvy191xaGHQk
	 JNxbWY4U8bwRZHHIijJvWPrZoHsj6W7qHMDst1NHXZ6fkA4UKlv8kOCktPbnVOEbL8
	 bmzUteaGyvzWNJX9I5dErU0rqipzgarnmmjpky8w=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
	Kalle Valo <kvalo@kernel.org>,
	ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 3/3] [v2] wifi: ath11k: fix few -Wmaybe-uninitialized warnings
Date: Thu, 29 Feb 2024 11:40:31 +0300
Message-ID: <20240229084031.51957-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240229084031.51957-1-dmantipov@yandex.ru>
References: <788f1df8-64e1-4b3c-ae8e-00c67be1c3de@quicinc.com>
 <20240229084031.51957-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling with gcc version 14.0.1 20240226 (experimental) and
W=12, I've noticed the following warnings:

drivers/net/wireless/ath/ath11k/qmi.c: In function 'ath11k_qmi_load_file_target_mem':
drivers/net/wireless/ath/ath11k/qmi.c:2401:16: warning: 'ret' may be used uninitialized
[-Wmaybe-uninitialized]
 2401 |         return ret;

drivers/net/wireless/ath/ath11k/qmi.c: In function 'ath11k_qmi_load_bdf_qmi':
drivers/net/wireless/ath/ath11k/qmi.c:2494:17: warning: 'fw_entry' may be used uninitialized
[-Wmaybe-uninitialized]
 2494 |                 release_firmware(fw_entry);

And a bunch of them traced to an uninitialized fields of the same
variable, e.g.:

drivers/net/wireless/ath/ath11k/spectral.c: In function 'ath11k_spectral_process_data':
drivers/net/wireless/ath/ath11k/spectral.c:700:47: warning: 'summ_rpt.meta.freq1' may
be used uninitialized [-Wmaybe-uninitialized]
  700 |         struct ath11k_spectral_summary_report summ_rpt;

Fix all of the above by using 0, NULL, and {} initializers, respectively.
Note there are few more (less obvious) -Wmaybe-uninitialized warnings
still remains, but they're hardly possible to fix without running on
a physical hardware. Compile tested only.

Also noticed by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: use {} initializer (Jeff Johnson) and aggregate to the series
---
 drivers/net/wireless/ath/ath11k/qmi.c      | 4 ++--
 drivers/net/wireless/ath/ath11k/spectral.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

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
index 79e091134515..9834e7dc5120 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.c
+++ b/drivers/net/wireless/ath/ath11k/spectral.c
@@ -697,7 +697,7 @@ static int ath11k_spectral_process_data(struct ath11k *ar,
 	struct ath11k_base *ab = ar->ab;
 	struct spectral_tlv *tlv;
 	struct spectral_summary_fft_report *summary = NULL;
-	struct ath11k_spectral_summary_report summ_rpt;
+	struct ath11k_spectral_summary_report summ_rpt = {};
 	struct fft_sample_ath11k *fft_sample = NULL;
 	u8 *data;
 	u32 data_len, i;
-- 
2.44.0


