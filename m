Return-Path: <linux-wireless+bounces-37573-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aRZmMW3eJ2rG3gIAu9opvQ
	(envelope-from <linux-wireless+bounces-37573-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 11:35:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B50065E637
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 11:35:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=RfUNNIAP;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37573-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37573-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92F12305D6BB
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 09:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D7639AD41;
	Tue,  9 Jun 2026 09:34:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8608E38553F
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 09:34:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997655; cv=none; b=JDoPnoevIE6wMWCu6ffb+/0t9hdbwF5/W65fxD9fdT8yRo/PIv4OOrP/9k3B9OfO+v5tJEP6/kg1pxg2tI6EZETRRvmiqFb7Af9csMbxgJlU21FG8OuTfzAPtKMI/8p9J8giZO45Gia0l1p+PDPYO7qAt1dW6E+AS0fHyVslfk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997655; c=relaxed/simple;
	bh=OAJ2FPGaOegDlCFXTwuYym3ZIC2TJcNNxRzP1MK00TM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nyPHmpmk+XjePPlZO713eWRCtumaaPX95w5ysriskr9zfL1FugU09y6KHQXGmvNVdqavep9bW/GXUbN/y560jinLSUteu7Vi2Ga45Zsw/Iv7QV2VoDKoHGxu5AxuMRfH6hyiMzt1Plsf5D7Jh5dtbYxKY3oRbBE9jQ46jTaye3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=RfUNNIAP; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso59936335e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 02:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780997651; x=1781602451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oFRCm287uDLfDYNp3lKjU19Sbg+yyapEIRmK1Aq/3i8=;
        b=RfUNNIAPi8Hei0ImLkmuzZgkHOlC06v8rD7gLLkHJlTeqBOMoKQZGdvGIGnwIHOS5Y
         IXyDGy8NUHv1lZbT5KtAFIx9GhJafLaMLhkv6J/XFJDn4vhEpPsrTKAxa+8kvuPUpEWT
         JUi9tncJdl4ZL4Tg0w14YTUTXLP0viQMla9H+6AfHvovIFL8FYB1QGprvddYHy7tm8Ss
         kAxKZi3yHrszb6klGfbFApCmliixnU3o+9/YvUhgjcnDdsLQZtI6+9aPXz7p7GJObd9M
         fLEIuo4vjmT10oUc7ttV7dxJmN60UXh/jr2p5DoRvKMsU7aod2xmS3rwSvWyrgMXMzph
         dDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780997651; x=1781602451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFRCm287uDLfDYNp3lKjU19Sbg+yyapEIRmK1Aq/3i8=;
        b=hDbrKupzG4h0TzJOvN0nC0qYiL/6Jg4b9nLCJiM13BVHxwG+X2FbsU+QkSmL7PfpB9
         Hb/hSncqhyX2qgJYEaBNpF+oQO4ySzSQ+W7S77fVbJdgz/sy32UapIWoVpYoTP6+v4OY
         uu8OAqukfobURBjZRAowWrW1Gl2cNdo7uIINZkF9Upz6SDXY1DnRw4+uvikM1fZld7yQ
         oT8q72kZhHBaP+GjKleGkZaPduzUTkfohPj7t9FEsh2O9kQmEeN00sj52kMDFCIDcvLQ
         5bqeLbsTduH7kpkfQQbYy2pLPvJh8CuFL6S+nDwdW42ZDw/+zIPsoHlngvk2LBOAM20V
         lu4g==
X-Forwarded-Encrypted: i=1; AFNElJ9kjPHK+ilmpqsFn74F9O+raoaeqfjCgWFaTkKD0yffOTpaaHDiizqjszwfTr9cq/BAulgA/aP8K4WkFIJl7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYOoJEcJwj5gxddi3AsJ2vFazMDN7twtp5EJAyrWjfiYR0mZr3
	aU/Ri8ifVUnPetLvNr8D85Eo8D/+wpPJqlJ0YCREKDLxoqjmBUPZBLD3OEVdWWI8+bEq1ZRA2js
	B+xbXEDk=
X-Gm-Gg: Acq92OFuR591gAL6AQW0TBq4GzjMCgJyMUhtiUGZWt0qBH/UMNFxpOw/1J73HhngV4m
	HUiZuRrBmdflWEThWNTeYItJszhLd5nVkXrrtUeNa9bXqfAHBTY3/GkFKifFFmGQmjqhlziukcB
	pzPaCzlIbFp0Aj15Pj/HnePama10IIwl82WaU8MGbRaTytVnfJ5JaqceLK6u1B31JrxV4p8rq6C
	5So3Cch2mXZiPlUFpCMBRTK8KNYkxO/RWRu/VpzHCr3ZMUOdQhz75XReXX9AaDpwexCl30jW4ay
	KR6kg3Xd+ua6NT7fk8k3Lz0esceqcWNtsvlMvQGf+bxQJxvRjq9uw3NJsEEtCeQtMT2bGao5Ajx
	bi8YMwXMdfWFsKENCzkk387iCkgRVG4JXmZCFLDMXjJTGGDmiYkfi776L/sMAOaR4feF+DkEKCQ
	SvovzyMXdC5FhztbRw69fSqeTpfwSBHXgaUFyrDkK2wsZPnHmt6cNmzlwUH8WC9RzEBuWpCUcET
	SC83Q==
X-Received: by 2002:a05:600c:3510:b0:490:ab8b:1bb3 with SMTP id 5b1f17b1804b1-490c25dd857mr311914885e9.18.1780997650810;
        Tue, 09 Jun 2026 02:34:10 -0700 (PDT)
Received: from localhost ([46.101.197.76])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490bc3d663csm516975455e9.11.2026.06.09.02.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 02:34:10 -0700 (PDT)
From: Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>
Subject: [PATCH] wifi: mac80211_hwsim: fix destroy-on-close UAF in netlink handlers
Date: Tue,  9 Jun 2026 09:32:49 +0000
Message-ID: <20260609093408.2777763-1-dominik.czarnota@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37573-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[dominik.czarnota@trailofbits.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:jukka.rissanen@linux.intel.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dominik.czarnota@trailofbits.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dominik.czarnota@trailofbits.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,trailofbits.com:dkim,trailofbits.com:email,trailofbits.com:mid,trailofbits.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B50065E637

mac80211_hwsim is a developer testing driver for simulated 802.11
radios and is not used for normal wireless LAN operation.

Its generic-netlink handlers can look up a radio by MAC address and then
continue using the returned hwsim data after the rhashtable lookup has
completed. A destroy_on_close netlink socket can concurrently remove that
radio from the global table and unregister/free the ieee80211_hw, leaving
the handler with stale hwsim_data, wdev or PMSR request pointers. This
can lead to a use-after-free.

Make address lookup take an active radio reference under hwsim_radio_lock.
Drop that reference at the end of each netlink handler that uses the
lookup helper. During radio deletion, drop the initial reference and wait
for active handlers to finish before unregistering and freeing the hw.

Fixes: e9ed49bf4c2c ("mac80211-hwsim: Add support for HWSIM_ATTR_DESTROY_RADIO_ON_CLOSE")
Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>
---
The issue was reproduced on a KASAN kernel with a PMSR-based netlink
race reproducer. The report showed a slab-use-after-free in
cfg80211_pmsr_report() from hwsim_pmsr_report_nl(). I can share the
reproducer and full QEMU log if useful.

 drivers/net/wireless/virtual/mac80211_hwsim.c | 37 ++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 1fcf5d0d2e13f..0cc9d06b98041 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/list.h>
+#include <linux/completion.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <net/dst.h>
@@ -31,6 +32,7 @@
 #include <net/genetlink.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <linux/refcount.h>
 #include <linux/rhashtable.h>
 #include <linux/nospec.h>
 #include <linux/virtio.h>
@@ -688,6 +690,8 @@ struct mac80211_hwsim_data {
 	int channels, idx;
 	bool use_chanctx;
 	bool destroy_on_close;
+	refcount_t ref;
+	struct completion ref_done;
 	u32 portid;
 	char alpha2[2];
 	const struct ieee80211_regdomain *regd;
@@ -795,7 +799,22 @@ struct hwsim_radiotap_ack_hdr {
 
 static struct mac80211_hwsim_data *get_hwsim_data_ref_from_addr(const u8 *addr)
 {
-	return rhashtable_lookup_fast(&hwsim_radios_rht, addr, hwsim_rht_params);
+	struct mac80211_hwsim_data *data;
+
+	spin_lock_bh(&hwsim_radio_lock);
+	data = rhashtable_lookup_fast(&hwsim_radios_rht, addr,
+				      hwsim_rht_params);
+	if (data && !refcount_inc_not_zero(&data->ref))
+		data = NULL;
+	spin_unlock_bh(&hwsim_radio_lock);
+
+	return data;
+}
+
+static void hwsim_data_put(struct mac80211_hwsim_data *data)
+{
+	if (refcount_dec_and_test(&data->ref))
+		complete(&data->ref_done);
 }
 
 /* MAC80211_HWSIM netlink family */
@@ -4124,6 +4143,7 @@ static int hwsim_pmsr_report_nl(struct sk_buff *msg, struct genl_info *info)
 	data->pmsr_request_wdev = NULL;
 
 	mutex_unlock(&data->mutex);
+	hwsim_data_put(data);
 	return err;
 }
 
@@ -5620,6 +5640,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 
 	data = hw->priv;
 	data->hw = hw;
+	refcount_set(&data->ref, 1);
+	init_completion(&data->ref_done);
 
 	data->dev = device_create(&hwsim_class, NULL, 0, hw, "hwsim%d", idx);
 	if (IS_ERR(data->dev)) {
@@ -6127,6 +6149,9 @@ static void mac80211_hwsim_del_radio(struct mac80211_hwsim_data *data,
 				     const char *hwname,
 				     struct genl_info *info)
 {
+	hwsim_data_put(data);
+	wait_for_completion(&data->ref_done);
+
 	hwsim_mcast_del_radio(data->idx, hwname, info);
 	debugfs_remove_recursive(data->debugfs);
 	ieee80211_unregister_hw(data->hw);
@@ -6239,7 +6264,7 @@ static int hwsim_tx_info_frame_received_nl(struct sk_buff *skb_2,
 {
 
 	struct ieee80211_hdr *hdr;
-	struct mac80211_hwsim_data *data2;
+	struct mac80211_hwsim_data *data2 = NULL;
 	struct ieee80211_tx_info *txi;
 	struct hwsim_tx_rate *tx_attempts;
 	u64 ret_skb_cookie;
@@ -6326,8 +6351,11 @@ static int hwsim_tx_info_frame_received_nl(struct sk_buff *skb_2,
 		txi->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
 
 	ieee80211_tx_status_irqsafe(data2->hw, skb);
+	hwsim_data_put(data2);
 	return 0;
 out:
+	if (data2)
+		hwsim_data_put(data2);
 	return -EINVAL;
 
 }
@@ -6335,7 +6363,7 @@ static int hwsim_tx_info_frame_received_nl(struct sk_buff *skb_2,
 static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
 					  struct genl_info *info)
 {
-	struct mac80211_hwsim_data *data2;
+	struct mac80211_hwsim_data *data2 = NULL;
 	struct ieee80211_rx_status rx_status;
 	struct ieee80211_hdr *hdr;
 	const u8 *dst;
@@ -6439,10 +6467,13 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
 
 	mac80211_hwsim_rx(data2, &rx_status, skb);
 
+	hwsim_data_put(data2);
 	return 0;
 err:
 	pr_debug("mac80211_hwsim: error occurred in %s\n", __func__);
 out:
+	if (data2)
+		hwsim_data_put(data2);
 	dev_kfree_skb(skb);
 	return -EINVAL;
 }

