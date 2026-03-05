Return-Path: <linux-wireless+bounces-32569-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFXkM1C8qWnNDQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32569-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 18:24:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B6E21621A
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 18:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DEA73011171
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 17:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33D83E1205;
	Thu,  5 Mar 2026 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="ar6we1TO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2070A3E123B
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772731394; cv=none; b=rZD/KFjqFZlrI4HPbuWelUKR8nf+HefcoyAEw/sSjVKVbB0VlvLdK53pf0AtFR6OZrGzcSPhrEIeJIYY7WZrNjwI+QInhDlNWqKZmevSUaa0VyRKNWuayVb1d2j2QEqkzF0C2BZ+rpiOPCFqmHmWdxQejDBAJHeqXH5ka/wHPMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772731394; c=relaxed/simple;
	bh=M0q11xF7CXO0zwYacOuAhBWP4t2LzK+M8gQ0gf14PPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jR45FDfaaX5F1VXzy287W4+g1Zcnwp5+SVWsPFlyKdLA6wrgzp6GR4CV7FUp1ZW+EM46+VGD/S2OUCqdsCXPcIH+EbMs44w+7tFyD66hTTdxpf5c1cFmIgnTy0onE2yMMQDUEgwrrmwWkW50F+xiZVC8J8UfQXxHe+8n22sKjUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=ar6we1TO; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PUx1aVpAe1izQ34xuUAmiUZwn/8D4nl21eIuKvA+qCY=; b=ar6we1TO8+163a4KvVDFAtTNfy
	DviBkoCvyJ7wdj4NZKvHanXm/dYX1zbwDC2FsS6YMQPzcba+NnxfyfLWHZrF7cvcJEM75kAG3owYY
	lrQZ/3/3AkUMj8TuW3XvaRFZbiwo77NSNfoaR4MVYWTTlWJyph82AJumgHSuhp5SXsgc=;
Received: from p200300cadf1c8200000000000000085c.dip0.t-ipconnect.de ([2003:ca:df1c:8200::85c] helo=max)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1vyCC2-00E9Om-2O;
	Thu, 05 Mar 2026 18:08:58 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH wireless] mac80211: fix crash in ieee80211_chan_bw_change for AP_VLAN stations
Date: Thu,  5 Mar 2026 17:08:12 +0000
Message-ID: <20260305170812.2904208-1-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 79B6E21621A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32569-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[nbd.name:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.069];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

ieee80211_chan_bw_change() iterates all stations and accesses
link->reserved.oper via sta->sdata->link[link_id]. For stations on
AP_VLAN interfaces (e.g. 4addr WDS clients), sta->sdata points to
the VLAN sdata, whose link never participates in chanctx reservations.
This leaves link->reserved.oper zero-initialized with chan == NULL,
causing a NULL pointer dereference in __ieee80211_sta_cap_rx_bw()
when accessing chandef->chan->band during CSA.

Resolve the VLAN sdata to its parent AP sdata using get_bss_sdata()
before accessing link data.

Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/chan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 4447cf03c41b..f382b144ebac 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -561,13 +561,15 @@ static void ieee80211_chan_bw_change(struct ieee80211_local *local,
 	rcu_read_lock();
 	list_for_each_entry_rcu(sta, &local->sta_list,
 				list) {
-		struct ieee80211_sub_if_data *sdata = sta->sdata;
+		struct ieee80211_sub_if_data *sdata;
 		enum ieee80211_sta_rx_bandwidth new_sta_bw;
 		unsigned int link_id;
 
 		if (!ieee80211_sdata_running(sta->sdata))
 			continue;
 
+		sdata = get_bss_sdata(sta->sdata);
+
 		for (link_id = 0; link_id < ARRAY_SIZE(sta->sdata->link); link_id++) {
 			struct ieee80211_link_data *link =
 				rcu_dereference(sdata->link[link_id]);
-- 
2.51.0


