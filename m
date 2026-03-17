Return-Path: <linux-wireless+bounces-33353-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNrBGtaWuWkJKwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33353-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 19:00:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3322B07E9
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 19:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4692B30BE1E3
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 17:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9090137882E;
	Tue, 17 Mar 2026 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="xDgoQTnh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3669737881E
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768630; cv=none; b=nlDenB3GFx2Ue2P/V+qw30bbbQ1KkRoCgV9gVaEJKl+DxlxPZi5G0bmaU36kDAgScgXJQynILfDr1ysdsf7x/UIeB91FiGdIH4pI+D8MPSYJ3+8myfU3uzzDAyr3dJVAfrPbgQ32eg5F24KzJTnZ4ZYFU9S/mRqLoSjRwGrHiBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768630; c=relaxed/simple;
	bh=7Kcx/vlxG1rv93svyUUGJca+uCyfY6vStjBgnfsfPQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVwsaGZnQT+7JMVtUejd2DID1N1gOQRcpahghQ6o8m/UEFGwRbNh2U19YoEkgeoua19+VfjJKX5gnUNOkQ9iVv1dDRZ76Z7z791T/NLaQljRPpODeEE40g4vFo4MChKMRGZpbOrlnptU74pPa4qNUO5/iBjFGI5jpp4drQLENA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=xDgoQTnh; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1773768626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1laft9brAscXHWygDMHywLWraBhdNtqQIsBfWpKqcP0=;
	b=xDgoQTnhyg3ZyjO+S1IVetCbyrkyqOeIPe6J+TKd9GIKz4ch07z9d//AGbH27GbGFRfhvt
	OFpP4zyfzwsqTOiVHMCGL08TC0gC/isHPjRU3f2xgEsSHlNAmxH0R+jrTBEc7yGgY9LsPr
	DO4RkydI1nr6V4C57ZLBVvlShhUxL85HWJQIYaIOMCFBrN8XMSUbumBSnRz9USRCzcf9cV
	ESthIKAEB/9tqeujl+3sSsj5WkM9XASvoLaBZmuvf3g4Yn7YEfzu1lNsOuU1S89HW+gz7d
	9RDZBiayNi1sN4CLN3RF71Iw/u6/vm6xuxYUW1oJLKoMIcuaRlDN3ZOt/NYycQ==
From: Lucid Duck <lucid_duck@justthetip.ca>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	sean.wang@kernel.org,
	lorenzo@kernel.org,
	linux-mediatek@lists.infradead.org,
	morrownr@gmail.com,
	Lucid Duck <lucid_duck@justthetip.ca>
Subject: [PATCH v3 0/1] wifi: mt76: mt7921: fix txpower reporting from rate power configuration
Date: Tue, 17 Mar 2026 10:30:15 -0700
Message-ID: <20260317173016.136975-1-lucid_duck@justthetip.ca>
In-Reply-To: <CAGp9Lzp0LEac0DnAzs477fG5rmA+ZjdDHfdAPWccK3GKEY05rw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33353-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,lists.infradead.org,gmail.com,justthetip.ca];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[justthetip.ca:query timed out];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,justthetip.ca:dkim,justthetip.ca:mid]
X-Rspamd-Queue-Id: CF3322B07E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sean, Felix,

Here's v3 of the txpower fix, reworked based on both of your feedback.

Felix pointed out in v1 review that the fix should determine the maximum
rate power from the loop in mt76_connac_mcu_rate_txpower_band(). Sean
confirmed this direction in v2 review and clarified that the value should
come from the same computation that configures the firmware's per-rate
power tables, not from bss_conf.txpower.

v3 does exactly that. The loop already computes the right value via
mt76_get_rate_power_limits() but discards the return. This patch
captures it and stores it to phy->txpower_cur for the current channel,
matching how mt7915 handles this in mt7915_mcu_set_txpower_sku().
Nick independently confirmed v2 produced correct values on his
MT7921AU -- v3 preserves those results while addressing the
source-of-truth concern.

Two additional issues came up during implementation:

- mt7921's chanctx callbacks don't update phy->chandef (the common
  mt76_add_chanctx does, but mt7921 overrides it with a minimal
  version). Fixed by syncing chandef from ctx->def and re-triggering
  the rate power path in add_chanctx and change_chanctx.

- For chanctx drivers, mac80211 routes iw set txpower through
  BSS_CHANGED_TXPOWER, not IEEE80211_CONF_CHANGE_POWER, and never
  updates hw->conf.power_level. Added a BSS_CHANGED_TXPOWER handler
  to bridge this into the rate power path.

Tested on Alfa AWUS036AXML (MT7921AU), kernel 6.17.1, Canada:

  Band       Auto       User limit (15dBm)   Stock (before)
  2.4GHz     33 dBm     18 dBm               3 dBm
  5GHz       26 dBm     18 dBm               3 dBm
  6GHz       15 dBm      8 dBm (5dBm limit)  3 dBm

  Values match regulatory limits + 3 dBm 2x2 path delta.

Test suite (973 tests, 3.5 hours):

  Regulatory accuracy:     correct on all 3 bands (2.4/5/6 GHz)

  User txpower sweep:      every 1 dBm from 1 to reg_max, all 3 bands

  Band switching:          100 cycles between 2.4 and 5 GHz, 0 failures

  Module reload:           50 rmmod/insmod/connect/verify cycles, 0 failures

  2-hour soak:             480 samples at 15s intervals, zero drift

  Band rotation soak:      30 rotations across all 3 bands over 1 hour,
                           240 samples, 0 failures

  Regdomain switching:     10 countries (CA/US/JP/DE/GB/AU/NZ/BR/KR/TW)
                           mid-session without reconnecting, all correct
                           (JP correctly dropped to 23 dBm on 5GHz UNII-1)

  Monitor mode:            correct on ch1/6/11 (2.4GHz) and ch36/44/149
                           (5GHz), txpower set works in monitor mode

  Edge cases:              min power (1dBm), over-max clamping, rapid
                           power changes (10 in 10s), all correct

  Firmware cross-check:    debugfs txpower_sku confirms per-rate tables
                           match regulatory limits on all bands

Lucid Duck (1):
  wifi: mt76: mt7921: fix txpower reporting from rate power
    configuration

 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 12 +++++++---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 22 ++++++++++++++++++-
 2 files changed, 30 insertions(+), 4 deletions(-)

--
2.51.0


