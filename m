Return-Path: <linux-wireless+bounces-14531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4109B06AB
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 17:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C540B236F3
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 15:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486BA17C9FA;
	Fri, 25 Oct 2024 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPGu2HMa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E89166315
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868444; cv=none; b=QDHybRi7IlqG3YlBc372aJZ6skvbEjxzcstB319+3Fx7MEtmDnkL9e8HsJx62P7nEl3Sdvq8qL4c3Jt31u0simbQAgKRw8V49hFQSCXXCxZNttNgvx9e/59gQc1AfcFm4QlTok+G4SgRzKmxz/IrA8WIzTr5qUVFx+7KHqSxQVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868444; c=relaxed/simple;
	bh=pzHm+p7iOQ3ZHeJddCbAsTb72gDaFZfayku/dAdnQvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMNaEUPEDN4Xj4ybZfBBTy4Lp0WfkUSYeazLZ7MzvjTfe7nanHJ2KprFKvG7OHBcTB2hIGBmuqUfBc6E6ME/grBlh2Vz4DlIyuBPiQFH/eiRJD3chXcq1F/z24ilF3NfDKYNqpTt5mKbqxWatQv9HKGrto5ne8yRkpyXJ/905C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JPGu2HMa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729868440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y8B9LV+ler/WieU+IGPE+8OX97zcf6y+ob4ao9vxZG8=;
	b=JPGu2HMa0VmJkvbZ1032ccnLrZwu9+fuQjTZ13+CTCZif5BmgbWrK6MgZtmNBiGWVAZxCs
	Aq7U9odEeV56faYonRTPcfiezURKGm7MeB4j6XjNw0DweaSbDkMkeeQE0TpVm3pakKHyyr
	4WTGfYPgzJRAdKBACfPxSPc1frCPxOU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-1Yq5t58kP22QHPiCbMdRvQ-1; Fri, 25 Oct 2024 11:00:39 -0400
X-MC-Unique: 1Yq5t58kP22QHPiCbMdRvQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-431518ae047so17252465e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 08:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729868438; x=1730473238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8B9LV+ler/WieU+IGPE+8OX97zcf6y+ob4ao9vxZG8=;
        b=sJ1wh0BT0eFfkI/dXi970MUUrbumeZ+xjZGBRbm5fPD0bUn1JxiU3xAxlZQQykuOdq
         DC0R95gzhSTre6mH0RshVsIBHKwZ9t2m0q2xtyxTs/zOhc9b58FMb6aOJEXPWodFyV8q
         CJVyJM+Hnw2pPOjeO6kpO1QmjunjXwLPtwc426Xa3bealb1k9gwpMJzj5lzJgj3LHvkb
         Mn+TX0byMeRLANrAbeQBx+oqDMCqkaAJM/aX2a9mx8XkXo1/O5AxGnqiMzHmLH8heN8V
         h36QDPpkBxxLy5i2DxzBcX0ez1m5kn10SiqWZBdRtIe90e9L/W2dycQflfXMqEpx6WDV
         KJnw==
X-Forwarded-Encrypted: i=1; AJvYcCUWri5HMwgY9iXK7VUhpySTUMMAbM6zKsvfYF1mK8wSckkHwWWEX/fs65poWOePY67QIsSbqdWZ0MJZSlbwwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMMzDAGu/V2qWizfJTeOrgKPebMj2Bm6fs5B32noXuM6zjO2Zd
	lqDBjF8SWJaJURfXBsusNlBag/m/2rxoXFL+ZYWXqKlFcv2v9hIV2scIlnztqvQeZwll1tF2Fxq
	/DM4BjheFpvkr5Q7Ao6hR2JsVOsJnA+Doynvw/OQNrlCadzx/OH52dQv3DepG1Fmy
X-Received: by 2002:a05:6000:d84:b0:37e:eee5:80dc with SMTP id ffacd0b85a97d-3803ac6704fmr4258115f8f.28.1729868437900;
        Fri, 25 Oct 2024 08:00:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0kR0T6tO4HMLrjOiOdPK2NT4nWQw4oUfgmMiDyLMaWTYTtq+bTSQKDKbrlWpwhU7sEMawvQ==
X-Received: by 2002:a05:6000:d84:b0:37e:eee5:80dc with SMTP id ffacd0b85a97d-3803ac6704fmr4257961f8f.28.1729868436829;
        Fri, 25 Oct 2024 08:00:36 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82de5ba00738ac8dadaac7543.dip.versatel-1u1.de. [2001:16b8:2de5:ba00:738a:c8da:daac:7543])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b9216fsm1727189f8f.100.2024.10.25.08.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:00:36 -0700 (PDT)
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
Subject: [PATCH 01/10] PCI: Make pcim_request_all_regions() a public function
Date: Fri, 25 Oct 2024 16:59:44 +0200
Message-ID: <20241025145959.185373-2-pstanner@redhat.com>
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


