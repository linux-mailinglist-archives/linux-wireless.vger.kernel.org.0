Return-Path: <linux-wireless+bounces-37377-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9bLoKgtWIWo+EAEAu9opvQ
	(envelope-from <linux-wireless+bounces-37377-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 12:40:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B27763F200
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 12:40:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kemnade.info header.s=20220719 header.b=3Gd+ZVrk;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37377-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37377-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=kemnade.info;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AB4A306C333
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 10:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD1B3EA979;
	Thu,  4 Jun 2026 10:33:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753973DB308;
	Thu,  4 Jun 2026 10:33:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569213; cv=none; b=Ne0K0RSTOr0Mww9QLAcKa6Jf0iPLUdjxI8FSY+O0LK5Rq+PO95rAdUDCZkWlVHomedhtju8L4sf+4jz6ii3rm3C7GQHPoU0zINJ15YhXeTsmRiDCUuOzGSDYuqIhCTD1BmrSXnp/xEr7sqx/PdoOun1YCBbdQWaZLR31X/9mmjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569213; c=relaxed/simple;
	bh=BLc07fKVhXzZnWvTKJ4XMwVDTHiS8Mpeo7tD3taTAyk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=f5+J0TbaR3n6xVRmczmUAkCzH4RsyoyiGK3bAAzguG1KtLvipwZGX3OmWjM2W2UDX6AW8W3jMX28OarCZ2lRU3aV0TFsHMgXHAuoih50N6Z67t2SDcPmQTQlY4QOKqiJVvmr3R/+cX0/K78oNZPwAHG1Fg/4RCqSxVxBCbbGJhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=3Gd+ZVrk; arc=none smtp.client-ip=178.238.236.174
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=ctqp3CGlY5sM1PgS+2m+8jYbn8Iw3joc7iBSUmspyLM=; b=3Gd+ZVrkvGmkYr5UAQ66p/zprE
	QbxrwBiBvvYbvmWlMKu3T77oEb6CdaBnOST7FQSQz8SGQGugrmfXxUEIuG0iOFPMVKRGKwRWLo/Ls
	GFStsdqOf3XxxgPYavuCyEk5H0sE1EhidfHHGuDGwCBATXDQga36Dhu8p3W1hCz48MmBZ9Q9RqKxu
	z8sKvXy1XtbJlltu5xEUm5Ajecx2bKtaHTV4kMpl9edHNGfe0e4ENLYeALvu9XqfvC+EHI00t8gtl
	HjxEg2GD6uH/EvxhNtNFHoiTubagAHKWTH8Yd0qp8Uzn/sT5O+1vEO/86hSoijB7aNq6fXEtsDhW8
	H0ChtRfg==;
From: Andreas Kemnade <andreas@kemnade.info>
To: johannes.berg@intel.com,
	astrand@lysator.liu.se,
	quic_rdevanat@quicinc.com,
	kees@kernel.org,
	sakari.ailus@linux.intel.com,
	andreas@kemnade.info,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wireless: wlcore: enable the right set of ciphers
Date: Thu,  4 Jun 2026 12:33:16 +0200
Message-ID: <20260604103316.377251-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kemnade.info,none];
	R_DKIM_ALLOW(-0.20)[kemnade.info:s=20220719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andreas@kemnade.info,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37377-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:johannes.berg@intel.com,m:astrand@lysator.liu.se,m:quic_rdevanat@quicinc.com,m:kees@kernel.org,m:sakari.ailus@linux.intel.com,m:andreas@kemnade.info,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kemnade.info:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andreas@kemnade.info,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B27763F200

The firmware version number check for IGTK introduced in
commit c34dbc5900b0 ("wifi: wlcore: Add support for IGTK key")

lets the amount of ciphers decrease on every boot of a too old firmware and
that is practically happening. It also does not take into account other
chips than the wl18xx. On some wl128x, the following can be observed
when connecting via nm to a common ap:

[  484.113311] wlcore: WARNING could not set keys
[  484.117828] wlcore: ERROR Could not add or replace key
[  484.123016] wlan0: failed to set key (5, ff:ff:ff:ff:ff:ff) to hardware (-5)
[  484.123046] wlcore: Hardware recovery in progress. FW ver: Rev 7.3.10.0.142
[  484.139923] wlcore: pc: 0x0, hint_sts: 0x00000048 count: 1
[  484.145721] wlcore: down
[  484.148986] ieee80211 phy0: Hardware restart was requested
[  484.610473] wlcore: firmware booted (Rev 7.3.10.0.142)
[  484.633758] wlcore: Association completed.
[  484.690490] wlcore: ERROR command execute failure 14
[  484.690490] ------------[ cut here ]------------
[  484.700195] WARNING: drivers/net/wireless/ti/wlcore/main.c:872 at wl12xx_queue_recovery_work+0x64/0x74 [wlcore], CPU#0: kworker/0:0/892

This repeats endlessly.
Always disable IGTK on wl12xx and fix the decrementing mess.

Fixes: c34dbc5900b0 ("wifi: wlcore: Add support for IGTK key")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/net/wireless/ti/wlcore/main.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 1c340a4a0930..be583ae331c0 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -32,6 +32,15 @@
 #define WL1271_BOOT_RETRIES 3
 #define WL1271_WAKEUP_TIMEOUT 500
 
+static const u32 cipher_suites[] = {
+	WLAN_CIPHER_SUITE_WEP40,
+	WLAN_CIPHER_SUITE_WEP104,
+	WLAN_CIPHER_SUITE_TKIP,
+	WLAN_CIPHER_SUITE_CCMP,
+	WL1271_CIPHER_SUITE_GEM,
+	WLAN_CIPHER_SUITE_AES_CMAC,
+};
+
 static char *fwlog_param;
 static int fwlog_mem_blocks = -1;
 static int bug_on_recovery = -1;
@@ -2367,6 +2376,7 @@ static int wl12xx_init_vif_data(struct wl1271 *wl, struct ieee80211_vif *vif)
 
 static int wl12xx_init_fw(struct wl1271 *wl)
 {
+	struct wlcore_platdev_data *pdev_data = dev_get_platdata(&wl->pdev->dev);
 	int retries = WL1271_BOOT_RETRIES;
 	bool booted = false;
 	struct wiphy *wiphy = wl->hw->wiphy;
@@ -2421,8 +2431,9 @@ static int wl12xx_init_fw(struct wl1271 *wl)
 
 	/* WLAN_CIPHER_SUITE_AES_CMAC must be last in cipher_suites;
 	   support only with firmware 8.9.1 and newer */
-	if (wl->chip.fw_ver[FW_VER_MAJOR] < 1)
-		wl->hw->wiphy->n_cipher_suites--;
+	if (wl->chip.fw_ver[FW_VER_MAJOR] < 1  ||
+	    (!strncmp(pdev_data->family->name, "wl12", 4)))
+		wl->hw->wiphy->n_cipher_suites = ARRAY_SIZE(cipher_suites) - 1;
 
 	/*
 	 * Now we know if 11a is supported (info from the NVS), so disable
@@ -6198,14 +6209,6 @@ static void wl1271_unregister_hw(struct wl1271 *wl)
 static int wl1271_init_ieee80211(struct wl1271 *wl)
 {
 	int i;
-	static const u32 cipher_suites[] = {
-		WLAN_CIPHER_SUITE_WEP40,
-		WLAN_CIPHER_SUITE_WEP104,
-		WLAN_CIPHER_SUITE_TKIP,
-		WLAN_CIPHER_SUITE_CCMP,
-		WL1271_CIPHER_SUITE_GEM,
-		WLAN_CIPHER_SUITE_AES_CMAC,
-	};
 
 	/* The tx descriptor buffer */
 	wl->hw->extra_tx_headroom = sizeof(struct wl1271_tx_hw_descr);
-- 
2.47.3


