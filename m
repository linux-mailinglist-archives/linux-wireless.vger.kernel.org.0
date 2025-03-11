Return-Path: <linux-wireless+bounces-20180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4BFA5CC83
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 18:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E6618992E5
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 17:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB2B1EDA2A;
	Tue, 11 Mar 2025 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5kssCRw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4929E1EBA1E
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715116; cv=none; b=EKWt1V960m8ey/pAx2+fy2j1C2/uGtui1V70tY/uvSa3hlLEbJPUvAWt+oTQEy3sjIEAAHBFfLKJAwrX36TL8l9qpPIYxmGh/mIOs+URcUVg79dVzJwz6F7TQ/MOR/x0+EAv0NwbKGx8u/4cBxDO5iXZbhAkeJ+dxgw9SXzqO0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715116; c=relaxed/simple;
	bh=HsotVx6KpH1JEpP3CAmCRSuWKsczS3BnfeLb6xjVxBY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P+KZ85X1+yBBgx4VHINdv2aAwCiZLMZt5UR4B3MYoGFkeB3yKMS1sv/KUq55FtH7fA4Oh79F46IJPu0vEp0l/AWfij5qHukgNBVE15auxD/n9BqnjxXa836Vtmlw2yxRCYn8A1dsTk6BeO70ylJa2jbcXQLx9RN9kQ6CVSA+2t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5kssCRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF06C4CEEC;
	Tue, 11 Mar 2025 17:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741715116;
	bh=HsotVx6KpH1JEpP3CAmCRSuWKsczS3BnfeLb6xjVxBY=;
	h=From:Subject:Date:To:Cc:From;
	b=G5kssCRwzyB4/FViiPUYdFPYz46vIbGGPS1cA0pcwICqWGv1D7qAVe3/J8okR2QYi
	 8RvdI6AmRI4tPCk2FCsmFCKQcWon2c6+hLrnOo0Hr+GAzt/EbU5FrIiAH3q4UGKPsg
	 asXrvoLsr8RqLyQGdMs7HEjx+1RjWaE4A0gsyDlRt4K9+upUhkp3of22lhCmnkwKta
	 wPFuo3MQeD7jYDEp11gnF64mxeTmE2v4UgB12e9a75d9CX/15b0bzQu8W+k5lQAxUF
	 MNI5fzvw8bkhgTwJfrBPW3MOAn9PfTygbyFWFCI3SBUZwHTFOlOInxuYwWvpO+QGOm
	 6AHzdy/ng9w2g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v2 00/13] wifi: mt76: mt7996: Preliminary work to support
 MLO
Date: Tue, 11 Mar 2025 18:44:59 +0100
Message-Id: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJt20GcC/23MSw6CMBSF4a2QO7amDyqWkfswDApeoBFac0saD
 enerYwd/ic53w4RyWGEttqBMLnogi8hTxUMs/UTMvcoDZJLzaXkbN0aYy5sXQIzGs2IiluDHMr
 hRTi694Hdu9Kzi1ugz2En8Vv/MkkwzlQ91LbvVSP09fZE8ricA03Q5Zy/xCM45qUAAAA=
X-Change-ID: 20250220-mt7996-mlo-95e9fe30a9e0
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>
X-Mailer: b4 0.14.2

This series is the first preliminary work needed to support MLO in
MT7996 driver.

---
Changes in v2:
- Rebase on top of mt76 master branch
- get rid of mt76_sta_common_init utility routine and introduce
  mt7996_sta_state routine
- Link to v1: https://lore.kernel.org/r/20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org

---
Lorenzo Bianconi (9):
      wifi: mt76: mt7996: Add chage_vif_links stub
      wifi: mt76: mt7996: Introduce mt7996_sta_link container
      wifi: mt76: mt7996: Add mt7996_sta_link struct in mt7996_vif_link
      wifi: mt76: mt7996: Add vif_cfg_changed callback
      wifi: mt76: mt7996: Add link_info_changed callback
      wifi: mt76: mt7996: Add mt7996_sta_state routine
      wifi: mt76: mt7996: Rely on mt7996_sta_link in sta_add/sta_remove callbacks
      wifi: mt76: mt7996: Support MLO in mt7996_mac_sta_event()
      wifi: mt76: mt7996: Rely on mt7996_vif_link and mt7996_sta_link in mt7996_mac_twt_teardown_flow signature

Shayne Chen (4):
      wifi: mt76: mt7996: Add mt7996_mac_sta_change_links callback
      wifi: mt76: Check link_conf pointer in mt76_connac_mcu_sta_basic_tlv()
      wifi: mt76: mt7996: Update mt7996_mcu_add_sta to MLO support
      wifi: mt76: mt7996: Rely on mt7996_vif_link in mt7996_mcu_twt_agrt_update signature

 drivers/net/wireless/mediatek/mt76/mac80211.c      |   5 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |   2 +
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |  12 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 125 +++--
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 527 ++++++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 335 +++++++------
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |   3 -
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  36 +-
 9 files changed, 689 insertions(+), 358 deletions(-)
---
base-commit: 33584256a5f38ffb9e8829d08302a3021f2a8475
change-id: 20250220-mt7996-mlo-95e9fe30a9e0

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


