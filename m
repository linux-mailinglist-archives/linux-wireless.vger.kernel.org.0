Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8869F47E2E2
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 13:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243347AbhLWMH6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 07:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239577AbhLWMH6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 07:07:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAC5C061401
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 04:07:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A843761E56
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 12:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059B5C36AE9;
        Thu, 23 Dec 2021 12:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640261277;
        bh=Mp1Sf3znRj9NJX7BYaYrvIJCneHahI+/Il2UQjthOKQ=;
        h=From:To:Cc:Subject:Date:From;
        b=gXBCHudz5AnwULtokbYSpSRGcfhyA5sSMC/XVv+aVcKjNXsLyZeCyoTZGEqRhSizd
         s8F1WkIJ9B4t70oFHvn9CkTmLFlXlLGHB5yhxhuJwQ9Z6s+l4Q2ac09y/5c1+eRklS
         Bj13zqpZ7Ayc2oJXCqLl9hPaklA+IIGnvs8xH4UTp06Nk0idK8zAxwM8qW7OK7lzf9
         AV0WHDyCff0M/Nanz+SWrhbafbBZq/SrXst1EZyWSVhvcAIS90CP7D47jdG/e95lG3
         xYgQuhNlxDluGTtnSsdjWIBCEL4Pi2o60abZuLrwKOOWZcdkKITr92fTjGQ1OM1VCw
         injJCdVPyCwyQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 00/15] mt7915 connac rework
Date:   Thu, 23 Dec 2021 13:07:28 +0100
Message-Id: <cover.1640260901.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some more patches to fully integrate mt7915 driver in mt76-connac module
(the work is not completed yet).

Lorenzo Bianconi (15):
  mt76: mt7915: remove duplicated defs in mcu.h
  mt76: connac: move mt76_connac_mcu_bss_omac_tlv in connac module
  mt76: connac: move mt76_connac_mcu_bss_ext_tlv in connac module
  mt76: connac: move mt76_connac_mcu_bss_basic_tlv in connac module
  mt76: mt7915: rely on mt76_connac_mcu_sta_ba_tlv
  mt76: mt7915: rely on mt76_connac_mcu_wtbl_ba_tlv
  mt76: mt7915: rely on mt76_connac_mcu_sta_ba
  mt76: mt7915: rely on mt76_connac_mcu_wtbl_generic_tlv
  mt76: mt7915: rely on mt76_connac_mcu_sta_basic_tlv
  mt76: mt7915: rely on mt76_connac_mcu_sta_uapsd
  mt76: mt7915: rely on mt76_connac_mcu_wtbl_smps_tlv
  mt76: mt7915: rely on mt76_connac_mcu_wtbl_ht_tlv
  mt76: mt7915: rely on mt76_connac_mcu_wtbl_hdr_trans_tlv
  mt76: connac: move mt76_connac_mcu_wtbl_update_hdr_trans in connac
    module
  mt76: connac: introduce is_connac_v2 utility routine

 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 139 +----
 .../net/wireless/mediatek/mt76/mt76_connac.h  |   5 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 198 ++++++-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  23 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 485 +-----------------
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  23 -
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   3 -
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |   2 +
 9 files changed, 236 insertions(+), 646 deletions(-)

-- 
2.33.1

