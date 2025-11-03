Return-Path: <linux-wireless+bounces-28488-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FF9C2A950
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 09:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2858346256
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 08:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648582E040C;
	Mon,  3 Nov 2025 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b="h48xp0Rg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.codelabs.ch (mail.codelabs.ch [109.202.192.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7FB2E03EC
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.202.192.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762158861; cv=none; b=fq1Y16HElCTEjJTzGOojXSuVaERzrUus3SZa/SGYeW+8t6wzr6i/yBHmihSgE/rVtBZYsbZkP4NPtiwjEdGBjkXjYRy9OKtA+28DTJHHWYZnvHRPJF1rCIlMFY/H+E1PfjAds0bAswQn9rDlUUu/GFdzzxo8TiKoDCmQuPblqmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762158861; c=relaxed/simple;
	bh=LB2tnZ21wPNNDYhPNZZQSV0kB+mA0/nAZfxt+OOQLAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z8oNCrYOoPcKFfgfVhkm+tAXRUgkqGuKO9JvQ+Z8TPbasyCf2SDLlj3ssztwpApMb8eVLACbgbic47vflf/BPzsY/dmUVEBejVTsjhkiK4TmN14nkujU341iMKYgI1vDuXVa405JkUMtggXLqDsyVxsIQpYSDQUovYiIkHNjFH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org; spf=pass smtp.mailfrom=strongswan.org; dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b=h48xp0Rg; arc=none smtp.client-ip=109.202.192.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strongswan.org
Received: from localhost (localhost [127.0.0.1])
	by mail.codelabs.ch (Postfix) with ESMTP id B34695A0002;
	Mon,  3 Nov 2025 09:24:59 +0100 (CET)
Received: from mail.codelabs.ch ([127.0.0.1])
 by localhost (fenrir.codelabs.ch [127.0.0.1]) (amavis, port 10024) with ESMTP
 id guF6M5YyWX6Y; Mon,  3 Nov 2025 09:24:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=strongswan.org;
	s=default; t=1762158298;
	bh=LB2tnZ21wPNNDYhPNZZQSV0kB+mA0/nAZfxt+OOQLAY=;
	h=From:To:Cc:Subject:Date:From;
	b=h48xp0RgWOM9UEWccYQZzomfw30wYrVgJtLVL7q0iQTsW07ip1+Aog5sAeQ6+17zv
	 4bvG/raPKrAKVrrna7hKIklcOm9dnmBhqvYYsbjB6YH7sAJk9AxBp1GWviNw2ydHQh
	 +bfe4q63Twvzmjigjpn3Cnu8BrBWaApnw/QpFM1I+huUYC3MeRrTH4rf5Tn2JAfYeY
	 iosszzkiI688Tjk8999J0pa+XRzTu46t5QKYoYBQLAwbL2BDhQ/TyAoZuUS4ngik25
	 33Aq7DYi8v/yKAKCu6b97QyiyJcquBBOZ2LCfFw9mjZzcFZhRW5AuNdxVh3qgl44vU
	 4FBewQg5RrEbg==
Received: from zbook.home (unknown [185.12.128.224])
	by mail.codelabs.ch (Postfix) with ESMTPSA id A5A2E5A0001;
	Mon,  3 Nov 2025 09:24:58 +0100 (CET)
From: Martin Willi <martin@strongswan.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless] wifi: mac80211_hwsim: Limit destroy_on_close radio removal to netgroup
Date: Mon,  3 Nov 2025 09:24:36 +0100
Message-ID: <20251103082436.30483-1-martin@strongswan.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hwsim radios marked destroy_on_close are removed when the Netlink socket
that created them is closed. As the portid is not unique across network
namespaces, closing a socket in one namespace may remove radios in another
if it has the destroy_on_close flag set.

Instead of matching the network namespace, match the netgroup of the radio
to limit radio removal to those that have been created by the closing
Netlink socket. The netgroup of a radio identifies the network namespace
it was created in, and matching on it removes a destroy_on_close radio
even if it has been moved to another namespace.

Fixes: 100cb9ff40e0 ("mac80211_hwsim: Allow managing radios from non-initial namespaces")
Signed-off-by: Martin Willi <martin@strongswan.org>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 9f856042a67a..d28bf18d57ec 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -6698,14 +6698,15 @@ static struct genl_family hwsim_genl_family __ro_after_init = {
 	.n_mcgrps = ARRAY_SIZE(hwsim_mcgrps),
 };
 
-static void remove_user_radios(u32 portid)
+static void remove_user_radios(u32 portid, int netgroup)
 {
 	struct mac80211_hwsim_data *entry, *tmp;
 	LIST_HEAD(list);
 
 	spin_lock_bh(&hwsim_radio_lock);
 	list_for_each_entry_safe(entry, tmp, &hwsim_radios, list) {
-		if (entry->destroy_on_close && entry->portid == portid) {
+		if (entry->destroy_on_close && entry->portid == portid &&
+		    entry->netgroup == netgroup) {
 			list_move(&entry->list, &list);
 			rhashtable_remove_fast(&hwsim_radios_rht, &entry->rht,
 					       hwsim_rht_params);
@@ -6730,7 +6731,7 @@ static int mac80211_hwsim_netlink_notify(struct notifier_block *nb,
 	if (state != NETLINK_URELEASE)
 		return NOTIFY_DONE;
 
-	remove_user_radios(notify->portid);
+	remove_user_radios(notify->portid, hwsim_net_get_netgroup(notify->net));
 
 	if (notify->portid == hwsim_net_get_wmediumd(notify->net)) {
 		printk(KERN_INFO "mac80211_hwsim: wmediumd released netlink"
-- 
2.43.0


