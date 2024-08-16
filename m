Return-Path: <linux-wireless+bounces-11522-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D545954429
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 10:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFF9282A2D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 08:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540E71527B1;
	Fri, 16 Aug 2024 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiImdcE+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449F6149C78
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796613; cv=none; b=qY1oBjUGdl3AJQC6zZO/5tYDiK6PxEHgT1zQRLGR3IcpgYIpqLux4b4taotzDwAEqJ0H17MMVjRZ/gavQ7jZblbfZuQRt7cE4klAGCvMuKL52EXG0IIk5JyaIiLHAtUeAPztQYlu9VAs7lCO5oW0hWUVYCYVvk+b6MvgeLbIfAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796613; c=relaxed/simple;
	bh=VxK2Q9rTPaJTkxCUDwKgVr4mTt/G6TMMjXLiVOpU1l8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISd2k02uJ5GzHtY4tgWQgeiW6tcW8QUUxXiOwOnDsRmJx/qEhfFaQ6FGt/+3/jWAjIax5ErTtLveyHon81qk1StQ96uj2Ltg+XqAw+tLb7apAmxpvoCk/+s0cAQMpc1Oa/jxExqh+yqSrXRRohwqDz3l5Mdi35tqGl7o6n4mfqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EiImdcE+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723796610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9vavx9d8Z3lY3D2Y8KLNdQxHUg+4fLRoKF7EdDYKitk=;
	b=EiImdcE+7HtVRz5d6o2vpumDXS9y7i0S+/C93W+MV3ESLr6EvrjsMFEzIIDTELYBgh3iA9
	PNbxitAQBgyGfJk7nSbG1GkGp+DF/+Qa+miFhcK098vIPrDoFMprmt8cbMAKkEvzTsymE7
	SiMb20AtKQ+l+yjGbNOnzVV4iso2iYQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-fQE4FJNiP0yT9wELBIfz9Q-1; Fri, 16 Aug 2024 04:23:28 -0400
X-MC-Unique: fQE4FJNiP0yT9wELBIfz9Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-429e937ed37so2344905e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 01:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796607; x=1724401407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vavx9d8Z3lY3D2Y8KLNdQxHUg+4fLRoKF7EdDYKitk=;
        b=Hu4puMZ/ffW2/KVnKMRx4QTXgLFqg2eJ7oEtjKL//qz5HPvpzlA47w7JE+ZBUohp/+
         UhY2zOPtNhfwXd9lezgBShrl0U91MOxS7HJIkcvxgZIXnMHSJZ6CryenGKPNZ/mUzChx
         FvxEJQnVBKHsZkeYf8MGYmN0WLkFBPj3fKn1I8/sSCAqxg2NnyOOlOy3/wspfSbSGO8t
         4wBPuYafcxO4+nLF7SsyXfR6OUqXFrcmWYETIMItfkCc30su/Dvrqc4S4PvYgIzFzx0S
         QNUUqfiFuMyWITp5nOg74ywddlmODipQGWhahd3k5TDrVLZy6VOHAgTEkI7ih1zSqCD/
         yPhg==
X-Forwarded-Encrypted: i=1; AJvYcCVX3HKanbFOrFcdm6aQcEzFd0CgcAcNlqFB65VIxfpLAlCJjXe4Fz+wdtMGKVWhzx0MwI3r/k8qfsekhE4UcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhctYK2wz7TV6TQ6zmaYiHs54Mf2xXMK9n5kJAvKx+9yG7vKqV
	cBs3h/OgpRGpkaR37dkRR7+44Fi6xAmvY5rtrYNbWsDwHYLPt7naaQ3FoJdOaORopQEvmHG2vVT
	DGCNWJ+mQdAaSn5CsSd7yJVUq16YMfLTfMVbB4FUJo9g9nmZD6n4gS6+yWhEByov5
X-Received: by 2002:a05:600c:4f52:b0:427:9f6f:9c00 with SMTP id 5b1f17b1804b1-429ed820e35mr7943795e9.6.1723796606690;
        Fri, 16 Aug 2024 01:23:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH6n0oWvlUqxpyDu61U28p7RR4akODFJTFMNu8jX2SKNBsfpChGB90y3cm5ks0xETivd581Q==
X-Received: by 2002:a05:600c:4f52:b0:427:9f6f:9c00 with SMTP id 5b1f17b1804b1-429ed820e35mr7943515e9.6.1723796606233;
        Fri, 16 Aug 2024 01:23:26 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded367ebsm71461355e9.25.2024.08.16.01.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:23:25 -0700 (PDT)
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
	linux-pci@vger.kernel.org
Subject: [PATCH v3 06/10] wifi: iwlwifi: replace deprecated PCI functions
Date: Fri, 16 Aug 2024 10:22:58 +0200
Message-ID: <20240816082304.14115-7-pstanner@redhat.com>
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
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 719ddc4b72c5..6b282276e7b5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3534,7 +3534,6 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	struct iwl_trans_pcie *trans_pcie, **priv;
 	struct iwl_trans *trans;
 	int ret, addr_size;
-	void __iomem * const *table;
 	u32 bar0;
 
 	/* reassign our BAR 0 if invalid due to possible runtime PM races */
@@ -3657,22 +3656,15 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
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
2.46.0


