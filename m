Return-Path: <linux-wireless+bounces-38241-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TkzjJzXnQWo7vwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38241-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 05:32:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EBF6D5AC2
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 05:32:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KMZTp+7M;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38241-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38241-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F6B33009F2E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 03:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6691635B639;
	Mon, 29 Jun 2026 03:32:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCCE883F
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 03:31:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782703922; cv=none; b=jHo3a7LJfP++hU/W3ceaTxBuPJUJl/SGnw/wKU4P9WU2wLvD5a/yKABLIDmsKL4BxjusRYbVPeuErONy50LaDmqFOPW5v4SbU36NMFeGpX0bWju+S3H+9mjB2FbSL9q1LVi+05mIc40AXpw4UYBPRP/0yOn5B1ET++70VXdsgnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782703922; c=relaxed/simple;
	bh=9k4RkclFritAkzoZy07kM+pXgxaZlSZ9BAtKis/9+yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jeStt0dsw8zHl5uM7ZfM3TwoFlX2jvuyl12Pvh9qsWsGTfgzZwYqpEyV0fFdyCyHA0sLeuXW4/zojA6B6O+K8Y36k01nHr1/jtNpyarswiMKO0y30tbc/bpNj5J5eq1UZeMmPb/MFwdt07B4xc1/enkWSrU6NilQTXLHKgT0CBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMZTp+7M; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c82538b6b0so17535805ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 20:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782703919; x=1783308719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LC6ibcb4fBz4HS0hDrSYuTYh0saDn6KPejFghovjxq8=;
        b=KMZTp+7MG7TX7tTqiBTPE+AW4l5P5u6N+bluLZDOAArruBYpX43uNX+AaColVVlJL6
         MMoHxCAxQYp7oKE4YPFTxF8kq6E6Xeed6v2S1UApWOTkG4666ZgRN/uuf0UfMeWTzIGx
         x8beo8FBdz/v8OStB/TUrA0XFzoEHp4eAqNRtudyjBgRMTMdWK3yKeTxLzGUrgJAItiF
         Dnt9+7ueILxLM5lPafAQU6g9LMVy1UQbStFp0rp3uOAo0uE5/v/9TeG2NmCnkw+oPvYB
         iWb/f+8jsMoetRciuE3tujlTb0Gqw3L5FHn6q+t6MSxVEWYOTpwvNCQM0pe+IKDKHcF9
         xiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782703919; x=1783308719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LC6ibcb4fBz4HS0hDrSYuTYh0saDn6KPejFghovjxq8=;
        b=PeZFwHHGefHvhBjyDmJYgS/qkQR2AxyOfz66kcpVt+1XN7PXrd9hacRwbsDlAVdIfU
         D2FkbztawH8pF0crzMIfz1epeysZsZte5ipRlUfTim/avOdI6nWRlZicKuA30gizkGuL
         ywuEYHEWXtaIgBRfOqiKHq1MSiFwWsF2OypAYy2ADOBXuXEXI79JxL5cLtdxPmA9RDKc
         zmSwaf5LWp9V46hoF+thm1nC2Wl4MDeG1Mpghim2TCYs3T6u01/ruXrR5/oI1/ExRk2G
         uBtB1ofa/KbikaxZ9BpQNKnqxB6PjWbCFGJmX0zHbgVirQyo7C5JOyrBnYX/bMgF4euk
         PSVg==
X-Gm-Message-State: AOJu0Yzd0CPi0WZaeFHVFzBYP+qReTRx8zBDLJKP5xvvDeg7k2f0I6qp
	SaYe4yE0bF45BRaXdPfDE5Xd4d898GG+egNzzu78UvBSDMeW2TlXL8//f1FhZVU8
X-Gm-Gg: AfdE7cmwMEtp/39XTXE3VggvQTbLTd09WrHsCElOYlAjGOhK8UjRijJmQyyznrxC6nF
	sFxTtkn6Sjy3LWnfvJ8yiKN3Wjj58EMMAtrvimH3w9wfAPCmoZMj5FVZHqBYeUsi1ettEUvkQPm
	54wg0HC6PHyx5ekXqmywl2SP4bXZxXVR9lxVdJRfBOiCplFJGWar2hCjF0mgofisTLfwA/AoaAm
	kMFlmvVp5uvZg/iYS4iyw7rB/ZuTdGVygWYiUHx0uJk29wsRX5R+aLzouxMgkpcPsBZY4p6Gqus
	znywdpGJFr9C9NlPo3/zsmaTn9Iwa6Ewvo5dCMX1TBv7lOb1JlriJBVolH/YnX3XhCNvVRl+YaO
	HZBYhPRTHO4RIfqhwGlNAzL+SdkO8ANPQiyR86k2i4AtggR1VJG7iXgboMKSGkwjCxlrBOS1OTi
	5+unIABza2UhJr5D2PIGRPvFLYkCd93jJkwQtNnqf9hjQgqD3GitJtcEE/a2tN1ZF9/niog56ju
	atGOi2Cgw==
X-Received: by 2002:a17:902:d58d:b0:2c6:9f6a:9f6f with SMTP id d9443c01a7336-2c7fc742693mr149837835ad.28.1782703918499;
        Sun, 28 Jun 2026 20:31:58 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c99f2905e76sm975994a12.10.2026.06.28.20.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 20:31:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH wireless-next] wifi: rt2x00: Use flexible array for hw_mode_spec channels
Date: Sun, 28 Jun 2026 20:31:56 -0700
Message-ID: <20260629033156.2363850-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[wp.pl,kernel.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38241-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:stf_xl@wp.pl,m:kees@kernel.org,m:gustavoars@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1EBF6D5AC2

struct hw_mode_spec stores channel information that is allocated by the
individual rt2x00 drivers during hardware probing.  The channel info
array has the same lifetime as the hardware mode specification, but it
is currently allocated separately and then freed through a separate
pointer.

Make struct rt2x00_dev hold a pointer to the hardware mode
specification, store the channel info as a flexible array member, and
allocate both pieces together with kzalloc_flex().

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../net/wireless/ralink/rt2x00/rt2400pci.c    | 24 +++---
 .../net/wireless/ralink/rt2x00/rt2500pci.c    | 55 ++++++++------
 .../net/wireless/ralink/rt2x00/rt2500usb.c    | 55 ++++++++------
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 74 ++++++++++---------
 drivers/net/wireless/ralink/rt2x00/rt2x00.h   |  4 +-
 .../net/wireless/ralink/rt2x00/rt2x00config.c | 12 +--
 .../net/wireless/ralink/rt2x00/rt2x00dev.c    |  4 +-
 drivers/net/wireless/ralink/rt2x00/rt61pci.c  | 42 ++++++-----
 drivers/net/wireless/ralink/rt2x00/rt73usb.c  | 50 +++++++------
 9 files changed, 177 insertions(+), 143 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2400pci.c b/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
index cac191304bf5..3fb74dcbee63 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
@@ -1559,7 +1559,7 @@ static const struct rf_channel rf_vals_b[] = {
 
 static int rt2400pci_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 {
-	struct hw_mode_spec *spec = &rt2x00dev->spec;
+	struct hw_mode_spec *spec;
 	struct channel_info *info;
 	u8 *tx_power;
 	unsigned int i;
@@ -1580,27 +1580,25 @@ static int rt2400pci_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 	/*
 	 * Initialize hw_mode information.
 	 */
-	spec->supported_bands = SUPPORT_BAND_2GHZ;
-	spec->supported_rates = SUPPORT_RATE_CCK;
+	spec = kzalloc_flex(*spec, channels_info, ARRAY_SIZE(rf_vals_b));
+	if (!spec)
+		return -ENOMEM;
 
 	spec->num_channels = ARRAY_SIZE(rf_vals_b);
 	spec->channels = rf_vals_b;
 
-	/*
-	 * Create channel information array
-	 */
-	info = kzalloc_objs(*info, spec->num_channels);
-	if (!info)
-		return -ENOMEM;
-
-	spec->channels_info = info;
+	spec->supported_bands = SUPPORT_BAND_2GHZ;
+	spec->supported_rates = SUPPORT_RATE_CCK;
 
 	tx_power = rt2x00_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_START);
 	for (i = 0; i < 14; i++) {
-		info[i].max_power = TXPOWER_FROM_DEV(MAX_TXPOWER);
-		info[i].default_power1 = TXPOWER_FROM_DEV(tx_power[i]);
+		info = &spec->channels_info[i];
+		info->max_power = TXPOWER_FROM_DEV(MAX_TXPOWER);
+		info->default_power1 = TXPOWER_FROM_DEV(tx_power[i]);
 	}
 
+	rt2x00dev->spec = spec;
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2500pci.c b/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
index fc35b60e422c..4c85f401c091 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
@@ -1854,7 +1854,10 @@ static const struct rf_channel rf_vals_5222[] = {
 
 static int rt2500pci_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 {
-	struct hw_mode_spec *spec = &rt2x00dev->spec;
+	const struct rf_channel *channels;
+	unsigned int num_channels = 0;
+	unsigned int supported_bands;
+	struct hw_mode_spec *spec;
 	struct channel_info *info;
 	u8 *tx_power;
 	unsigned int i;
@@ -1880,52 +1883,58 @@ static int rt2500pci_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 	/*
 	 * Initialize hw_mode information.
 	 */
-	spec->supported_bands = SUPPORT_BAND_2GHZ;
-	spec->supported_rates = SUPPORT_RATE_CCK | SUPPORT_RATE_OFDM;
+	supported_bands = SUPPORT_BAND_2GHZ;
 
 	if (rt2x00_rf(rt2x00dev, RF2522)) {
-		spec->num_channels = ARRAY_SIZE(rf_vals_bg_2522);
-		spec->channels = rf_vals_bg_2522;
+		num_channels = ARRAY_SIZE(rf_vals_bg_2522);
+		channels = rf_vals_bg_2522;
 	} else if (rt2x00_rf(rt2x00dev, RF2523)) {
-		spec->num_channels = ARRAY_SIZE(rf_vals_bg_2523);
-		spec->channels = rf_vals_bg_2523;
+		num_channels = ARRAY_SIZE(rf_vals_bg_2523);
+		channels = rf_vals_bg_2523;
 	} else if (rt2x00_rf(rt2x00dev, RF2524)) {
-		spec->num_channels = ARRAY_SIZE(rf_vals_bg_2524);
-		spec->channels = rf_vals_bg_2524;
+		num_channels = ARRAY_SIZE(rf_vals_bg_2524);
+		channels = rf_vals_bg_2524;
 	} else if (rt2x00_rf(rt2x00dev, RF2525)) {
-		spec->num_channels = ARRAY_SIZE(rf_vals_bg_2525);
-		spec->channels = rf_vals_bg_2525;
+		num_channels = ARRAY_SIZE(rf_vals_bg_2525);
+		channels = rf_vals_bg_2525;
 	} else if (rt2x00_rf(rt2x00dev, RF2525E)) {
-		spec->num_channels = ARRAY_SIZE(rf_vals_bg_2525e);
-		spec->channels = rf_vals_bg_2525e;
+		num_channels = ARRAY_SIZE(rf_vals_bg_2525e);
+		channels = rf_vals_bg_2525e;
 	} else if (rt2x00_rf(rt2x00dev, RF5222)) {
-		spec->supported_bands |= SUPPORT_BAND_5GHZ;
-		spec->num_channels = ARRAY_SIZE(rf_vals_5222);
-		spec->channels = rf_vals_5222;
+		supported_bands |= SUPPORT_BAND_5GHZ;
+		num_channels = ARRAY_SIZE(rf_vals_5222);
+		channels = rf_vals_5222;
 	}
 
 	/*
 	 * Create channel information array
 	 */
-	info = kzalloc_objs(*info, spec->num_channels);
-	if (!info)
+	spec = kzalloc_flex(*spec, channels_info, num_channels);
+	if (!spec)
 		return -ENOMEM;
 
-	spec->channels_info = info;
+	spec->num_channels = num_channels;
+	spec->channels = channels;
+	spec->supported_bands = supported_bands;
+	spec->supported_rates = SUPPORT_RATE_CCK | SUPPORT_RATE_OFDM;
 
 	tx_power = rt2x00_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_START);
 	for (i = 0; i < 14; i++) {
-		info[i].max_power = MAX_TXPOWER;
-		info[i].default_power1 = TXPOWER_FROM_DEV(tx_power[i]);
+		info = &spec->channels_info[i];
+		info->max_power = MAX_TXPOWER;
+		info->default_power1 = TXPOWER_FROM_DEV(tx_power[i]);
 	}
 
 	if (spec->num_channels > 14) {
 		for (i = 14; i < spec->num_channels; i++) {
-			info[i].max_power = MAX_TXPOWER;
-			info[i].default_power1 = DEFAULT_TXPOWER;
+			info = &spec->channels_info[i];
+			info->max_power = MAX_TXPOWER;
+			info->default_power1 = DEFAULT_TXPOWER;
 		}
 	}
 
+	rt2x00dev->spec = spec;
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2500usb.c b/drivers/net/wireless/ralink/rt2x00/rt2500usb.c
index 58728df6666c..cbc1c1399cc6 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2500usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2500usb.c
@@ -1661,7 +1661,10 @@ static const struct rf_channel rf_vals_5222[] = {
 
 static int rt2500usb_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 {
-	struct hw_mode_spec *spec = &rt2x00dev->spec;
+	const struct rf_channel *channels;
+	unsigned int num_channels = 0;
+	unsigned int supported_bands;
+	struct hw_mode_spec *spec;
 	struct channel_info *info;
 	u8 *tx_power;
 	unsigned int i;
@@ -1693,52 +1696,58 @@ static int rt2500usb_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 	/*
 	 * Initialize hw_mode information.
 	 */
-	spec->supported_bands = SUPPORT_BAND_2GHZ;
-	spec->supported_rates = SUPPORT_RATE_CCK | SUPPORT_RATE_OFDM;
+	supported_bands = SUPPORT_BAND_2GHZ;
 
 	if (rt2x00_rf(rt2x00dev, RF2522)) {
-		spec->num_channels = ARRAY_SIZE(rf_vals_bg_2522);
-		spec->channels = rf_vals_bg_2522;
+		num_channels = ARRAY_SIZE(rf_vals_bg_2522);
+		channels = rf_vals_bg_2522;
 	} else if (rt2x00_rf(rt2x00dev, RF2523)) {
-		spec->num_channels = ARRAY_SIZE(rf_vals_bg_2523);
-		spec->channels = rf_vals_bg_2523;
+		num_channels = ARRAY_SIZE(rf_vals_bg_2523);
+		channels = rf_vals_bg_2523;
 	} else if (rt2x00_rf(rt2x00dev, RF2524)) {
-		spec->num_channels = ARRAY_SIZE(rf_vals_bg_2524);
-		spec->channels = rf_vals_bg_2524;
+		num_channels = ARRAY_SIZE(rf_vals_bg_2524);
+		channels = rf_vals_bg_2524;
 	} else if (rt2x00_rf(rt2x00dev, RF2525)) {
-		spec->num_channels = ARRAY_SIZE(rf_vals_bg_2525);
-		spec->channels = rf_vals_bg_2525;
+		num_channels = ARRAY_SIZE(rf_vals_bg_2525);
+		channels = rf_vals_bg_2525;
 	} else if (rt2x00_rf(rt2x00dev, RF2525E)) {
-		spec->num_channels = ARRAY_SIZE(rf_vals_bg_2525e);
-		spec->channels = rf_vals_bg_2525e;
+		num_channels = ARRAY_SIZE(rf_vals_bg_2525e);
+		channels = rf_vals_bg_2525e;
 	} else if (rt2x00_rf(rt2x00dev, RF5222)) {
-		spec->supported_bands |= SUPPORT_BAND_5GHZ;
-		spec->num_channels = ARRAY_SIZE(rf_vals_5222);
-		spec->channels = rf_vals_5222;
+		supported_bands |= SUPPORT_BAND_5GHZ;
+		num_channels = ARRAY_SIZE(rf_vals_5222);
+		channels = rf_vals_5222;
 	}
 
 	/*
 	 * Create channel information array
 	 */
-	info = kzalloc_objs(*info, spec->num_channels);
-	if (!info)
+	spec = kzalloc_flex(*spec, channels_info, num_channels);
+	if (!spec)
 		return -ENOMEM;
 
-	spec->channels_info = info;
+	spec->num_channels = num_channels;
+	spec->channels = channels;
+	spec->supported_bands = supported_bands;
+	spec->supported_rates = SUPPORT_RATE_CCK | SUPPORT_RATE_OFDM;
 
 	tx_power = rt2x00_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_START);
 	for (i = 0; i < 14; i++) {
-		info[i].max_power = MAX_TXPOWER;
-		info[i].default_power1 = TXPOWER_FROM_DEV(tx_power[i]);
+		info = &spec->channels_info[i];
+		info->max_power = MAX_TXPOWER;
+		info->default_power1 = TXPOWER_FROM_DEV(tx_power[i]);
 	}
 
 	if (spec->num_channels > 14) {
 		for (i = 14; i < spec->num_channels; i++) {
-			info[i].max_power = MAX_TXPOWER;
-			info[i].default_power1 = DEFAULT_TXPOWER;
+			info = &spec->channels_info[i];
+			info->max_power = MAX_TXPOWER;
+			info->default_power1 = DEFAULT_TXPOWER;
 		}
 	}
 
+	rt2x00dev->spec = spec;
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 97290899674e..7b7f6dcc9247 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -11778,7 +11778,9 @@ static const struct rf_channel rf_vals_7620[] = {
 
 static int rt2800_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 {
-	struct hw_mode_spec *spec = &rt2x00dev->spec;
+	const struct rf_channel *channels;
+	unsigned int num_channels = 0;
+	struct hw_mode_spec *spec;
 	struct channel_info *info;
 	s8 *default_power1;
 	s8 *default_power2;
@@ -11840,19 +11842,17 @@ static int rt2800_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 	/*
 	 * Initialize hw_mode information.
 	 */
-	spec->supported_rates = SUPPORT_RATE_CCK | SUPPORT_RATE_OFDM;
-
 	switch (rt2x00dev->chip.rf) {
 	case RF2720:
 	case RF2820:
-		spec->num_channels = 14;
-		spec->channels = rf_vals;
+		num_channels = 14;
+		channels = rf_vals;
 		break;
 
 	case RF2750:
 	case RF2850:
-		spec->num_channels = ARRAY_SIZE(rf_vals);
-		spec->channels = rf_vals;
+		num_channels = ARRAY_SIZE(rf_vals);
+		channels = rf_vals;
 		break;
 
 	case RF2020:
@@ -11870,44 +11870,52 @@ static int rt2800_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 	case RF5372:
 	case RF5390:
 	case RF5392:
-		spec->num_channels = 14;
+		num_channels = 14;
 		if (rt2800_clk_is_20mhz(rt2x00dev))
-			spec->channels = rf_vals_3x_xtal20;
+			channels = rf_vals_3x_xtal20;
 		else
-			spec->channels = rf_vals_3x;
+			channels = rf_vals_3x;
 		break;
 
 	case RF7620:
-		spec->num_channels = ARRAY_SIZE(rf_vals_7620);
-		spec->channels = rf_vals_7620;
+		num_channels = ARRAY_SIZE(rf_vals_7620);
+		channels = rf_vals_7620;
 		break;
 
 	case RF3052:
 	case RF3053:
-		spec->num_channels = ARRAY_SIZE(rf_vals_3x);
-		spec->channels = rf_vals_3x;
+		num_channels = ARRAY_SIZE(rf_vals_3x);
+		channels = rf_vals_3x;
 		break;
 
 	case RF3853:
-		spec->num_channels = ARRAY_SIZE(rf_vals_3853);
-		spec->channels = rf_vals_3853;
+		num_channels = ARRAY_SIZE(rf_vals_3853);
+		channels = rf_vals_3853;
 		break;
 
 	case RF5592:
 		reg = rt2800_register_read(rt2x00dev, MAC_DEBUG_INDEX);
 		if (rt2x00_get_field32(reg, MAC_DEBUG_INDEX_XTAL)) {
-			spec->num_channels = ARRAY_SIZE(rf_vals_5592_xtal40);
-			spec->channels = rf_vals_5592_xtal40;
+			num_channels = ARRAY_SIZE(rf_vals_5592_xtal40);
+			channels = rf_vals_5592_xtal40;
 		} else {
-			spec->num_channels = ARRAY_SIZE(rf_vals_5592_xtal20);
-			spec->channels = rf_vals_5592_xtal20;
+			num_channels = ARRAY_SIZE(rf_vals_5592_xtal20);
+			channels = rf_vals_5592_xtal20;
 		}
 		break;
 	}
 
-	if (WARN_ON_ONCE(!spec->channels))
+	if (WARN_ON_ONCE(!channels))
 		return -ENODEV;
 
+	spec = kzalloc_flex(*spec, channels_info, num_channels);
+	if (!spec)
+		return -ENOMEM;
+
+	spec->num_channels = num_channels;
+	spec->channels = channels;
+	spec->supported_rates = SUPPORT_RATE_CCK | SUPPORT_RATE_OFDM;
+
 	spec->supported_bands = SUPPORT_BAND_2GHZ;
 	if (spec->num_channels > 14)
 		spec->supported_bands |= SUPPORT_BAND_5GHZ;
@@ -11959,19 +11967,13 @@ static int rt2800_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 	/*
 	 * Create channel information and survey arrays
 	 */
-	info = kzalloc_objs(*info, spec->num_channels);
-	if (!info)
-		return -ENOMEM;
-
 	rt2x00dev->chan_survey =
 		kzalloc_objs(struct rt2x00_chan_survey, spec->num_channels);
 	if (!rt2x00dev->chan_survey) {
-		kfree(info);
+		kfree(spec);
 		return -ENOMEM;
 	}
 
-	spec->channels_info = info;
-
 	default_power1 = rt2800_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_BG1);
 	default_power2 = rt2800_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_BG2);
 
@@ -11982,10 +11984,11 @@ static int rt2800_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 		default_power3 = NULL;
 
 	for (i = 0; i < 14; i++) {
-		info[i].default_power1 = default_power1[i];
-		info[i].default_power2 = default_power2[i];
+		info = &spec->channels_info[i];
+		info->default_power1 = default_power1[i];
+		info->default_power2 = default_power2[i];
 		if (default_power3)
-			info[i].default_power3 = default_power3[i];
+			info->default_power3 = default_power3[i];
 	}
 
 	if (spec->num_channels > 14) {
@@ -12002,10 +12005,11 @@ static int rt2800_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 			default_power3 = NULL;
 
 		for (i = 14; i < spec->num_channels; i++) {
-			info[i].default_power1 = default_power1[i - 14];
-			info[i].default_power2 = default_power2[i - 14];
+			info = &spec->channels_info[i];
+			info->default_power1 = default_power1[i - 14];
+			info->default_power2 = default_power2[i - 14];
 			if (default_power3)
-				info[i].default_power3 = default_power3[i - 14];
+				info->default_power3 = default_power3[i - 14];
 		}
 	}
 
@@ -12033,6 +12037,8 @@ static int rt2800_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 		break;
 	}
 
+	rt2x00dev->spec = spec;
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index 7d313e86d3f2..babc04210a65 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -404,9 +404,9 @@ struct hw_mode_spec {
 
 	unsigned int num_channels;
 	const struct rf_channel *channels;
-	const struct channel_info *channels_info;
 
 	struct ieee80211_sta_ht_cap ht;
+	struct channel_info channels_info[] __counted_by(num_channels);
 };
 
 /*
@@ -802,7 +802,7 @@ struct rt2x00_dev {
 	/*
 	 * hw capability specifications.
 	 */
-	struct hw_mode_spec spec;
+	struct hw_mode_spec *spec;
 
 	/*
 	 * This is the default TX/RX antenna setup as indicated
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00config.c b/drivers/net/wireless/ralink/rt2x00/rt2x00config.c
index f895f560a185..b97cb67c4361 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00config.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00config.c
@@ -165,7 +165,7 @@ void rt2x00lib_config_antenna(struct rt2x00_dev *rt2x00dev,
 static u16 rt2x00ht_center_channel(struct rt2x00_dev *rt2x00dev,
 				   struct ieee80211_conf *conf)
 {
-	struct hw_mode_spec *spec = &rt2x00dev->spec;
+	struct hw_mode_spec *spec = rt2x00dev->spec;
 	int center_channel;
 	u16 i;
 
@@ -194,6 +194,7 @@ void rt2x00lib_config(struct rt2x00_dev *rt2x00dev,
 		      struct ieee80211_conf *conf,
 		      unsigned int ieee80211_flags)
 {
+	struct hw_mode_spec *spec = rt2x00dev->spec;
 	struct rt2x00lib_conf libconf;
 	u16 hw_value;
 	u16 autowake_timeout;
@@ -218,13 +219,8 @@ void rt2x00lib_config(struct rt2x00_dev *rt2x00dev,
 			hw_value = conf->chandef.chan->hw_value;
 		}
 
-		memcpy(&libconf.rf,
-		       &rt2x00dev->spec.channels[hw_value],
-		       sizeof(libconf.rf));
-
-		memcpy(&libconf.channel,
-		       &rt2x00dev->spec.channels_info[hw_value],
-		       sizeof(libconf.channel));
+		memcpy(&libconf.rf, &spec->channels[hw_value], sizeof(libconf.rf));
+		memcpy(&libconf.channel, &spec->channels_info[hw_value], sizeof(libconf.channel));
 
 		/* Used for VCO periodic calibration */
 		rt2x00dev->rf_channel = libconf.rf.channel;
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index edc1f8eac747..3ffbc8aabbae 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -1097,7 +1097,7 @@ static void rt2x00lib_remove_hw(struct rt2x00_dev *rt2x00dev)
 		rt2x00dev->hw->wiphy->bands[NL80211_BAND_5GHZ] = NULL;
 	}
 
-	kfree(rt2x00dev->spec.channels_info);
+	kfree(rt2x00dev->spec);
 	kfree(rt2x00dev->chan_survey);
 }
 
@@ -1116,7 +1116,7 @@ static const struct ieee80211_tpt_blink rt2x00_tpt_blink[] = {
 
 static int rt2x00lib_probe_hw(struct rt2x00_dev *rt2x00dev)
 {
-	struct hw_mode_spec *spec = &rt2x00dev->spec;
+	struct hw_mode_spec *spec = rt2x00dev->spec;
 	int status;
 
 	if (test_bit(DEVICE_STATE_REGISTERED_HW, &rt2x00dev->flags))
diff --git a/drivers/net/wireless/ralink/rt2x00/rt61pci.c b/drivers/net/wireless/ralink/rt2x00/rt61pci.c
index 79e1fd0a1fbd..479825f8bba9 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt61pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt61pci.c
@@ -2654,7 +2654,10 @@ static const struct rf_channel rf_vals_seq[] = {
 
 static int rt61pci_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 {
-	struct hw_mode_spec *spec = &rt2x00dev->spec;
+	const struct rf_channel *channels;
+	unsigned int num_channels = 0;
+	unsigned int supported_bands;
+	struct hw_mode_spec *spec;
 	struct channel_info *info;
 	u8 *tx_power;
 	unsigned int i;
@@ -2693,46 +2696,51 @@ static int rt61pci_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 	/*
 	 * Initialize hw_mode information.
 	 */
-	spec->supported_bands = SUPPORT_BAND_2GHZ;
-	spec->supported_rates = SUPPORT_RATE_CCK | SUPPORT_RATE_OFDM;
+	supported_bands = SUPPORT_BAND_2GHZ;
 
 	if (!rt2x00_has_cap_rf_sequence(rt2x00dev)) {
-		spec->num_channels = 14;
-		spec->channels = rf_vals_noseq;
+		num_channels = 14;
+		channels = rf_vals_noseq;
 	} else {
-		spec->num_channels = 14;
-		spec->channels = rf_vals_seq;
+		num_channels = 14;
+		channels = rf_vals_seq;
 	}
 
 	if (rt2x00_rf(rt2x00dev, RF5225) || rt2x00_rf(rt2x00dev, RF5325)) {
-		spec->supported_bands |= SUPPORT_BAND_5GHZ;
-		spec->num_channels = ARRAY_SIZE(rf_vals_seq);
+		supported_bands |= SUPPORT_BAND_5GHZ;
+		num_channels = ARRAY_SIZE(rf_vals_seq);
 	}
 
 	/*
 	 * Create channel information array
 	 */
-	info = kzalloc_objs(*info, spec->num_channels);
-	if (!info)
+	spec = kzalloc_flex(*spec, channels_info, num_channels);
+	if (!spec)
 		return -ENOMEM;
 
-	spec->channels_info = info;
+	spec->num_channels = num_channels;
+	spec->channels = channels;
+	spec->supported_bands = supported_bands;
+	spec->supported_rates = SUPPORT_RATE_CCK | SUPPORT_RATE_OFDM;
 
 	tx_power = rt2x00_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_G_START);
 	for (i = 0; i < 14; i++) {
-		info[i].max_power = MAX_TXPOWER;
-		info[i].default_power1 = TXPOWER_FROM_DEV(tx_power[i]);
+		info = &spec->channels_info[i];
+		info->max_power = MAX_TXPOWER;
+		info->default_power1 = TXPOWER_FROM_DEV(tx_power[i]);
 	}
 
 	if (spec->num_channels > 14) {
 		tx_power = rt2x00_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_A_START);
 		for (i = 14; i < spec->num_channels; i++) {
-			info[i].max_power = MAX_TXPOWER;
-			info[i].default_power1 =
-					TXPOWER_FROM_DEV(tx_power[i - 14]);
+			info = &spec->channels_info[i];
+			info->max_power = MAX_TXPOWER;
+			info->default_power1 = TXPOWER_FROM_DEV(tx_power[i - 14]);
 		}
 	}
 
+	rt2x00dev->spec = spec;
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt73usb.c b/drivers/net/wireless/ralink/rt2x00/rt73usb.c
index d6b7174d087a..17338378329b 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt73usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt73usb.c
@@ -2088,7 +2088,10 @@ static const struct rf_channel rf_vals_5225_2527[] = {
 
 static int rt73usb_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 {
-	struct hw_mode_spec *spec = &rt2x00dev->spec;
+	const struct rf_channel *channels;
+	unsigned int num_channels = 0;
+	unsigned int supported_bands;
+	struct hw_mode_spec *spec;
 	struct channel_info *info;
 	u8 *tx_power;
 	unsigned int i;
@@ -2114,49 +2117,54 @@ static int rt73usb_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 	/*
 	 * Initialize hw_mode information.
 	 */
-	spec->supported_bands = SUPPORT_BAND_2GHZ;
-	spec->supported_rates = SUPPORT_RATE_CCK | SUPPORT_RATE_OFDM;
+	supported_bands = SUPPORT_BAND_2GHZ;
 
 	if (rt2x00_rf(rt2x00dev, RF2528)) {
-		spec->num_channels = ARRAY_SIZE(rf_vals_bg_2528);
-		spec->channels = rf_vals_bg_2528;
+		num_channels = ARRAY_SIZE(rf_vals_bg_2528);
+		channels = rf_vals_bg_2528;
 	} else if (rt2x00_rf(rt2x00dev, RF5226)) {
-		spec->supported_bands |= SUPPORT_BAND_5GHZ;
-		spec->num_channels = ARRAY_SIZE(rf_vals_5226);
-		spec->channels = rf_vals_5226;
+		supported_bands |= SUPPORT_BAND_5GHZ;
+		num_channels = ARRAY_SIZE(rf_vals_5226);
+		channels = rf_vals_5226;
 	} else if (rt2x00_rf(rt2x00dev, RF2527)) {
-		spec->num_channels = 14;
-		spec->channels = rf_vals_5225_2527;
+		num_channels = 14;
+		channels = rf_vals_5225_2527;
 	} else if (rt2x00_rf(rt2x00dev, RF5225)) {
-		spec->supported_bands |= SUPPORT_BAND_5GHZ;
-		spec->num_channels = ARRAY_SIZE(rf_vals_5225_2527);
-		spec->channels = rf_vals_5225_2527;
+		supported_bands |= SUPPORT_BAND_5GHZ;
+		num_channels = ARRAY_SIZE(rf_vals_5225_2527);
+		channels = rf_vals_5225_2527;
 	}
 
 	/*
 	 * Create channel information array
 	 */
-	info = kzalloc_objs(*info, spec->num_channels);
-	if (!info)
+	spec = kzalloc_flex(*spec, channels_info, num_channels);
+	if (!spec)
 		return -ENOMEM;
 
-	spec->channels_info = info;
+	spec->num_channels = num_channels;
+	spec->channels = channels;
+	spec->supported_bands = supported_bands;
+	spec->supported_rates = SUPPORT_RATE_CCK | SUPPORT_RATE_OFDM;
 
 	tx_power = rt2x00_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_G_START);
 	for (i = 0; i < 14; i++) {
-		info[i].max_power = MAX_TXPOWER;
-		info[i].default_power1 = TXPOWER_FROM_DEV(tx_power[i]);
+		info = &spec->channels_info[i];
+		info->max_power = MAX_TXPOWER;
+		info->default_power1 = TXPOWER_FROM_DEV(tx_power[i]);
 	}
 
 	if (spec->num_channels > 14) {
 		tx_power = rt2x00_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_A_START);
 		for (i = 14; i < spec->num_channels; i++) {
-			info[i].max_power = MAX_TXPOWER;
-			info[i].default_power1 =
-					TXPOWER_FROM_DEV(tx_power[i - 14]);
+			info = &spec->channels_info[i];
+			info->max_power = MAX_TXPOWER;
+			info->default_power1 = TXPOWER_FROM_DEV(tx_power[i - 14]);
 		}
 	}
 
+	rt2x00dev->spec = spec;
+
 	return 0;
 }
 
-- 
2.54.0


