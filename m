Return-Path: <linux-wireless+bounces-16161-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C819EB3D1
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 15:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA3E1683CE
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 14:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3F91AA7A3;
	Tue, 10 Dec 2024 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="C75aKllD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward205a.mail.yandex.net (forward205a.mail.yandex.net [178.154.239.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983D278F38;
	Tue, 10 Dec 2024 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842010; cv=none; b=CfZy0WEmSPbCCIjxtWdTl1zLtQpmJwzeS9LduEcGuWvdZ4Hk5t/bM2D2rlqkHzQwXx7bqFnHvaWEduxlVInYL8X/P2OLKA1sTD7a/v66+ciSAp+JcpUy+tivJJtvRz4oTdgQL/c/1+cwE31Iy6NivqneI9s6ZEMxVik9vXNbyxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842010; c=relaxed/simple;
	bh=IA4TyROiF1W807IEDV30/mCfk8J3N8UTj/aqgXeX+Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvbITk3X/qCjmhJZwlcwwa2YlhWgggvV/tYp4g78V+NbAujbT14zPFxUQNW2sfm16b8zOnGwPRcqWoZgnXX6PNvkgot9aaVgkGG6nA9ugRJMEp/0h+r4K9SX7erF/47KQ6rlsOxHvsSrPVLm/YbAHxd4pmd2coyrmyFk8QsWfxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=C75aKllD; arc=none smtp.client-ip=178.154.239.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
	by forward205a.mail.yandex.net (Yandex) with ESMTPS id 08FDA67462;
	Tue, 10 Dec 2024 17:40:13 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:200:0:640:1d5:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id E098F60AF5;
	Tue, 10 Dec 2024 17:40:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 0enkiN2OgCg0-MKNOj2ww;
	Tue, 10 Dec 2024 17:40:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1733841602; bh=b2VIYTAThn7M+4bBggR3iBohV2L5yGDB68aLTe+G0g0=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=C75aKllD4P+vimY8Y7v3yMKh7dLhCXMsfS/LFjQDplf43LlzKr3H1zFRbc0Ima7sU
	 uzqoxuGdW7ei3x4gNMsPmZajfblerBgxyoNcHRg/C1/wrNKzbEBzZCEOX3d23imhz6
	 J4JFuK8oIU/w4cG218lUOODpstq7SU8CjTC7cw0Y=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: cfg80211: simplify cfg80211_mlme_register_mgmt()
Date: Tue, 10 Dec 2024 17:39:51 +0300
Message-ID: <20241210143951.5685-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210143951.5685-1-dmantipov@yandex.ru>
References: <20241210143951.5685-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify 'cfg80211_mlme_register_mgmt()' to allocate an instance of
'struct cfg80211_mgmt_registration' only if the latter is really
needed (i.e. when the list of registrations should be updated)
and prefer 'kmalloc()' over 'kzalloc()' since all of the members
are explicitly initialized.

Fixes: 9dba48a6ece7 ("cfg80211: support multicast RX registration")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/wireless/mlme.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 4790136758d5..c7d913c76966 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -639,7 +639,7 @@ int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
 				struct netlink_ext_ack *extack)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
-	struct cfg80211_mgmt_registration *reg, *nreg;
+	struct cfg80211_mgmt_registration *reg;
 	int err = 0;
 	u16 mgmt_type;
 	bool update_multicast = false;
@@ -680,10 +680,6 @@ int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
 		return -EINVAL;
 	}
 
-	nreg = kzalloc(sizeof(*reg) + match_len, GFP_KERNEL);
-	if (!nreg)
-		return -ENOMEM;
-
 	spin_lock_bh(&rdev->mgmt_registrations_lock);
 
 	list_for_each_entry(reg, &wdev->mgmt_registrations, list) {
@@ -707,9 +703,14 @@ int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
 	if (err)
 		goto out;
 
-	if (update_multicast) {
-		kfree(nreg);
-	} else {
+	if (!update_multicast) {
+		struct cfg80211_mgmt_registration *nreg =
+			kmalloc(sizeof(*reg) + match_len, GFP_KERNEL);
+
+		if (!nreg) {
+			err = -ENOMEM;
+			goto out;
+		}
 		nreg->match_len = match_len;
 		memcpy(nreg->match, match_data, match_len);
 		nreg->nlportid = snd_portid;
@@ -726,7 +727,6 @@ int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
 	return 0;
 
  out:
-	kfree(nreg);
 	spin_unlock_bh(&rdev->mgmt_registrations_lock);
 
 	return err;
-- 
2.47.1


