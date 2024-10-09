Return-Path: <linux-wireless+bounces-13791-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 018FF996366
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 10:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B831C2399E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2895199246;
	Wed,  9 Oct 2024 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EieKqTAk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE8C18E75A
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463094; cv=none; b=VhvOAxAYF3u5UNjmdrI7NY5YGXG0tPvc+8MS3OSjawB5Dti9YBe4a7pVEIsyA1CmryICCuWmawWLUuFrMjZd1i8qHKLdbR3j7PsrEYhdOueRIhO9PrAMblvMsDX69fUHq0z+nKmdnRbRF5/nTE92ob4zvyc4HfeyVE8jtsCoojY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463094; c=relaxed/simple;
	bh=WtIqqb3Qz76cjqi0EoDty0yZzRmnvQrkK4n/LtQ6xEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UI+f5dmY0z1eS8n/18ZhL/T27qIXipBh7z9BdSdSbNl/HpEPVBGzHIm7b784CiR8giOxvfNbvFB5+7hHVQubG3YOqoUbnBoqvxupJcP0IQZS0OkDDg+jiUh0+lLMYGE3GJfIMte/SvJuipaOzks+LpOyB++ND0oaFyI0PmV0/Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EieKqTAk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728463092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whIiuNRJJmYlfQ3wiaGZ/HmATem6GNPoxo7pUmmbAqQ=;
	b=EieKqTAkrDo0LDV1F9bo1DPI8UsrfVuin/ZUB2iLfRFIID7Vqf0qKIRCx9Ro9vLkqx4siO
	f2vW2uRdbADcuQDmlOFpcUQeeqs+wKDj/K7Efzmj1qK20EnomDaB4UE5bzPFkaclsi46kc
	rgvlMyoN/aqyg0vnD7vpClmifJH5SyU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-3lQ3TGaxMOi73J4H06OWiQ-1; Wed, 09 Oct 2024 04:38:11 -0400
X-MC-Unique: 3lQ3TGaxMOi73J4H06OWiQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7ae48475234so1704794685a.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Oct 2024 01:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728463090; x=1729067890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whIiuNRJJmYlfQ3wiaGZ/HmATem6GNPoxo7pUmmbAqQ=;
        b=ktCaJspi59psl0/S1TxFRWcfZ+sNQ9RgEZmp153Euwta/sLGgoMEWYwHS4OPQ4023K
         h8BmVXfiuZ//9P5eR/bggXiHLlk4BSBRpPdAfdrLIx4870Mg5HJzExw3tJDBUb4weXtI
         EGECZVhR4niVkfqge0XPbw6sSddd4thcx4eVD4GFgocgHwnUJZNbDGtvixWJOUqzDP2J
         8eCxwSNCpaPtwGSeDW2aoC8quCEBFqBSm8vStvFIZDg8zKw2Bd1gebO78+OKhO12Atfb
         PcmzmsgzUD4oZxF4iIrUr5zmhwbaUH32VIhkgVwM1ZF4lD3BfWjWEqXbworW3VbB0Xok
         7JdA==
X-Forwarded-Encrypted: i=1; AJvYcCVC/siPt/Jmsj2MRAMObsoZiKY4/SoSrgMJbwvaS8KV3lhEzl/EIVjgNAtyOZe0OQtXg7u/zNwvzaJWBVp1dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmOQ0gX14fzzqhSSYBMxVtT6d6Pg4K3bx8aZEoTIDw4gqFM5lV
	QR3RW+GAQinLPAKG9A+m7E02THpVsJUMWUTr0WVp52Thqz+H2s6LpSifeNJ+3Wra/cd45v7TvYV
	SlGkBQHJcb48syCWkk1CKM3HDzHeSBUuaHCqnNRySR7Q4dbev91868u7JW1ClDzAI
X-Received: by 2002:a05:620a:6006:b0:7a9:ab72:7374 with SMTP id af79cd13be357-7b10ed4fff8mr102279085a.35.1728463090665;
        Wed, 09 Oct 2024 01:38:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/MgCEUv0CJEAIc6rr0qvcu86NTMXEfUgLL+h2hiKBHzQb8C5W8ydxW51ghGpiTPgzdZQtmw==
X-Received: by 2002:a05:620a:6006:b0:7a9:ab72:7374 with SMTP id af79cd13be357-7b10ed4fff8mr102275485a.35.1728463090297;
        Wed, 09 Oct 2024 01:38:10 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75615aa2sm439643585a.14.2024.10.09.01.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:38:10 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Dubov <oakad@yahoo.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rasesh Mody <rmody@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Igor Mitsyanko <imitsyanko@quantenna.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Soumya Negi <soumya.negi97@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Christian Brauner <brauner@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Ye Bin <yebin10@huawei.com>,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Marc Zyngier <maz@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-staging@lists.linux.dev,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-sound@vger.kernel.org
Subject: [RFC PATCH 10/13] staging: rts5280: Use always-managed version of pci_intx()
Date: Wed,  9 Oct 2024 10:35:16 +0200
Message-ID: <20241009083519.10088-11-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241009083519.10088-1-pstanner@redhat.com>
References: <20241009083519.10088-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_intx() is a hybrid function which can sometimes be managed through
devres. To remove this hybrid nature from pci_intx(), it is necessary to
port users to either an always-managed or a never-managed version.

rts5208 enables its PCI-Device with pcim_enable_device(). Thus, it needs the
always-managed version.

Replace pci_intx() with pcim_intx().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/staging/rts5208/rtsx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index c4f54c311d05..4831eb035bf7 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -246,7 +246,7 @@ static int rtsx_acquire_irq(struct rtsx_dev *dev)
 	}
 
 	dev->irq = dev->pci->irq;
-	pci_intx(dev->pci, !chip->msi_en);
+	pcim_intx(dev->pci, !chip->msi_en);
 
 	return 0;
 }
-- 
2.46.1


