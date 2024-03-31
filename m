Return-Path: <linux-wireless+bounces-5664-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 881E18930C4
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Mar 2024 11:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0022826C7
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Mar 2024 09:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177B5146D4C;
	Sun, 31 Mar 2024 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eKn0UBLP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAD481211
	for <linux-wireless@vger.kernel.org>; Sun, 31 Mar 2024 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711874770; cv=none; b=G2iiFk7iJTA3+yeOZlwpfK0JSlR6uOGwxkEcqcTw0T2L1xpwOPjTcAliQRfBk1X3CELggh126b5POErWmtOgFxaZ6lGN0cdwTGXXsAZYb+CwwnmYkn34Hv3pvkNlqI2GOhpnIGCq4k0c9IPeiTZ6B89F4LOrExer9Po5hhnH5wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711874770; c=relaxed/simple;
	bh=djiFy5u3KBh7sxz0UqH9tQzKO6FqFPG/J3nA2oWVUvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EMxOkyemEDzqN7WzYJEx7GZdxDnOkKeBxRVDJ/veZ098EEaLtXRpREGawlBZHbv7qmnDIaqW2aI8tU/r+6OUV2HSGBIhj69jqygawbimJJxuJj6wV9tZF1cKZzVnaVdJ8xw7RrGdafh9JX937767vI5WoVoj/cbR654SI8cTTLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eKn0UBLP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso1561311f8f.0
        for <linux-wireless@vger.kernel.org>; Sun, 31 Mar 2024 01:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711874765; x=1712479565; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynnKTjrcpie+nYJ7zJCc1O/bqKJjh6+n6bK0J+8BU9g=;
        b=eKn0UBLPfWs3/FCQwlmpwniiztBjeVdAShWQwH6W9vnKYQk7grjxmt538jyg83x3zY
         E2R4a14910zg0WKlaFgrzZPIhkRamYkdGo14QN85dM3/bvic5jLaQlSkB2q78wEs9WOE
         3gWACJvKc0GBK6KJhoMTY4MD7wpNMd0Q8zyNh52h6zQ6JxrVFDZAVcAY8c5BXEPgKvcI
         gQxpO00Xf9K1AZdZ0jJwVfLskr0Z6xhf2xRF9tFbGOcub6Kur5rKsx5287ZiUrb62M4S
         Rbf7BvcP9t+NTnh4+jIWJLu8W3jxTvX1bfRCODKRJnmSb8JiD8BQNDIpgI5n4pKuiET2
         1bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711874765; x=1712479565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynnKTjrcpie+nYJ7zJCc1O/bqKJjh6+n6bK0J+8BU9g=;
        b=Fc5urla0OUzrQDnZVWZiYVGehMvEGYB6ZSQHWRHughx++BUxAPF+uMUWTvfFM357RX
         upBClFCk9FDydfNy9bjAPj9C8XBCPKXXkpUNr+Wyke4ortDbkBQ7kKOwcE72pcoK+bU5
         qULc+fMivfRwB/T9JfiV/Eiq6IC3l9JCr3uRLG/8Ox8fwAwBKZn8tsnhyHIfy3Owet2J
         lLOT8PPSZyLIFNjyp4PkRoARvnktr9qA4t+litv9MtAT+l0EG5xIZPpnzHbuIx3MvqvJ
         uoEV6u3PlyY5iVZi/IE8+qkubLLFvZlwZPDBoFy7DjFUIAOxfJThLIi/PpuYofKJp2op
         wkjw==
X-Forwarded-Encrypted: i=1; AJvYcCX/8mecbNzynJV0ZMj3PV+L2VulzuXVREYlvxVBbqyR2RiYn6c9BqcreOEtqVZ/An2H5hQlQUDnpzLzP3gOQ94VX7Kftw9D5/YMMPrU0Qk=
X-Gm-Message-State: AOJu0Yx3ZZDte9YAVZ7voQ3D/Dr4HR5Ybn9CTZDuLRX0f/cb78rrzxY2
	CRaycPgNd57Mfp1aB0XWAIOUbOL2jIvuY0l0kB2KIWF7R1D1Ch6TapcvbwXuEn7Ra40Wimkm/88
	w
X-Google-Smtp-Source: AGHT+IE9HCbYqXr10WjNVCL6+bCwlLWbV/NMZIwtw1PAsCjjTRvMs1pGxGA/oXfJxTVFO3HnB1qqrw==
X-Received: by 2002:a05:6000:18a1:b0:341:e1b1:a5b5 with SMTP id b1-20020a05600018a100b00341e1b1a5b5mr6504132wri.13.1711874764733;
        Sun, 31 Mar 2024 01:46:04 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm8436003wrp.77.2024.03.31.01.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 01:46:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 31 Mar 2024 10:44:08 +0200
Subject: [PATCH v2 21/25] nvdimm: virtio_pmem: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-module-owner-virtio-v2-21-98f04bfaf46a@linaro.org>
References: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
In-Reply-To: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>, 
 David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Jens Axboe <axboe@kernel.dk>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Amit Shah <amit@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Gonglei <arei.gonglei@huawei.com>, "David S. Miller" <davem@davemloft.net>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Alexander Graf <graf@amazon.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>, 
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: virtualization@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, v9fs@lists.linux.dev, 
 kvm@vger.kernel.org, linux-wireless@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=811;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=djiFy5u3KBh7sxz0UqH9tQzKO6FqFPG/J3nA2oWVUvM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCSJiCUA1oHxtanMlVDa3B0IS2vFZjLtjegvnB
 r2LktHu/TmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgkiYgAKCRDBN2bmhouD
 1+fCD/9rVUL5S9fAYP2Cn2joknxd9GcyxZ1ZcSysBEormmSyzUriEDIqirrsKi680bEbDylBOX9
 x2MmTBvkQvu/rIQaoQX/tKOG7I91b1Vbkk+M/NAsbbgnagkOSShnc3shFsc3rXApauvlxnO1qvb
 z8DY07D/WFV3/ayX9Pc0+PnpUDKtjympuX6u7ZHB4k6EwKFN2I+M+HiqBoPn3/ikV3qi8Pl5ABn
 dVmokdreeUGTxM3sQFHK02cmnhLTPk71xIHNooat+Oh5ZT6rcdAvm0AG4WFUisCpcckAFMO+cX6
 PQoSym3RhOSPNBuSGE69s0aBavxd4IuhZiI4o/Jw+0VdzvVble2tpHu+anv+0Glt6Ng5f1OPaYi
 CXmDxjyV03jkc2tlsgpIdfrBwo4k9U+5eOoACVeHWRlxa6eDLI8ViIyEzujQpnD8ueNX2Q8XFgl
 S2ARJ2DUcykXT3jv1xRLTcRYkjqbSrBQ4N13gZPLY2T8UnZrpAwIylFubiw1Ahd+W3KV1JUzxwL
 vUBVwDlontFEzLJVXp78UAxmuAChFTir9BJsAENfp8Sn6B+wzUxU1X5IwJrmDBoO/JvPuQAW3N1
 eQRSKA5Wuv0EaRhEEMBePFtrM57giBzRXdSf97ZWQDn40PWYCC+66dK7kdUzInryIhsEEMdcmlc
 cYX7/PO50bomQrA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Acked-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Depends on the first patch.
---
 drivers/nvdimm/virtio_pmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index 4ceced5cefcf..c9b97aeabf85 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -151,7 +151,6 @@ static struct virtio_driver virtio_pmem_driver = {
 	.feature_table		= features,
 	.feature_table_size	= ARRAY_SIZE(features),
 	.driver.name		= KBUILD_MODNAME,
-	.driver.owner		= THIS_MODULE,
 	.id_table		= id_table,
 	.validate		= virtio_pmem_validate,
 	.probe			= virtio_pmem_probe,

-- 
2.34.1


