Return-Path: <linux-wireless+bounces-7998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCC68CD004
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 12:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EAAC1C223B8
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 10:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D53613EFFB;
	Thu, 23 May 2024 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="na2yELYr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C109913D2AC
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458994; cv=none; b=QRrxnbPi0x4xz2KNdqrCfO9ZeiO9It1onyKBgzejqX5qxsqAJ9fNCi9tYGILiCZ7+6g8pqbaAsi2J6lpr1w5zA++TsA4HwdxfakzvSD7bSTu0pmTscHS0XARJHeeYvXXSK/RAb06Vazg5icKYXB8f5/MGs+XuY10IJv7B3p5FkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458994; c=relaxed/simple;
	bh=S2/n4EVxYxtv2KMycfoOg8jTL8j+Wy5rBQ3f8T546pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWeRcXo3QMl6LV8LBOCmcqG+r3XSxnLpqJxOi+BHWyNC2hBd7xJIg1cFa1Uc1+czvFFJwZAnESDglezKo3NLvmcXGY7eed4tfG53dsDkxpQHy5c4W9W9C7nHNvXvuXi82Dhr1gFwSOipfMImaCRaqTJ379jCI5NKXz81p44beoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=na2yELYr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mjEqoB4hS2uguo2bebKoUL585uZAN4NGKVxtvBWeAAg=;
	t=1716458992; x=1717668592; b=na2yELYrQ7YGxE0+diPIhS5PYt3dMuCB9fWVC7QZx5LXH6S
	TvsgYLM5d6wl2Cq+gARtbvvfrtfUQA25MwD5czK1dp4yfWLPPmDZKQVaQVX75H4A9XYYhsVHWB3AC
	F0WzQc/wD/Fz/EVvqN+1xa8lg6m2g/KlQAWXMrr7PUsrhXYgoYX/f+rBya1Qz1LTx6CM+lT/z9ut3
	7qnzLXQ/aay5Jg10dqyp6oYuF1KarFgWA1qPGOu0KPBbvbgyvdgvSmBQHy4fGu9zXFpFnqjsBFRfv
	AonvS+5gjSt7IqFuSJhs22wsuH2F4pQoMaVohDo6h8KnPMZgUY+2r+IfJTPbOOUQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sA5OQ-00000005wvn-033E;
	Thu, 23 May 2024 12:09:50 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 3/8] wifi: ieee80211: remove unused enum ieee80211_client_reg_power
Date: Thu, 23 May 2024 12:09:44 +0200
Message-ID: <20240523120945.32ed8fc1522d.Id4480d162e1921478e33d145890dc16c263b57bf@changeid>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523120945.9a2c19a51e53.I50fa1b1a18b70f63a5095131ac23dc2e71f3d426@changeid>
References: <20240523120945.9a2c19a51e53.I50fa1b1a18b70f63a5095131ac23dc2e71f3d426@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This has never been used, and it's really not directly
representing the spec, so shouldn't have been here in
the first place. Remove it.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 769008a51809..456a55bd6c6b 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2426,24 +2426,6 @@ enum ieee80211_ap_reg_power {
 		IEEE80211_REG_AP_POWER_AFTER_LAST - 1,
 };
 
-/**
- * enum ieee80211_client_reg_power - regulatory power for a client
- *
- * @IEEE80211_REG_UNSET_CLIENT: Client has no regulatory power mode
- * @IEEE80211_REG_DEFAULT_CLIENT: Default Client
- * @IEEE80211_REG_SUBORDINATE_CLIENT: Subordinate Client
- * @IEEE80211_REG_CLIENT_POWER_AFTER_LAST: internal
- * @IEEE80211_REG_CLIENT_POWER_MAX: maximum value
- */
-enum ieee80211_client_reg_power {
-	IEEE80211_REG_UNSET_CLIENT,
-	IEEE80211_REG_DEFAULT_CLIENT,
-	IEEE80211_REG_SUBORDINATE_CLIENT,
-	IEEE80211_REG_CLIENT_POWER_AFTER_LAST,
-	IEEE80211_REG_CLIENT_POWER_MAX =
-		IEEE80211_REG_CLIENT_POWER_AFTER_LAST - 1,
-};
-
 /* 802.11ax HE MAC capabilities */
 #define IEEE80211_HE_MAC_CAP0_HTC_HE				0x01
 #define IEEE80211_HE_MAC_CAP0_TWT_REQ				0x02
-- 
2.45.1


