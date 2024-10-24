Return-Path: <linux-wireless+bounces-14459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 928B19AE3A9
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 13:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36E19B234B1
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 11:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF96D1CDA1C;
	Thu, 24 Oct 2024 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="SYR/8giV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F9E1CCEE0;
	Thu, 24 Oct 2024 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729768787; cv=none; b=kisNimwUIzTbRdaqMtcXYMc3hiOz/CQ2JrfKs5jQ+5tZ/oUvF6hfQ2rdVptaaj7JrqU63zCsLRxNcFXzHUzFTCw9Vco7yGWvc3p2q4PfjsGfZ8ZGaxf3o0hNUrM99NtDLpTR4uuFtQY8QUjKhWypELMRuGX5h2EpyPHSk3SpluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729768787; c=relaxed/simple;
	bh=utpNps1/ZY6oW+MzyY2tkq5Q/ZXySUJ0sIocbr8mDgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBkRgHje/v48h3pYh3oohAqBuz+wF0gsD3OdIPnLaY8un29KaMAdSbd0kMw9Kd0Sjx04KtRxcewOT24DMo0EzHR5qMPBVezhnnoCV8Jrv1ElAYZOZuQnTSF6BLtocQjQID3rcEnRGX+lDWFHXNJ+ALlEbJasSJNN5VhcyG2vITQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=SYR/8giV; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:4c80:0:640:a0f:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 8D9EF60B5D;
	Thu, 24 Oct 2024 14:19:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id SJSJZc7btmI0-YBgQ4H2V;
	Thu, 24 Oct 2024 14:19:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1729768774; bh=Ujogf2n6d3xM51NjQgS1UgXmJyF3SKIBj1zGKPXG+uE=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=SYR/8giVvrCbXYTHDwxv0XDwR5fe7SCh/3YPvhI3YDKr0Gc10UMD3w6V1sUOyeAlv
	 i5mru+Hsf1S+OPAGs8O3MAsK4gqxpVI8tXGHIGq8LgZ7n5Zfj7bqmM1gCX+Eq+PNGP
	 38ryKNlAB0L3RFd7Ylhyf65NeYB2srH2NdXGB22w=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2 2/3] wifi: ath11k: annotate ch_param of struct scan_chan_list_params with __counted_by
Date: Thu, 24 Oct 2024 14:19:20 +0300
Message-ID: <20241024111921.93105-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024111921.93105-1-dmantipov@yandex.ru>
References: <20241024111921.93105-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to 'ath11k_reg_update_chan_list()', annotate flexible
array member 'ch_param' of 'struct scan_chan_list_params' with
'__counted_by()' attribute to improve runtime bounds checking
when CONFIG_UBSAN_BOUNDS is enabled. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: add related comment in ath11k_reg_update_chan_list()
---
 drivers/net/wireless/ath/ath11k/reg.c | 3 +++
 drivers/net/wireless/ath/ath11k/wmi.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index b0f289784dd3..0a8a0ea2bdc7 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -164,6 +164,9 @@ int ath11k_reg_update_chan_list(struct ath11k *ar, bool wait)
 		return -ENOMEM;
 
 	params->pdev_id = ar->pdev->pdev_id;
+	/* Note nallchans should be set before populating ch_param[],
+	 * otherwise __counted_by() might raise false positives.
+	 */
 	params->nallchans = num_channels;
 
 	ch = params->ch_param;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 8982b909c821..58471da42087 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3819,7 +3819,7 @@ struct wmi_stop_scan_cmd {
 struct scan_chan_list_params {
 	u32 pdev_id;
 	u16 nallchans;
-	struct channel_param ch_param[];
+	struct channel_param ch_param[] __counted_by(nallchans);
 };
 
 struct wmi_scan_chan_list_cmd {
-- 
2.47.0


