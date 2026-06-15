Return-Path: <linux-wireless+bounces-37814-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hUZ1IE/OL2q8GwUAu9opvQ
	(envelope-from <linux-wireless+bounces-37814-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 12:05:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E870B6853D7
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 12:05:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=nKbWjbw9;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37814-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37814-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BA54301B919
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 10:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1A03D332E;
	Mon, 15 Jun 2026 10:04:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FFB2EEE71;
	Mon, 15 Jun 2026 10:04:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781517869; cv=none; b=S6k+2zxZkqqDKwEZOzbPi3aDe6Focnl677/LgJEMiMsOjRzbwzvXoXZxysRErlUBmik060TPyHMsjsWdOV8m2aRLi6dwOsEJK1C+VJ56pyw3+BVZApiWGq92Unj0bXj87hwkCdTu5No18VjWIal5pI052Yl26PfSdDh5Fy84BzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781517869; c=relaxed/simple;
	bh=g/8xnAwne8DXAmxDpypotkqsc4FueU6nYUDeAtZHNWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dbx4TgHC01SqFAfjOQzjbjoo/GP6sCNyfLtLKdhiz+Tk2R/KUNDr7k2FIX3oTNJHhr0BEv5GtleatsgUT2p8PQTBkCPQ7qTqkhVFpimbpTcblXgakBoU3JxmKEVl3XasZS0SAiU9qcZBQFH3OwXSF/JqDLQNRRktSdLaZB+YWhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=nKbWjbw9; arc=none smtp.client-ip=18.132.163.193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781517828;
	bh=ooU2R9jgNyhauJx6UrZTEWa22XXcFTRTmssU3/mmzzM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=nKbWjbw9tqHwDE55lO7bm5jK14OuNrW6Mg9qQ8JmUC6wVF9UaTAef5QHHbAcno/1w
	 7U0xd2RXnvsa9IaWgLv5YhdgzJBtt91IhA1G1+Ke4yO6spEMwcEfRLb/fUCw+PoO+A
	 nWvFnSV+cBkMpPdZM2nsRR302tzu6C4SPBysXci4=
X-QQ-mid: zesmtpsz5t1781517812t739bc093
X-QQ-Originating-IP: KSDGjuIfdttbINF+ELlLi4VEnMNbksYDYuXT9pX3hqY=
Received: from localhost.localdomain ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Jun 2026 18:03:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5588724815608668507
EX-QQ-RecipientCnt: 6
From: meihaipeng <meihaipeng@uniontech.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	meihaipeng <meihaipeng@uniontech.com>,
	syzbot+c0472dd80bb8f668625f@syzkaller.appspotmail.com
Subject: [PATCH v2 1/1] wifi: mac80211_hwsim: skip sta_add rc update on sub-20 chanctx
Date: Mon, 15 Jun 2026 18:03:21 +0800
Message-Id: <20260615100321.22208-1-meihaipeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: NuZvjORXcxgL4M8HaWuGNMOZv/OZXJjqkdIW5SHfd3lvN8GEsRYo54Ja
	R8osj18pRV2ez0IpwOoKRSNxgbFvi8keR8XdWW3qLlwUSC4PdoaNxjOaj0LxTyqHhTlF236
	JPSd5/djb4dWFRhL7HSJOhohbE4vwBrZ+PEqVB4rtQBjCapN1bFnm5S4fQL/XpOSsVtMW47
	3OCXsPa/LLT6UJL4mzsp+IMDPSUMgBRqy6AQLnKg6K7Rx5bSlcfYJ1gwwdskAtHrZtsa/Cr
	R/5xLXKikrmx5dpd7uSk2IHoSVqbFP12VNPgXF539Fn3ULMJAmWyXBRw/FuLpvTdn+78igS
	gVIuAkM/XO0XaC9p864c1LRzBQ2ltZboZBGat69gxTdDIkCW/+UdBfQqzdHjdjwqoJYb68l
	kL5Cmn187s18ARF1yCPi+6mcn/yfC4O1ZlKjef+IuNfsLKx/4LrJaV9JHZiBzSDQ5QyXsMN
	I19TW1NvdCqa0taCpQwulLzE7fnLD8Ay48nCQL6JnqeJGapzpDaAmU3GFv9ZfoHdgq96rFK
	2IGO+dBMzfxHVYaduBa4Cb300zjYz2HAOSO5H5oan+emCNsgddVKpGVkhnJg0Z6ROLefl4t
	QaTQWRp+ZtgW1jV+OLmwcvSqgH+JDt4HNCwCzo5shsHOVpraKWnVP6AoTuPKVUi26hGTBya
	XKEpn2411rVCBzMOe/QhYW1cQ+sCfDv+vVLNBaHUMcV1cXFEPnQPnwT9Xu3YGNnspbudg8x
	rATOrOzBVBT9H0YyI4bt4iJF/DaoNHZnY2iAzyR249EwT4naY1CD0ZAApeFkseHb5BMoYwD
	M+kPcAZZ/0egrryR/rGs3cras1uHEMbYdCk3kTwuS5uYAMpTB0OZCLPIXvTUAVpIIM3pELH
	NNaeMZfi2YtwUrV19SYCEeDgTVQQ6Ll6LVPyg3aGrYg+i6EEkqq0cGeLScIHLfAcMh+6PyW
	i2WE8gcWCxzxJ2ZjocuQlfRs9l7ct+I1qPUHZ4LBzp/wa8En8lacNTiOnA/NQ6UiaOfjjES
	ces4xNkgNkKr+iqO/1quCXilwAfVqJQVJRNzWcDvJyw5XNJ8E85LE2Fhps/XhtG1TBqDM1q
	A==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:andrei.otcheretianski@intel.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:meihaipeng@uniontech.com,m:syzbot+c0472dd80bb8f668625f@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37814-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[meihaipeng@uniontech.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meihaipeng@uniontech.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,c0472dd80bb8f668625f];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,appspotmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E870B6853D7

mac80211_hwsim_sta_add() eagerly calls mac80211_hwsim_sta_rc_update()
for a new STA.

The warning that syzbot hits comes from that add-time call. For sub-20
MHz channel contexts, ieee80211_sta_rx_bandwidth cannot represent the
configured width, so the synthetic sta_add()-time rc_update() trips a
false warning before any real rc_update() path is involved.

Do the same thing that was done for S1G: keep the rc_update() logic
itself unchanged and simply skip the sta_add()-time call when any active
link uses a sub-20 MHz channel context.

Fixes: aea9a6088ae46 ("wifi: mac80211_hwsim: do rc update per link")
Reported-by: syzbot+c0472dd80bb8f668625f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c0472dd80bb8f668625f
Signed-off-by: meihaipeng <meihaipeng@uniontech.com>

---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 47 ++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 1fcf5d0d2e13..4640b5d6cfa3 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -1022,6 +1022,46 @@ static int hwsim_get_chanwidth(enum nl80211_chan_width bw)
 	return INT_MAX;
 }
 
+static bool hwsim_sta_uses_sub20_chanctx(struct ieee80211_hw *hw,
+					 struct ieee80211_vif *vif,
+					 struct ieee80211_sta *sta)
+{
+	struct mac80211_hwsim_data *data = hw->priv;
+	int link_id;
+
+	rcu_read_lock();
+	for (link_id = 0; link_id < ARRAY_SIZE(sta->link); link_id++) {
+		struct ieee80211_link_sta *link_sta;
+		enum nl80211_chan_width confbw = data->bw;
+		struct ieee80211_bss_conf *vif_conf;
+		struct ieee80211_chanctx_conf *chanctx_conf;
+
+		link_sta = rcu_dereference(sta->link[link_id]);
+		if (!link_sta)
+			continue;
+
+		if (data->use_chanctx) {
+			vif_conf = rcu_dereference(vif->link_conf[link_id]);
+			if (!vif_conf)
+				continue;
+
+			chanctx_conf = rcu_dereference(vif_conf->chanctx_conf);
+			if (!chanctx_conf)
+				continue;
+
+			confbw = chanctx_conf->def.width;
+		}
+
+		if (hwsim_get_chanwidth(confbw) < 20) {
+			rcu_read_unlock();
+			return true;
+		}
+	}
+	rcu_read_unlock();
+
+	return false;
+}
+
 static void mac80211_hwsim_tx_frame(struct ieee80211_hw *hw,
 				    struct sk_buff *skb,
 				    struct ieee80211_channel *chan);
@@ -2846,7 +2886,12 @@ static int mac80211_hwsim_sta_add(struct ieee80211_hw *hw,
 
 	hwsim_check_magic(vif);
 	hwsim_set_sta_magic(sta);
-	mac80211_hwsim_sta_rc_update(hw, vif, &sta->deflink, 0);
+	/*
+	 * Like S1G, sub-20 widths aren't handled by this add-time
+	 * rc_update() call.
+	 */
+	if (!hwsim_sta_uses_sub20_chanctx(hw, vif, sta))
+		mac80211_hwsim_sta_rc_update(hw, vif, &sta->deflink, 0);
 
 	if (sta->valid_links) {
 		WARN(hweight16(sta->valid_links) > 1,
-- 
2.20.1


