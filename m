Return-Path: <linux-wireless+bounces-15168-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8F89C38CE
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 08:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CFF5B2142C
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 07:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A94715533B;
	Mon, 11 Nov 2024 07:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="JMshykj2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7417132103
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 07:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731308535; cv=none; b=mI4mQUnEa7z5s4p6R+oOof0owGuQV2XmYYi4vB+HX35ajYoX+xkCVNpiLj9f7hWeh3TzJtcEQh/MXmBGp6VpdPXU+cvb2liHNMr/rFsBjZEztzww74plgSqCg52ZOKdhhfXJ/ZpmZVVEG1WjfLH3d5uLuMU6JGmEzhqJBnWSZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731308535; c=relaxed/simple;
	bh=0diTyvi0Q1Auoo0ekEXNR8JTDJdcsyUCUG0ol1NqSYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQio5sK9Ugg31glTDSflwac/pKlKYvNU+x0U8kx8kWLZxm0YX0jxat60A8mUNvxDKrMUaxfBCKBHY47cADAdyD9RW9pYuXBQdJEwIi6AjRRVxG3dmO/hczEBSX2pajJxdWpi9G/uE1WEbHpAodk4ojJDXqHj9LbDxRh87eFzaTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=JMshykj2; arc=none smtp.client-ip=178.154.239.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:26bf:0:640:efa0:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id C2E2660EF0;
	Mon, 11 Nov 2024 10:02:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 22g22h1xFKo0-govi4NYx;
	Mon, 11 Nov 2024 10:02:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731308524; bh=Hnc4rXZBLyzhprBfCHAiUnNWF9Eu9HutM4xBiFwPAI8=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=JMshykj2z7wKGhgi99RUU8xHKyDQfHQA0w8MuCpSXgCmgUHzB1k85O6E/ETwbI6nv
	 fqOZdu5BLlS8TPCgZhllYRH9bp48TYCdhz2UnRtr3whsFT7OcsI7Yl9mj1Tj9ussmy
	 NMf1m23mU9RvtD8krcDEWFtE21c7uZ7yXqSfCcJM=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2 3/4] wifi: ath11k: cleanup struct ath11k_mon_data
Date: Mon, 11 Nov 2024 10:01:51 +0300
Message-ID: <20241111070152.85140-3-dmantipov@yandex.ru>
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

Remove initialized but otherwise unused 'rx_status_q' member of
'struct ath11k_mon_data' and adjust 'ath11k_dp_rx_pdev_mon_status_attach'
accordingly. Compile tested only.

Fixes: 67a9d399fcb0 ("ath11k: enable RX PPDU stats in monitor co-exist mode")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: join the series
---
 drivers/net/wireless/ath/ath11k/dp.h    | 1 -
 drivers/net/wireless/ath/ath11k/dp_rx.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 65d2bc0687c8..f777314db8b3 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -165,7 +165,6 @@ struct ath11k_mon_data {
 	struct ath11k_pdev_mon_stats rx_mon_stats;
 	/* lock for monitor data */
 	spinlock_t mon_lock;
-	struct sk_buff_head rx_status_q;
 };
 
 struct ath11k_pdev_dp {
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 40088e62572e..81bc93e2d05c 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -5705,8 +5705,6 @@ static int ath11k_dp_rx_pdev_mon_status_attach(struct ath11k *ar)
 	struct ath11k_pdev_dp *dp = &ar->dp;
 	struct ath11k_mon_data *pmon = (struct ath11k_mon_data *)&dp->mon_data;
 
-	skb_queue_head_init(&pmon->rx_status_q);
-
 	pmon->mon_ppdu_status = DP_PPDU_STATUS_START;
 
 	memset(&pmon->rx_mon_stats, 0,
-- 
2.47.0


