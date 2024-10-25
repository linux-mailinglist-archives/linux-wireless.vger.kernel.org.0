Return-Path: <linux-wireless+bounces-14535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D7E9B06CC
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 17:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0A41F23EFF
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F0820D4F8;
	Fri, 25 Oct 2024 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFCEw67O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E704B20BB2C
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868453; cv=none; b=D4HRF79dBns0XuPpUzyOnZ870CAa3iw4Wq42C+LFv7vA2s/5LzVjupzZOHRNh1aHuAlGHy5OlIBJWx2o1eaqaB0TsTyRFd3glLUOsobUPtiUBcH1StWIK8pwfsFhlQcKvvW06aUeonilkILTV47KwZrY2FY2NZWPYdedLABVKUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868453; c=relaxed/simple;
	bh=fUViQ0wuhaRh1Z4rYxnCtcfkzxZviFoQ/oXZmPMz6Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKLhsXS1/JiOY2sn2cOZOnVoUfkOrqYKHf6aU4kvEN2oRoBeV/5bYFM9kGCwmffbe5/je9g0ymskaspONnx1u8M4mqkTjoDBJ0VYwUcOYsVHwOmDqc+3BPvnKv0IDOTHmzm+vB38uzXH6nZfQqZ4sc1NMhHrZJUCfvCq8W+Io1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFCEw67O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729868449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2pA/Y9KFQGL5eKPmyYHAWaMItiz6sKe/fm026vyTOII=;
	b=jFCEw67O6KoNu2rIgik00Q9/fBKsjeXxPrjJhBbo+B4B+w3nepQZO/2qQtg6GTI1XmG2k4
	+wYtIzdmE1tyvFd0DKdFvy/nX7a0xqcptwUXPesGj0W83lHYVfWoNpuNf15PUwgq+l+/42
	xLvaqeMmYvLWIJPvko0CITakF3wS1YQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-aMBVBFx7MiykUZIgILQmDg-1; Fri, 25 Oct 2024 11:00:48 -0400
X-MC-Unique: aMBVBFx7MiykUZIgILQmDg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d49887a2cso1147193f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 08:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729868447; x=1730473247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pA/Y9KFQGL5eKPmyYHAWaMItiz6sKe/fm026vyTOII=;
        b=jS+sCbeuhD4Z2MLdLKgDGIWi/ylBblN0xb3YqNI4SzZkMwwC7NDNxJ5L9Xt3+ifgDS
         SCFU4Xpa2Pp5TA9lapOEXWRsSlotVVIsTcpntoO/XFKb1ZmL/kvKbmB6nzEk8eE7WUBP
         TZpY6HLyeHsJQqYQXzDHJg5whfQOcpq4YYtrNb+hVIEPng+KoFnwJKBtPndRReW6Cs7q
         iMDKWqYAjtVbI1/PoDdBqkye89uahquYOt5K+eImeuii3ZOhfKEu+n7YLtV0uVaF9vvi
         ex0Se+kYfrczyPHbaawdmwFQpj1cyvc0WUrB3Yo3GDbuTIXJBbkBToHHqOz/Grt9KX91
         xuUw==
X-Forwarded-Encrypted: i=1; AJvYcCVmbaPfZ9VJrrqsPSdmiEGjr0qoJ1aXDORCBynfaeeWewGlDkoVnpRgP3eOjhcKYzM9tok4MIjFXigR7dVxEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRRVrse3OVhVn+Qfqu0q2laYK0uUFL8Q+zkez8wxrjmUxGuq9j
	67GKBU4nhiSD/FQtKwPCGMPVxgtHOivdtnfRt5I3dmecFzHNoqHnO1pgoA/3FIGCAH+BZoNtnP5
	8rfDaFM6hIwcklCA8PcFVJSerkVjufirN32ZJSMd7+CC+nfHcTP3HI6GZCkw+0r4a
X-Received: by 2002:adf:f5c3:0:b0:37d:2e74:2eea with SMTP id ffacd0b85a97d-3803ab671c1mr4935438f8f.5.1729868446675;
        Fri, 25 Oct 2024 08:00:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrImwuTr8UU6hSynSFO/Qk6OWlhES0U2PEH7e6DuZZMiwqG+LsgRJgOGFwOY24fOpFVbrN7g==
X-Received: by 2002:adf:f5c3:0:b0:37d:2e74:2eea with SMTP id ffacd0b85a97d-3803ab671c1mr4935358f8f.5.1729868446141;
        Fri, 25 Oct 2024 08:00:46 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82de5ba00738ac8dadaac7543.dip.versatel-1u1.de. [2001:16b8:2de5:ba00:738a:c8da:daac:7543])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b9216fsm1727189f8f.100.2024.10.25.08.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:00:45 -0700 (PDT)
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
Subject: [PATCH 06/10] wifi: iwlwifi: replace deprecated PCI functions
Date: Fri, 25 Oct 2024 16:59:49 +0200
Message-ID: <20241025145959.185373-7-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025145959.185373-1-pstanner@redhat.com>
References: <20241025145959.185373-1-pstanner@redhat.com>
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


