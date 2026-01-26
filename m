Return-Path: <linux-wireless+bounces-31168-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIteGyc6d2mMdQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31168-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 10:55:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F264A86465
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 10:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF0053048022
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 09:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94A532D7DA;
	Mon, 26 Jan 2026 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVMCV8Uq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831A026ED25
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421180; cv=none; b=NMMoKZBSGdUqf7aqm+B1mNn4OUdL66LhRr3cLM4YLrSPgv/T9dC/azfdgFBCGxQHfXEf1jog2TeFoiPEPwt/QzyEfD0y7ukdaDtTJhB31C+V5Qo64OYDBa8t+tq2XBZlqIaE3CN7X11qq0Oy4WvbeUw3zTDy8K8w7iUWFgqTvDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421180; c=relaxed/simple;
	bh=sVSpH8+NYcnzIMyg/fb54cqToJBJ6v/9h1Hs4tEdwMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spe7/VHPuAuo1b1W8S+L67ACqlr+rsfjNuZMdH2Qk3+0yOj4z0DeM+qWWKR/tzDKa8qNqMRyETsZUxZdhi3UJSjtoTPaU9RjpKKSH/ARLUH/zopCen7MhG+J2E68uHP19K7PXCXAuBoSUW60O731dAGbvAODaIfVmYQcIswPBdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVMCV8Uq; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bc274b8b15bso2838934a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 01:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769421179; x=1770025979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sWYMBOcYeZ9PNMuTUodJCzRwRVLkcoq/F3X3pSbTUs=;
        b=gVMCV8UqllILzfGrSank9a+zBtgU56tFDGILMNDrhN6f/Nc2RhGYMH2AvwcMCTTSNV
         HTIzCDzaWb08FVQhRz1GcPROhXbTNa5WynR1VSGuP4zgVQCIOtaSaOC7aSNZa0N2rTZ3
         j+GK65CsOHYKgTSDB5cPAHO5SRWjW3JD5LxrRjUnYGTchy3w20GbNi+fBmTogASbm9aj
         uMm5fcAf4di2m2HmswhH/yN4uGGmuZsL2LxjFTi04D+uNXVtxkzVl6d8XAQyllz/DB7/
         DS2yEJbTu/dJc+f9CjRzVuKStldatc2nBSMhYYo5rnuenMBrJ/36Jwy4stf0WJiDt2CZ
         WdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769421179; x=1770025979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3sWYMBOcYeZ9PNMuTUodJCzRwRVLkcoq/F3X3pSbTUs=;
        b=NypIHSeHdsWqS0FRG+ulL61fnHDR4gZhi47lFzxrUh+dYhtT9sqnVM62CbvI8RM6Fs
         Jw9LYI/DlY/SetCUPzAUp1QT/CHXYXNQ+C2VPXZy1yg84bPBF6xlquC9E3+WCTAbiQB6
         UDQM7HBT3M6EyFiXrJ8rjnSBqiJbMWWgGL+4YWM11OlSFV9h8dBtXNun+9GnjfB6UUCw
         oEGewXihbZJiJVrLXn1kclJ+zYIhnOMN0Zc5FlJ+ecm9YQufxh/R16XoycX4L2iAHqnp
         GR/38XOy2i6KwL3goeokJ2kT0TmpfTXzccfyQUqyr7ytTw7dNFvT7qNxrSd/9jtWkZj3
         zMtg==
X-Gm-Message-State: AOJu0YyXdSgn7jljBCZltuKgnfkSgiLcYm2bEPDfhdRiAznjTdnZL1kC
	TUjXcdL/jUPaDMWJeyOfDfAskDxAq4EpE/QQmJnCPdjoYJKhXY74c0En
X-Gm-Gg: AZuq6aLkw2S0A3EKs6He8BUa/gPrSgVTaeGXy2INrXi58mBZp+dvVUeM1NjjlcsLUJW
	UzibwfaeyH03HQNampuEfRsqcVQ/4TimUTJUBUJAPX9X3PEyi5psgbztQMyghceYTivZi8Uyhg7
	ZzbVz/27fhAXrk9wTQ1HBHWBe18E2ohRVHCkqzQaVeLz2Gk6XMVr9PjK5mvbxP3oyFoOUWt5Hag
	ny3J1GY3kOc8f5e3HRuZbLoaCEUsrhdSrF7FGCja9Pe5Wcqbs6ZyZNmpMC6WgTGBXsvibG1tbMj
	PJ7/o8phTdX56wIcZbzyHnAXNZ0TxKSxGNh0Knz8m+3gHFsrHEqsroI0d4TDMw4df795xutbIW4
	d1sofm+F1uy1ZlFroU4vNeKVgyoP8omPti7tA5zOKlTonpQVQJwxSuUGJowxeEOUjqwlc7v1yGw
	zfs17Z6oM7wnuKu8RgT8HqksrWC7eJz1miDBLf
X-Received: by 2002:a17:90b:3512:b0:34f:62e7:4cfd with SMTP id 98e67ed59e1d1-353c4183501mr3515625a91.24.1769421178790;
        Mon, 26 Jan 2026 01:52:58 -0800 (PST)
Received: from saikiran-Yoga-Slim-7-14Q8X9 ([2402:e280:3d17:646:1d59:cd47:36b6:dec7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536f359950sm3187627a91.10.2026.01.26.01.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:52:58 -0800 (PST)
From: Saikiran <bjsaikiran@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	kvalo@kernel.org,
	Saikiran <bjsaikiran@gmail.com>
Subject: [PATCH v2 1/2] wifi: ath12k: Remove frequency range filtering for single-phy devices
Date: Mon, 26 Jan 2026 15:22:43 +0530
Message-ID: <20260126095244.113301-2-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126095244.113301-1-bjsaikiran@gmail.com>
References: <20260126095244.113301-1-bjsaikiran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31168-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F264A86465
X-Rspamd-Action: no action

The frequency range filtering added in commit acc152f9be20 was designed
for split-phy devices where multiple radios with overlapping frequency
ranges within the same band are combined into a single wiphy. Each radio
in such setups handles only a subset of channels within a band (e.g., two
5GHz radios covering 5GHz-low and 5GHz-high separately).

However, this filtering breaks single-phy devices like WCN7850 that use
a single radio to handle both 2.4GHz and 5GHz bands. On these devices,
the freq_range is set to cover the entire supported spectrum, but the
filtering logic incorrectly restricts channels, causing 5GHz to become
completely unusable.

The issue manifests as:
- All 5GHz channels filtered out during channel list updates
- No 5GHz SSIDs visible in scans
- Only 2.4GHz networks functional

Remove the frequency range filtering entirely and rely on the firmware
to handle frequency restrictions based on actual hardware capabilities.
This approach works correctly for both split-phy and single-phy devices,
as the firmware has complete knowledge of what the hardware supports.

Fixes: acc152f9be20 ("wifi: ath12k: combine channel list for split-phy devices in single-wiphy")
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim 7x)
Signed-off-by: Saikiran <bjsaikiran@gmail.com>
---
 drivers/net/wireless/ath/ath12k/reg.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 7898f6981e5a..48c362a86524 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -153,12 +153,6 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
 			if (bands[band]->channels[i].flags &
 			    IEEE80211_CHAN_DISABLED)
 				continue;
-			/* Skip Channels that are not in current radio's range */
-			if (bands[band]->channels[i].center_freq <
-			    KHZ_TO_MHZ(ar->freq_range.start_freq) ||
-			    bands[band]->channels[i].center_freq >
-			    KHZ_TO_MHZ(ar->freq_range.end_freq))
-				continue;
 
 			num_channels++;
 		}
@@ -190,13 +184,6 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
 			if (channel->flags & IEEE80211_CHAN_DISABLED)
 				continue;
 
-			/* Skip Channels that are not in current radio's range */
-			if (bands[band]->channels[i].center_freq <
-			    KHZ_TO_MHZ(ar->freq_range.start_freq) ||
-			    bands[band]->channels[i].center_freq >
-			    KHZ_TO_MHZ(ar->freq_range.end_freq))
-				continue;
-
 			/* TODO: Set to true/false based on some condition? */
 			ch->allow_ht = true;
 			ch->allow_vht = true;
-- 
2.51.0


