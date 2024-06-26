Return-Path: <linux-wireless+bounces-9585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7242917975
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 09:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F34CB2180A
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 07:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDEC14900E;
	Wed, 26 Jun 2024 07:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Ee4RMwqi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF6213D8A8
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719386173; cv=none; b=cdSDuw0/6W6WJww2/FPnFKD0Ho6WTJGl67ke0Tso2xj+p/KaTFNDJMXgFqzuRLaAEE2fosyUoEzhGHmUqDKpB26KukTuoEzdsHGTouDA6DDIs/4J/CzwkIp7ls92XOAPO/fN1xRNRisxNFYuWQPDVV0bI9JauweOtw1Bq0Y4B2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719386173; c=relaxed/simple;
	bh=s6mUhxhBBNbpzOffXw8AxwCwuP5mE5JoVTY6tmrMKqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CNHEIzxx8CT3L7zhDjTaX8N6xWT4PUTxaHiV2mijvlt5b3upiRu5L3toD633X8lMvDldUtwxvmI70Pa+V4bbN1p5hYaxGq5AskjaXuJvH/sgKeoIKk9oFU6qBVAnwZQZ+iqNaUyOBdZwHlhLd3oV07OP0wMfczV8FSAAeHQBSAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Ee4RMwqi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=8S+pFZxjKBV1gjVxZVTeqrmROdYopfCCOWAK3o6ZoZc=; t=1719386170; x=1720595770; 
	b=Ee4RMwqi7FmfjGZw54cl/bFKnbm8a3pK/lW1DCv9mVSdiU6zGdzuHgdIJkbImENLqFNUOuRqoPq
	/95N5QwRxKES4YAyXGbvqZyD9weVwgLyOYcPIbNEvDe/RzwHGvvra3WFiiR+4gIZCk4tBoT2/AUu+
	GWA3pEWAMEHkqPfpNasVYVk58qRmbjTn7D3VbiT4yP5LTgCYiw6uOjiYKDVIUJcH20bZ7vaHU3Epu
	GuEO7ZPMZzzDe5mcLa1jJlwhpdATQDofi658yOrlPUu2Kka5MUwA2zPGV6baTo9krZuXvhtfikaPt
	xYtcXb9OZgNF1DDMSPTcFF9a+EtdZcVOcohQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sMMsr-00000002m2v-0Hpa;
	Wed, 26 Jun 2024 09:16:01 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+1d516edf1e74469ba5d3@syzkaller.appspotmail.com
Subject: [PATCH] wifi: mac80211: disable softirqs for queued frame handling
Date: Wed, 26 Jun 2024 09:15:59 +0200
Message-ID: <20240626091559.cd6f08105a6e.I74778610a5ff2cf8680964698131099d2960352a@changeid>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

As noticed by syzbot, calling ieee80211_handle_queued_frames()
(and actually handling frames there) requires softirqs to be
disabled, since we call into the RX code. Fix that in the case
of cleaning up frames left over during shutdown.

Fixes: 177c6ae9725d ("wifi: mac80211: handle tasklet frames before stopping")
Reported-by: syzbot+1d516edf1e74469ba5d3@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/main.c | 1 +
 net/mac80211/util.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 1132dea0e290..0965ad11ec74 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -423,6 +423,7 @@ u64 ieee80211_reset_erp_info(struct ieee80211_sub_if_data *sdata)
 	       BSS_CHANGED_ERP_SLOT;
 }
 
+/* context: requires softirqs disabled */
 void ieee80211_handle_queued_frames(struct ieee80211_local *local)
 {
 	struct sk_buff *skb;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 963ed75deb76..771c05640aa3 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1567,7 +1567,9 @@ u32 ieee80211_sta_get_rates(struct ieee80211_sub_if_data *sdata,
 
 void ieee80211_stop_device(struct ieee80211_local *local)
 {
+	local_bh_disable();
 	ieee80211_handle_queued_frames(local);
+	local_bh_enable();
 
 	ieee80211_led_radio(local, false);
 	ieee80211_mod_tpt_led_trig(local, 0, IEEE80211_TPT_LEDTRIG_FL_RADIO);
-- 
2.45.2


