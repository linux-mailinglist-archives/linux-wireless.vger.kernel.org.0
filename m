Return-Path: <linux-wireless+bounces-32998-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oH9dHt3XsWnVFgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32998-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 22:00:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE70126A3B1
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 22:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F60D307D4E3
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 20:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E53239E63;
	Wed, 11 Mar 2026 20:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJNF5dQk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21367350A08
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 20:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773262650; cv=pass; b=jvSudjgQBCHU8lQ210rwOkx3lhrtGOxshF25sdmIFWtD9bF7SAK4EbDEgbXw1g+BJ1wi0FIZnbFOd1lDO4lDisF2aRC6pZIn0Os+z1NWYnTEDWTV+vRIrCMzzeEWOGoMPytvBI/6ZQ6e+oiodhNQ/DM9mZ70qTk/EBFmgdGMj7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773262650; c=relaxed/simple;
	bh=cQzc+P2qKXOaph3T+6nmGSpOHj8lmyaGOBl7s45UogY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRbx5nytbWQVoBSW+UVg1b1aMa+6GWvbu2bYQIo5uXzzjONyCyNj0Rg7KhnAxR8NIbKv/ObGdScoX1jxmpSYn4p8TGmRxFqo907Le6aWJ5Eq4P7TU9HiETxU33vTCpkOI0e+iJUzWlWIjMIsihaHYMmnL1L19AeccsyYMinFHcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJNF5dQk; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-661d20c9787so381832a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 13:57:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773262647; cv=none;
        d=google.com; s=arc-20240605;
        b=TjhRuvNlhYVKLgktKJR7GCeUx7ZhrADHdfegYbYV8zjtsHvoENnhgwo8RZdAr6EIjV
         exYVHwfk4GLaA028XCcDOBSHi0OdN5jOQckEbrz+csi/yT6b/iaA+NMg+yAmPCQ6PpBI
         nh9l5LcMNKNfyUSrsWo2nRfWliqCRA3RYds0vCMjNw4wuNRoPB6/2vu3qyguvMnQ6VRP
         gOcGdCbaRYkVuBNMCnG7C7XiCzV6XOuhMhgtjtMv8Dj+/UPz5dFwecUfwnDCF6+BbLKl
         XsMfW7NgpilAnRgcXVf0x3TydxPtkwCR7RBaZCnxXJoxanUs5/P46Y+iFfGDPsgAOlnh
         XEdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XFQ/QAVUt2bC4UBVG90/SucbtwxVRuUMolNaHVPHXSY=;
        fh=MXkW9Xo5Ym/gIF9EG8Fk1lbc8jJJ90IIrm4Se6meZo4=;
        b=XQM556JydYGf8GhKglovTT+C19vcuTya6kAriLvTq+Qg/QjM1jLXdJL0bnfxvfimGn
         hnIB1xCTORGh7UyBrr5qaNisOGyzrZqYzqgohrf4eGEJMoQAWaMMNStbIk9WJtUPwGkK
         0d9fjyCV/l+n+vBKdEwovIwXSx8JdAeUqGPedL3JwDsZC/VOQgwehU+K8WohB9A7P6kS
         3QUSanSzs0XZ8jATzqDuMgDD7kX5cHIKWGRzQR9F3I24SmWBKriTOlbPQi+8C8eAHxQz
         0p/p7LoePnbL6SlSWpHD2DjewSRG9HOHpMCeRhe+kAhkTabylr8suQLeiT9nm1Tdr17u
         O79g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773262647; x=1773867447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XFQ/QAVUt2bC4UBVG90/SucbtwxVRuUMolNaHVPHXSY=;
        b=mJNF5dQkBzsUTxWKzcgOMSsN8vBA8/yXKK3vMtZOF1wYf/DGjbBjh5hg3ZTyJMGwF0
         MqNq4VmPhhzey4bvfWPhg24686L4hS/tdqqdTgb7D6iy85hkzKbOLB5AaslKQ9XOIkh2
         uBKfPzPWAXiZwnyo/uiJjTQZ/tXNTqxKxm4hGxv1vGm9Vf69Ly67cEmv/Vq0Chg+I50/
         sQahlxGFFtPBCTTHn/+Ro3lTgEDjD9BhU+PJ3HUHBm/E9WLjvDImXcmLXsunMiODHfPh
         ZWtpa/4UNENcGWPIPGtGrsveqatOtTxAT+zYZgaV9vfgzLfNi4SmeKC3MFI8SDGXk6Kd
         cP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773262647; x=1773867447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFQ/QAVUt2bC4UBVG90/SucbtwxVRuUMolNaHVPHXSY=;
        b=QYCkj7CnV9S701ogaEvgT4YsEZqPHNVuZi4rZJvw4UprnbrtryGtfDvMbGsdW4O7+f
         jdI3sa1KXGZOE21iMNqgqe9T3QKjG3aeH59N1kfeFEToVxLFYd29zZchEVKxmB7X0VRM
         ffiA+cxQoo/44LQRQPZTnGXQGQDVxlfbmtMm05Yrchz2r0F+jqADBhe7Fl8NBjLKkJe6
         ay9z/91Sslpo02vxs6Bbcaf1BWjZ1ob85vm5AnRdSxnMOXhte7N0EUsqnCvn9LhvfPhU
         V4B19YEPbqF+r4BZEI6Q+bm4G/G0tu0em4JTizVLRUazJoysDkB2oAffy0VqnJO5c4e/
         Vgcw==
X-Gm-Message-State: AOJu0Yw10Ztw4btIofiZzU6llfvyWWEOacHIj9G+gJvcYuf6XdjXgERP
	MUfepOwBwcv0cxFj0MyqAHyPHUY3+8Q5TNDdP6wkQuQi/ySX2RkEyCwG8aPnUPuTgfIw+BrMfz5
	kT7aONUBaUs8UzHn77lfwgueBi7BMG98=
X-Gm-Gg: ATEYQzxuxPveLgoXL7I2vRisRrKp0vwm7nWWFT+djPziMeqR1lhuhHMaeK9tcNecYc3
	thHzuUF9EtHhrjN55FN68fRMCirF3l4Ckg11t+sXkKdRMRYekulUPH3L8jqj4HPsT6N+MJoKtdY
	Orjc4OIshP6V6RstIri8A6IWpfjfHIHNT26BNR/DV6DE55/qlRc9M4j2ZcS0bwa7J0XCW3T6N2O
	4dfI7JK7Ah85ciCyz93HAoYusR+cP90JfC9m8etDbOwcDK+674g/g7LN8Vb/OY+cVPuj6SBr75a
	kRRsjg==
X-Received: by 2002:a17:906:7955:b0:b90:71a2:3e76 with SMTP id
 a640c23a62f3a-b972e70af16mr238634666b.61.1773262647344; Wed, 11 Mar 2026
 13:57:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANAPQzi3BkfnRS4CEXAA560O5cO8e6MEYxeVVx1u+xUeXS-gmA@mail.gmail.com>
 <CAGp9LzoidBL1iYYC371+Fw+drbArLRTneJKxCoFiitx=dweKCg@mail.gmail.com>
 <CANAPQzjiBf8Rqphn2SypYN2O6bddj6vB=63Mp=T5YVEt2oGvyw@mail.gmail.com> <CANAPQzgiE1rMP3F=5NJg3hp2uBXtq44+vTRBdkHwdfHyXJ8MQQ@mail.gmail.com>
In-Reply-To: <CANAPQzgiE1rMP3F=5NJg3hp2uBXtq44+vTRBdkHwdfHyXJ8MQQ@mail.gmail.com>
From: bryam vargas <bryamestebanvargas@gmail.com>
Date: Wed, 11 Mar 2026 15:57:15 -0500
X-Gm-Features: AaiRm501XYuf6_xNncggL8WilcZ-LyyUOcc71F3ioiC44yhoD1Fm0RW2lRnL-J0
Message-ID: <CANAPQzgD312EPSbvaQTE6U+wn85L65+xZHms7DP509ApxWvSZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mt76: connac: fix txpower_cur not updated in mt76_connac_mcu_set_rate_txpower()
To: Sean Wang <sean.wang@kernel.org>
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32998-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryamestebanvargas@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE70126A3B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From 6c75ad481f0c3667d6ae2a2c8f7c2df08b1d52b5 Mon Sep 17 00:00:00 2001
From: bryam <bryamestebanvargas@gmail.com>
Date: Mon, 9 Mar 2026 11:52:53 -0500
Subject: [PATCH v2 1/2] mt76: mt7921: add mt7921-specific get_txpower callback

Instead of updating txpower_cur in the write path
(mt76_connac_mcu_set_rate_txpower), implement a mt7921-specific
.get_txpower callback that derives the reported TX power directly
from the SKU limits at query time.

This avoids mixing write-side configuration with reporting logic.
The callback uses mt76_get_power_bound() for SAR constraints and
chain delta, then mt76_get_rate_power_limits() for per-rate EEPROM
limits, yielding the actual TX power value.

Fixes: 3b4a3bdba808 ("mt76: mt7921: add support for reporting tx power")
Signed-off-by: Bryam Vargas <bryamestebanvargas@gmail.com>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 67383c4..35454e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1517,6 +1517,31 @@ static void mt7921_rfkill_poll(struct ieee80211_hw *hw)
     wiphy_rfkill_set_hw_state(hw->wiphy, ret ? false : true);
 }

+
+static int mt7921_get_txpower(struct ieee80211_hw *hw,
+                  struct ieee80211_vif *vif,
+                  unsigned int link_id, int *dbm)
+{
+    struct mt76_phy *phy = mt76_vif_phy(hw, vif);
+    struct mt76_power_limits limits;
+    int n_chains, delta;
+    s8 tx_power;
+
+    if (!phy)
+        return -EINVAL;
+
+    if (!phy->chandef.chan)
+        return mt76_get_txpower(hw, vif, link_id, dbm);
+
+    n_chains = hweight16(phy->chainmask);
+    delta = mt76_tx_power_path_delta(n_chains);
+    tx_power = mt76_get_power_bound(phy, phy->chandef.chan->max_power);
+    tx_power = mt76_get_rate_power_limits(phy, phy->chandef.chan,
+                          &limits, tx_power);
+    *dbm = DIV_ROUND_UP(tx_power + delta, 2);
+    return 0;
+}
+
 const struct ieee80211_ops mt7921_ops = {
     .tx = mt792x_tx,
     .start = mt7921_start,
@@ -1541,7 +1566,7 @@ const struct ieee80211_ops mt7921_ops = {
     .wake_tx_queue = mt76_wake_tx_queue,
     .release_buffered_frames = mt76_release_buffered_frames,
     .channel_switch_beacon = mt7921_channel_switch_beacon,
-    .get_txpower = mt76_get_txpower,
+    .get_txpower = mt7921_get_txpower,
     .get_stats = mt792x_get_stats,
     .get_et_sset_count = mt792x_get_et_sset_count,
     .get_et_strings = mt792x_get_et_strings,
--
2.43.0

