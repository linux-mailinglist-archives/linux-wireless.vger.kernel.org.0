Return-Path: <linux-wireless+bounces-11525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C4195443F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 10:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8014BB26554
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 08:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F58154BEC;
	Fri, 16 Aug 2024 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxXHVAG1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AD4155732
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796618; cv=none; b=b6XAn+Jkg40xTu9kyBhtV8noJRcmzWwhsrOWdEXbwwolLgMRv/BHCsEbdqL/9NMvdS/2Xp+FRubcbd0OrQoMgzUMqeZO2j1KMi7wQx6CAc0zmJSuW9nW4RT/RRmOEB7eR7EHQx/qMFH871J/ZvVDVP3AJ2P+QFXkUfSh5BkCzm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796618; c=relaxed/simple;
	bh=vRi2Dr8oYOl/Dn3cbKasTreqlBKKIRjGiyZnnXF2ueo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvPPFiema1u1QoaqETY8Xm6+NA1QzSMMlMISULPCNowI6IvprIiXyHomPTPFokQi/Q1Jy3/bO4NvJAOMW4N5QwAZFuJPiY09kovwff9tmmheNDuDuDMRdJQts4D2Q88vXOokyVgnPBAf4my5YjU1UA5B9vxrPe3vhbf6iqkzIME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QxXHVAG1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723796615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18rNye0tQ5OucjTqtNIdO+/X5BNRh9H93PkE7JosHtA=;
	b=QxXHVAG1EyJ4pEqvl1ISrJT8Owy7caYopU9wyRajh2csXSPccGTpP8pMRvh/D6mJb7C+n2
	uNbhb3x8aLpR1ebLLtvYLK5mVNawU+i0w4phGCFZoaOrTLgXrmhC9RKnLYUXe+lPtQumNE
	JRkkq+Wo4/f7+y5uz4Y8JXeC/vl9+mE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-aFJssUCdOqe29-T3yP1cFg-1; Fri, 16 Aug 2024 04:23:33 -0400
X-MC-Unique: aFJssUCdOqe29-T3yP1cFg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52eff9a3109so316303e87.1
        for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 01:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796611; x=1724401411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18rNye0tQ5OucjTqtNIdO+/X5BNRh9H93PkE7JosHtA=;
        b=Jv3S/kz7AYYuGp6QAanVHmbSA+2yV7h7xEFTOe5nm6juuepVslbp64tjQW3QCgs73K
         sRvAisXCl4xcYeAEJNAReeECPQUtFDszXgybQNu7PQwDtrmTx2QjEaE7gwrDFa62OIff
         euC8bUFjunJNebk+2zLGclsP08ZuvqdUfUFv/PioZo5xtWrMn/Z1tGkYIark0i52axQG
         rTFgG3BISm98K+3CV7O+kLhSznPLdHdboLBud0y+JcHTbHaHGyx/7UdJVho9R6nxiQEG
         rVBUFYgLH9En7XtgkSwL4Eltghrwx/5JXR93UosssscCfnp5sdQJo/djNtLeg5xyMUV0
         BFHg==
X-Forwarded-Encrypted: i=1; AJvYcCWiepb1iB4GCHtgTyD4asnbJY0TULip9hjLNq1bgig51RIgqmZoFzmYTxIxRC4UDJdzhe9mAm1scpEPPI/5MW5/4w/gTkiW7pmfnO5rShI=
X-Gm-Message-State: AOJu0YyoV+/3nRF9dTp67pM66qHHAGYBCBlyjAtVd1OCoJnyO8MyYb9O
	KorwhHYxc6Mnm87OOTX9UXqHVDQZtda2hAb4d+UH6Iif/q8djMcuVry5UVuu5pGvGIgrHWiJKtI
	WDYBivFSE371lbeIOyhqi6A01g7E9BePr6XoTk3wlYPyTozAc1bqpZk5KVzrCkJme
X-Received: by 2002:a2e:bc16:0:b0:2ef:307d:17 with SMTP id 38308e7fff4ca-2f3be6e6debmr8624101fa.1.1723796611396;
        Fri, 16 Aug 2024 01:23:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1IvrWWZfR+lgeOS08d4L6C4BkPOCAMrmkf0L9QOweXgsFSvigKNGw42Y5Pcrt7oEZghU4ww==
X-Received: by 2002:a2e:bc16:0:b0:2ef:307d:17 with SMTP id 38308e7fff4ca-2f3be6e6debmr8623641fa.1.1723796610906;
        Fri, 16 Aug 2024 01:23:30 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded367ebsm71461355e9.25.2024.08.16.01.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:23:30 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jie Wang <jie.wang@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnaud Ebalard <arno@natisbad.org>,
	Srujana Challa <schalla@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v3 09/10] ALSA: korg1212: Replace deprecated PCI functions
Date: Fri, 16 Aug 2024 10:23:01 +0200
Message-ID: <20240816082304.14115-10-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240816082304.14115-1-pstanner@redhat.com>
References: <20240816082304.14115-1-pstanner@redhat.com>
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
Reviewed-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/korg1212/korg1212.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index 5c2cac201a28..b5428ac34d3b 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -2106,7 +2106,7 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci)
         for (i=0; i<kAudioChannels; i++)
                 korg1212->volumePhase[i] = 0;
 
-	err = pcim_iomap_regions_request_all(pci, 1 << 0, "korg1212");
+	err = pcim_request_all_regions(pci, "korg1212");
 	if (err < 0)
 		return err;
 
@@ -2128,7 +2128,9 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci)
 		   korg1212->iomem2, iomem2_size,
 		   stateName[korg1212->cardState]);
 
-	korg1212->iobase = pcim_iomap_table(pci)[0];
+	korg1212->iobase = pcim_iomap(pci, 0, 0);
+	if (!korg1212->iobase)
+		return -ENOMEM;
 
 	err = devm_request_irq(&pci->dev, pci->irq, snd_korg1212_interrupt,
                           IRQF_SHARED,
-- 
2.46.0


