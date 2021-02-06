Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D02311CA3
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Feb 2021 11:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhBFKgg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 Feb 2021 05:36:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:42946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhBFKgf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 Feb 2021 05:36:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 897BB64E27;
        Sat,  6 Feb 2021 10:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612607755;
        bh=uso5Vqol3uBYCoKDpXmLbXjJ4mHiriEW3ZbxB15n6H4=;
        h=From:To:Cc:Subject:Date:From;
        b=qsGk8xxRpojy8p1tJN1HTPJZ33XNPYeaCUmmyxAdfp6NN66+s+VbnOoTtQWe/Ob48
         C2dIJUkFtibV6de5Pa1CX5FURdt4RmCtUhlf8e+Gg40NEb81Gf8nMswKZ3G4eUPDvp
         D0Xy7tTEdy1ctK0Yjep4l5ebYnckeu1F9FWIsQFrG6QQ4PM1jYlyya2QHfEXH25YWV
         RbstjbQ7nY/jHJBhV1w+psVS9fZhT+pHZn3XFNUtAVqBvY7xu3hp76Me+9DWvFGbe2
         GfwlouDAlY3njV7J16G52fUEZSWoq/xwwcu14vDi/NBH2k7XtT9yORaJtlSEBSyJUp
         7CXpYm+tVTRhA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: removed unused definitions in mcu.h
Date:   Sat,  6 Feb 2021 11:35:41 +0100
Message-Id: <d65da5d5632d269903f28816e351030bb5b11453.1612607649.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get rid of the following definitions in mt7921/mcu.h since they are not
actually used:
- MT7921_WTBL_UPDATE_MAX_SIZE
- MT7921_STA_UPDATE_MAX_SIZE
- MT7921_WTBL_UPDATE_BA_SIZE

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   | 23 -------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index 9701392d77db..e4aeb2f99332 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -234,29 +234,6 @@ enum {
 	MT_IBF = BIT(1)		/* implicit beamforming */
 };
 
-#define MT7921_WTBL_UPDATE_MAX_SIZE	(sizeof(struct wtbl_req_hdr) +	\
-					 sizeof(struct wtbl_generic) +	\
-					 sizeof(struct wtbl_rx) +	\
-					 sizeof(struct wtbl_ht) +	\
-					 sizeof(struct wtbl_vht) +	\
-					 sizeof(struct wtbl_hdr_trans) +\
-					 sizeof(struct wtbl_ba) +	\
-					 sizeof(struct wtbl_smps))
-
-#define MT7921_STA_UPDATE_MAX_SIZE	(sizeof(struct sta_req_hdr) +	\
-					 sizeof(struct sta_rec_basic) +	\
-					 sizeof(struct sta_rec_ht) +	\
-					 sizeof(struct sta_rec_he) +	\
-					 sizeof(struct sta_rec_ba) +	\
-					 sizeof(struct sta_rec_vht) +	\
-					 sizeof(struct sta_rec_uapsd) + \
-					 sizeof(struct sta_rec_amsdu) +	\
-					 sizeof(struct tlv) +		\
-					 MT7921_WTBL_UPDATE_MAX_SIZE)
-
-#define MT7921_WTBL_UPDATE_BA_SIZE	(sizeof(struct wtbl_req_hdr) +	\
-					 sizeof(struct wtbl_ba))
-
 #define STA_CAP_WMM			BIT(0)
 #define STA_CAP_SGI_20			BIT(4)
 #define STA_CAP_SGI_40			BIT(5)
-- 
2.29.2

