Return-Path: <linux-wireless+bounces-10942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B68509476D9
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 10:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D0E1F21AE7
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 08:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9EB158D8D;
	Mon,  5 Aug 2024 08:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lpgiwlw6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E860F14E2DF
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844950; cv=none; b=HhQqFQl03rvYRDEygjaLNxv9Cu2ldGLbgzXkoDrehsRiWA67A3oyz4x93ScLBAq7Fr16imaC4iElsoQ2DEGK5zBhIb6PQBldmGar+o5ZsZ26up0xtJcfy/5ATtsYjq2+gNokGiNA1F4zTUrj1qTDqyaPEw/ATBNOOOwUlPsarno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844950; c=relaxed/simple;
	bh=eDX/oUhvMuTvOdEU35gML3pMZ3bHnmTWwtIB4yn4vRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l246AAk/gqsSteHNoIxaxe41Wr+oJ1qX4LVL0tc4EvD+p/MIwvy9L0eO7ugUsUr/Txewq3dZWQZGTDL6j1UYRqz4FbzeNDtgwoVDugUv1ovW516UrsIY6/aqtYjIys0qUfkcUSHB6aXXnXXd8Ha5k+QksmHbR0rzITQ8Bz9c68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lpgiwlw6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722844948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6elIcVAva6IdGos3xrpBxA061GwStf3eghsSoUI+FxU=;
	b=Lpgiwlw6Yzni8oZdZsXAJZKU51WMQbOAlS0RMvSm3eAgKu8INGw4B48EtTu0AfsmrIvM+R
	vRVytD+85GTW9hYl3mYN3N9K8YTN2yZsSn6Ww6K84evLqyW4mV49WzMiVhiAtN10dvFmba
	RNpimBuZ7P8vG8bJLgSXudsQycPz5iw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-bKuDX4VeMtG-qw2DAgByEg-1; Mon, 05 Aug 2024 04:02:22 -0400
X-MC-Unique: bKuDX4VeMtG-qw2DAgByEg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a77cd5611c5so79467566b.2
        for <linux-wireless@vger.kernel.org>; Mon, 05 Aug 2024 01:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844941; x=1723449741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6elIcVAva6IdGos3xrpBxA061GwStf3eghsSoUI+FxU=;
        b=KqowN82c77APLZ8tl22yCKAZjCnHw/GFIo1RTanJsjVZc3XsdtkOMO0O31V7nv2lGH
         wXaJpcZSKamHdlxyDd7KDV6QKRQNQBmoX+xwdpTOwc2zthdXLkyxvrxyWx6Lzv1RPBQQ
         8RAoamKQH2jiIaeenkQWJarpaBVfn/gH7/0GY8gYay310ZhvAKIHCApSO9gss9baAWjV
         5Z4viDrNFldkD7CEb0/gp8sTvABcoPs9M9bFt9A4ZtjRSSpWEVUxR+wdd4pqMErj8Pye
         76ul4zFCXP8RxKYxvKZRh4uuyLeoYb1dHACsr4UK1YrulSl8BLIcMLkQoMLDOF6sWkRN
         6Bjw==
X-Forwarded-Encrypted: i=1; AJvYcCWGetbsSysu0hb1c4lSXEdflKotKztoDVV1hlKoBswgWewGMrbTUbLy8wYEIdGdKMeDpIoSyZXl4kZ6Ho457A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZeRyasWCMOlRgWnzBFBs63HFZYLMKzADQ4bkwkQMhKtkCL19K
	sA3sOvaVOj/TeFpXqOqPfson1+NSCJXqmAtLLBCwPDwvQvZyXGuYcdIb2ze7qKTIM6U5tmKP3XF
	748VJHRuPY9dtT4faQM1t29ss4i+QVqqxgAl05m4GT+q0LLeMeiQLeLhOXcVrAAzT
X-Received: by 2002:a17:906:bc0b:b0:a7a:9a78:4b5e with SMTP id a640c23a62f3a-a7dc50ff341mr387930966b.8.1722844941120;
        Mon, 05 Aug 2024 01:02:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkK5Lt7n9jXqXSSRLA1PwUtBlM1U1xQiwgfbtLyFZ2DIUDAUIZgCzu48VuDRqWx5Z3WdARVA==
X-Received: by 2002:a17:906:bc0b:b0:a7a:9a78:4b5e with SMTP id a640c23a62f3a-a7dc50ff341mr387928066b.8.1722844940701;
        Mon, 05 Aug 2024 01:02:20 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82df07e000a5f4891a3b0b190.dip.versatel-1u1.de. [2001:16b8:2df0:7e00:a5f:4891:a3b0:b190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7de8d0868bsm277958966b.143.2024.08.05.01.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 01:02:20 -0700 (PDT)
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
	linux-sound@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 09/10] ALSA: korg1212: Replace deprecated PCI functions
Date: Mon,  5 Aug 2024 10:01:36 +0200
Message-ID: <20240805080150.9739-11-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805080150.9739-2-pstanner@redhat.com>
References: <20240805080150.9739-2-pstanner@redhat.com>
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
2.45.2


