Return-Path: <linux-wireless+bounces-37808-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iNfMBwy/L2rPFgUAu9opvQ
	(envelope-from <linux-wireless+bounces-37808-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 10:59:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A0A684D16
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 10:59:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ceMjYg9X;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37808-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37808-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD6993098F1E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 08:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45E63845D3;
	Mon, 15 Jun 2026 08:53:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2B33C4166
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 08:53:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513615; cv=none; b=IdQgw4Xbz/1FvJXM/VT1l8l6Hq/GqWCCjUyNfC863t8nXUxyEUG5yqOXSt290dGxQ50L8JtAnU0kv6j5Ljmh3ceyuemCoVOXo9Tlo9nP6S4Vq68uszmU1CHUti2SNdm7riDyGsQW4ftMeujJ140nriXwRnPD4p+LD0EtsQ2D9d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513615; c=relaxed/simple;
	bh=OWJaDtzTNFfYb4kwUpXR+Lmmv4hbSoZIAP9DfB4Ath4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BY5EDk7BxwmBlr4Lf/HLa2TCH4QmDrPHc+7N719w7V1sObnDvDljYFz1BEkZ1eOoABni6VspiKTghsBz7lfypxqnnJi2PeNiJKgbmWU7MfZp0PWf7UTC/YIiImt9gfSM92xOx+59zU7r5vdpsxosmYA7My/ELiG11BSyByjgP7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceMjYg9X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CB11F0155B
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 08:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781513610;
	bh=wV8yp34yT9DNlfEB0qpaBCoOWBTx/yzawKiLgppkC2U=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=ceMjYg9XMCAJl+VoYZGq13Phe8avRw/gjUvaz5LB9ZxGU1siJJL90WZuJGVb64Qy7
	 M4YuYDXAtbi98hkUXeE1y0udI+SHA6qDUkFdRgylM3ch9syH7mUGh/EvsSqfrcUcd9
	 dZJE8/dwF0dOqR/T3ODzx0srC/bxSvf1DRTCZKeYM80E461rWOlMKjP7vjsOMX4kLq
	 QkyFJo2JCMmF+b0IUmMJ1DVEZ9VtDiRprXNwingigKc7j3CAM67DsRkrhcSkgoJcBX
	 X9pO4nn7e3LZwjyY56hnNQ98AaVoPoRcVUh/xeZ/EKhvl3YTTSwDA+FrsXxkzGC+pW
	 bnWkzmdC6KJGg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3967725a77fso27453101fa.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 01:53:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ99fgPuf8CkPsyuDfHRlHJAahnRJw7W9nlE5ac19t2UhSv2ED+IlWHwI6EgQLmhLe+cWbRlDaKNw1GUg3CvwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8NOLiFNjOdoUMBBx45jkxdYN5+JnobEbs8k6/C3cTE+stp6hQ
	jtUMYfhDEBnLyZkPxsCyhktvyeaFXmdfE+vJ0qcP8N0WKqgtrR/x/sHJTEnYgm7KbeuVwKXZSAL
	cQyl91gDbo4ThkSQmNMmbNJWsFFuQovAhfo71z4rsWg==
X-Received: by 2002:a2e:a80e:0:b0:394:1236:ccb9 with SMTP id
 38308e7fff4ca-3992afa6f0dmr39903161fa.5.1781513609364; Mon, 15 Jun 2026
 01:53:29 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jun 2026 10:53:27 +0200
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jun 2026 10:53:26 +0200
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260612-block-as-nvmem-v5-5-95e0b30fff90@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com> <20260612-block-as-nvmem-v5-5-95e0b30fff90@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 10:53:26 +0200
X-Gmail-Original-Message-ID: <CAMRc=McQkLnz2OS2RREAbcrsp47cL-W3bCduq8LwPBBUcVNyJw@mail.gmail.com>
X-Gm-Features: AVVi8CePDlRvn_yeBo8fPXp3FCAEnmQ_ET92GyWt_9-SxcNPTVPxsiTbCwGweBo
Message-ID: <CAMRc=McQkLnz2OS2RREAbcrsp47cL-W3bCduq8LwPBBUcVNyJw@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] block: implement NVMEM provider
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, daniel@makrotopia.org, Ulf Hansson <ulfh@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saravana Kannan <saravanak@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37808-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:loic.poulain@oss.qualcomm.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,makrotopia.org,kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,config.name:url,qualcomm.com:email,mail.gmail.com:mid,config.id:url,makrotopia.org:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85A0A684D16

On Fri, 12 Jun 2026 15:20:57 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> From: Daniel Golle <daniel@makrotopia.org>
>
> On embedded devices using an eMMC it is common that one or more partitions
> on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPROM
> data. Allow referencing the partition in device tree for the kernel and
> Wi-Fi drivers accessing it via the NVMEM layer.
>
> For now, NVMEM is only registered for the whole disk block device, as the
> OF node is currently only associated to it.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  block/Kconfig             |   9 ++++
>  block/Makefile            |   1 +
>  block/blk-nvmem.c         | 109 ++++++++++++++++++++++++++++++++++++++++++++++
>  block/blk.h               |   8 ++++
>  block/genhd.c             |   4 ++
>  include/linux/blk_types.h |   3 ++
>  include/linux/blkdev.h    |   1 +
>  7 files changed, 135 insertions(+)
>
> diff --git a/block/Kconfig b/block/Kconfig
> index 15027963472d7b40e27b9097a5993c457b5b3054..0b33747e16dc33473683706f75c92bdf8b648f7c 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -209,6 +209,15 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
>  	  by falling back to the kernel crypto API when inline
>  	  encryption hardware is not present.
>
> +config BLK_NVMEM
> +	bool "Block device NVMEM provider"
> +	depends on OF
> +	depends on NVMEM
> +	help
> +	  Allow block devices (or partitions) to act as NVMEM providers,
> +	  typically used with eMMC to store MAC addresses or Wi-Fi
> +	  calibration data on embedded devices.
> +
>  source "block/partitions/Kconfig"
>
>  config BLK_PM
> diff --git a/block/Makefile b/block/Makefile
> index 7dce2e44276c4274c11a0a61121c83d9c43d6e0c..d7ac389e71902bc091a8800ea266190a43b3e63d 100644
> --- a/block/Makefile
> +++ b/block/Makefile
> @@ -36,3 +36,4 @@ obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= blk-crypto.o blk-crypto-profile.o \
>  					   blk-crypto-sysfs.o
>  obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)	+= blk-crypto-fallback.o
>  obj-$(CONFIG_BLOCK_HOLDER_DEPRECATED)	+= holder.o
> +obj-$(CONFIG_BLK_NVMEM)                += blk-nvmem.o
> diff --git a/block/blk-nvmem.c b/block/blk-nvmem.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..c005f059d9fe56242ebaef9905673dff902b5686
> --- /dev/null
> +++ b/block/blk-nvmem.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * block device NVMEM provider
> + *
> + * Copyright (c) 2024 Daniel Golle <daniel@makrotopia.org>
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * Useful on devices using a partition on an eMMC for MAC addresses or
> + * Wi-Fi calibration EEPROM data.
> + */
> +
> +#include <linux/file.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of.h>
> +#include <linux/pagemap.h>
> +#include <linux/property.h>
> +
> +#include "blk.h"
> +
> +static int blk_nvmem_reg_read(void *priv, unsigned int from, void *val, size_t bytes)
> +{
> +	blk_mode_t mode = BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES;
> +	dev_t devt = (dev_t)(uintptr_t)priv;
> +	size_t bytes_left = bytes;
> +	loff_t pos = from;
> +	int ret = 0;
> +
> +	struct file *bdev_file __free(fput) = bdev_file_open_by_dev(devt, mode, priv, NULL);
> +	if (IS_ERR(bdev_file))
> +		return PTR_ERR(bdev_file);
> +
> +	while (bytes_left) {
> +		pgoff_t f_index = pos >> PAGE_SHIFT;
> +		struct folio *folio;
> +		size_t folio_off;
> +		size_t to_read;
> +
> +		folio = read_mapping_folio(bdev_file->f_mapping, f_index, NULL);
> +		if (IS_ERR(folio)) {
> +			ret = PTR_ERR(folio);
> +			break;
> +		}
> +
> +		folio_off = offset_in_folio(folio, pos);
> +		to_read = min(bytes_left, folio_size(folio) - folio_off);
> +		memcpy_from_folio(val, folio, folio_off, to_read);
> +		pos += to_read;
> +		bytes_left -= to_read;
> +		val += to_read;
> +		folio_put(folio);
> +	}
> +
> +	return ret;
> +}
> +
> +void blk_nvmem_add(struct block_device *bdev)
> +{
> +	struct device *dev = &bdev->bd_device;
> +	struct nvmem_config config = {};
> +
> +	/* skip devices which do not have a device tree node */
> +	if (!dev_of_node(dev))
> +		return;
> +
> +	/* skip devices without an nvmem layout defined */
> +	struct device_node *child __free(device_node) =
> +		of_get_child_by_name(dev_of_node(dev), "nvmem-layout");
> +	if (!child)
> +		return;
> +
> +	/*
> +	 * skip block device too large to be represented as NVMEM devices,
> +	 * the NVMEM reg_read callback uses an unsigned int offset
> +	 */
> +	if (bdev_nr_bytes(bdev) > UINT_MAX) {
> +		dev_warn(dev, "block device too large to be an NVMEM provider\n");
> +		return;
> +	}
> +
> +	config.id = NVMEM_DEVID_NONE;
> +	config.dev = dev;
> +	config.name = dev_name(dev);
> +	config.owner = THIS_MODULE;
> +	config.priv = (void *)(uintptr_t)dev->devt;
> +	config.reg_read = blk_nvmem_reg_read;
> +	config.size = bdev_nr_bytes(bdev);
> +	config.word_size = 1;
> +	config.stride = 1;
> +	config.read_only = true;
> +	config.root_only = true;
> +	config.ignore_wp = true;
> +	config.of_node = to_of_node(dev->fwnode);
> +
> +	bdev->bd_nvmem = nvmem_register(&config);
> +	if (IS_ERR(bdev->bd_nvmem)) {
> +		dev_err_probe(dev, PTR_ERR(bdev->bd_nvmem),
> +			      "Failed to register NVMEM device\n");

Using dev_err_probe() only makes sense with a return value. Which makes me
think: we won't retry this after a probe deferral. I think we should return
int from this function just for this use-case. Also: if we *do* have
a layout, shouldn't we treat a failure to register the nvmem provider as
a an error and propagate it up the stack?

> +		bdev->bd_nvmem = NULL;
> +	}
> +}
> +
> +void blk_nvmem_del(struct block_device *bdev)
> +{
> +	if (bdev->bd_nvmem)

Nvmem core already performs a NULL check.

> +		nvmem_unregister(bdev->bd_nvmem);
> +
> +	bdev->bd_nvmem = NULL;
> +}
> diff --git a/block/blk.h b/block/blk.h
> index ec4674cdf2ead4fd259ff5fc42401f591e684ee9..cd3c7ca723391c40be56f1dd4810e641b7c8a2b3 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -757,4 +757,12 @@ static inline void blk_debugfs_unlock(struct request_queue *q,
>  	memalloc_noio_restore(memflags);
>  }
>
> +#ifdef CONFIG_BLK_NVMEM
> +void blk_nvmem_add(struct block_device *bdev);
> +void blk_nvmem_del(struct block_device *bdev);
> +#else
> +static inline void blk_nvmem_add(struct block_device *bdev) {}
> +static inline void blk_nvmem_del(struct block_device *bdev) {}
> +#endif
> +
>  #endif /* BLK_INTERNAL_H */
> diff --git a/block/genhd.c b/block/genhd.c
> index 7d6854fd28e95ae9134309679a7c6a937f5b7db8..1b2382de6fb30c1e5f60f45c04dc03ed3bf5d5f2 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -421,6 +421,8 @@ static void add_disk_final(struct gendisk *disk)
>  		 */
>  		dev_set_uevent_suppress(ddev, 0);
>  		disk_uevent(disk, KOBJ_ADD);
> +
> +		blk_nvmem_add(disk->part0);
>  	}
>
>  	blk_apply_bdi_limits(disk->bdi, &disk->queue->limits);
> @@ -704,6 +706,8 @@ static void __del_gendisk(struct gendisk *disk)
>
>  	disk_del_events(disk);
>
> +	blk_nvmem_del(disk->part0);
> +
>  	/*
>  	 * Prevent new openers by unlinked the bdev inode.
>  	 */
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 8808ee76e73c09e0ceaac41ba59e86fb0c4efc64..ace6f59b860d0813665b2f62a1c03a1f4be94059 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -73,6 +73,9 @@ struct block_device {
>  	int			bd_writers;
>  #ifdef CONFIG_SECURITY
>  	void			*bd_security;
> +#endif
> +#ifdef CONFIG_BLK_NVMEM
> +	struct nvmem_device	*bd_nvmem;
>  #endif
>  	/*
>  	 * keep this out-of-line as it's both big and not needed in the fast
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 890128cdea1ce66863c5baa36f3b336ec4550807..f15d2b5bf9e4fd2368b8a70416a978e22c0d4333 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -30,6 +30,7 @@
>
>  struct module;
>  struct request_queue;
> +struct nvmem_device;
>  struct elevator_queue;
>  struct blk_trace;
>  struct request;
>
> --
> 2.34.1
>
>

I like this approach better than the previous one.

Thanks,
Bartosz

