Return-Path: <linux-wireless+bounces-15170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D56CD9C38E0
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 08:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658441F20FE5
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 07:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221E9157A48;
	Mon, 11 Nov 2024 07:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="sW+ztbsg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward200d.mail.yandex.net (forward200d.mail.yandex.net [178.154.239.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE9312CD96
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 07:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731309000; cv=none; b=W2OrcFUEal1X1PyrD84gfyqy9TIB8XdlD7rOqYU5nw2nekeIotDXMO4YC60bLiu3gSpdcwyEhRzkvXQLhKPH6/iSDvhPLJISOknrzhrc9CmL2sj3cpBbh3HqIitCFIAPS6NiRF5xFe/M46eT2nHbXUiXofo3tHPYIQjRePMygy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731309000; c=relaxed/simple;
	bh=qaUQSOFhYJXvubcqraXC149uUofWivpAcrEa2FN4MXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HagWvum4D4cHP877JEmeeC46XXa9rSw2WwoAbB7gDlRZbAaSSVJa2qcUQ3b21HTs9bUm56yvQglE8fmB+752nHgGDn+Lqm4C63Ez5E4D4JtGYhm529TWe842u9Yg73WPhMFLWlEUwMwzxAwefwm+vLv42I45M/RX1dKjRsElPKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=sW+ztbsg; arc=none smtp.client-ip=178.154.239.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward200a.mail.yandex.net (forward200a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d200])
	by forward200d.mail.yandex.net (Yandex) with ESMTPS id 213566E9D3
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 10:02:42 +0300 (MSK)
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
	by forward200a.mail.yandex.net (Yandex) with ESMTP id 0082164934
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 10:02:12 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:26bf:0:640:efa0:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 37B0F471EC;
	Mon, 11 Nov 2024 10:02:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 22g22h1xFKo0-qN6QcCb0;
	Mon, 11 Nov 2024 10:02:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731308523; bh=fb9xSrcUwXm5GaYavX8s9M756oY8Tq+2xHCr4k5NO4k=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=sW+ztbsgSdXpw1rB/foQbUUFFBqzMA15B2puelvr4dIARa7o3NBl/l/f95/7A2QVi
	 fQ24iKQq5kIYFM7BgHnBuQKmifnUF+sK7qQ1IKbomlMeVIL/Dad5XBAH5J/ApewCC/
	 k3GY58fyYlfo7o1q0dN49mtag4qrGZoXq8knKs6k=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2 2/4] wifi: ath11k: cleanup struct ath11k_reg_tpc_power_info
Date: Mon, 11 Nov 2024 10:01:50 +0300
Message-ID: <20241111070152.85140-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111070152.85140-1-dmantipov@yandex.ru>
References: <20241111070152.85140-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused 'ap_constraint_power' field of 'struct
ath11k_reg_tpc_power_info' and adjust related comment.
Compile tested only.

Fixes: 6f4e235be655 ("wifi: ath11k: add parse of transmit power envelope element")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: join the series
---
 drivers/net/wireless/ath/ath11k/core.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 5ab1fdd21144..b1440a70a886 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -340,7 +340,6 @@ struct ath11k_chan_power_info {
  * @ap_power_type: type of power (SP/LPI/VLP)
  * @num_pwr_levels: number of power levels
  * @reg_max: Array of maximum TX power (dBm) per PSD value
- * @ap_constraint_power: AP constraint power (dBm)
  * @tpe: TPE values processed from TPE IE
  * @chan_power_info: power info to send to firmware
  */
@@ -350,7 +349,6 @@ struct ath11k_reg_tpc_power_info {
 	enum wmi_reg_6ghz_ap_type ap_power_type;
 	u8 num_pwr_levels;
 	u8 reg_max[ATH11K_NUM_PWR_LEVELS];
-	u8 ap_constraint_power;
 	s8 tpe[ATH11K_NUM_PWR_LEVELS];
 	struct ath11k_chan_power_info chan_power_info[ATH11K_NUM_PWR_LEVELS];
 };
-- 
2.47.0


