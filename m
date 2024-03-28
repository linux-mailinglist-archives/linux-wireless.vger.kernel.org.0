Return-Path: <linux-wireless+bounces-5341-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E33D88E775
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 15:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70086B33D14
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 14:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B7814D2BB;
	Wed, 27 Mar 2024 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UY+nkERF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C5314D29B
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543537; cv=none; b=JeqoClR1tgnF4vrarUIFMPAOVLzHYAcajI3YGMYJWKhEGZTjmt3p6WeUeU8+JrDAZ94lFNWZ2WQKNLFJFTnEArbpLxcLUQgh/6R5HUOemZCOF70t2GhZR/u1BBk21SvROPUU4IPbSYP04UBf3bTYccNfZRQzc6rQ9FJ9ETgb9yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543537; c=relaxed/simple;
	bh=jCwmMevYkV3Lqd1Wbq1GxwStD6bPo7hGezrcOjB2c0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=luzSFvWV+XcvczWyTJ0X870ggO/gGLdtQUDTUXsCz6SuU+PJpiAbn7SO8PeL6MIhgDxkns+WVBCSPuL/k8KhCWdvqI0ohmBSyzk1h7nxt+PCZVIaH2lX97i78aOzyQTMiAqrdXL9/aIeE2l1QiRkjQEH7QhYkmgyxfHNioeIPMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UY+nkERF; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so882704766b.0
        for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 05:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711543533; x=1712148333; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=No4VShp4MNQIo4/ZHdyujXMPexV2jpx81+F0aVzAh9c=;
        b=UY+nkERFr/YlW+5xVV53crYMg/3iD1rZgyYlGBroGnN9DKN1IiDs1quLsjbg8TsRLc
         0z7atrPbRb8Y525lo/dgcKuAi91jTeXurTkYbCyXnqbptYbXwdCabn9HAA4rlX+8NiA4
         FoylyfGjlEgDDS8lQ/AD5hI1mMjTelVxIEZTfBuYZVt/mFEtWPebI4gCHIvjoXJS1UIT
         nadzHxn7SEyqo1xiJhu+6XVvgZtKeMC1ldwFOjrLzYOACjoYGGssFUBTO3zyQcoYB/ee
         ZC+7ddY8nx6WkMjsPtkiVputOn7zaBFTh/oAh+cI0DdKU6tACmIjXe9PXybxtOVpjdO7
         ZAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543533; x=1712148333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=No4VShp4MNQIo4/ZHdyujXMPexV2jpx81+F0aVzAh9c=;
        b=nDVnaaOI8t7B+4+EjeAzMngCrfdoOURMYdc6omFrC3LrdFgNbbhpnLh37teNU7zCz8
         hPR0LIGUNU1QEhtHB8MU0J2TVtWUndT4qTReoSxS+d2A3UzR1ZlZF+co584WA4LdVmoh
         Elbvst969v1jp/y4wN+OnffoCq/qmv/4v3oDHVwTSIHhQWPHCxexhUwhwRUfbugPRv5p
         HzbkZexgXp7gplyRQMvZsg1fJHstC9suYddYMzENg5cnw6IRcExjmu5gbnCXqqDzmWqF
         PdejvBe+T8ztK50xiutejGQLABGgRyPTSgLsI1TBaKWrgwQXnRCsk0HmL3ngfZQwJXJR
         1LzA==
X-Forwarded-Encrypted: i=1; AJvYcCV+SDO9+aDkpFa0i3V/v+AaL289GVGU3qVbpxTuRGBAjT3ug8UmxOeQTH/n5SgH7FOP6XhYZGicmuwY4CHkCRoiUQhROx428E2lUdg2Wfw=
X-Gm-Message-State: AOJu0YzV2lz9/+2cOu8XwxT2XZf0MOTnx38pWu8hU20w7qrKoH03BbZL
	dRL6SxWsjRWzZO2Mwji1mhRvtRSp4403iJwIlbvscuICRMZlgnKN8nm9SRXAhfw=
X-Google-Smtp-Source: AGHT+IGcHd2qY7ZBro2wyisxjF8vmsU4S1L2u/P0SqS5KVxX0CKJYhU9jvIT/xpw11DDb5r10WYfVA==
X-Received: by 2002:a17:906:f2d3:b0:a47:35e5:7da0 with SMTP id gz19-20020a170906f2d300b00a4735e57da0mr825525ejb.41.1711543532979;
        Wed, 27 Mar 2024 05:45:32 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id gx16-20020a170906f1d000b00a4707ec7c34sm5379175ejb.166.2024.03.27.05.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:45:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 13:41:04 +0100
Subject: [PATCH 11/22] iommu: virtio: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-virtio-v1-11-0feffab77d99@linaro.org>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
In-Reply-To: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Richard Weinberger <richard@nod.at>, 
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
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=741;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=jCwmMevYkV3Lqd1Wbq1GxwStD6bPo7hGezrcOjB2c0A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBBPjcRuWcdv+n/Al0ahdDHsSs8WafHdIUlLGa
 Dnt3fJtJ9GJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgQT4wAKCRDBN2bmhouD
 18avD/9TrqZBBr4oeroLUMQVYofN5TjAKsnyKZWl94vQ0iYfSWHuOlNDOTMSN2Dt08NBk9v0Xs9
 eUeYmPAYKRPRGkVuIDT6wOGW74KIxf5Mzb+3Ds4U2QrJRdXG8f/ICyRsRD1pHENt8cK7rI+E6zd
 umkuE/KYrQKTdXb4i5CHK+4jJ+DeoSIswuO/54AUq+E3pgGpFpdxxhj3208Hfz7tvnh9pgJmVh6
 zMv18OlPg2XfxZF78f5CFbftrBco7QM6ZHNrOk4RVql8QzSC7xQUjkGRYbxSF9HZVWgRUQh2WXF
 xxDK7TkVVSHfRKctSH//72hik+jo9foWddmeNbFaTrbXNjnnfnMRGMsnzz2EPFrHjDeT61LqF0T
 u8SNrNOpi53cLv3XWw09T4PdY+XEqvqtEOvJNJ8yEihBPgdwlfuUFeotY8G4XEtfN9ajZcjpkdP
 F6UV6cNFIDph+aGoj6T5rloUw8mjhJCO8p2f/T4HHgOs9RkcoLnb4zY9lprMxc6PMlT2fC/AaSB
 JwlRKgB9FMrOWfSuB5JVqDAZUUoNi3ycrmnq6XQAxs+QanigRO2orLbBXUxhmwRrcORCAXzAY/m
 L00b+Gn5jqZIFKGhzVfYaO/NbGgHZGtdQ9ZEg14BZW6tIdbpC/y2F8V6vq4H0WyOMH7b1wZ8HiD
 Mj246oViTtDiKNw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/iommu/virtio-iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 04048f64a2c0..9ed8958a42bf 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1261,7 +1261,6 @@ MODULE_DEVICE_TABLE(virtio, id_table);
 
 static struct virtio_driver virtio_iommu_drv = {
 	.driver.name		= KBUILD_MODNAME,
-	.driver.owner		= THIS_MODULE,
 	.id_table		= id_table,
 	.feature_table		= features,
 	.feature_table_size	= ARRAY_SIZE(features),

-- 
2.34.1


