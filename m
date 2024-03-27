Return-Path: <linux-wireless+bounces-5329-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA7988E4C7
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 15:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 590262A4D48
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 14:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC290145322;
	Wed, 27 Mar 2024 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YmjO+wGu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD59144D3A
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543304; cv=none; b=lbkg3HlZsXre/JUDvovh7j5Pxu7hAgYfPV2/rHF4H+6tR3GAaMHImmIe18sywUPzYjbQQs/v33yKS+UfmPKOBojWYMzxwvzeuhnvioWcYGvovIg+hkqjpR20lIVaxLBHJIsIinKcvnnjpeXZQh1xFIF6UugQY2sAv7BvjMFDsOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543304; c=relaxed/simple;
	bh=ZqxqBePx9O0aSeYwWfac5JC18N8WH4wazKZPUDWtyb4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lZJ08Q6cylKf3TdKYRE/sOgwZKQIphNw3Mk6J9MCVhOvekZl7c3pw3y5Y4hCQL5BPSU1b+t+Ve9nVpECSyXnN4sgSKp3k1BFg3g3tf6jQFRTpoHappL5pEbNSAtMF2aHinBZajJwCEIeR6l2iJFzxxW6lUhAlfjdbkyzpdknbAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YmjO+wGu; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d485886545so116599411fa.2
        for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711543298; x=1712148098; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AFaFw1OZuXizkw4uNoNpzMqxfCxSvA28jWrn6rdqU5M=;
        b=YmjO+wGuctwvzU8ZNUZDLFidgP/qW/gIe+e/+u4PRXpt9aiaCueYVHxxQlnquEf7wo
         6MyMimKon6o+3zr83QHAolDCtbiRJMHQv0jm8UKyy8FzdMI/X3wY0G/Hz3/vV0CzydiL
         yWCuUl8kd9sCC8Ij7Bol3c8a1BC7xup4GJ32Z0UBIfzqzoS1GOAtXwMC0UYO/LLSI6iK
         RvtDXOXNSC/Fe8BGekmHqP/S7ATCiIzBkHVqGsLX3qejNAy2BJ/wPs4Hiu1C6o67xezY
         xW0UY+GJG8n23TR5q8R6KRDFbbgl11ZZg/l7GMMAsdIIFzQci+jZohdP7rpB6CULoHWT
         TP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543298; x=1712148098;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFaFw1OZuXizkw4uNoNpzMqxfCxSvA28jWrn6rdqU5M=;
        b=I7FzU5UrNUY/61htZxZsNdlCxyvmIbYDfE8kXR1q/ljD6EDguno162qaPouGuxBhbU
         EZ2p3jDAzED/TxFpVCYwa6cTpQhFkn2R2rotIzFceRuhUCgJBIq6T7uX9Ru4iqD98kIe
         lJ6+YDVCzE9t8eNrHCVmj52Jh0XZeDhTKzTq+BX7w9gpz2G3ASFnOOv3bnV60oVBSa53
         oAhoPPWobOTZ7gtwAd4BLmTKTmoWbij/yuA4w5K+zq0jQILLuL6kZwt9FMBS/Xkg/jY0
         Y4QiZhgCAxlv2cZtzi8mDZhhsFftMIKCcWzzfqded6JOSQoam1fEqU2aQUD9biHRzOb3
         c8cQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3JKt0ogGBz70x9aoQ6AFmCglQlV8KRUJ+dFWc6/jn2e5VUvOX3WtYIZ0WpZLGFn3xdJBy6tr0x5t610UgI5sIeRVjPNsQw3uxW+RHPAM=
X-Gm-Message-State: AOJu0YwvxU1MTpb20GVcM7YpRYgHo0w1oQScxBXMzC1Y71nojBqlFZYa
	HHqcna1zJh/fCv8iW9hvT8gbF1d5C/9TVpGR+6PpES9hJFVvvhGw7q/k4vOFoLU=
X-Google-Smtp-Source: AGHT+IFS1x7gpjA7jUKSh2w40PflGxs4LWIU8D0QvTuDe3IphcKfLGKJ6nGMGd9SaTSRJh693GFsRg==
X-Received: by 2002:a2e:3a1a:0:b0:2d6:e148:2463 with SMTP id h26-20020a2e3a1a000000b002d6e1482463mr2074785lja.24.1711543298562;
        Wed, 27 Mar 2024 05:41:38 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id gx16-20020a170906f1d000b00a4707ec7c34sm5379175ejb.166.2024.03.27.05.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:41:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/22] virtio: store owner from modules with
 register_virtio_driver()
Date: Wed, 27 Mar 2024 13:40:53 +0100
Message-Id: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANUTBGYC/x3MSQqAMAxA0atI1gY0dQCvIi4coga0ldQJxLtbX
 L7F/w94VmEPVfSA8ilenA1I4wj6ubUTowzBQAlliaESVzccC6O7LCueors4zLOiLExn+pYIQrk
 pj3L/17p53w9578lCZQAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3506;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ZqxqBePx9O0aSeYwWfac5JC18N8WH4wazKZPUDWtyb4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBBPZS5yGoH1UVP3T0Npm8blJRoVKIHSae5kBq
 HxYGiIbwMaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgQT2QAKCRDBN2bmhouD
 12zhD/9C6ukv+8iXJ63iu65KAxWO0209no/Zk8V5PPOIg8YWF23fhUh5Tg2IbxFs1SDSIqOKCGf
 078xrARdl7OLN91lsOjjrbjnZZrO+3UXwHxBg6rRfwtkp+kgAzLzR84hoSWqyqlq+JpiqE73Ex1
 fNyOEu1Il2sVbtLvNN9ZvBBGDNN/h7JC9ywVxJ0Fa0LD8kwtsV8pUIgsVva8ILQKkMQBTP09QPM
 7DW97OEmYao/IN0z9JQ8xmwCXf08ciDibfQZ884ZF4dVW/paLFkgw4OyR+22WTqneeBTsJKdlH1
 Os9//BH9zlvxyZG6vpAg3g6NvH7MxigyNbztqSw7Uqw1jx1u1032qs/yjWHbs7c4pNm32w5Sc2U
 BWMIQlsiyt2Gg33SxWybhDqMfp72LBlT04SmQHYDlMTlPA4vvgeUK/H/oYmg/uzy5MM/kx9WGtR
 pNCFFDPI2B6EAqAvrzZWEGv2PVNujF5tHSLKVqxYwXHWIDIqg8LnCgQeizyqp/tqjoQFY7vGlzI
 B3wE5riIQuaCN41Id+3PH7pVc6tEQlepaRhz7jRIFh+JEA53CORhQ62m1PpLMq7z8zNhn+Igsh+
 AB69huA3C3eKILpuFw33OXJybFczTX0Vd0F95nDwyWCahIwaUlrRfoO1JQlJFdOgChtyx0ws9Uf
 xOnSxyBfnZ9hbow==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Merging
=======
All further patches depend on the first virtio patch, therefore please ack
and this should go via one tree: virtio?

Description
===========
Modules registering driver with register_virtio_driver() often forget to
set .owner field.

Solve the problem by moving this task away from the drivers to the core
amba bus code, just like we did for platform_driver in commit
9447057eaff8 ("platform_device: use a macro instead of
platform_driver_register").

Best regards,
Krzysztof

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Krzysztof Kozlowski (22):
      virtio: store owner from modules with register_virtio_driver()
      um: virt-pci: drop owner assignment
      virtio_blk: drop owner assignment
      bluetooth: virtio: drop owner assignment
      hwrng: virtio: drop owner assignment
      virtio_console: drop owner assignment
      crypto: virtio - drop owner assignment
      firmware: arm_scmi: virtio: drop owner assignment
      gpio: virtio: drop owner assignment
      drm/virtio: drop owner assignment
      iommu: virtio: drop owner assignment
      misc: nsm: drop owner assignment
      net: caif: virtio: drop owner assignment
      net: virtio: drop owner assignment
      net: 9p: virtio: drop owner assignment
      net: vmw_vsock: virtio: drop owner assignment
      wireless: mac80211_hwsim: drop owner assignment
      nvdimm: virtio_pmem: drop owner assignment
      rpmsg: virtio: drop owner assignment
      scsi: virtio: drop owner assignment
      fuse: virtio: drop owner assignment
      sound: virtio: drop owner assignment

 Documentation/driver-api/virtio/writing_virtio_drivers.rst | 1 -
 arch/um/drivers/virt-pci.c                                 | 1 -
 drivers/block/virtio_blk.c                                 | 1 -
 drivers/bluetooth/virtio_bt.c                              | 1 -
 drivers/char/hw_random/virtio-rng.c                        | 1 -
 drivers/char/virtio_console.c                              | 2 --
 drivers/crypto/virtio/virtio_crypto_core.c                 | 1 -
 drivers/firmware/arm_scmi/virtio.c                         | 1 -
 drivers/gpio/gpio-virtio.c                                 | 1 -
 drivers/gpu/drm/virtio/virtgpu_drv.c                       | 1 -
 drivers/iommu/virtio-iommu.c                               | 1 -
 drivers/misc/nsm.c                                         | 1 -
 drivers/net/caif/caif_virtio.c                             | 1 -
 drivers/net/virtio_net.c                                   | 1 -
 drivers/net/wireless/virtual/mac80211_hwsim.c              | 1 -
 drivers/nvdimm/virtio_pmem.c                               | 1 -
 drivers/rpmsg/virtio_rpmsg_bus.c                           | 1 -
 drivers/scsi/virtio_scsi.c                                 | 1 -
 drivers/virtio/virtio.c                                    | 6 ++++--
 fs/fuse/virtio_fs.c                                        | 1 -
 include/linux/virtio.h                                     | 7 +++++--
 net/9p/trans_virtio.c                                      | 1 -
 net/vmw_vsock/virtio_transport.c                           | 1 -
 sound/virtio/virtio_card.c                                 | 1 -
 24 files changed, 9 insertions(+), 27 deletions(-)
---
base-commit: 7fdcff3312e16ba8d1419f8a18f465c5cc235ecf
change-id: 20240327-module-owner-virtio-546763b3ca22

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


