Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D540D1ECB5A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2020 10:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgFCIWx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 04:22:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgFCIWw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 04:22:52 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADBB320825;
        Wed,  3 Jun 2020 08:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591172571;
        bh=iE6Gdr3BLRFDPHFQ3nGskGnayPtPL53jnGaYczx5h5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yhi3fSh2sk0eUvW5EOFLkUNUEGDg4t+vpsLsrzA4cKIyVSC6dAHTi0LPFtPGCHykF
         ayEBUCttUNn6Kzqv7ICJfK3P24nZt3zFIKaQRWPALd8temA8P8lK3R3m9w4mXboIIO
         Pu9MMzxG9Rj3Kw4crO+B9gCo6AeLQ23jjrJWiWCw=
Received: by pali.im (Postfix)
        id 0C7E26F0; Wed,  3 Jun 2020 10:22:50 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Hemantkumar Suthar <shemant@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Zhaoyang Liu <liuzy@marvell.com>, Cathy Luo <cluo@marvell.com>
Subject: [PATCH 1/4] mwifiex: Fix firmware filename for sd8977 chipset
Date:   Wed,  3 Jun 2020 10:22:26 +0200
Message-Id: <20200603082229.15043-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200603082229.15043-1-pali@kernel.org>
References: <20200603082229.15043-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Firmware for sd8977 chipset is distributed by Marvell package and also as
part of the linux-firmware repository in filename sdsd8977_combo_v2.bin.

This patch fixes mwifiex driver to load correct firmware file for sd8977.

Fixes: 1a0f547831dce ("mwifiex: add support for sd8977 chipset")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/sdio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wireless/marvell/mwifiex/sdio.h
index 71cd8629b28e..0cac2296ed53 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.h
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
@@ -36,7 +36,7 @@
 #define SD8897_DEFAULT_FW_NAME "mrvl/sd8897_uapsta.bin"
 #define SD8887_DEFAULT_FW_NAME "mrvl/sd8887_uapsta.bin"
 #define SD8801_DEFAULT_FW_NAME "mrvl/sd8801_uapsta.bin"
-#define SD8977_DEFAULT_FW_NAME "mrvl/sd8977_uapsta.bin"
+#define SD8977_DEFAULT_FW_NAME "mrvl/sdsd8977_combo_v2.bin"
 #define SD8987_DEFAULT_FW_NAME "mrvl/sd8987_uapsta.bin"
 #define SD8997_DEFAULT_FW_NAME "mrvl/sd8997_uapsta.bin"
 
-- 
2.20.1

