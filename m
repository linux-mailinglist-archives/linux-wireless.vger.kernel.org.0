Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436D4291A15
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Oct 2020 21:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgJRTV1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Oct 2020 15:21:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729379AbgJRTVZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Oct 2020 15:21:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A72EC222EB;
        Sun, 18 Oct 2020 19:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603048884;
        bh=v2Irryi3FqaIFDpBaCx1TpdVuR2A4FadIVt8z2gYIKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GdP5WVegabMv2ho+LAAml/OpyMxFrV995AOD5/a7Gm2XxFSQQkVnCfDvZWyT6ROW0
         hty4aDuwfz64dt7k/dlExrruxVLrOMbJU8MrOEoLxx8mBvrJQ8cs6TvV371NCv42Bo
         eU7bIUBUtjbPKnTnD2jBkXcObeTqoldwHBMzjIz4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 047/101] rtw88: pci: Power cycle device during shutdown
Date:   Sun, 18 Oct 2020 15:19:32 -0400
Message-Id: <20201018192026.4053674-47-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201018192026.4053674-1-sashal@kernel.org>
References: <20201018192026.4053674-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 44492e70adc8086c42d3745d21d591657a427f04 ]

There are reports that 8822CE fails to work rtw88 with "failed to read DBI
register" error. Also I have a system with 8723DE which freezes the whole
system when the rtw88 is probing the device.

According to [1], platform firmware may not properly power manage the
device during shutdown. I did some expirements and putting the device to
D3 can workaround the issue.

So let's power cycle the device by putting the device to D3 at shutdown
to prevent the issue from happening.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=206411#c9

BugLink: https://bugs.launchpad.net/bugs/1872984
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200928165508.20775-1-kai.heng.feng@canonical.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 3413973bc4750..7f1f5073b9f4d 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1599,6 +1599,8 @@ void rtw_pci_shutdown(struct pci_dev *pdev)
 
 	if (chip->ops->shutdown)
 		chip->ops->shutdown(rtwdev);
+
+	pci_set_power_state(pdev, PCI_D3hot);
 }
 EXPORT_SYMBOL(rtw_pci_shutdown);
 
-- 
2.25.1

