Return-Path: <linux-wireless+bounces-14728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B623C9B61BC
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 12:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74CC6283C11
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 11:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E821E5737;
	Wed, 30 Oct 2024 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRrJRJhs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6813A1F1304
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287716; cv=none; b=p3LTOM+VA9KbhTixJEFy2bZxvJaO+LrvS5evAn0OG6kvgxqllBhXbnYy7i9v+9NOUSlX2vIjETBn/LDYL+LQHdth6cI8JDMVJhvcDBuPBkULX1pJEqMfEqm/wDkaLsBb9a/rrueAhOhHWhhcjNafeDVsmPrF3ZAjxEu4lgY19cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287716; c=relaxed/simple;
	bh=x2AO4woPu9H2aNxl2TylFo7TB42POmIv8HM+dl0TTWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrgpKZrkch44qEuq04bH5HEcgcb+njowL4Q02Ptwy7fnFX8RsuQLA5tlEoBB3iRcqpRfCoveT/Bn4NSODCdIoIb12xxR21y9dACpB7miX13pGgqW40cKoS8VV0x16XC8gJ3wJvBKtPk5FCQh7yTn9zyIzV5nFHC6Q0szCvyH7TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FRrJRJhs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730287713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZ55uYUf11n7K97VlTpkijb2Akz5QQrQmQxQWIeLt9U=;
	b=FRrJRJhs2XXlhUn5peCAD9N/8GMk7MbA3NcC7sP+lw5rks6fxAnc7YpDL7mak1QLpnKQf/
	DkK3dCQRoJGs3+HVDj/+BVYLwA5ojtddBP4MD3rUE7BXhKTlbvEom4eo6XJIob4EHOlDdn
	/nCQ41kfM2UkKSxMrokKqtWJzPuuUWs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-dQcp-iFNMvCno3lWe2qFZg-1; Wed, 30 Oct 2024 07:28:32 -0400
X-MC-Unique: dQcp-iFNMvCno3lWe2qFZg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9e0eb26f08so224397666b.0
        for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 04:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730287711; x=1730892511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZ55uYUf11n7K97VlTpkijb2Akz5QQrQmQxQWIeLt9U=;
        b=eRyUmdQmPolvaOda3RGkKcIaIFGYrfLnYPmuzl94giZ67Sx8Ffb+t2E7ib2iNs17qK
         n7+iN+q6yp8Qa63JEjVoTCYo6J0a0pyU+/gmP7Pqh1AYmWRcQSmovWtUPaD4GUHaCmKi
         Rrq7y3xxXWNxZ5Kz1X+xBvF6aO0HDMJIUcLccn0+vdew7nHXMlCbiAA4KRBhpHW9nApZ
         teWrqSrLB9mXRU/NxhUPwv4EY19g+fg/pZNaQL3eZdR5UNEIOxkVSMszEQiUXVB/oXYW
         zMOcqldbEwvHHUuZZmHiaZG3itsd4+ljcW2R9Ax/FzUJfAjYQ2zUxCv3zkOoLO4p1tef
         ipmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHzp2+GV/AqQgGd7j6DHOFzgrKyI2+uigVLr3Tb+lv2uxubvilAxMhjkXX6fXT85WQXzHlLkKdbBiHoIjRyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXsMeDEUi0V+x/rqesF7cVIYFCGlxxhfgpH4uOK5pKLDvKXMD4
	bCt+wJ/0K+zUl3EpvC3jNRLc2a457QyYOC3OLv2AX9MNzGdGlcDVvaxNiHvr3EyiQZdwdhONdLR
	fCBziM9lo//pPpuTkYJLCIi2X3YZRtVmkMTVPGL6ktX4JUv59lfNyMUc3Vv/PQPcb
X-Received: by 2002:a17:907:74d:b0:a9a:1792:f05 with SMTP id a640c23a62f3a-a9e3a620de8mr312284966b.31.1730287710787;
        Wed, 30 Oct 2024 04:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEypW41JHp9s0QMpUNgIGz0rguEz+SlI+R6m1S08Xc0YathnVPUssPJwfq+JcR1+Av7QYJ0Ag==
X-Received: by 2002:a17:907:74d:b0:a9a:1792:f05 with SMTP id a640c23a62f3a-a9e3a620de8mr312277366b.31.1730287710210;
        Wed, 30 Oct 2024 04:28:30 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3db7:f800:98bb:372a:45f9:41e4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b30f58991sm557324566b.159.2024.10.30.04.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:28:29 -0700 (PDT)
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
	Philipp Stanner <pstanner@redhat.com>,
	Jie Wang <jie.wang@intel.com>,
	Michal Witwicki <michal.witwicki@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>,
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
	linux-sound@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v6 09/10] ALSA: korg1212: Replace deprecated PCI functions
Date: Wed, 30 Oct 2024 12:27:42 +0100
Message-ID: <20241030112743.104395-10-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030112743.104395-1-pstanner@redhat.com>
References: <20241030112743.104395-1-pstanner@redhat.com>
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
index e62fb1ad6d77..49b71082c485 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -2108,7 +2108,7 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci)
         for (i=0; i<kAudioChannels; i++)
                 korg1212->volumePhase[i] = 0;
 
-	err = pcim_iomap_regions_request_all(pci, 1 << 0, "korg1212");
+	err = pcim_request_all_regions(pci, "korg1212");
 	if (err < 0)
 		return err;
 
@@ -2130,7 +2130,9 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci)
 		   korg1212->iomem2, iomem2_size,
 		   stateName[korg1212->cardState]);
 
-	korg1212->iobase = pcim_iomap_table(pci)[0];
+	korg1212->iobase = pcim_iomap(pci, 0, 0);
+	if (!korg1212->iobase)
+		return -ENOMEM;
 
 	err = devm_request_irq(&pci->dev, pci->irq, snd_korg1212_interrupt,
                           IRQF_SHARED,
-- 
2.47.0


