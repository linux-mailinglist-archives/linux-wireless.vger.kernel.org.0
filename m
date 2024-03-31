Return-Path: <linux-wireless+bounces-5662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E245A8930AA
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Mar 2024 10:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921DD2822CA
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Mar 2024 08:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16635145B0F;
	Sun, 31 Mar 2024 08:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HGDOQtxT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63B974BF4
	for <linux-wireless@vger.kernel.org>; Sun, 31 Mar 2024 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711874761; cv=none; b=BjGuDNx5YNzF5Z38aUOH05xYT1K6mnbO4+ITUo67vzS4cuMKCDyzPTTVWvSUWgoXy9qMHKyugjUd4zIey9c+reGr7ssXm1BaTXsjUq9rukQV3ZVkQKwuMktl82okb20s8LCZ1ML/vZ+UPfpZjx1FxsL61R/G0bVZUmUYUqinbWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711874761; c=relaxed/simple;
	bh=5dl9NHTh9y5H4tCny8ybMFxMPRLUrKfowCNkKiS6mRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M957j9yCqHm9TimuTVNpFAo8VZ3qTaIc90i+SsPY3G5XKxFqrypAukoWUcMF8X0ToIrbSCbnQTVFYoxwKVt/Tc6SbqecaFK8IA34ep7Yi31kbeITgLGrdHD4lA1J4lXNMmc8LO6aggNdt2v1eqZNyLpO2Yt9+hCEAxUurm1xXOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HGDOQtxT; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33ff53528ceso2327797f8f.0
        for <linux-wireless@vger.kernel.org>; Sun, 31 Mar 2024 01:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711874755; x=1712479555; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7ekE7D2gd0aNFp79HNvxaXJwfCkZ3wIe32KjT1nW5Q=;
        b=HGDOQtxTFMNQhnWkkgWgbyMUuetBrEM2YSyKaUQmbMlEQEboVuTVdC3p5J62ZKgsxS
         i07TyuC/1EUqyB/xwYLhZC95YGq95pKCzA8R+Cy6X8Ptq14zXSOuYZcY3O/eTYj8Gy+i
         QIXlSQvWbAslAVnTe8+JqIEjZiQ6Cndmrj2DZAptBRONvS2yJUsbCNyhSdt6SzNl+qhw
         vUvrgjVE74yPkrkcsnKLvMJhJN3gPSe9W3CYMiFlvrPV6CEQ+6XVP6ZJMSvBT6rOHbjw
         wx3uD3jiLRA2jTX/RB4hDWg9r90KX6zKMSF1MDS/2/htGeJaTebXtQu61KbraKoDTWD+
         DWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711874755; x=1712479555;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7ekE7D2gd0aNFp79HNvxaXJwfCkZ3wIe32KjT1nW5Q=;
        b=dsWY/M76Z7xcRYeSuY33UDJdWMyTJXbDf/EFkIgiU7JBOZLkil9GUlKAZZyPoIOaul
         iBj68pohkA+UxjdNHH5ezJUrWveeNuyw+OBMYLrKjN23RmHDCo+UBBUEMh9nAUNtOe8w
         QJRNGtWFMwts4Q11P+Ic1OL8f1RQcnmuPm91ko8JFaq8HHxcfWR/PI7qemEEkY7Bp/kh
         VPCj3/3wMci71nUiD1STxsniIfKd0p1egGShYEaesQ82ExLRSrrHgb5YnFO5Jxnpg9yo
         HCL1D8uTP9hKSKIsXXsUB96R6CMOkTaSo4ri9nnIpf0fNasEz/sR3Ay123a6KMLCaOJW
         lYLA==
X-Forwarded-Encrypted: i=1; AJvYcCV7jqbR7EQDUt4WgfSOmbM3Z1T/AYsNhzpXLS9Yimxv9xHlLuXmm9bvGTubPSD1Dh7LOdazdW+KOd8aEg5hwQmaDILTCjrRlyrO+vViysU=
X-Gm-Message-State: AOJu0YwQOtfU2hOsM8slYqkpzvc1Sks0+FdQ8MB2Pjhs0pFxBAuha2/K
	hGXlRT0OSF1TF+kZ8jYfQm374NR+m/CdhUxorQ6He0/buFlhVScmsRzyrJYazktfbObm7w0/8dR
	E
X-Google-Smtp-Source: AGHT+IHY4jvw69go4YrexvUO+g7bpZX2iGHLXVofTcCejYK0NsEIJ6fVRrU+mpuH9SmiUHUnya0lAg==
X-Received: by 2002:adf:f9d0:0:b0:33e:c7e3:b1bb with SMTP id w16-20020adff9d0000000b0033ec7e3b1bbmr3804378wrr.16.1711874755569;
        Sun, 31 Mar 2024 01:45:55 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm8436003wrp.77.2024.03.31.01.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 01:45:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 31 Mar 2024 10:44:06 +0200
Subject: [PATCH v2 19/25] vsock/virtio: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-module-owner-virtio-v2-19-98f04bfaf46a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=830;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=5dl9NHTh9y5H4tCny8ybMFxMPRLUrKfowCNkKiS6mRo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCSJgfo8D9Iywb3YbbB+haseiaS7hwl8I7GNnU
 gN5S8CUSaWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgkiYAAKCRDBN2bmhouD
 1ynHD/kB086VP7zwkINBMOuLtMvEWc+ntX9e3b9T60ArHB1XFORqGA9Cfk/X4Xd8lg3xRFyt0I3
 3DbMVZgjLetwapU5SywzAZRv+sQhJvRCGiT4R53cOj9D3+CVWiLMFHPzeNl+J8UTiR8zO1OydZD
 iX1ZEV/aX17efMwK2c6sW6DfCy0XdEClWLFaoNhT0vwGEqu/gl1hAZaA6GLpAfitOT2zrJNaUA8
 c8Fy18ZJGcFiwIpFKEcpVCE82fSv2Q3v1gf1KYKTDlJBhFFceaiYD28j0IbBjDRoZTx0XQg5Cv/
 yd4PXc2kASxcUzl8yI8ov0t21VLGjBI+QFGY8psfuZT3rIBPZF1VenQ4dbTErDZb3xWhUt4tBGK
 RU2sIzcU+Hqerfkd6YHjV4ti4LHUfRPORFtg788xKx44NrBoJ9r2GLPab7JSZL7AjZAYOUNx4Op
 iNXSZPULjqG3zZg3AZ+NILd9u/zAp6t1r5eEiBusCKGguYyEIrbQutmNIsSIqWgNGKZ25X0Ypee
 7517fTJGgJcLSYgVKO0zgJh4z1Lq1YAom+EGc8WFF5dd5CZ03p5iQjDdpmNvBoOqDp/ENFLzcx0
 g7/yuB9kIHOthzTRKAJkMdEidrBMPLnZhJjq4SnNTzXiDHmR5nysZ2gzxLzE1GW0iIr1wY5bfZL
 7noJDUdPEH4jNfQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Depends on the first patch.
---
 net/vmw_vsock/virtio_transport.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 1748268e0694..13f42a62b034 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -858,7 +858,6 @@ static struct virtio_driver virtio_vsock_driver = {
 	.feature_table = features,
 	.feature_table_size = ARRAY_SIZE(features),
 	.driver.name = KBUILD_MODNAME,
-	.driver.owner = THIS_MODULE,
 	.id_table = id_table,
 	.probe = virtio_vsock_probe,
 	.remove = virtio_vsock_remove,

-- 
2.34.1


