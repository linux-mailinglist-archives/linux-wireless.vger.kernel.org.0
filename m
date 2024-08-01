Return-Path: <linux-wireless+bounces-10829-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E68D9451FE
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 19:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8249E1C23B87
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 17:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A646B1BD4E7;
	Thu,  1 Aug 2024 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/jvTb7c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CC51BCA07
	for <linux-wireless@vger.kernel.org>; Thu,  1 Aug 2024 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534401; cv=none; b=m5Fr7+mXPlnE1VMoUMIPrGC4cW5hu7Ag5OLAFM8AP5Rj2VXcr3pbPR2OsxiZtr+oWa1+dc4MECwtKev38q/0HE2L/VA9ARv/oIbaY0zLgsoVHCQMhSF8DvK+a4mOEdW6U38SKHjbjaAQ9uVBuhBC66U8SgjGC86nO22VDfmRwQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534401; c=relaxed/simple;
	bh=T/Lr5R3ZpRsNgk4LNzf4i3JOmIq6wzNv8zvkRdHooAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TH2BEwVQ272Z8s0gg0Kq4hy/jtX745Yt6jMk3ogKx33QN7rVelxlU5p6BoP0wcJA8lDgt6oa9ZfzmEvfKp1bXFnomKLjCVgX+Oq8iIfXu1qFXiq1NTH0zTGTQEIrBjdyJBwwDWQgyZ1lltDd2/HHMhvSTFp2u82UynmEe4f2Q/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f/jvTb7c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722534398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIcu667vSRZRiKEHakO3GAIgbzPtgHQvNS3his8mZEo=;
	b=f/jvTb7cJQ7arqLwJ0gC/XLARtBm5ucYSPOdfrzjBLigopqMduT0LhSgjS4Dn7cKg9NJCu
	CsE3lDxNQt6frgioT0Ujz41T6yv+9xXcRG6V+zCSjp7FetAA/mPvAT3Dx6JJTmITDOSmZx
	2VCfhxXP20DW67Od4Q6kfaezeAKnBtY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-yNwTLhD-MzWIgD1dboWiNQ-1; Thu, 01 Aug 2024 13:46:36 -0400
X-MC-Unique: yNwTLhD-MzWIgD1dboWiNQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5af1a5a36feso826507a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 01 Aug 2024 10:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534396; x=1723139196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIcu667vSRZRiKEHakO3GAIgbzPtgHQvNS3his8mZEo=;
        b=Bi/ORwqjMgPOP+ZlYdmSF4zAM1OJIJp/HIJVvNVkgEwoawFn9QgWEs6oFlzV9GGGwY
         mvIYL4v+yYyd0pfJW9mGvipaMKv/y4xdmNRY6fzWu4L+JV/XDUWJMXhxWe1BKfdqdt6o
         FADIBEjZUAHtyVKh35YU0LT2Z2YKUjah6Y63bAra9jn7hZnb2A+dhGmIt0yyvLeqWMzu
         XrAlDRjnIVrJUlCmj86KAYueSbdcvc2hUq73QpDX3biHapC+ty14BnZi5CKItVNGJsG9
         +8c5XwqZyyH2bfVLHdMhxEOd1xrjpFAeYcdLcSVK5yBmG97mteEFI8l0ITRwnQBx9KFh
         M0wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRjJXKBybnkBlRcfU/+oOVGG0IeEyFMqWyTOdEXr7kdKr0afY6J5ldWMVodKJhGFTzUYUilGxPIz3N7+ZNlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxH/gPR/wApzumJS5aVZpUCBn3SgKFs8iy0UvurtDh0UKZCr2Hu
	w0/hHoYiexcnFLcgViXyQG9tqxm2VLVks6+mcVWOD2Oe0gC4CcLukx8kD+7cDCtJanYEAUJm0OT
	3WoIxDFeQfVSKGHNo4UN/tVPNJN1hY7ioyM1pcL0xXEoxmKstu/+AiMfD1BaP4Beo
X-Received: by 2002:a17:907:2d21:b0:a7a:9f0f:ab1b with SMTP id a640c23a62f3a-a7dc509f24fmr31653766b.7.1722534395630;
        Thu, 01 Aug 2024 10:46:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHsAm8ay3YLV5X2CKZi8aqVdjkY/Zte8gQFe54oKpkGHtEojyFbBE+V0V3Lk+EwhBeWW6VAw==
X-Received: by 2002:a17:907:2d21:b0:a7a:9f0f:ab1b with SMTP id a640c23a62f3a-a7dc509f24fmr31648666b.7.1722534395021;
        Thu, 01 Aug 2024 10:46:35 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d4b:3000:1a1d:18ca:1d82:9859])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e83848sm5339066b.177.2024.08.01.10.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:46:34 -0700 (PDT)
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Jie Wang <jie.wang@intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
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
Subject: [PATCH 05/10] intel_th: pci: Replace deprecated PCI functions
Date: Thu,  1 Aug 2024 19:46:03 +0200
Message-ID: <20240801174608.50592-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801174608.50592-1-pstanner@redhat.com>
References: <20240801174608.50592-1-pstanner@redhat.com>
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
pcim_request_all_regions()

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/hwtracing/intel_th/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 0d7b9839e5b6..e9d8d28e055f 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -23,7 +23,6 @@ enum {
 	TH_PCI_RTIT_BAR		= 4,
 };
 
-#define BAR_MASK (BIT(TH_PCI_CONFIG_BAR) | BIT(TH_PCI_STH_SW_BAR))
 
 #define PCI_REG_NPKDSC	0x80
 #define NPKDSC_TSACT	BIT(5)
@@ -83,10 +82,16 @@ static int intel_th_pci_probe(struct pci_dev *pdev,
 	if (err)
 		return err;
 
-	err = pcim_iomap_regions_request_all(pdev, BAR_MASK, DRIVER_NAME);
+	err = pcim_request_all_regions(pdev, DRIVER_NAME);
 	if (err)
 		return err;
 
+	if (!pcim_iomap(pdev, TH_PCI_CONFIG_BAR, 0))
+		return -ENOMEM;
+
+	if (!pcim_iomap(pdev, TH_PCI_STH_SW_BAR, 0))
+		return -ENOMEM;
+
 	if (pdev->resource[TH_PCI_RTIT_BAR].start) {
 		resource[TH_MMIO_RTIT] = pdev->resource[TH_PCI_RTIT_BAR];
 		r++;
-- 
2.45.2


