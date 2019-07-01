Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C5F5BC53
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2019 15:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfGANEs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jul 2019 09:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfGANEs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jul 2019 09:04:48 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.13.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEB172146E;
        Mon,  1 Jul 2019 13:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561986287;
        bh=auHxALRJNXXFb5kU2yQVMBcv2EttpWt0NKwhucd+Q+o=;
        h=From:To:Cc:Subject:Date:From;
        b=FjVlcAna0RtRXeWnb5T5zieRnTUSm7ZWsZMH1crr1DlCttHJTblR2VHzQmR42Nbpv
         gynTEA5FwQMB4VG7fHOy/ue4pZw0J2Rp/iJmd6zcIMWXPOwyMWVNQM7ruyk0LkS+Cl
         6sKubJoX6olrCYWfZXOPHVahCUZMxhZ9BSGQfKJo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, s.gottschall@newmedia-net.de,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com,
        royluo@google.com
Subject: [PATCH 0/2] mt76: mt7615: add hw support for AES_CMAC cipher 
Date:   Mon,  1 Jul 2019 15:04:38 +0200
Message-Id: <cover.1561985981.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fall back to sw encryption for unsupported ciphers

Lorenzo Bianconi (2):
  mt76: mt7615: fall back to sw encryption for unsupported ciphers
  mt76: mt7615: add BIP_CMAC_128 cipher support

 drivers/net/wireless/mediatek/mt76/mac80211.c    |  5 +++--
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c  |  9 +++++++--
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 16 ++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c  |  3 +++
 4 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.21.0

