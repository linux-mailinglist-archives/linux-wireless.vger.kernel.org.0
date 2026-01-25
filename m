Return-Path: <linux-wireless+bounces-31140-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Oph2ANr1dWkXKAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31140-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 11:52:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E4E801EC
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 11:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8C0530053BB
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 10:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77140281530;
	Sun, 25 Jan 2026 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M916Q+2W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551E41DDA18
	for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769338324; cv=none; b=FsX5x2Ex2PhM3YeEajKjNutgOAKFGBshBThUYc5+EkYF5LIZo55BZJ8Iip//CypEoqDHxOamB6uRZvySz/GUPEZ1gVbcoXoOumNhunKPuBgQ9XEfauZ5zyIpa8yNtnmz80z01JoFVgF8gnvlU8OPv+g3WFd58ZJ5M/IyPcKljMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769338324; c=relaxed/simple;
	bh=oEMK/NQ1fqobKbWExDVcllQalgHRTxpeSvTj6dSXi0E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hv8e+u6AJSYmNzsQd9xGp9D8Xz0lXO913nYBMNiXB/XFPHqray0M6+87QDNUKjfU5U1kfSd6HmZFK5hZbBQMkJcyOpcDoBISnTAvFYJDu+1SjU8cJPMQZl9Nn0x8q4Tut5CAPo0meQVp4nNI8jjo7y/xAn4RdabXqpbl6Hvuylo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M916Q+2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7EBC4CEF1;
	Sun, 25 Jan 2026 10:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769338323;
	bh=oEMK/NQ1fqobKbWExDVcllQalgHRTxpeSvTj6dSXi0E=;
	h=From:Subject:Date:To:Cc:From;
	b=M916Q+2Wdfv5t0xYMwVvadX/WaHQkxh1wHamU8Fzeelqn7k860bFHT7TcAYEPW4xm
	 hufJ3lQbMOkT7SWwJnTUsTXbg/SoeNXRy5VtF+rxqH3qwlu2e70heg/fIS9Swfhdv3
	 Gwqh7bJtlpTDMDp9ESczJ/t1fzGIp3AJS3e8SWPlN5gVg8FoEkQtMcKxDiP8C8Rd1I
	 2q3nf3z9n8noOwsDiw/5vVm3EGzvVz+y1V0aPT8eiBFlY2Lv2w21YsIpx/xPgHgGc7
	 5UV8gY6XvE9Efn6hbpDbzOll12c5SP9wMYt4GxyiHBEq1SAT4YCvWLK3gNdIs3Jj6S
	 6IA3BEBDdE31A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH wireless-next v2 0/2] wifi: mac80211: Introduce eMLSR/eMLMR
 parsing support in AP mode.
Date: Sun, 25 Jan 2026 11:51:29 +0100
Message-Id: <20260125-mac80211-emlsr-v2-0-466329d61c88@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13Myw6CMBCF4Vchs7amHblUV76HYQFlCo1QzNQ0G
 tJ3t5K4cfmf5HwbBGJHAS7FBkzRBbf6HHgowEydH0m4ITegxFoqVGLpjJaolKBlDiyqpimlRmu
 1MZBPDybrXjt4a3NPLjxXfu9+VN/1R+E/FZWQwkoqT31fD+equ96JPc3HlUdoU0oflHglnq0AA
 AA=
X-Change-ID: 20260121-mac80211-emlsr-5774082ff8cc
To: Johannes Berg <johannes@sipsolutions.net>, 
 Ryder Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
 Shayne Chen <shayne.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 MeiChia Chiu <MeiChia.Chiu@mediatek.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31140-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[sipsolutions.net,mediatek.com,gmail.com,collabora.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,mediatek.com,kernel.org,gmail.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 45E4E801EC
X-Rspamd-Action: no action

Introduce support in AP mode for parsing of the Operating Mode Notification
frame sent by the client to enable/disable MLO eMLSR or eMLMR if supported
by both the AP and the client.
Add drv_set_eml_op_mode mac80211 callback in order to configure underlay
driver with eMLSR info (control and bitmap).
Implement drv_set_eml_op_mode callback for MT7996 driver.

---
Changes in v2:
- Improve sanity check against device EML capabilities
- Squash patch 1/2 and 2/2
- Validate link_bitmap with vif->active_links
- Introduce ieee80211_eml_params struct as containe for EML info to pass
  to the underlay driver.
- Pass padding_delay and transition_delay to the underlay driver.
- Implement drv_set_eml_op_mode callback for MT7996 driver.
- Link to v1: https://lore.kernel.org/r/20260122-mac80211-emlsr-v1-0-f0e43bb6d95a@kernel.org

---
Lorenzo Bianconi (1):
      wifi: mac80211: Add eMLSR/eMLMR action frame parsing support

MeiChia Chiu (1):
      wifi: mt76: mt7996: Add eMLSR support

 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   9 ++
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  16 +++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  54 +++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |   5 +
 include/linux/ieee80211-eht.h                      |  28 +++++
 include/linux/ieee80211.h                          |   6 +
 include/net/mac80211.h                             |  23 ++++
 net/mac80211/driver-ops.h                          |  22 ++++
 net/mac80211/eht.c                                 | 135 +++++++++++++++++++++
 net/mac80211/ieee80211_i.h                         |   2 +
 net/mac80211/iface.c                               |  10 +-
 net/mac80211/rx.c                                  |   8 ++
 net/mac80211/trace.h                               |  32 +++++
 13 files changed, 349 insertions(+), 1 deletion(-)
---
base-commit: 1e1dd9eeaab3908746d1dce5db6b0c29e0d28d6d
change-id: 20260121-mac80211-emlsr-5774082ff8cc

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


