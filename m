Return-Path: <linux-wireless+bounces-23563-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFDDACCA40
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 17:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A78E3A7B7E
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 15:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E702923D28A;
	Tue,  3 Jun 2025 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="rQWhBu8I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0061123D2B5;
	Tue,  3 Jun 2025 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748964696; cv=none; b=tjLtKF6DrmN6fuGXX7jqt67UWj8Ech66i7RoWXNj9PHJy14See7jOXsT7XjwdUwrF6MBlT712pl8JKh7zDseL45OEU2rPKRWMPx7tFDoacDBywdgLOBJj/K05RKPEheeii+JkaAvmDL8HuJ9nwL9shGdOzF81L49AYyelIEhUlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748964696; c=relaxed/simple;
	bh=d08uzOt1VGoqfeJIgallA9cokl1Sjskad74nVOQBGWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ONbIgBa3pkA3RnNKSoz9GxndIrIRTmwWMbvJdBB87f/46tSevebx68W1+6qbOJsz3+34spQ3ZEnPE+PfkHT5qmOlivldMEmfkJe10Nb9IIMGrZ1Vd8CDUsoXJq0TkA0RmKqi7Qe2Axh0rfVN1eLP7m60RAXXR7s1Rmfx7Ezy4Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=rQWhBu8I; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.12])
	by mail.ispras.ru (Postfix) with ESMTPSA id 5AE62552F539;
	Tue,  3 Jun 2025 15:31:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5AE62552F539
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1748964691;
	bh=HOMZ46XwuOVuNK3GluB5hiNrhNDhEtpIHBQJiSl126w=;
	h=From:To:Cc:Subject:Date:From;
	b=rQWhBu8IbNp2aEw1yGkHmkH/fABhcDcPqyjQzsnUgL1E3uonSTiGzjxrSSxsV3+sI
	 Zj+p9GVtiv8zpkx3ZqxXvXZOGMASXL7ZkNaHmfpfRcwM17aW7/ng3mJo/pu6QjC1LO
	 XGe4Scb5H7aIjWf85dMse5cii36+YONMTAfOBEQs=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next] wifi: rtw89: fix spelling mistake of RTW89_FLAG_FORBIDDEN_TRACK_WORK
Date: Tue,  3 Jun 2025 18:31:23 +0300
Message-ID: <20250603153124.188755-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename RTW89_FLAG_FORBIDDEN_TRACK_WROK -> RTW89_FLAG_FORBIDDEN_TRACK_WORK.

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 2 +-
 drivers/net/wireless/realtek/rtw89/core.h     | 2 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 49447668cbf3..e54f3dc97e7e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3742,7 +3742,7 @@ static void rtw89_track_work(struct wiphy *wiphy, struct wiphy_work *work)
 
 	lockdep_assert_wiphy(wiphy);
 
-	if (test_bit(RTW89_FLAG_FORBIDDEN_TRACK_WROK, rtwdev->flags))
+	if (test_bit(RTW89_FLAG_FORBIDDEN_TRACK_WORK, rtwdev->flags))
 		return;
 
 	if (!test_bit(RTW89_FLAG_RUNNING, rtwdev->flags))
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 1c8f3b9b7c4c..a081fce1466f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4912,7 +4912,7 @@ enum rtw89_flags {
 	RTW89_FLAG_CRASH_SIMULATING,
 	RTW89_FLAG_SER_HANDLING,
 	RTW89_FLAG_WOWLAN,
-	RTW89_FLAG_FORBIDDEN_TRACK_WROK,
+	RTW89_FLAG_FORBIDDEN_TRACK_WORK,
 	RTW89_FLAG_CHANGING_INTERFACE,
 	RTW89_FLAG_HW_RFKILL_STATE,
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index a47971003bd4..a8e8b098cc9c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1698,13 +1698,13 @@ static int rtw89_ops_suspend(struct ieee80211_hw *hw,
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	set_bit(RTW89_FLAG_FORBIDDEN_TRACK_WROK, rtwdev->flags);
+	set_bit(RTW89_FLAG_FORBIDDEN_TRACK_WORK, rtwdev->flags);
 	wiphy_delayed_work_cancel(hw->wiphy, &rtwdev->track_work);
 
 	ret = rtw89_wow_suspend(rtwdev, wowlan);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to suspend for wow %d\n", ret);
-		clear_bit(RTW89_FLAG_FORBIDDEN_TRACK_WROK, rtwdev->flags);
+		clear_bit(RTW89_FLAG_FORBIDDEN_TRACK_WORK, rtwdev->flags);
 		return 1;
 	}
 
@@ -1722,7 +1722,7 @@ static int rtw89_ops_resume(struct ieee80211_hw *hw)
 	if (ret)
 		rtw89_warn(rtwdev, "failed to resume for wow %d\n", ret);
 
-	clear_bit(RTW89_FLAG_FORBIDDEN_TRACK_WROK, rtwdev->flags);
+	clear_bit(RTW89_FLAG_FORBIDDEN_TRACK_WORK, rtwdev->flags);
 	wiphy_delayed_work_queue(hw->wiphy, &rtwdev->track_work,
 				 RTW89_TRACK_WORK_PERIOD);
 
-- 
2.49.0


