Return-Path: <linux-wireless+bounces-14078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F849A0A27
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 14:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95263281CB1
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 12:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A94209695;
	Wed, 16 Oct 2024 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dP9k24RO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA8B208D82
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082510; cv=none; b=XbegkgtDLjoOinY05VttcnZDh054Hde4Rc9SbBH6uRXgVAbqUdBv0Hn7kMBUvqwdr9u8o5/mt0KDy4nUGUNlROO3QjpCXxw3RegMrr1dhXUPBLP7SAemrSP6GdrNd47qCix6wn5XIRHEZxwFbo9Qc88HmXQPbweLAfPVjJPk/2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082510; c=relaxed/simple;
	bh=pzHm+p7iOQ3ZHeJddCbAsTb72gDaFZfayku/dAdnQvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWUbvWQDZviTd3sd5j2NCV1y5ovEDD3MS/HYLkqU2iQNSf5WFA9uHJwuzAG8PkkdL0e8wqm8JUMhNq88xTtu1QzR8IGnUQVC53PIuF9VMvv5Itnfz1TGpRYTYmaB7oAUGBnmj53R55G9bcLk2Ec9yZnbxcdLB8V3H+SIHbhxv0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dP9k24RO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729082507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y8B9LV+ler/WieU+IGPE+8OX97zcf6y+ob4ao9vxZG8=;
	b=dP9k24ROouWtoi0wgUP2ERMPrz1gPIoIj1Tljav8cuabAI6RIcvvhl66LBdkzWAXdwRPck
	iULxpx38BzaRat+Xc514hijBUnjznUGEZZlQgC+eDw6GZUvIpkQ4cgfBx9ia2xEY78lpYj
	uIvmgE/tOogNcGu28g8bkmaENtm6os4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-jGobJXLUPtGmSdxOuinEaA-1; Wed, 16 Oct 2024 08:41:46 -0400
X-MC-Unique: jGobJXLUPtGmSdxOuinEaA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43058dce286so37974795e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 05:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729082505; x=1729687305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8B9LV+ler/WieU+IGPE+8OX97zcf6y+ob4ao9vxZG8=;
        b=eUaHPtrOInV4UrFdoNKZ293+dccDcai7My3KMr3eGst6eryJzXdEJAFvxl1oga8kY4
         sltQR4ASfqQWeyLOS4kuo2F3MkN8E4zlsQ2o4p0pmKkiJCDWCot8CD4O8AOAZGLZcKhP
         dC5xzJqRvdvjCqs57ABoeXmZCUU6SWdff5mmMfLy5xjHFbS9di9pJCL8GfRVmlO3O+Hx
         xDupTvfX2wsjlf9RHiLRPKd94zk77zUcvPWRGMWv7vvaZTpgEuYx7T6f+cqEEVIQ2VZO
         BSHUT35I7Ne4uHAgXL0om4BtI3zqTJgiOyt7T/LI1rKLNJGXDTbffhSjgSUdH+0ZtpXu
         vxkA==
X-Forwarded-Encrypted: i=1; AJvYcCVONYbnNCulrtTG2J+yxAH2jkYqJvH8I8ivkh2WXB93JEyTk+wYgsouvHR1pXGJT9ARJ7n3/L+wwrz8KQvC4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6e38voUspbSdZYMH3/ZyLZdooE+9xPXX3HGUhZAQN72B6OLce
	EbLO1Qi63egtMNwqPq7Hea+Oyad4AoQz570asABDJa9gikQQUqo4fUR2C42jPiI6MnOAQbfejNY
	OYfljewc01c5/9s+Hri4snmYvGWPtPlL47k/RFr3grJVT81204+6pkX0m49wPPiCz
X-Received: by 2002:a05:600c:5251:b0:430:5846:7582 with SMTP id 5b1f17b1804b1-431255d53a7mr128785095e9.7.1729082504852;
        Wed, 16 Oct 2024 05:41:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGxF9+2xYoc2iAcnZEJLUiZOKpsxfW9lx+KNsJOv5CduYI06lG5Znx9zhblHV4xRBC8nAdSQ==
X-Received: by 2002:a05:600c:5251:b0:430:5846:7582 with SMTP id 5b1f17b1804b1-431255d53a7mr128784405e9.7.1729082504314;
        Wed, 16 Oct 2024 05:41:44 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8ffd6sm4246879f8f.50.2024.10.16.05.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 05:41:43 -0700 (PDT)
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
Subject: [PATCH v4 01/10] PCI: Make pcim_request_all_regions() a public function
Date: Wed, 16 Oct 2024 14:41:23 +0200
Message-ID: <20241016124136.41540-2-pstanner@redhat.com>
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

In order to remove the deprecated function
pcim_iomap_regions_request_all(), a few drivers need an interface to
request all BARs a PCI-Device offers.

Make pcim_request_all_regions() a public interface.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/devres.c | 3 ++-
 include/linux/pci.h  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index b133967faef8..2a64da5c91fb 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -939,7 +939,7 @@ static void pcim_release_all_regions(struct pci_dev *pdev)
  * desired, release individual regions with pcim_release_region() or all of
  * them at once with pcim_release_all_regions().
  */
-static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 {
 	int ret;
 	int bar;
@@ -957,6 +957,7 @@ static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 
 	return ret;
 }
+EXPORT_SYMBOL(pcim_request_all_regions);
 
 /**
  * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..3b151c8331e5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2293,6 +2293,7 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 				    struct pci_dev *dev) { }
 #endif
 
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name);
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 				const char *name);
-- 
2.47.0


