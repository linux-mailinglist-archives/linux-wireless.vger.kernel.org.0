Return-Path: <linux-wireless+bounces-1088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A3A819FE3
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 14:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595A9B2592C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 13:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A73358A4;
	Wed, 20 Dec 2023 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="U4zYWIrO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7320C2D633
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cc794df8aaso35255401fa.0
        for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 05:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1703079309; x=1703684109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jWziPB/IY4raRpV7Rblo2J34Fb+ngLADi7PN5gCH0UA=;
        b=U4zYWIrOltAWomZ8b4ZuYZsB5JQR+wwqSdNWBp2Hu7F2ynmp0Fx87RcAcJdzHLt4jN
         mRQQrMgtXskZki3Kx7659hRzThhXitYUrI4Z9OSlgh2+t73worv7NuJbTgd0PdKDQoXp
         rqLtEp+FceFID7bzDIbVpFcWAbFm4OE7oLjBQpGhgIoXGWsoLwG1y2Dh5yrVv2fq8+h2
         o3cL6Nk+Lgg6VdChZlsTSUL4KHsinx9Q2u8iLrZlz1Om7zShAwdKQuHo0UG7iqWRTj9l
         H9tzY4tDxCNKGV+mgw/Xi3o2507QkGPS+Nw43h9yxPL4gvzYLCjIQEm+4DPzP6ItLnQ+
         uLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703079309; x=1703684109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWziPB/IY4raRpV7Rblo2J34Fb+ngLADi7PN5gCH0UA=;
        b=Pnx1RqDLNbogCruO0N3M0P1Prs5Rm4v2LB4V0UPDrIcpUVY1JBsLZDxGKT5rVHQleC
         XW2q+qtaY1lbrgdDewbn0Ni0WVKlKN8H4YR59XjTUFAtH0wYtNeSoYDCQPoxyUWIQHwX
         hLxJuppjXGpg7j3s9CNPNBQnQS+Kso62zOmgQ0D6tCBJeKrGp8zcjgpCIY0ydrlCAUTa
         21tlix9wYu6G7o5ycRVNJjB6D7okqUv9w6xlyc5NfzYW1ZPn1on2HTd9qOi2Ol6MN9/I
         6LcAdppAyrNacl1tciJCk+fCP05hYHnGi3TB/IPBEM9iP9qr8Mp+vuJl+S3ReTN+cl7j
         8Kuw==
X-Gm-Message-State: AOJu0YzBnyqTWn9lvj2tz/ysYmeDsvzB7XMF9RCx01VUlN5bZJl0i9KS
	Kw/o5Ncz+RlXWLVBnfnxCN1b+g==
X-Google-Smtp-Source: AGHT+IEAL+yh9uQ4aAFGQ29ZazDWjMdPd+mZb0CGVjlxfHYC5i3OJGCjBNKGpq+jEqiurpFmIp022g==
X-Received: by 2002:a05:651c:516:b0:2cc:3e21:23a with SMTP id o22-20020a05651c051600b002cc3e21023amr6212072ljp.107.1703079308754;
        Wed, 20 Dec 2023 05:35:08 -0800 (PST)
Received: from x1.fritz.box (p200300f6af2831005d1de4756caae0ab.dip0.t-ipconnect.de. [2003:f6:af28:3100:5d1d:e475:6caa:e0ab])
        by smtp.gmail.com with ESMTPSA id i15-20020a05640200cf00b005537e39745csm2293895edu.47.2023.12.20.05.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:35:08 -0800 (PST)
From: Mathias Krause <minipli@grsecurity.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mathias Krause <minipli@grsecurity.net>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Franky Lin <franky.lin@broadcom.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SHA-cyfmac-dev-list@infineon.com,
	brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH] PCI: Remove unused 'node' member from struct pci_driver
Date: Wed, 20 Dec 2023 14:35:05 +0100
Message-Id: <20231220133505.8798-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the unused 'node' member. It got replaced by device_driver
chaining more than 20 years ago in commit 4b4a837f2b57 ("PCI: start to
use common fields of struct device_driver more...") of the history.git
tree.

Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
There is only one "user" that makes use of the 'node' member, which is
the brcm80211 driver. However, its "use" is clearly wrong (a list head
cannot be initialized this way) and, obviously, not needed.

If netdev folks instead want to split this off into a separate commit, I
can do that. However, I don't expect any cross-tree conflicts regarding
this change.

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c | 1 -
 include/linux/pci.h                                     | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 80220685f5e4..d7fb88bb6ae1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2707,7 +2707,6 @@ MODULE_DEVICE_TABLE(pci, brcmf_pcie_devid_table);
 
 
 static struct pci_driver brcmf_pciedrvr = {
-	.node = {},
 	.name = KBUILD_MODNAME,
 	.id_table = brcmf_pcie_devid_table,
 	.probe = brcmf_pcie_probe,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index dea043bc1e38..835a937fd233 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -885,7 +885,6 @@ struct module;
 
 /**
  * struct pci_driver - PCI driver structure
- * @node:	List of driver structures.
  * @name:	Driver name.
  * @id_table:	Pointer to table of device IDs the driver is
  *		interested in.  Most drivers should export this
@@ -940,7 +939,6 @@ struct module;
  *		own I/O address space.
  */
 struct pci_driver {
-	struct list_head	node;
 	const char		*name;
 	const struct pci_device_id *id_table;	/* Must be non-NULL for probe to be called */
 	int  (*probe)(struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
-- 
2.39.2


