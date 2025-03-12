Return-Path: <linux-wireless+bounces-20226-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA27A5DB23
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 12:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BB41899CFB
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 11:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5929823A99A;
	Wed, 12 Mar 2025 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnWHDUP4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3446A22E011
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778040; cv=none; b=ELEJRtsn+9nyST2oGRzqxNzvdcyRBvWdpwZz2WNyNIkCi6asOtpdxTEsPgmNOHup1WTjvedFvXXaKvaBFhRDscw+Vmi6BpTSkzWkLX4W2hIdvV9VhJHI0RYSktXCt/JjZJLDWRc3PwNcEmOmcOEwo4aahKJqrtbZ0VpMaivO1/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778040; c=relaxed/simple;
	bh=1i42LEYWnooCgw6RTcX9X+IbQM3F7trqbsr3RzKCLjE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W4TbGeapIgnrFZPy8MIqFvhTKZB9INCUbyieWsK14I47wxU7+rdnIIoCw7CHzBlIQTqpu7CKH+LrXhM0wcGcKgy+MTerKlPq4t2aCSSKcuXvMm/4Ggt+zEvvrXH5jIDzzqRNM9s91xKJcyu/dnn8mKUUFy0ZDZyZqjJB49coMcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnWHDUP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5908DC4CEE3;
	Wed, 12 Mar 2025 11:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741778039;
	bh=1i42LEYWnooCgw6RTcX9X+IbQM3F7trqbsr3RzKCLjE=;
	h=From:Subject:Date:To:Cc:From;
	b=cnWHDUP4v/uF+NZlL9BC+3QQ6HT5AC7/0lBqlsgpqGqgGHZ7kAOA+M5ELEMZfx5U2
	 gXWnAtqKLv8Ltj+NFK8Pdl/v4aYtEJ4krcjOXdO89SFrUEq23fXnWJBAew6NC/VQ7q
	 Hs3/XpBQb/9tbNDC/9FJx5COi8foD0SYie8YEFJ3fnje2KJg0BQXDwrxU5SF26m+5I
	 0pU8qdbO3xBiHUIFgp/s4988RZt+rYXNY+qSuBi9kbFIXvlh7LvrI0s3hOJReEtySh
	 HWmsBsaL+yHnvtxPrlRaz+ZkgR/Oxy9ejgNMetTIcG/jlPcwcXetEX31XQprEwSLlQ
	 PsipGkCD9Qf3A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH 00/21] wifi: mt76: mt7996: second preliminary work to
 support MLO
Date: Wed, 12 Mar 2025 12:13:44 +0100
Message-Id: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGhs0WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0Mj3SQT3dwSc0tLM93cnHzdAiPdlBSL1LRUkyQzSzMTJaC2gqLUtMw
 KsJHRsbW1ABpjO01iAAAA
X-Change-ID: 20250312-b4-mt7996-mlo-p2-dd8efe4b6964
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

This series is the second preliminary work needed to support MLO in
MT7996 driver.

---
Lorenzo Bianconi (9):
      wifi: mt76: mt7996: Add mt7996_sta_link to mt7996_mcu_add_bss_info signature
      wifi: mt76: mt7996: rework mt7996_sta_hw_queue_read to support MLO
      wifi: mt76: mt7996: rework mt7996_mac_sta_rc_work to support MLO
      wifi: mt76: mt7996: rework mt7996_mac_sta_poll to support MLO
      wifi: mt76: mt7996: rework mt7996_update_mu_group to support MLO
      wifi: mt76: mt7996: rework mt7996_net_fill_forward_path to support MLO
      wifi: mt76: mt7996: set vif default link_id adding/removing vif links
      wifi: mt76: mt7996: rework mt7996_ampdu_action to support MLO
      wifi: mt76: mt7996: Update mt7996_tx to MLO support

Shayne Chen (12):
      wifi: mt76: mt7996: Update mt7996_mcu_add_rate_ctrl to MLO
      wifi: mt76: mt7996: Add mt7996_mcu_sta_mld_setup_tlv() and mt7996_mcu_sta_eht_mld_tlv()
      wifi: mt76: mt7996: Add mt7996_mcu_teardown_mld_sta rouine
      wifi: mt76: mt7996: rework mt7996_mac_write_txwi() for MLO support
      wifi: mt76: mt7996: Rely on wcid_to_sta in mt7996_mac_add_txs_skb()
      wifi: mt76: mt7996: rework mt7996_rx_get_wcid to support MLO
      wifi: mt76: mt7996: rework mt7996_sta_set_4addr and mt7996_sta_set_decap_offload to support MLO
      wifi: mt76: mt7996: rework mt7996_set_hw_key to support MLO
      wifi: mt76: mt7996: remove mt7996_mac_enable_rtscts()
      wifi: mt76: mt7996: rework mt7996_mcu_add_obss_spr to support MLO
      wifi: mt76: mt7996: rework mt7996_mcu_beacon_inband_discov to support MLO
      wifi: mt76: mt7996: rework set/get_tsf callabcks to support MLO

 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |  54 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 163 +++++--
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 493 ++++++++++++++-------
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 321 +++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |  32 ++
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  43 +-
 6 files changed, 754 insertions(+), 352 deletions(-)
---
base-commit: 61cf5540d86945a531dd939e90e72a4b134d7cb8
change-id: 20250312-b4-mt7996-mlo-p2-dd8efe4b6964

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


