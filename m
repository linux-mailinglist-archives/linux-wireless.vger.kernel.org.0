Return-Path: <linux-wireless+bounces-14081-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FA69A0A4D
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 14:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF9E1F21BC6
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 12:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617A120E016;
	Wed, 16 Oct 2024 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S21ELOVa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F73208D61
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082516; cv=none; b=kY+kj0/dsYwVKtfHZFoSSQnKH9m2u0LnrL6QrDHnN3NwmmSQ6OTTYwv8zva4dJayNcpcL0MtyeRjDpu4bx25dZJakFWY/zHScTHSCNgXonoNRghod3uRZIPhpcxycwLXK/LHlV/HA+6pmAMY7ApWOho1foeU/wVISHWYiYV+jQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082516; c=relaxed/simple;
	bh=oVo6QvjNlOPmijXz1zHLQkfiuuBuqfV474IJ4VAK4xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyI9VLFpUH2sEsWjC+zaXvmiomaxS41ohmPmdv8vtWDpJfnsukgGXOOZZcyo1NFIgqq+Yw4FG61N2eDP5kXkEZJsVqBGeGKtXjyKRocWOh14Sg2n9yFo7kfQUk4eBfNAyInGKmrpGb/BKjpaBwInKm7VCu8HR2tVnutO1AU7z48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S21ELOVa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729082513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CkbzS05iowN1f0M3rgo936jPG3Sqbtimq2cAJDorb0Y=;
	b=S21ELOVarHN+YLr2ulOa2EjnixkjNjNdrcfk4wSgd2VuDtIohDfwQe3O4p+xoEQCui+4uM
	V96gsTctUWjYsYMrDi3pvCkDTrvbH/2/go4I+SAODMUs5HLNLbiH6QkjDMXEDXLujWgmAj
	hKZLAyZRiyVfZCzBhVIO+yXL1Cy8FOE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-v8lGmmlxN2iim1Stf6W05g-1; Wed, 16 Oct 2024 08:41:51 -0400
X-MC-Unique: v8lGmmlxN2iim1Stf6W05g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d3e8dccc9so3216180f8f.1
        for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 05:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729082511; x=1729687311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkbzS05iowN1f0M3rgo936jPG3Sqbtimq2cAJDorb0Y=;
        b=m6HYuLOI/Wr/ame29HmrQjLfwy5pSIxXw6YKwiePwET2XetmwiD6tRjI4GgWEe/yjO
         zeQdRZuoMZGTM19lC9SKKzYURO1Y09wFeM5dvuRHAgnNnItsANHP3CiI7tpdoTysODa0
         f8xPSYpT7A0jaAAlWqiW0nAm83B/CUggqaTAazrwwz/gEr+Exb526D2+vzCmz98F0Dap
         89VVyhO3amkS0hROsxmpvUI7wzVUDGgjNOGZu+oN8D6+bgNR7kvg6mhcfT4tp02Q6S/j
         lv3wxYvE4L18f6MbGDfyzkirWgsaiyd1tA7mpgiErFWQktx/T43v0v2CW2JkMm9m2WkS
         uO1A==
X-Forwarded-Encrypted: i=1; AJvYcCXMJFpXnFwZVvQ12i1ZmboVdOHqc54PpMgna5lUlfuJcZOaHwFUilE/2f8IQ11A1IwVAdK51WTIqbAmX1GXsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrQr1FsZWsGRIQIXIdkXP0VgcbxPAk0AVIklO/xiJfJ9tLKhoC
	PTMxjVP6xdUimkCn5VJ9zAHr62PWpOdXzoHqtc+7VfQpF4jv/1aznbdMO/gW+/sSZxzfuOQ6U4M
	APhq0a3g5LODPoVi9v6+/3UYk+iUm0wGPca5cSLpBcD+onCf35GabgLHDyvsXYB4T
X-Received: by 2002:a05:6000:1101:b0:37c:c4d3:b9ba with SMTP id ffacd0b85a97d-37d5519998amr12212274f8f.12.1729082510432;
        Wed, 16 Oct 2024 05:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFK1gqBE/jl0UfBUACkKIQmrpKFH7ZX+GOEOp/3UeRC+ZbEAEi2K3NnzF3HBuuhY4BbNlHnw==
X-Received: by 2002:a05:6000:1101:b0:37c:c4d3:b9ba with SMTP id ffacd0b85a97d-37d5519998amr12212213f8f.12.1729082509847;
        Wed, 16 Oct 2024 05:41:49 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8ffd6sm4246879f8f.50.2024.10.16.05.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 05:41:49 -0700 (PDT)
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
Subject: [PATCH v4 04/10] crypto: marvell - replace deprecated PCI functions
Date: Wed, 16 Oct 2024 14:41:26 +0200
Message-ID: <20241016124136.41540-5-pstanner@redhat.com>
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
---
 drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c | 14 +++++++++-----
 drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c | 13 +++++++++----
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
index 400e36d9908f..94d0e73e42de 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
@@ -739,18 +739,22 @@ static int otx2_cptpf_probe(struct pci_dev *pdev,
 		dev_err(dev, "Unable to get usable DMA configuration\n");
 		goto clear_drvdata;
 	}
-	/* Map PF's configuration registers */
-	err = pcim_iomap_regions_request_all(pdev, 1 << PCI_PF_REG_BAR_NUM,
-					     OTX2_CPT_DRV_NAME);
+	err = pcim_request_all_regions(pdev, OTX2_CPT_DRV_NAME);
 	if (err) {
-		dev_err(dev, "Couldn't get PCI resources 0x%x\n", err);
+		dev_err(dev, "Couldn't request PCI resources 0x%x\n", err);
 		goto clear_drvdata;
 	}
 	pci_set_master(pdev);
 	pci_set_drvdata(pdev, cptpf);
 	cptpf->pdev = pdev;
 
-	cptpf->reg_base = pcim_iomap_table(pdev)[PCI_PF_REG_BAR_NUM];
+	/* Map PF's configuration registers */
+	cptpf->reg_base = pcim_iomap(pdev, PCI_PF_REG_BAR_NUM, 0);
+	if (!cptpf->reg_base) {
+		err = -ENOMEM;
+		dev_err(dev, "Couldn't ioremap PCI resource 0x%x\n", err);
+		goto clear_drvdata;
+	}
 
 	/* Check if AF driver is up, otherwise defer probe */
 	err = cpt_is_pf_usable(cptpf);
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
index 527d34cc258b..d0b6ee901f62 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
@@ -358,9 +358,8 @@ static int otx2_cptvf_probe(struct pci_dev *pdev,
 		dev_err(dev, "Unable to get usable DMA configuration\n");
 		goto clear_drvdata;
 	}
-	/* Map VF's configuration registers */
-	ret = pcim_iomap_regions_request_all(pdev, 1 << PCI_PF_REG_BAR_NUM,
-					     OTX2_CPTVF_DRV_NAME);
+
+	ret = pcim_request_all_regions(pdev, OTX2_CPTVF_DRV_NAME);
 	if (ret) {
 		dev_err(dev, "Couldn't get PCI resources 0x%x\n", ret);
 		goto clear_drvdata;
@@ -369,7 +368,13 @@ static int otx2_cptvf_probe(struct pci_dev *pdev,
 	pci_set_drvdata(pdev, cptvf);
 	cptvf->pdev = pdev;
 
-	cptvf->reg_base = pcim_iomap_table(pdev)[PCI_PF_REG_BAR_NUM];
+	/* Map VF's configuration registers */
+	cptvf->reg_base = pcim_iomap(pdev, PCI_PF_REG_BAR_NUM, 0);
+	if (!cptvf->reg_base) {
+		ret = -ENOMEM;
+		dev_err(dev, "Couldn't ioremap PCI resource 0x%x\n", ret);
+		goto clear_drvdata;
+	}
 
 	otx2_cpt_set_hw_caps(pdev, &cptvf->cap_flag);
 
-- 
2.47.0


