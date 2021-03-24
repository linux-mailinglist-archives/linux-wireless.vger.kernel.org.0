Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E493473C7
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Mar 2021 09:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhCXIiO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Mar 2021 04:38:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234042AbhCXIho (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Mar 2021 04:37:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AEAB619E0;
        Wed, 24 Mar 2021 08:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616575063;
        bh=YykuS/DpdKZRpuw/dHPsANCVexzIEwjeKdtxFZWcbZg=;
        h=From:To:Cc:Subject:Date:From;
        b=YxK07MixKPZVQHQ09nNE6w60Qt6Cz/mMxL+smb06kGAnVDEkiwHG3sv1r3GK2E10G
         tn3F48lDVTC829wDCMWE8TCbNwSvzjRMED0CBOM+laE83O7zf9QpoCCYtN2KxLB/20
         BHAkh3XPBfihd3PF1HU0+6T8uQ3xe/6Kfdegp5xMyiGTk8N0e50umSE+sRFA8UE+Kr
         2TPXMazszcLbDJmXNMnwkmX+x4kN5dsOQexlw2yQY9QsmL9TDglD2vofdYZ1UoSkhE
         2tZ9yAeFl/B3ptKoNP5/CJ9ePObEJ9HqnO2K0TTOW+C1Flt8TcaHFDysgD4Kw1Yh3j
         ABkRuXUyXHMMQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Jayden.Kuo@mediatek.com
Subject: [PATCH 0/2] properly configure rcpi for mt7921 devices
Date:   Wed, 24 Mar 2021 09:37:35 +0100
Message-Id: <cover.1616574803.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set rcpi based on association process rssi for mt7921 devices since
it is used by rate controller embedded into the fw to initialize
amsdu size.

Lorenzo Bianconi (2):
  mt76: connac: introcuce mt76_sta_cmd_info data structure
  mt76: mt7921: properly configure rcpi adding a sta to the fw

 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 13 ++++---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 35 ++++++++++---------
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 19 +++++++---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 35 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 31 ++++++++++++----
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  7 ++++
 6 files changed, 105 insertions(+), 35 deletions(-)

-- 
2.30.2

