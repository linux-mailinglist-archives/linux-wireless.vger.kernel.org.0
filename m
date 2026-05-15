Return-Path: <linux-wireless+bounces-36500-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE+rLkNpB2oJ2QIAu9opvQ
	(envelope-from <linux-wireless+bounces-36500-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 20:43:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1955566E4
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 20:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 284BD30063A1
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 18:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E9F3EEAEA;
	Fri, 15 May 2026 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="dnaC/HaX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFADF3F44F6
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778870374; cv=none; b=s1Ce1nak9oKQiMo2ZGTFMxHGYdQILJPARSW4YMER45CXBSiouzCGfYWU0SzbX0wAfachYI9ganbEj/X0V5ByC/6UJnaxogeoEe5RHX9cjUp02EwGQeYhdZW7GhNxmHW2+dErQmDMf7KkTkKNvmiu/PZMXvtyxjqHrqxZk+CGiUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778870374; c=relaxed/simple;
	bh=EKxsl5E2M8E7QMXwaS5Z8b0/PEJ1bez4Bgf7i4lbFpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PkF3krS7VnTgQ0lz8Va8M3Pw/RmrAsaReDqwMmoiUHuUzzA/kEEWni0yIhZ8m2bukRnb/PLRss338n6my6SlpOwCS8tjS6L1YQEL7SDV0BxzFeYl3m3KJdqCGQMeUC5QgxEYhxfnN1XrF56YgqtaEbTLNY9UlFEC1GrKJWfSPJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=dnaC/HaX; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1778870367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U/jjmpLvObTvHV9hKFKnoUw9o9V/WxOQQ1aWJYolflY=;
	b=dnaC/HaXTrd1HN65qJlPNvodOGgPnHpnIbq9bzDw81zwAz1zH+NGN5gmwyBSeZRcMsy9Zj
	MhPGbLHqPDKi7mCObKhZo1Vm911TPoreaxJYuMB3fOm4IwGsHrnj5bHB/e7UUSMEM29aqy
	GnA1iUzT+nwlunVnEOq0CpDvbL7OHRsd8l7M31Evn1s5tTU9QWGS8hR5638rfxMc9DZx8y
	WNFZycEzjsfFT6EkifMG5efww8+Fg/hKjLbQ59zW9VVgNPBlRQVew3weDdvnvEdIz/8ufs
	irgwAn4CR88QCoV4FZOE0poXnrEsMH0ul99FGlhXB7dwrGZo1gExJu2iAsewug==
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Deren Wu <deren.wu@mediatek.com>,
	Nick Morrow <morrownr@gmail.com>,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7921: assert sniffer on chanctx change
Date: Fri, 15 May 2026 11:39:21 -0700
Message-ID: <20260515183921.23484-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 3C1955566E4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36500-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,justthetip.ca:email,justthetip.ca:mid,justthetip.ca:dkim]
X-Rspamd-Action: no action

mt7921_change_chanctx() configures the channel for monitor vifs but
does not re-assert sniffer mode. mt7925_change_chanctx() does. Match
mt7925 by adding the missing mt7921_mcu_set_sniffer(true) call,
completing the architectural pattern from commit 914189af23b8 ("wifi:
mt76: mt7921: fix channel switch fail in monitor mode").

The user-visible regression this asymmetry produced on v6.17 and v6.18
was addressed by commit cdb2941a516c ("Revert "wifi: mt76: mt792x:
improve monitor interface handling"") in v6.19 and backported to the
6.17.y and 6.18.y stable trees. This patch is defense in depth in
case the NO_VIRTUAL_MONITOR change is reintroduced in a future series.

Tested-by: Nick Morrow <morrownr@gmail.com>
Tested-on: RasPi4B, RasPiOS 64 bit, Alfa AWUS036AXML mt7921u
Tested-on: RasPi4B, RasPiOS 64 bit, Netgear A9000 mt7925u
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 3d74fabe7408..fec9ab577dd1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1405,10 +1405,12 @@ mt7921_change_chanctx(struct ieee80211_hw *hw,
 	vif = container_of((void *)mvif, struct ieee80211_vif, drv_priv);
 
 	mt792x_mutex_acquire(phy->dev);
-	if (vif->type == NL80211_IFTYPE_MONITOR)
+	if (vif->type == NL80211_IFTYPE_MONITOR) {
+		mt7921_mcu_set_sniffer(mvif->phy->dev, vif, true);
 		mt7921_mcu_config_sniffer(mvif, ctx);
-	else
+	} else {
 		mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->bss_conf.mt76, ctx);
+	}
 	mt792x_mutex_release(phy->dev);
 }
 
-- 
2.54.0


