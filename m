Return-Path: <linux-wireless+bounces-10570-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 111E193E281
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 03:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B607B1F21AC4
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 01:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED68279B9D;
	Sun, 28 Jul 2024 00:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIWl7MdQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C416A79B99;
	Sun, 28 Jul 2024 00:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128031; cv=none; b=qIZqETxWHxo5lDhAbAAaYzDrP5pOwbYzJabmyvGTCGfNSbYoPlFtaakbl213w7jT2cx/mRPk1p2Y+pOYxdZYYlp/+Bc3q7JmfWq6SQa2ngo0uTdHpU0+XqlT5KVxNfva2kLTF8XfAFh4WnZuT9N/JCzKZJ9QhT3AjvuhGsilrNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128031; c=relaxed/simple;
	bh=0Y+cz/Rz1pWg4dYeWexKRS/P6J+i2ulC983HXeDxsGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEe0rd4JHPDe3KsqtXmZHWDBUcQiuPA6liXBSaD7UOdh2xBG1KJ4E6YatN4uYwUhZ9GtHdt/ppLLjnE5a/z+T3j/J3QhpC9dCm3Qw4LwGSw/HD1g48lBCMXflEZSq2EIxaQRca4u+vKa/xDbJ5/57CZXsrQHL9qn0C4z1TbKRx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIWl7MdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B197C4AF07;
	Sun, 28 Jul 2024 00:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128031;
	bh=0Y+cz/Rz1pWg4dYeWexKRS/P6J+i2ulC983HXeDxsGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lIWl7MdQtvzhvseAjUdvtNbEMccU3l3Hps/fWrjp+7RZQ76chb+jmsmiKQLMsQk0I
	 EyNCpF0BCyOCtJN2E/zZa6B7o3IiBiHacHv9w3z3OpTdbZVWmb9B8+eggzKEfVGFBh
	 6H+GkIKAR0Dz7Od5nMjfx8goxSy7wa+XuXwAf3TJJFtt8zdMYAlAHL6CHRckcMIg3G
	 xHQyDCA2U8m+DbmqXBU3MAeS6L89UZ5AYw6FCDwVdKFGJ7QOutLWT7y/J8qwtm/Ftk
	 C1Ht2G6BbdsEe5478nxvQMX/0cR1CObHf7qoHvVZY+Js8hanDlNoYfhUNOztyZAc2c
	 2u1IVjbebIvXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 09/27] wifi: rtw89: pci: fix RX tag race condition resulting in wrong RX length
Date: Sat, 27 Jul 2024 20:52:52 -0400
Message-ID: <20240728005329.1723272-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005329.1723272-1-sashal@kernel.org>
References: <20240728005329.1723272-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 94298477f81a1701fc4e1b5a0ce9672acab5dcb2 ]

Read 32 bits RX info to a local variable to fix race condition between
reading RX length and RX tag.

Another solution is to get RX tag at first statement, but adopted solution
can save some memory read, and also save 15 bytes binary code.

RX tag, a sequence number, is used to ensure that RX data has been DMA to
memory completely, so driver must check sequence number is expected before
reading other data.

This potential problem happens only after enabling 36-bit DMA.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://msgid.link/20240611021901.26394-2-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 03bbcf9b6737c..1ba812fae12f0 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -183,14 +183,17 @@ static void rtw89_pci_sync_skb_for_device(struct rtw89_dev *rtwdev,
 static void rtw89_pci_rxbd_info_update(struct rtw89_dev *rtwdev,
 				       struct sk_buff *skb)
 {
-	struct rtw89_pci_rxbd_info *rxbd_info;
 	struct rtw89_pci_rx_info *rx_info = RTW89_PCI_RX_SKB_CB(skb);
+	struct rtw89_pci_rxbd_info *rxbd_info;
+	__le32 info;
 
 	rxbd_info = (struct rtw89_pci_rxbd_info *)skb->data;
-	rx_info->fs = le32_get_bits(rxbd_info->dword, RTW89_PCI_RXBD_FS);
-	rx_info->ls = le32_get_bits(rxbd_info->dword, RTW89_PCI_RXBD_LS);
-	rx_info->len = le32_get_bits(rxbd_info->dword, RTW89_PCI_RXBD_WRITE_SIZE);
-	rx_info->tag = le32_get_bits(rxbd_info->dword, RTW89_PCI_RXBD_TAG);
+	info = rxbd_info->dword;
+
+	rx_info->fs = le32_get_bits(info, RTW89_PCI_RXBD_FS);
+	rx_info->ls = le32_get_bits(info, RTW89_PCI_RXBD_LS);
+	rx_info->len = le32_get_bits(info, RTW89_PCI_RXBD_WRITE_SIZE);
+	rx_info->tag = le32_get_bits(info, RTW89_PCI_RXBD_TAG);
 }
 
 static int rtw89_pci_validate_rx_tag(struct rtw89_dev *rtwdev,
-- 
2.43.0


