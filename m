Return-Path: <linux-wireless+bounces-14083-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309A39A0A57
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 14:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4462A1C26EB4
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 12:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3516820F5D0;
	Wed, 16 Oct 2024 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKvd2VlH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB2B20E02B
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082519; cv=none; b=abfZmXAwgAQGcrAgTX2RdzyW9lBVBXjBxocIYUj4zcb5IC5RCI1UqbOHZh7IkbnnHiUy/W9Xeh+1mBHI+Ut+yfOjkghX9aqYHAkZevG9XIl7lsTEBF3XZkgkY6ytm0NooVd5A2Y1hyNVa7AZ1FSSwSxz+EfIdFwZUm6vgTRL8Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082519; c=relaxed/simple;
	bh=fUViQ0wuhaRh1Z4rYxnCtcfkzxZviFoQ/oXZmPMz6Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnQzW3e8i38PeURgzWBIRxcmRsP8KprX8BuDqkryl4tNHZV5G3m9UzAklr85I0p7sDUkhLMUYBy4kHikwUV+SI1k/n/TKKE+LC4DX9HLTKdT7le+dBaXUwfq4z7bjcQjP3W5NQUu7bVnvOEQxr+9jtTyP297A3k9216MnMu6ADw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hKvd2VlH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729082516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2pA/Y9KFQGL5eKPmyYHAWaMItiz6sKe/fm026vyTOII=;
	b=hKvd2VlH4gzCLOb2reP0gr80NUbsMFsRUphaXjcg8ZvSBkRZhnF8v0sXisIvDN4RDD5hZy
	yDPYgq/KLQO4MjV3sFIOfX93AzeV4+RE++hmIBoEpWlK13VUD3EzNsfRShWTwZMDI8MvVU
	ECUHp9qvHSR9mr3lRGQVc/QUT0CDcvs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-kdWH9-leNnCRRu9h5KWzug-1; Wed, 16 Oct 2024 08:41:55 -0400
X-MC-Unique: kdWH9-leNnCRRu9h5KWzug-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4312935010fso35995335e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 05:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729082514; x=1729687314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pA/Y9KFQGL5eKPmyYHAWaMItiz6sKe/fm026vyTOII=;
        b=v0xK8Ym/GOqq7XM3RciKmWIv+9NnNf4UbeURUc/m4Ye50KlEc/p7SfxpbZEIzLcbAb
         IwGAdZfWfRK8tBGCx3kl83B82dOVHh4KJwPPPvvuhqROQ+gt7N5fNJ9mp0/XXZTqYApH
         OtCQnOxVZ0Vrl44X1iP9LEXXz6CYNlc8xCPGak7b60nlozzcjRbuxLNmKEmxcTWauCPW
         KsKPkCVcydpElVX4CjUGWlLrozIIHom7GjUFrPHuqopmZ7YS1Z+Lip29spAUqCNyaAeI
         VryZ7MZ4pVGQyR6ik6QZDS3ALIjCBxngDPVKzQzWpe3/oupB9lbZQwYNSUnf8M73zBB+
         ysmA==
X-Forwarded-Encrypted: i=1; AJvYcCU2RPGOfaAjD4sBW/EifRekSD5nwT6uWsxL0jTfOgEDdC3YpAc2rER+rIskkoTTklMU9ld/5/9fYi9hYGITYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7SFaS5QikvAr5P9EWccOfOu8ooUYVAx+yjjE6kmI3mPzF8J51
	XE/O/BPevi09zuvarSPDCh1SbeISqATZOurNAta1OAYnbMDvSof/U1/3M3GTab2MSm4SNZrWGWi
	r10LZii65NdeXquO/oeSFSni4V9VkAqNIFadYONVWEljjkRL8EQjBpMetU5sEa6PU
X-Received: by 2002:a05:600c:3396:b0:431:44c6:9b1e with SMTP id 5b1f17b1804b1-43144c69d10mr51163095e9.9.1729082514057;
        Wed, 16 Oct 2024 05:41:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRP/BuTiWCzH6fd4BbV0uMaXkt+guEHku1txQLYMKYVO9MVZ59DOYiHB9WTaV8Ckg5o6YnZw==
X-Received: by 2002:a05:600c:3396:b0:431:44c6:9b1e with SMTP id 5b1f17b1804b1-43144c69d10mr51162825e9.9.1729082513565;
        Wed, 16 Oct 2024 05:41:53 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8ffd6sm4246879f8f.50.2024.10.16.05.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 05:41:53 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnaud Ebalard <arno@natisbad.org>,
	Srujana Challa <schalla@marvell.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Philipp Stanner <pstanner@redhat.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jie Wang <jie.wang@intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH v4 06/10] wifi: iwlwifi: replace deprecated PCI functions
Date: Wed, 16 Oct 2024 14:41:28 +0200
Message-ID: <20241016124136.41540-7-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016124136.41540-1-pstanner@redhat.com>
References: <20241016124136.41540-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() and pcim_iomap_regions_request_all() have been
deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace these functions with their successors, pcim_iomap() and
pcim_request_all_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 3b9943eb6934..4b41613ad89d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3533,7 +3533,6 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	struct iwl_trans_pcie *trans_pcie, **priv;
 	struct iwl_trans *trans;
 	int ret, addr_size;
-	void __iomem * const *table;
 	u32 bar0;
 
 	/* reassign our BAR 0 if invalid due to possible runtime PM races */
@@ -3659,22 +3658,15 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		}
 	}
 
-	ret = pcim_iomap_regions_request_all(pdev, BIT(0), DRV_NAME);
+	ret = pcim_request_all_regions(pdev, DRV_NAME);
 	if (ret) {
-		dev_err(&pdev->dev, "pcim_iomap_regions_request_all failed\n");
+		dev_err(&pdev->dev, "pcim_request_all_regions failed\n");
 		goto out_no_pci;
 	}
 
-	table = pcim_iomap_table(pdev);
-	if (!table) {
-		dev_err(&pdev->dev, "pcim_iomap_table failed\n");
-		ret = -ENOMEM;
-		goto out_no_pci;
-	}
-
-	trans_pcie->hw_base = table[0];
+	trans_pcie->hw_base = pcim_iomap(pdev, 0, 0);
 	if (!trans_pcie->hw_base) {
-		dev_err(&pdev->dev, "couldn't find IO mem in first BAR\n");
+		dev_err(&pdev->dev, "pcim_iomap failed\n");
 		ret = -ENODEV;
 		goto out_no_pci;
 	}
-- 
2.47.0


