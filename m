Return-Path: <linux-wireless+bounces-14463-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3019AE3D8
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 13:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BAF61F211CF
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 11:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1553C1CF5C6;
	Thu, 24 Oct 2024 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="wrkWD0dW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C951CF295;
	Thu, 24 Oct 2024 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729769401; cv=none; b=crgZ/K0hJI1KLG3BO5skqhnkdIKhrWvU4ECzZIXR3FSlfH/D6ND13LXONOmYznnYhlb+MQa3pQz9xeaOCDo5H/ZwxeHaGAEuKs/VXqw577S6jfIDV06nOZcBm9UEc0PgCiZTICeiR7AeD2cWpBVNkHXYuNesC77rWOgdF8hI5YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729769401; c=relaxed/simple;
	bh=nDWU0O1vn5ngbJToDYeqUZGhEDVSV8kfu0i38xckejU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxVOqQcAjiuZZX4bxiQznS+PlBc8kkfsDar77w5mCKIoDJZoNjXaOykv38JGp86s5rb/hwCZZuiDnj8LS407CwFERd9iu+UwlfEBNowiq3caMeqAfEddGJdKcnMZ7I9ylCULnpH9BBkdvWKZ+5GBrCAge5aW1FxbRbEQQp8SIhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=wrkWD0dW; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:3e0b:0:640:c81:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 9B0F446EE4;
	Thu, 24 Oct 2024 14:29:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id oTSTCcEXxKo0-oCYzBIe4;
	Thu, 24 Oct 2024 14:29:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1729769395; bh=uVIY/XG3B4mLRa5gqLMjSJGb7yZMvMoSYtpC3HeQrSU=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=wrkWD0dWLqOZ1ZY6N/C/fqfTW4XS4nYXNx9NZtTSaX13erZWL4Ujch8zr1EL3TKmD
	 iX08gz8gf+EgQ+ai1ZdmYd8DjWIKYMJkgEvldYau9cLRvQcuPfReZncHNNH/MyB9f4
	 3udw25otROcyKmfx3XM92VSLR8HfooWnYz/4S0DY=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2 2/2] wifi: ath12k: annotate channel of struct ath12k_wmi_scan_chan_list_arg with __counted_by
Date: Thu, 24 Oct 2024 14:29:12 +0300
Message-ID: <20241024112912.106104-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024112912.106104-1-dmantipov@yandex.ru>
References: <20241024112912.106104-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to 'ath12k_reg_update_chan_list()', annotate flexible
array member 'channel' of 'struct ath12k_wmi_scan_chan_list_arg'
with '__counted_by()' attribute to improve runtime bounds checking
when CONFIG_UBSAN_BOUNDS is enabled. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: fix typo and add related comment in ath12k_reg_update_chan_list()
---
 drivers/net/wireless/ath/ath12k/reg.c | 3 +++
 drivers/net/wireless/ath/ath12k/wmi.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 439d61f284d8..dbd6f0570498 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -131,6 +131,9 @@ int ath12k_reg_update_chan_list(struct ath12k *ar)
 		return -ENOMEM;
 
 	arg->pdev_id = ar->pdev->pdev_id;
+	/* Note nallchans should be set before populating channel[],
+	 * otherwise __counted_by() might raise false positives.
+	 */
 	arg->nallchans = num_channels;
 
 	ch = arg->channel;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 6a913f9b8315..02b3d722a23b 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3746,7 +3746,7 @@ struct wmi_stop_scan_cmd {
 struct ath12k_wmi_scan_chan_list_arg {
 	u32 pdev_id;
 	u16 nallchans;
-	struct ath12k_wmi_channel_arg channel[];
+	struct ath12k_wmi_channel_arg channel[] __counted_by(nallchans);
 };
 
 struct wmi_scan_chan_list_cmd {
-- 
2.47.0


