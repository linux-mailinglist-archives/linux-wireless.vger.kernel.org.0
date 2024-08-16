Return-Path: <linux-wireless+bounces-11524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD482954439
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 10:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F74284B2D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 08:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83895155A53;
	Fri, 16 Aug 2024 08:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhycMhrY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D2B154BEC
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796616; cv=none; b=CFkdhMRnkNIQrAiDA7puCcihWiiTggKX/rIGCas8/u3k8CcQGP2raiYhLwvTYFinWHdDY/eP1q/11UZ8864ILMjSmk1arqjDwDX1vKF6VAWGoO4ORyCIgxDoYJhw5GX8lES9VHLFRDpSKAOiL3ArHgtMGRGp30RZD8YuIhKuLhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796616; c=relaxed/simple;
	bh=YADw69teg6OUTw/9kGSAzVxq8RbBIlzKklSmAwNjgek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SG0whCtjvyJ4s4earQwHOSbgGdWLeiVg5l2Ipa2QjOYMeOFUJ0ylVNCMXKsrwyglgKfW1wj3e3lIuzewKPAZ9aFHKVH5rQTsiwvlDOR1bE7/qL1N/qaVI0G2GGZymLOoOSjI6udL3nyPvGSY8jz18jUcxK3E6/WSJWZ6rX1UkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NhycMhrY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723796613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wR7g/AUrRep93UkGki3e8tPEClSI97kh3uS4quT0v8M=;
	b=NhycMhrYjMP7ZidkfzlRlZfIjHEbglpT7ZEbzkKT47aX3Ng/CaPEekKgPpcOA9mOkdNd/X
	IBwfixvQ/1E8i9zT4RSNwJ2p6VriXXji3FnrNhfybp/T294Bg8iq/83xyD77QTv0sNz1Ro
	1bcEi5xwJYw+KKndCJMaKLpNwk1ykoo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-zdb052-kNf66lyd-13z1fQ-1; Fri, 16 Aug 2024 04:23:31 -0400
X-MC-Unique: zdb052-kNf66lyd-13z1fQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52fc215b7f0so237176e87.3
        for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 01:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796610; x=1724401410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wR7g/AUrRep93UkGki3e8tPEClSI97kh3uS4quT0v8M=;
        b=Yhicz772DLVv3riM8C8GP/U1mDDhRXAU+6ChlGEeetweI/53NXj+nIqkILQWqpRh/7
         w72o8bu+MSPkVzO0BUjJusN58GXAcHtTQZhXs0JwU0F4KbxmpREN63B0m7JX9Z3CvZ9y
         YUsZELp/P6W+L8oou+6/SdrmDCJ4B0yO4zngvJ60fO5DM4rRaoR+gQOCOkVy1e5/hEaU
         W9NXYBXC8kdLxM0vvFip26XETFEBXEHoylzjl/ex/cFzIL/lGyMZP7i2v42avNWYCQsW
         CmHpAZe0Jt3tnHw29GzwFsXAnj6fZDynwO6gxM1PL4XpTO9BoWzKbq7Vf3QMNbrXBBqQ
         KEcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcH8xTSUapw9dnSNhnCz7pR0jAI0yLppO/K0eaproObchyn1MYfwytO7ljD2PUNWyogx6XuQ3OMUQK8rlCEiy70LkuvLYxKtFz86Xf6jY=
X-Gm-Message-State: AOJu0YyOJImLtPwPF335TCVDStvavomQa27u7b5X5cBKowf51/qbUHOZ
	1V8aUQCWFa8PZf0VhfaKdh6eZYvY4IRHev5xKy4IcH+EK6h23YHC1LEIG7GEdBUZhFwq/oJeRvw
	vDEsM0Q0M8/HimgFija3pK5TsIXYxM/0ucNefiM+PZJ18TA5mrgnTCs54Y76xmj7a
X-Received: by 2002:a05:651c:210e:b0:2f3:b38c:a142 with SMTP id 38308e7fff4ca-2f3be6074c1mr8718111fa.6.1723796609792;
        Fri, 16 Aug 2024 01:23:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGedci6wEskLStoN5T+/a5fQ7mQwe3Hdz3eZpzwNe45i6iFhaTa+e9V9NXIeJ1Uhhe0A/2fIA==
X-Received: by 2002:a05:651c:210e:b0:2f3:b38c:a142 with SMTP id 38308e7fff4ca-2f3be6074c1mr8717741fa.6.1723796609341;
        Fri, 16 Aug 2024 01:23:29 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded367ebsm71461355e9.25.2024.08.16.01.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:23:29 -0700 (PDT)
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
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v3 08/10] serial: rp2: Replace deprecated PCI functions
Date: Fri, 16 Aug 2024 10:23:00 +0200
Message-ID: <20240816082304.14115-9-pstanner@redhat.com>
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
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/serial/rp2.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index 4132fcff7d4e..b6b30bb956fa 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -698,7 +698,6 @@ static int rp2_probe(struct pci_dev *pdev,
 	const struct firmware *fw;
 	struct rp2_card *card;
 	struct rp2_uart_port *ports;
-	void __iomem * const *bars;
 	int rc;
 
 	card = devm_kzalloc(&pdev->dev, sizeof(*card), GFP_KERNEL);
@@ -711,13 +710,16 @@ static int rp2_probe(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions_request_all(pdev, 0x03, DRV_NAME);
+	rc = pcim_request_all_regions(pdev, DRV_NAME);
 	if (rc)
 		return rc;
 
-	bars = pcim_iomap_table(pdev);
-	card->bar0 = bars[0];
-	card->bar1 = bars[1];
+	card->bar0 = pcim_iomap(pdev, 0, 0);
+	if (!card->bar0)
+		return -ENOMEM;
+	card->bar1 = pcim_iomap(pdev, 1, 0);
+	if (!card->bar1)
+		return -ENOMEM;
 	card->pdev = pdev;
 
 	rp2_decode_cap(id, &card->n_ports, &card->smpte);
-- 
2.46.0


