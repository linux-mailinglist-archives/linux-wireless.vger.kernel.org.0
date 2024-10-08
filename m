Return-Path: <linux-wireless+bounces-13695-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518BC99409D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 10:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6881C246E6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 08:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63845204F6A;
	Tue,  8 Oct 2024 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="RhC920Um"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA562204959
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372236; cv=none; b=mMqcUxz16lZ7jCvWTenvp3/wbwuoCyP57JP+1mH4hna6z2ed8wwOjTwkwOhboddk8Po/DRATvoFrQ/RiuE3anm6jmQYsOWogI8MresFU0JkNdJzV50XM2RfTwPUuRt/VM12+ZYpZP93uex5KxxMDhp+tKvwOiXa2mDU8tdvxV70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372236; c=relaxed/simple;
	bh=UkjF4HOro5aN8DiZTQ3QsDvednMYB+Spm+V0JtIFPlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctZYmh9GPKkqD1V8eaaH0pSJ7qzH2y0Thr66N1NfkI+ci3xhnFdo6ejVNLgKKP7Rxbhyi1R+rpDEPkF5ZJ7zwhaH55CQ7NAmbcPzh6jCsj9sFthqJ3TOV4jk4+C7Jh88fiLXgujwoYjc/YmJ8kgGtdQJgkO/jOIrZeycenyfKrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=RhC920Um; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+W2n1arQ3UlR5HI1TCcncXTPZc4iGYQAVL4hD78CJNg=; b=RhC920UmsFMJpMjVmK6U97sfrl
	ss0o/g+XFwcKUGxvboxB78FeVBLVZQxOOJ9EPqXRTj8mIsuUkriDhXfvw8VHgMt3ahPYl8X2egn+M
	CsdEz48x024iaA1Bbn7HUf2fYBRCLjWC+gA26t811lWnZ3xyftthIpZGL2ue1Kyq26OQ=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sy4ZP-006H62-1Y;
	Tue, 08 Oct 2024 09:23:47 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v4 09/11] wifi: mac80211: add support for the monitor SKIP_TX flag
Date: Tue,  8 Oct 2024 09:23:42 +0200
Message-ID: <9c3a51a9b214e40877da6a589d4383525d33af05.1728372192.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.bd168805c299851d01269473eb64e7b05edc41d6.1728372192.git-series.nbd@nbd.name>
References: <cover.bd168805c299851d01269473eb64e7b05edc41d6.1728372192.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not pass locally sent packets to monitor interfaces with this flag set.
Skip processing tx packets on the status call entirely if no monitor
interfaces without this flag are present.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/ieee80211_i.h | 2 +-
 net/mac80211/iface.c       | 2 ++
 net/mac80211/status.c      | 5 ++++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 4f0390918b60..d697e9dab70d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1370,7 +1370,7 @@ struct ieee80211_local {
 	spinlock_t queue_stop_reason_lock;
 
 	int open_count;
-	int monitors, cooked_mntrs;
+	int monitors, cooked_mntrs, tx_mntrs;
 	/* number of interfaces with corresponding FIF_ flags */
 	int fif_fcsfail, fif_plcpfail, fif_control, fif_other_bss, fif_pspoll,
 	    fif_probe_req;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 3aefc62034ba..54060ba97b98 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1094,6 +1094,8 @@ void ieee80211_adjust_monitor_flags(struct ieee80211_sub_if_data *sdata,
 	ADJUST(CONTROL, control);
 	ADJUST(CONTROL, pspoll);
 	ADJUST(OTHER_BSS, other_bss);
+	if (!(flags & MONITOR_FLAG_SKIP_TX))
+		local->tx_mntrs += offset;
 
 #undef ADJUST
 }
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index d1cf987de13b..eb889cda8bf9 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -927,6 +927,9 @@ void ieee80211_tx_monitor(struct ieee80211_local *local, struct sk_buff *skb,
 			if (!ieee80211_sdata_running(sdata))
 				continue;
 
+			if (sdata->u.mntr.flags & MONITOR_FLAG_SKIP_TX)
+				continue;
+
 			if ((sdata->u.mntr.flags & MONITOR_FLAG_COOK_FRAMES) &&
 			    !send_to_cooked)
 				continue;
@@ -1099,7 +1102,7 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 	 * This is a bit racy but we can avoid a lot of work
 	 * with this test...
 	 */
-	if (!local->monitors && (!send_to_cooked || !local->cooked_mntrs)) {
+	if (!local->tx_mntrs && (!send_to_cooked || !local->cooked_mntrs)) {
 		if (status->free_list)
 			list_add_tail(&skb->list, status->free_list);
 		else
-- 
git-series 0.9.1

