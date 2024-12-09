Return-Path: <linux-wireless+bounces-16019-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 390269E8B79
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 07:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D571885E84
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 06:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B192147F7;
	Mon,  9 Dec 2024 06:24:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E6217C219;
	Mon,  9 Dec 2024 06:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733725473; cv=none; b=VfZXIG9QPJ5sJL6pM2qDCR1xuICkQpMtfyrdUKWoY1CF974vYkANvTTHUMgBr58Z1ttauPF8skR7Pl8SRDDj3invcVTkGMK6RRrICsz5ezHrMeiSlSYcE3w1eH78WyZtPJB8VoJV1F2ChVmF3ZlXLBL16OoGhog45rDAZbQfR0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733725473; c=relaxed/simple;
	bh=/sl0QS0U1CzMJWR1QBZXE9y0vc6XoiH86C4hJmwnVdI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S89xwN7Px0LgEIHpEySYKU+Ps69+dtJwiuwyaVnIL8PNuGmYc2jwyLNNA5glHnsIHlbCJyM1WNJlJmsW3heXRoR5He6lwNzfkGi8CRfiVvZn4PpFbnMpiqAAeOdVkd/1uI2nB/gihwEfO/VmS6oIEUe3Xo1PZ+llSzFYkeDr8pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee267568d1b1fe-27223;
	Mon, 09 Dec 2024 14:24:27 +0800 (CST)
X-RM-TRANSID:2ee267568d1b1fe-27223
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee467568d1ad35-a6872;
	Mon, 09 Dec 2024 14:24:27 +0800 (CST)
X-RM-TRANSID:2ee467568d1ad35-a6872
From: Liu Jing <liujing@cmss.chinamobile.com>
To: imitsyanko@quantenna.com,
	geomatsi@gmail.com,
	kvalo@kernel.org,
	johannes.berg@intel.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] qtnfmac: fix spelling error in core.h
Date: Mon,  9 Dec 2024 14:24:25 +0800
Message-Id: <20241209062425.4139-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix specific spelling error in core.h.

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>

diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.h b/drivers/net/wireless/quantenna/qtnfmac/core.h
index b375a4751580..a377d85c2451 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.h
@@ -102,7 +102,7 @@ struct qtnf_wmac {
 	struct qtnf_mac_info macinfo;
 	struct qtnf_vif iflist[QTNF_MAX_INTF];
 	struct cfg80211_scan_request *scan_req;
-	struct mutex mac_lock;	/* lock during wmac speicific ops */
+	struct mutex mac_lock;	/* lock during wmac specific ops */
 	struct delayed_work scan_timeout;
 	struct ieee80211_regdomain *rd;
 	struct platform_device *pdev;
-- 
2.27.0




