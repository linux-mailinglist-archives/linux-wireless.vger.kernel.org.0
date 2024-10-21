Return-Path: <linux-wireless+bounces-14275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EF79A6C30
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 16:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51F11C21B02
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 14:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659331F9A8C;
	Mon, 21 Oct 2024 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Sw9RwZ+p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6141EABA5;
	Mon, 21 Oct 2024 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521277; cv=none; b=X/zIY2QPCP+otGrhtW551kFElI4nc6d1vp+PyBjWgrE9jWOtTsy99FSYUuAIOaHTkjHC5kiva5sQXJskI43l/BiX8ikMkoarm774MKZWvpXpWGQIre3l9ZDVOt91U265LdQypAaT0xzfah41y0ZN6InKXvXXaUADVtAfJY8JIME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521277; c=relaxed/simple;
	bh=H/1mC4SCc2iTgxP83Bnsjr0fXY2lPhM7iOe+UoT+TGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GaINcIywC55ZgjNECmQ2T5OwO93buQELtYiXUh7844EV9eKSa0YRSECSWsbD3qsh+HZv/UculQ2OFRvsnc9LFps9Gts0NhnHN74ZT0735DE4kF+ds8xs3CbUvhdkc6Fk2qXoaSAb3HM6xbvjTIXeFoZznWbeB+oxS4l1s0t/cKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Sw9RwZ+p; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1c:2911:0:640:4396:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id EC18460D4B;
	Mon, 21 Oct 2024 17:34:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id KYSvOR0ZrOs0-SSODkf8B;
	Mon, 21 Oct 2024 17:34:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1729521266; bh=MJ2cFZkn5LXzl2WTFVkvoYqur6ajXiI++VBDmLPedrQ=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Sw9RwZ+pcrfAc6wDZ0DNnP74UUFReZQDHiFQlCiwCJlhzut4ubqG2ywD9e6mJdfl+
	 EKNsRz3f1YCwIl2APzl6j0Gb+evBAsKOuDUvEmUAve8Z8HbCu1ElnOfmWdJy9BrewN
	 Q577mZBqgvcqcYu9gOKActPu4Cbq1lN0BOjZRdoU=
Authentication-Results: mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: ath12k: annotate channel of struct ath12k_wmi_scan_chan_list_arg with __counted_by
Date: Mon, 21 Oct 2024 17:34:19 +0300
Message-ID: <20241021143419.587716-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021143419.587716-1-dmantipov@yandex.ru>
References: <20241021143419.587716-1-dmantipov@yandex.ru>
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
 drivers/net/wireless/ath/ath12k/wmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 6a913f9b8315..9a6e28142754 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3746,7 +3746,7 @@ struct wmi_stop_scan_cmd {
 struct ath12k_wmi_scan_chan_list_arg {
 	u32 pdev_id;
 	u16 nallchans;
-	struct ath12k_wmi_channel_arg channel[];
+	struct ath12k_wmi_channel_arg channel[] __counted_by(nallchains);
 };
 
 struct wmi_scan_chan_list_cmd {
-- 
2.47.0


