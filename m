Return-Path: <linux-wireless+bounces-14272-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5189A6C17
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 16:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B828A282504
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 14:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0C31F9A92;
	Mon, 21 Oct 2024 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="J7P96z7G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [178.154.239.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05C71F5830;
	Mon, 21 Oct 2024 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520884; cv=none; b=fTLK4bqO/ibJDlfQ6Qw4G6WFJdBEFFBjJz1dRysP58p47mn8j5RBAtq0ZXG3RXXVTGSKV/eDZy8ICJgq1C6xPGepS6P9LU8fDgNmjmElyjDMfA5nKJZsu2E0UIJyZ/oXT/iY5rTXU/GWkxIVNBHjRsiSAFyVBrIOcR7UqLxYRdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520884; c=relaxed/simple;
	bh=h1+84YaQh4EMr5rMIOVjvixJqy8wfeLILOSoKrH6zzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdcAxeD2A/HSnvCWOTYtdSy1R3DtQ/PYegXUPLGcb7EjRhidS9dWeN8PkGuQGDiMS6YDzPBiRA2ITIFmYoAWOl2ghpQxbD0w2HUOeZ6ycqF0jBEGSbH3L1S8p6O+gwqgSyyaoetjmGD/+8I18YW8BDKUkjFGIkerP5qtBCSMY64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=J7P96z7G; arc=none smtp.client-ip=178.154.239.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c2a:1c1:0:640:adc:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id 4D0DE60E44;
	Mon, 21 Oct 2024 17:27:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id lRSmp10RnW20-bhKMYR3U;
	Mon, 21 Oct 2024 17:27:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1729520872; bh=7xC2Q+d9ax4rPHn12docKqRl8Axozv0IMIx6OMTAbmU=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=J7P96z7GpM9VBvB30nNMYZGHZLwL7CWxXaZrmeeLX2Q7jVDccPiP9ZjXXXXLuGlkQ
	 eiBbncnB+1KSIBV6IaszrQA2DEDUwNBIl23INhHPI8L+tHGxuFhkdYedeKMoTBugxB
	 mBJ969EGiX4IY3XfG1R7S74Sgg5N2DptYC5NiQtY=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: ath11k: annotate ch_param of struct scan_chan_list_params with __counted_by
Date: Mon, 21 Oct 2024 17:27:45 +0300
Message-ID: <20241021142745.585308-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021142745.585308-1-dmantipov@yandex.ru>
References: <20241021142745.585308-1-dmantipov@yandex.ru>
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
 drivers/net/wireless/ath/ath11k/wmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


