Return-Path: <linux-wireless+bounces-33039-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uN4CIPpHsmlrLAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33039-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 05:58:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD0126D3E7
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 05:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 485FB3020529
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 04:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E0139478F;
	Thu, 12 Mar 2026 04:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="KBZT2v9d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02741DDC28
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 04:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773291512; cv=none; b=jOH06FLo72iCX+8uvclxMviBgNyjubORk70uSBdQRrt322LruV3avU8XqvL6fnshnSV6WrQEsnxMRB+xlLFV8vOTgtN++inRiEGJyNBBuPlQhOJTFpfHlP4pVc8vBMB4dZpS1wIvb5/GO8MRMJJOpGIlk+5j44hQdJLIGl8CkIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773291512; c=relaxed/simple;
	bh=SNxAvTIl7r5LoUtI7KlKQ+NQNbjYktbwTZ3NRXBiBf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDex4P7I1nI9Jx0hlYYiTESrQstdyetQfbjUVX9JdWFktZzwuZs8GwzuuINgyE2Zb4IX0vLWfUr3n008Px2uQP95lYUUcJvbVKsuEi/turISj5qep33NBMzXjbbnRVPQ0eurSc2RJSsKmtodUSLVAEbZBs84lGQgLawUdQmtV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=KBZT2v9d; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c70c112cb61so362788a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 21:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1773291511; x=1773896311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tej8ijp6a77Vad+nvgoFtLvIdx4m5zOniBcUjvCi+W4=;
        b=KBZT2v9deHKGJEwRhaw2XIzq9Gh0pwfUIYfMSUTuoYEYjACr6RJ/FGZA6LR4qyzDJo
         svh27Ld870AzZXassECSKnD3idIFt6KzKCEBM4IiXxSprNvDnoDRoffudfYc+zXkLCuF
         I20rrAQ3K2cUMdnb17daZCRn/s4J4ogFfKSYY/3dVsYnwql8804UESLr/lQGfi0haOra
         +oZVMqgUrc4Qx7+tgsrNlxMzb85yTaabpjYeN5mWr2LgSMITLtJNg+xxDQDlh9mSqtJ4
         vDRu3FFvkAPQWFaGE+1NzNvqD3Lne0y7Fg3u9pjYNapj8QAjnJSBpkTzG7GmSbSMfh4V
         7jow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773291511; x=1773896311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tej8ijp6a77Vad+nvgoFtLvIdx4m5zOniBcUjvCi+W4=;
        b=nXTzMFums2Tb/UK7ZkQtExjIr8lFPb3WOHV7lQ9PZHw650xCMQchFi+3W50+Vzo8Di
         zQyhoRqzai3BX6l7RS4W+u20Yhx45y/0dThOPfHMM579sVJFBmH4MMixkQ56DUqqiDB+
         a5wcb9O/d7erYBrK0Kwp39dj9UJrvjXmcEz+eu6AtqzSgPV8L+eLioRBRu/4mcltq2W9
         W040NOX01K+iIWAGbIa+I8wEgGSTxx4QvcpDZ6EcUdsmamvlijtb2IpwShoAN23JBiZi
         3GTGRW22mLyL/47OZ87bktaVWPF3meDeZ3p/UBTFRKcbk3Xp449ypbcZb4cLUOjJrXLv
         J6tA==
X-Gm-Message-State: AOJu0YwEKPvA5dMMdt0o3KEcm/kl2xslij7ykDPCWKGiKZD9mYcE0MXD
	b3nq8mkWEmxLSCm67Tp3B3ovP772RDWssm4/E52NI3SkK6/58CzYF+ho4Vuf7pDBgSk=
X-Gm-Gg: ATEYQzzhd+ZVLlPeeEvBFsoliRQfECC4OgWNGOrJlWfXXma3ZiTIk/UZ2fd/WQSr5sq
	tyDl6OCLBCcTKvia6OJVFDZD4sotNX7XK8UT9clPNP6uNX4v1fD1z56nsd7w3vxWFDUJ1nXCUoz
	5CRFIfARIDbTCSZ64ayhFdpvY/DroI85EzX+nTEpAsDS/OGWsZ8StEC9+8p7ohRZ33AC0Dd+w7E
	izHhF1Phen20qk09yBpTFY7wflNmYFTVX1Q1fi+BKcFjgAzzpWl3/QeqLxbUnvhb1Stok982kM6
	7Uz2eWCVNE9rR+DmLOvDyfefNFcMrO0vECdsnWvgrSdEEhkH3+t2yTXmLGNlxWSOG/k2MFVwncV
	qvJ1yZtKX68PcojGPkw4EarWl3DPDunScGHIT1ApEfuRxnoxvdhTfxmiCFGvtmbt6Rf19xMMz9w
	VTKHaej2KcM+lhgXt4E2+P9c/4gDHwYdtHEBaCdovZ7WxqtgsNmki9Y4Bzm+fSlhj8GD5qyk5Bx
	0Dt8r2ZiEdNMevk9ZQzok3t5VbbrM4=
X-Received: by 2002:a05:6a20:e30b:b0:398:7d6e:27f4 with SMTP id adf61e73a8af0-398c5e58ecfmr4950459637.1.1773291510902;
        Wed, 11 Mar 2026 21:58:30 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07365090sm1382480b3a.46.2026.03.11.21.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 21:58:30 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next v3 1/3] wifi: mac80211: don't use cfg80211_chandef_create() for default chandef
Date: Thu, 12 Mar 2026 15:58:02 +1100
Message-ID: <20260312045804.362974-2-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312045804.362974-1-lachlan.hodges@morsemicro.com>
References: <20260312045804.362974-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[morsemicro-com.20230601.gappssmtp.com:server fail,sipsolutions.net:server fail,sto.lore.kernel.org:server fail,morsemicro.com:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33039-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,morsemicro.com:email,morsemicro.com:mid,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 0FD0126D3E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cfg80211_chandef_create() is called universally to create the
default chandef during hw registration, however it only really
makes sense to be used for 2GHz, 5GHz, and 6GHz (and by extension
the 'LC' band) as it relies on the channel type which is only
relevant to those specific bands.

To reduce some confusion, create a generic helper for creating the
default chandef that makes sense for all supported bands.

Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 net/mac80211/main.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 616f86b1a7e4..ed5d60328041 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1117,6 +1117,19 @@ ieee80211_ifcomb_check(const struct ieee80211_iface_combination *c, int n_comb)
 	return true;
 }
 
+static void ieee80211_create_default_chandef(struct cfg80211_chan_def *chandef,
+					     struct ieee80211_channel *chan)
+{
+	*chandef = (struct cfg80211_chan_def) {
+		.chan = chan,
+		.width = chan->band == NL80211_BAND_S1GHZ ?
+				 NL80211_CHAN_WIDTH_1 :
+				 NL80211_CHAN_WIDTH_20_NOHT,
+		.center_freq1 = chan->center_freq,
+		.freq1_offset = chan->freq_offset,
+	};
+}
+
 int ieee80211_register_hw(struct ieee80211_hw *hw)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
@@ -1260,9 +1273,8 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 			/* if none found then use the first anyway */
 			if (i == sband->n_channels)
 				i = 0;
-			cfg80211_chandef_create(&dflt_chandef,
-						&sband->channels[i],
-						NL80211_CHAN_NO_HT);
+			ieee80211_create_default_chandef(&dflt_chandef,
+							 &sband->channels[i]);
 			/* init channel we're on */
 			local->monitor_chanreq.oper = dflt_chandef;
 			if (local->emulate_chanctx) {
-- 
2.43.0


