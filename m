Return-Path: <linux-wireless+bounces-33667-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id U41sKKXzv2l7BQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33667-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2026 14:50:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F982E9842
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2026 14:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EB5E301C8B0
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2026 13:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A57C358364;
	Sun, 22 Mar 2026 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6lFFD+s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9291C1A6830
	for <linux-wireless@vger.kernel.org>; Sun, 22 Mar 2026 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774187367; cv=none; b=r7FuacGnjp8S8WMn9ubfJkhqMSAzSuPit5dmFwcoKmcMA3uhVZnWyoESK1fkGJlhoXBFCih/eD3gjJ24eq4rNUMnJsVyxFtNYJ+ZJ1d3H6ulLGzK8MRzey386ncy4fsk6Z69peE+iM4E+ae76Eu/4h1wCON7Kqi9oEeJl0Zt65E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774187367; c=relaxed/simple;
	bh=zKm9C68yGe+LNdtvfQE50xg0MjkcXA1Mc+sGWFF7iQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGxC+ZnrIs02ONQUjm9OKDHkekGvoZ8c/nW26zVQhm5N8zv+S7wIDq0TAslEUJ/1erRLVIzTZebtzCMBqL1ffc8wGSlTsc7Gl1krluhaTplpMXDyVmy7VVB8ivBjpQHfsfsUMi5doI2ZsTWPI+NQKNzvXmPAoVxvR4CdpUbhfzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6lFFD+s; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso23594585e9.0
        for <linux-wireless@vger.kernel.org>; Sun, 22 Mar 2026 06:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774187365; x=1774792165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvG7vaVxYt7j8HH9LHHGlNM2wx2cXGwZObQrBCXRyTk=;
        b=U6lFFD+sxGChTHkVAcezOGZfrOJy/LUeHiNGwNBU1tH3ry1AjFIie33EXhNZFY90rp
         WFbmU4oAi1sJ+ft3msrCzWMIvmVPOjMZIIBOGEBqjPdVDVSwUW6ZAYwiFTY3rn6Aq4t7
         GCD9Ejzeu+8nPaVAPE3x5sQM76c0vAlTLwjmYRf66le0iQ63RFkAuzGeuRl9YTMm9x71
         Gn3BBot41mnbX2AsuAYZlIpJEAtJZYYCraoDZWf5A+jzegV2Lla71iqgpJdG43OVL3ng
         bcYxYpP4+ndPOqtl4OS9AfylcSba7IpDEmlm90BZbwDnshyzBjcdtuRd3UAvEtYNS6mo
         /2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774187365; x=1774792165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CvG7vaVxYt7j8HH9LHHGlNM2wx2cXGwZObQrBCXRyTk=;
        b=Bm+3rpNCr19L58tYlPixGcjt1b651fSyK2InFVa+Zyg8oq8U6nr6CeOyYbBgvrvV56
         +uvwJauhkv0IrOiLbIG2EgSOh14+5wP5fVwIOgU0XZ5OdnohpeDV31WPB21rLHxIiNTS
         OaRGXjwggQmzANgyCLEBovN7cGKifnu9z3zfn77WCyM6hiOp8pIfqZOciNy1baqGIQu2
         /9jpaAfxNM2QJReqG+vLn0VkLI0tK51/QWiL/EDHzD3snHyC4qmIafEVBuOxhI7FyjLD
         OYEBVIeoolM3/+02yHQ/h/G5BuPQIrU2YsFtSb7Wg4zmgKu7F/W+VOYDz5+SFX1wH7jL
         gU7A==
X-Gm-Message-State: AOJu0YzxKJIdVZU/Vgkg1nw6PWVcE5vgVudteMK4KiJPpP8+4NlVb6BC
	KFbSLZX3GXr28pHymjXBA31jwNVaR7l8TcVVZaC8JVdcBX1AkDgNccoDteGHG9QVkas=
X-Gm-Gg: ATEYQzwakbgKPwjuCtFfSSLG7VKrdNEKRbl1tb5NhQvOaXPjpTpKMwxHUnmt+Y+4+Qv
	DiZ9DHMf3bacuhJbanWVaoA0Kyfmoos7I7AA2mLbZDWhcsCOKKyra9N0xj2vvvm5KXb1fWIt+bi
	Vyx0cs7JbXv1I9/vkyfdFN8lV/6/7XIbFjL6oZ88KSqRYdtXhcoIYyK1/EKpvOPm3k0kxj0Y/xS
	ai3UO1yl+huSoSasODkmfQGnRoF93LGFXrQmhng/jZFHhWifBLlmqWFgjbJEBapCdHPYfJ83xOb
	RkGVwwsO0BdCEUijOoxnFjQpvLc7CcDGOGg1LueSI8RWL9nIPHthzRwak1UTfbkENddNg4yWWE1
	37qa9UTz3ayRVUbSS236IYd24V0kIIK/MPg92BLS/maPRlx59jmw18cUSVn7NpklLUDJ82PqTEM
	Ppjd8vJ0sEG484TEbmlzJtGQd0bkHZIFHzWlCcF4Bjo/9xFYGs5JvyNMKdW4Ie9fSl/78n4G3Rp
	CG+LqCX7t1DyHAtzT2WU8HhDg==
X-Received: by 2002:a05:600c:3b8c:b0:486:d76c:fa51 with SMTP id 5b1f17b1804b1-486ff03ffa5mr121948785e9.27.1774187364780;
        Sun, 22 Mar 2026 06:49:24 -0700 (PDT)
Received: from DA4-DEB.fritz.box (p200300de871aef00290206c667fbb9b3.dip0.t-ipconnect.de. [2003:de:871a:ef00:2902:6c6:67fb:b9b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48700658441sm268260335e9.4.2026.03.22.06.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 06:49:24 -0700 (PDT)
From: Malte Schababerle <m.schababerle@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	Malte Schababerle <m.schababerle@gmail.com>
Subject: [PATCH 2/2] ath10k: force passive scan on 5GHz for WCN3990
Date: Sun, 22 Mar 2026 13:48:22 +0100
Message-ID: <20260322124822.230492-3-m.schababerle@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322124822.230492-1-m.schababerle@gmail.com>
References: <20260322124822.230492-1-m.schababerle@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-33667-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mschababerle@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3F982E9842
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

WCN3990 firmware (WLAN.HL.3.2) has a bug where active scan does not
tune the radio on 5GHz non-DFS channels. The radio reports identical
rx_clear_count values across channels, indicating no RF tuning occurs.
As a result, no 5GHz networks are discovered during active scan.

Passive scan works correctly on all 5GHz channels: the radio tunes
properly and rx_clear_count varies as expected.

Force passive scan mode for all 5GHz channels on WCN3990 using
QCA_REV_WCN3990(). DFS channels are already passive, so the effective
change is for non-DFS 5GHz channels only. This follows the pattern
established for WCN3990 firmware workarounds in thermal.c.

Tested on OnePlus 7T (SM8150/WCN3990) with WLAN.HL.3.2.0.c2-00006
and WLAN.HL.3.2.0.c2-00011:
- 5GHz passive scan discovers APs reliably (e.g. ch116/5580 MHz)
- Association to 5GHz networks succeeds
- No change to 2.4GHz or DFS channel behavior

Signed-off-by: Malte Schababerle <m.schababerle@gmail.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 24dd794e31ea2..f6829232f6b15 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3441,6 +3441,14 @@ static int ath10k_update_channel_list(struct ath10k *ar)
 			passive = channel->flags & IEEE80211_CHAN_NO_IR;
 			ch->passive = passive;
 
+			/* Force passive scan on 5GHz to work around WCN3990
+			 * firmware bug where active scan doesn't tune the
+			 * radio on 5GHz non-DFS channels.
+			 */
+			if (QCA_REV_WCN3990(ar) &&
+			    band == NL80211_BAND_5GHZ)
+				ch->passive = true;
+
 			/* the firmware is ignoring the "radar" flag of the
 			 * channel and is scanning actively using Probe Requests
 			 * on "Radar detection"/DFS channels which are not
-- 
2.47.3


