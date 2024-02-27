Return-Path: <linux-wireless+bounces-4035-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6E88684F3
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 01:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185751C22709
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 00:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D677E36D;
	Tue, 27 Feb 2024 00:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EtbmAdUx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E0B36C
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 00:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708993269; cv=none; b=iWbMVDelyyQ6/nWg+oNN51TGHT1FgO3FQgmy45N/FmP0dqrJlsPyIeyJF01oUzYj4CnvHoQVjZJZKOG8avPMdq5ZPPO7R6GLGYtkPqkImJRmErD27QJ4mXD0FoMPwWMVtDlbxOKPIfH+Q7eOKudEmNo4g4mKWN4RYUaBd1DfIAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708993269; c=relaxed/simple;
	bh=fYTwBpg7uMTawTUnQ2BSWuwAUKm59qg1pIXrtXgXbFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FQ0Sgs/MwLuFpEf6kZv4bMvKrVgxJZ/xKw97ciqzGpflF0oSp0J9gi9+K41xMf6lL/pU1buupQ+0cRnZRwo/44nwFqP7xWkplZsv61ZUcFVQiqjO3KB3FzQvPFeAvKpSNv3v33mSAhEmjiuRWvGSZ0PNhi0oMOjPVcPUt5Q4PqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EtbmAdUx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708993266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=deu2WpFSMCIwa7mbcBS0LlHiNgXZ/4WozKcv0iuRKBQ=;
	b=EtbmAdUx3TLx1uxDIteZl3MX4pjw150lSMFNoxCXZK1a9vZ8bBTG2fFDu9F4/Mfj4q6zcX
	WnuolmZ6gQMGgos5HRGYmgFJ4InES++k36k3DM5J1fuAQ0GdRn7HE6eLNH/KRxtlECAGAQ
	xt/bEpAQLU2W1L9a1pFttnbII1k7DCM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-Zlk-oQ-3NHihdyEn-k_ejQ-1; Mon, 26 Feb 2024 19:21:05 -0500
X-MC-Unique: Zlk-oQ-3NHihdyEn-k_ejQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33dadb50731so1954215f8f.1
        for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 16:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708993263; x=1709598063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=deu2WpFSMCIwa7mbcBS0LlHiNgXZ/4WozKcv0iuRKBQ=;
        b=VJZMAjPBnDuTDSupuemQ1jHMP9eY88NrsG1oyIsuZVFpWHQYgAKielyFr6glx/wWuR
         PB8jQg6HmeqjBMekkpO9J93jn4kfPMc/i2dWgOXe0+0c1dX0RCu5hUsRFKaGecVrF7Nn
         25J8Z9BHapczxcP+r7oplpxqxETa6Sx7tgZUvWycsvkwfoVPH51PECiw6AryLSUFBq1A
         r/SkcmH8U8f6/ToAAMBdZIGZ/1/C8savOiNBL8mVAEDZMzBXbDiwYBT/Yc6+KZXqNhvh
         NJYZm9OQ8K5eOsC+VQX7WjTB6HooE0zAB8O5pQQxxJwrOQpBoyCcRPr7srAWivQO8JOf
         r7bA==
X-Forwarded-Encrypted: i=1; AJvYcCUkfG5//FOKMngAnoU4T3xkpVhbG09rIdgE/I0kaBtGudqNfF+c9CHABCDuO1z7macRimUkkI43lpOv2tHG/KKHn9nn+Yt77InWPcmOkBk=
X-Gm-Message-State: AOJu0Yz1bWWtCOVpD503cj/lgpcD3dHyVB3UJrskCAoxSnF93eBQfYUX
	PswqGBQ/JTf1Y2tU3Wn3XLkvxVdjfYR/Br9Zg+FNLvh6QwvRARhN6aiF4KKbDVhC9pixWg/i0w4
	60c6c4jJzOdWz2kL9843I35AAT4fD7I5qJx5DIOouzNj/zZMlpUvg3XXwR+eL+gNS
X-Received: by 2002:a5d:588b:0:b0:33d:d96b:2615 with SMTP id n11-20020a5d588b000000b0033dd96b2615mr3090208wrf.47.1708993263418;
        Mon, 26 Feb 2024 16:21:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRfO+KR9IwLDp+vA/SLuUUNQWiLiDHzfpZePGawUDhvo/EwptbYbLO0SUGcBbbRPRC2I4yhw==
X-Received: by 2002:a5d:588b:0:b0:33d:d96b:2615 with SMTP id n11-20020a5d588b000000b0033dd96b2615mr3090190wrf.47.1708993263000;
        Mon, 26 Feb 2024 16:21:03 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f1-20020adfe901000000b0033d8b1ace25sm9720705wrm.2.2024.02.26.16.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 16:21:02 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Kalle Valo <kvalo@kernel.org>,
	Li Zetao <lizetao1@huawei.com>,
	linux-wireless@vger.kernel.org
Subject: [PATCH] wlcore: sdio: warn only once for wl12xx_sdio_raw_{read,write}() failures
Date: Tue, 27 Feb 2024 01:20:46 +0100
Message-ID: <20240227002059.379267-1-javierm@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report these failures only once, instead of keep logging the warnings for
the same condition every time that a SDIO read or write is attempted. This
behaviour is spammy and unnecessarily pollutes the kernel log buffer.

For example, on an AM625 BeaglePlay board where accessing a SDIO WiFi chip
fails with an -110 error:

  $ dmesg | grep "sdio write\|read failed (-110)" | wc -l
  39

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/net/wireless/ti/wlcore/sdio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
index eb5482ed76ae..47ecf33a0fbe 100644
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -75,8 +75,8 @@ static int __must_check wl12xx_sdio_raw_read(struct device *child, int addr,
 
 	sdio_release_host(func);
 
-	if (WARN_ON(ret))
-		dev_err(child->parent, "sdio read failed (%d)\n", ret);
+	if (WARN_ON_ONCE(ret))
+		dev_err_once(child->parent, "sdio read failed (%d)\n", ret);
 
 	if (unlikely(dump)) {
 		printk(KERN_DEBUG "wlcore_sdio: READ from 0x%04x\n", addr);
@@ -120,8 +120,8 @@ static int __must_check wl12xx_sdio_raw_write(struct device *child, int addr,
 
 	sdio_release_host(func);
 
-	if (WARN_ON(ret))
-		dev_err(child->parent, "sdio write failed (%d)\n", ret);
+	if (WARN_ON_ONCE(ret))
+		dev_err_once(child->parent, "sdio write failed (%d)\n", ret);
 
 	return ret;
 }
-- 
2.43.0


