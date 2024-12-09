Return-Path: <linux-wireless+bounces-16002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2089E897A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 04:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B377028217B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 03:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D8BBA3D;
	Mon,  9 Dec 2024 03:21:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9DC3D76;
	Mon,  9 Dec 2024 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733714506; cv=none; b=B79/g/GN3M5E4sux4DY7i1AylyiqdSSaYT2/CwQiC1awYtEUn/kiqEyhkdVKgNkJCrI/adM6y/In14ZN6nNuWX+vKw7apq+YhqiVIhNKIJCUzj36rwJ9/zMdsb+Wisf1s63fhzJcE8SqRps4/2RVqZck/GXjanHe8GuH3N9Z//4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733714506; c=relaxed/simple;
	bh=Rez3aHuHQMNMX/y70EcxNccKxCNJGUdMNBKelfEJe4k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K+d/bcf8OJRE1nH7FjeV3Oq2lPMuMOnzz7jLwZAWB50Ptv2PHojAS4prKyGrn8uJ600kMK5lxdHFu0fcXYOhuqYAJqTZ8R+Vn5O3vzLJrHGfJkooxIta8uD0ra0QA/vd22ktnx4oqBqlolO3jB/2xDS79mNX5QtynAloJK/l9II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26756623fcd5-25cfa;
	Mon, 09 Dec 2024 11:21:35 +0800 (CST)
X-RM-TRANSID:2ee26756623fcd5-25cfa
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66756623e653-9afc4;
	Mon, 09 Dec 2024 11:21:35 +0800 (CST)
X-RM-TRANSID:2ee66756623e653-9afc4
From: liujing <liujing@cmss.chinamobile.com>
To: pkshih@realtek.com,
	kvalo@kernel.org,
	suhui@nfschina.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] rtlwifi: rtl8188ee: fix spelling error in _rtl88e_phy_set_rfpath_switch()
Date: Mon,  9 Dec 2024 11:21:33 +0800
Message-Id: <20241209032133.2974-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling error in _rtl88e_phy_set_rfpath_switch() function.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
index 0fab3a0c7d49..754ca8549c76 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
@@ -1891,7 +1891,7 @@ static void _rtl88e_phy_set_rfpath_switch(struct ieee80211_hw *hw,
 		rtl_set_bbreg(hw, 0x914, MASKLWORD, 0x0201);
 
 		/* We use the RF definition of MAIN and AUX,
-		 * left antenna and right antenna repectively.
+		 * left antenna and right antenna respectively.
 		 * Default output at AUX.
 		 */
 		if (bmain) {
-- 
2.27.0




