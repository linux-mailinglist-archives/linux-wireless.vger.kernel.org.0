Return-Path: <linux-wireless+bounces-11516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AECCB95440C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 10:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C910B255A3
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 08:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB23B13F441;
	Fri, 16 Aug 2024 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8dHoJEC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD59313E05C
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796602; cv=none; b=gryrsvnFHgGXI+mGxBv5PqNpjdQBmGZg788jf+h0BlY7AbxVHrKYBonq8JNneM5euWWIzGUthZ4+86RvRr+kUPqFQIb+a14ZfWT4hCML1xA0TonfFuPdJNaoRAXNMzYhL3+KjTMFA6PY/Bwy0tbPdfXPYPrRqbcbsceEPzgspU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796602; c=relaxed/simple;
	bh=4A0ETd89A4IfgAb0abySs/aZMqbIWPs9HprUGPN5QFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QV/Ksw+YrekOF8u4f47tImZyq4I8gWKvqdTnWj1Cd3FLi/pkHtZHH3vemsItB0WRYVbTIDhk1EJ1hcOjxe0UA2LLrFBC0MW7V0zKMP3a7lA2IYU7J5DkdOdqKHJtYYgv/61HZB0sisrXFG95HfFC+cBlnLNSe0zE5akYDSu2y4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8dHoJEC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723796599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TrimoxVS1Kj7egtxDkUB7ViRlj0uS++glrAveWNoQyY=;
	b=U8dHoJECwwm+gKRsyEyCry920d56qngyEgf6rE/81PpLTpAveI7nHOZTYg2fcT/3CYN5mN
	1TlLrQEpjY1nLBKq44SVgBPl+hwYwnPZXtL/FaXV+zsw5rRGNQEQf08BEn2Pq8eQdl6H4N
	VEMV1irrGk46eDQWE0lJFxy+NPtMKo8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-ZQLs_1yCOKmn7KzCDOTqoA-1; Fri, 16 Aug 2024 04:23:18 -0400
X-MC-Unique: ZQLs_1yCOKmn7KzCDOTqoA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42809bbece7so3188335e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 01:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796597; x=1724401397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrimoxVS1Kj7egtxDkUB7ViRlj0uS++glrAveWNoQyY=;
        b=ISG2bNklhn682AjBNPyjK6087Vkz8fN4DuhHNz50t/oJx+fuvRKeCD5vAv6HI4tBRp
         NrJvMZGa/AvE/tswR9v78hDBLcKLdddhYPlW3wNGsIPGtWWXmq1CVxC76LGvlyCjCr5o
         OMq0uaRr+TpEjEglq4GORT+FDTTFvGJ9GOwNyQy5bxyCQ0KVYzslbjEznF5k0xFDqA+0
         KwtP9SJ8G7UY6odcNvPw/V9NeWEspYSFnhSUTbJUSeWbgzud+OvXnbhzyK2y0+zpeEa3
         WBVorVHX3PbHe4wR/MBTUkkA7xb2w80D4VBF06n7kuiDnVtyvkvJ2oZmN9/SnZ7XTCWK
         eNDA==
X-Forwarded-Encrypted: i=1; AJvYcCUPgSL0xD2SSWUY9iYGNMx3Gk4E6fRcAAxvd5CG5rq430TDICxV/o5aVl994o5fHgo6J3Fzp7Ueyim7skhdkAGbMWa88BNSyKv9X64SY3U=
X-Gm-Message-State: AOJu0Yw5H2E3FymvU+BfzzsXnfTXBxcld9M+EWn1OXNU5s10NmnPvLsE
	nJIEmdtiBXrhKPHvyCDy40ICeG2J3p2UofXOA6DJz+VPEA3SUuN3HFyy4FcMQKEI9TWEmbaGA7C
	AsPQCRI23siB8Fm9LV80K7+8GmOkQ2+jrnu0hTA/cQ8actTVo8jIetSTPqwbKX1Cn
X-Received: by 2002:a05:600c:3ba3:b0:426:5f08:542b with SMTP id 5b1f17b1804b1-429ed630745mr8194225e9.0.1723796597041;
        Fri, 16 Aug 2024 01:23:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv8X8ePSzchNamGEsYdfB/6Vd1EEN507cd6x8fbad0HupSX3+xiP7ZxfNzBVa2X9ALcjUjSQ==
X-Received: by 2002:a05:600c:3ba3:b0:426:5f08:542b with SMTP id 5b1f17b1804b1-429ed630745mr8193805e9.0.1723796596484;
        Fri, 16 Aug 2024 01:23:16 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded367ebsm71461355e9.25.2024.08.16.01.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:23:16 -0700 (PDT)
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
Subject: [PATCH v3 00/10] Remove pcim_iomap_regions_request_all()
Date: Fri, 16 Aug 2024 10:22:52 +0200
Message-ID: <20240816082304.14115-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I removed a ton of people from CC and only kept those who's approval is
pending.


Changes in v3:
  - Add missing full stops to commit messages (Andy).

Changes in v2:
  - Fix a bug in patch №4 ("crypto: marvell ...") where an error code
    was not set before printing it. (Me)
  - Apply Damien's Reviewed- / Acked-by to patches 1, 2 and 10. (Damien)
  - Apply Serge's Acked-by to patch №7. (Serge)
  - Apply Jiri's Reviewed-by to patch №8. (Jiri)
  - Apply Takashi Iwai's Reviewed-by to patch №9. (Takashi)


Hi all,

the PCI subsystem is currently working on cleaning up its devres API. To
do so, a few functions will be replaced with better alternatives.

This series removes pcim_iomap_regions_request_all(), which has been
deprecated already, and accordingly replaces the calls to
pcim_iomap_table() (which were only necessary because of
pcim_iomap_regions_request_all() in the first place) with calls to
pcim_iomap().

Would be great if you can take a look whether this behaves as you
intended for your respective component.

Cheers,
Philipp

Philipp Stanner (10):
  PCI: Make pcim_request_all_regions() a public function
  ata: ahci: Replace deprecated PCI functions
  crypto: qat - replace deprecated PCI functions
  crypto: marvell - replace deprecated PCI functions
  intel_th: pci: Replace deprecated PCI functions
  wifi: iwlwifi: replace deprecated PCI functions
  ntb: idt: Replace deprecated PCI functions
  serial: rp2: Replace deprecated PCI functions
  ALSA: korg1212: Replace deprecated PCI functions
  PCI: Remove pcim_iomap_regions_request_all()

 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/ata/acard-ahci.c                      |  6 +-
 drivers/ata/ahci.c                            |  6 +-
 drivers/crypto/intel/qat/qat_420xx/adf_drv.c  | 11 +++-
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c   | 11 +++-
 .../marvell/octeontx2/otx2_cptpf_main.c       | 14 +++--
 .../marvell/octeontx2/otx2_cptvf_main.c       | 13 ++--
 drivers/hwtracing/intel_th/pci.c              |  9 ++-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 16 ++---
 drivers/ntb/hw/idt/ntb_hw_idt.c               | 13 ++--
 drivers/pci/devres.c                          | 59 +------------------
 drivers/tty/serial/rp2.c                      | 12 ++--
 include/linux/pci.h                           |  3 +-
 sound/pci/korg1212/korg1212.c                 |  6 +-
 14 files changed, 76 insertions(+), 104 deletions(-)

-- 
2.46.0


