Return-Path: <linux-wireless+bounces-37931-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6ZkLN2bvNWoe6QYAu9opvQ
	(envelope-from <linux-wireless+bounces-37931-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 03:39:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3951F6A829C
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 03:39:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kasilag.me header.s=google header.b=k+VEEKhQ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37931-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37931-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kasilag.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 283A63046992
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 01:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B95F1DE2A5;
	Sat, 20 Jun 2026 01:39:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF10F19D092
	for <linux-wireless@vger.kernel.org>; Sat, 20 Jun 2026 01:39:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781919575; cv=none; b=lWRAhBm5RGnpM6g410xm2KtwC+3OkDE8FtvxxnCdUefWw1vCt2qd0dnVgBbpHa2L3VdWo7pGcSI/kx7GZmEYV9Mus5ZFEhgP8yYU9awATEtQmpU2JfwU2dYtz1ckRRNC3XErITAiOC3MQTaTE90lnTkl3yNyp5y5VvZ1BG/tpNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781919575; c=relaxed/simple;
	bh=NuKwllmelf+FZL2h5mskHLGEryoz0UxehEspb0TkNZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WRc/FsDV/11mF9ZvPB3Zv3dKeSYQOo1i7Qe2XPUR10lbH1i6MFU34vt9KBccrYy/dzNQ/lb7iFpiMfyM8Ap2LTkv8xjN0N9wkSDhPrHneM0Evi50eIp62jFeYAdCEO0KvWzmVbr/w0kHVAmNv/YTI60xtjOXYsD0dr8Hg8ZIk0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kasilag.me; spf=pass smtp.mailfrom=kasilag.me; dkim=pass (2048-bit key) header.d=kasilag.me header.i=@kasilag.me header.b=k+VEEKhQ; arc=none smtp.client-ip=209.85.214.195
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2c6b3f71648so31018285ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 18:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kasilag.me; s=google; t=1781919573; x=1782524373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=smAJSNsD8BYFeg8qmbLT9iMp7jN0lEYxyxXJ6DbCJYg=;
        b=k+VEEKhQxxBAgNTwgUZY3pS3qAjgiLMyHpAM/JeqA2wbD1J9rmNRO5LXBQC97qIb/f
         +97SgfK48D6gC3ZijHa1im1fAuB747h0Z3+5xiTgNkkW1yUionVWz6AEx9crun3e1rEw
         G+m/7yWkJADqIpPOY0unXe+PzvOZtvGQojNf3IcozpxXP95zGrh0TqbB9oDY+hZX6zvO
         k7S0zKQldywLRTGczNZTOz+/O36OXAlw2lJHGOFgRESGukp4+A5JAyt9rrxBPWCu11R2
         EbG5WrTJTFM/t7jLvBHKAC3gtwgDRl+a61VYGFpIPYwQ4SjGP+IGCvwX58KwFy99GcK/
         1bVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781919573; x=1782524373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smAJSNsD8BYFeg8qmbLT9iMp7jN0lEYxyxXJ6DbCJYg=;
        b=SMFhaOG6hapdrGPFCpZj7stJLwlWQ9HDQEy79VRWvb+VL/mbMVnslYOBiP5fdPfs9v
         Wr3pmzDgnzAlTmqxSAJNVoQ3fE/a/Dvx14Gr/oVpEnPZzKhHSSun2GwQGXaVVlLVC4Xo
         tVpPfWoX2xKRpCzN4D8V0RMCehOXfz9W5zRgsDwfsDwwioxSEVRZrZ7EhuwSRcfDug40
         /0LsaEY/z7to8cQly7lom35pUYVZxc4x40NFOnrUqMYxa9Ym+qdReVZh3quW9eZ6q/1k
         FVJ6Ha1lZ8C3KKyWqsZQQmoyYS9Xz50qCQYamJJErHskCE+T7onWXLAbIj9s7cfsmPg7
         GQKA==
X-Forwarded-Encrypted: i=1; AFNElJ9jKwhgR7L0gzZWpHjgwccwmuQvRECR24gHqyIE2Jd+rWzSOlxxGZ6JmExAtgRAuh6FfN43YclAItfZcSw1kQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJM9MeXbk25V+3R5/K0Lcebqj6nzYiUmewgdJQ79ejIVx//ngJ
	2alhFeut8ryndUcDMlu2dYaAEyL76gUD/l0GQzdjFoYU2SA558t+5KsovlkT9WqZS5M=
X-Gm-Gg: AfdE7ckUJokTXPVwCWaL/LvtDj1nmEfG1JdMeVOjW+YA3r+oypb5k3lfVP0hcuRofcI
	dsRsE0h5p9gZOAexvdWJfc3eW4FIXNJMvtuyCKH1+Yeii/j8jIoaBcF7jFfD7dkI3TL6yg7kF8S
	Z9jf+wh1LN9sJydwiATmkyeSH5eeyF4LVy26KYgD/zkClnSs7zyWE1TOYCaydDEsKB/qgtcF+x7
	sgpMOY5PmhFgZs5QH2XmQy82/Z+sLHXDl/TH2hLL8owqCvsjfrfxYdwDLPgxrxleh3gqm1qTfmQ
	p/+4PF/oI95cA5odLXp4CIRDLa8vVXywoi0TfruyrmB+BbDFUO2xroL9amG0k8YrLp9ABFpZ9LV
	FF+mhLF3fuxfOFsyYfqr52iSMTviizEY2RvFkCmeUP4EdfTZBt7iLzpjZuVM+o3uH/ZktY+sJDu
	wiSNA8SfgCg/ywupus2w==
X-Received: by 2002:a17:902:f610:b0:2c3:5683:9acb with SMTP id d9443c01a7336-2c718f98f0cmr68907925ad.32.1781919573089;
        Fri, 19 Jun 2026 18:39:33 -0700 (PDT)
Received: from localhost.localdomain ([2001:4451:470d:a400::3b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8e51sm7008285ad.39.2026.06.19.18.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 18:39:32 -0700 (PDT)
From: Kenneth Kasilag <kenneth@kasilag.me>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	Kenneth Kasilag <kenneth@kasilag.me>
Subject: [PATCH] wifi: mt76: mt7996: expose per-band MAC addresses to cfg80211
Date: Sat, 20 Jun 2026 01:38:50 +0000
Message-ID: <20260620013850.3949359-1-kenneth@kasilag.me>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kasilag.me,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kasilag.me:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37931-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:linux-wireless@vger.kernel.org,m:kenneth@kasilag.me,s:lists@lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER(0.00)[kenneth@kasilag.me,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kenneth@kasilag.me,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[kasilag.me:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3951F6A829C

mt7996/mt7992 are single-wiphy, multi-band devices. The driver assigns
each band its own MAC address from a per-band EEPROM entry, or derives
it from the primary band's address when that entry is empty, however
only the primary band's is published as perm_addr. The per-band
addresses are not exposed to cfg80211, so consumers usually fall back
to deriving one from perm_addr.

Store each band's address in wiphy->addresses[], indexed by radio, so
cfg80211 exposes the address the hardware actually uses for that radio.
addresses[0] is the primary band and matches perm_addr, as cfg80211
requires.

Link: https://github.com/openwrt/openwrt/issues/23578
Tested-on: Gemtek W1700K (MT7996)
Signed-off-by: Kenneth Kasilag <kenneth@kasilag.me>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index d6f9aa1ab52d..dbea4887b7ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -463,6 +463,8 @@ mt7996_init_wiphy_band(struct ieee80211_hw *hw, struct mt7996_phy *phy)
 	radio->n_freq_range = 1;
 	radio->iface_combinations = &if_comb;
 	radio->n_iface_combinations = 1;
+	memcpy(dev->radio_addrs[n_radios].addr, phy->mt76->macaddr, ETH_ALEN);
+	hw->wiphy->n_addresses++;
 	hw->wiphy->n_radio++;
 
 	wiphy->available_antennas_rx |= phy->mt76->chainmask;
@@ -505,6 +507,7 @@ mt7996_init_wiphy(struct ieee80211_hw *hw, struct mtk_wed_device *wed)
 	wiphy->n_iface_combinations = 1;
 
 	wiphy->radio = dev->radios;
+	wiphy->addresses = dev->radio_addrs;
 
 	wiphy->reg_notifier = mt7996_regd_notifier;
 	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 0d6488522ba7..cb5e60b25b89 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -411,6 +411,7 @@ struct mt7996_dev {
 	struct mt7996_phy *radio_phy[MT7996_MAX_RADIOS];
 	struct wiphy_radio radios[MT7996_MAX_RADIOS];
 	struct wiphy_radio_freq_range radio_freqs[MT7996_MAX_RADIOS];
+	struct mac_address radio_addrs[MT7996_MAX_RADIOS];
 
 	struct mt7996_hif *hif2;
 	struct mt7996_reg_desc reg;
-- 
2.39.5 (Apple Git-154)


