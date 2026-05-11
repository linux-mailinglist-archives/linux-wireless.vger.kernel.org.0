Return-Path: <linux-wireless+bounces-36226-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJfJI9G+AWpqjQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36226-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 13:34:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DD450CD1C
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 13:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1EC5306D0DF
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 11:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E468372B4B;
	Mon, 11 May 2026 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0Qisebm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69943372663
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498868; cv=none; b=JOOm8BhYzq4fLCUUBFVxut4CWftQTz1wEaAZmjAxFv1fbOtDt6w5/yIOWBR26jDxQ44/rRM9N6PkgPw9+rw5+DHZyIrX8o+8mPWJgSf3o/q2NRn/GmKhvH5KOAUieXItzt+wKDVP+SfdWx/oz2bCWnqPzV2PlioNnrqYyWjo0zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498868; c=relaxed/simple;
	bh=eROQJdvZzpzP6omZV4CYaxT1ro01gZWOXGEjjxJfLDg=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKyUJpbzdHM4gzO6nGybyJlWjeAv9d5PG1GvYcBYrCjTk3MWOS0r9z1L0CBVfWsFJsxI5Hn8doqFHHYBFtFEBE3GW6hfnnR2y9C2j9l3RKkNLT+sN5nl6Jjvg60BVXHf5Hb2iOUdTY2PKlrPme+wqGYYlZooRiT7G1XFn9z6sFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0Qisebm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242ADC2BCFC
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 11:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778498868;
	bh=eROQJdvZzpzP6omZV4CYaxT1ro01gZWOXGEjjxJfLDg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=u0QisebmC3wF3QsbrB29zEqJaZFBryPw0PYH3Qgps6fXb9lvX/LN4jmohJ05yxDnp
	 KzRFWKiHgBsr6XCzm2kn4FmDe79zFpgDG9HYBsVbvCMNEtt//EZB01GuX9Ds36RKqU
	 ODRV7vAIhZClvNKkRUdCCTmzF92cDPJ6psIXYoJxI3xH5vRZulchwhj6aqAu9kKMzS
	 lW8cBUq8T7aimtlfmDuhOBXTWFqU7DY9174tJvsamHIDXngQNf42FsGaifPIZbgsHF
	 aTxYlf5y5Sca2JdzATd9olwtIs/5vv/A8tHTz3Qp4TeDf/AEcfNd6JqBXJzDmnCVJY
	 Mboodu7MlmSug==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39394e1e8f3so34530931fa.1
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 04:27:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8NHOPBkds5RU9JKkNo3HfFNxgrPvAgD+Ct3VPsjNDq1XbPL0SmmRc/FQYyC9T7c8paisnTEwo5UBnm18IE6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYcEnXl8bSOE1wJWMvo0mAfVyqDQQQNq+HIhkWH0vzaWGngi77
	v691OlMTOcM+haYZKp4FIQWbXGUWJYtsKw6kL2Kny3VLEv2nnniaI+97677NJOlxEAsX9RuN5L+
	QJgyQf14Ls8nmy6uM0ztaX6N3KTBkEe69WCZYNaoZxA==
X-Received: by 2002:a05:6512:acf:b0:5a3:eb4b:37a7 with SMTP id
 2adb3069b0e04-5a8b6c9c525mr2447446e87.6.1778498866753; Mon, 11 May 2026
 04:27:46 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 May 2026 04:27:44 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 May 2026 04:27:44 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260507-block-as-nvmem-v2-4-bf17edd5134e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com> <20260507-block-as-nvmem-v2-4-bf17edd5134e@oss.qualcomm.com>
Date: Mon, 11 May 2026 04:27:44 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdOJtb2Jc-qXs3qBG+DGeSx=xmeZ0go9zn3gkyMBFnRCA@mail.gmail.com>
X-Gm-Features: AVHnY4K8k1k3RamLldv5ZwT4_Dz11oLIMFN3mMB1glD0JB_d179ZxB8TasJQaQQ
Message-ID: <CAMRc=MdOJtb2Jc-qXs3qBG+DGeSx=xmeZ0go9zn3gkyMBFnRCA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] block: implement NVMEM provider
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
X-Rspamd-Queue-Id: E2DD450CD1C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36226-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,makrotopia.org,kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:email,qualcomm.com:email,mail.gmail.com:mid,config.name:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,config.id:url,config.dev:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Thu, 7 May 2026 17:24:39 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> From: Daniel Golle <daniel@makrotopia.org>
>
> On embedded devices using an eMMC it is common that one or more partitions
> on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPROM
> data. Allow referencing the partition in device tree for the kernel and
> Wi-Fi drivers accessing it via the NVMEM layer.
>
> To safely defer the freeing of the provider private data until all
> consumers have released their cells, a nvmem_dev() accessor is added to
> the NVMEM core to expose the struct device embedded in struct nvmem_device.
> This allows registering a devm action on the nvmem device itself, ensuring
> the private data outlives any active cell references.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

...

> diff --git a/block/blk-nvmem.c b/block/blk-nvmem.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..96c0ffc51b1862a75644f3f94add35d59577d86b
> --- /dev/null
> +++ b/block/blk-nvmem.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * block device NVMEM provider
> + *
> + * Copyright (c) 2024 Daniel Golle <daniel@makrotopia.org>
> + *
> + * Useful on devices using a partition on an eMMC for MAC addresses or
> + * Wi-Fi calibration EEPROM data.
> + */
> +
> +#include "blk.h"

Local includes typically go after system-wide ones. I thought that maybe it's
a block subsystem thing but no, it too goes after here.

> +#include <linux/nvmem-provider.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of.h>
> +#include <linux/pagemap.h>
> +#include <linux/property.h>
> +
> +static void blk_nvmem_free(void *data)
> +{
> +	kfree(data);
> +}
> +
> +/* List of all NVMEM devices */
> +static LIST_HEAD(nvmem_devices);
> +static DEFINE_MUTEX(devices_mutex);
> +
> +struct blk_nvmem {
> +	struct nvmem_device	*nvmem;
> +	dev_t			devt;
> +	bool			removed;
> +	struct list_head	list;
> +};
> +
> +static int blk_nvmem_reg_read(void *priv, unsigned int from,
> +			      void *val, size_t bytes)
> +{
> +	blk_mode_t mode = BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES;
> +	unsigned long offs = from & ~PAGE_MASK, to_read;
> +	pgoff_t f_index = from >> PAGE_SHIFT;
> +	struct blk_nvmem *bnv = priv;
> +	size_t bytes_left = bytes;
> +	struct file *bdev_file;
> +	struct folio *folio;
> +	void *p;
> +	int ret = 0;
> +
> +	if (bnv->removed)
> +		return -ENODEV;
> +
> +	bdev_file = bdev_file_open_by_dev(bnv->devt, mode, priv, NULL);
> +	if (!bdev_file)
> +		return -ENODEV;
> +
> +	if (IS_ERR(bdev_file))
> +		return PTR_ERR(bdev_file);
> +
> +	while (bytes_left) {
> +		folio = read_mapping_folio(bdev_file->f_mapping, f_index++, NULL);
> +		if (IS_ERR(folio)) {
> +			ret = PTR_ERR(folio);
> +			goto err_release_bdev;
> +		}
> +		to_read = min_t(unsigned long, bytes_left, PAGE_SIZE - offs);
> +		p = folio_address(folio) + offset_in_folio(folio, offs);
> +		memcpy(val, p, to_read);
> +		offs = 0;
> +		bytes_left -= to_read;
> +		val += to_read;
> +		folio_put(folio);
> +	}
> +
> +err_release_bdev:
> +	fput(bdev_file);
> +
> +	return ret;
> +}
> +
> +static int blk_nvmem_register(struct device *dev)
> +{
> +	struct device_node *np = dev_of_node(dev);
> +	struct block_device *bdev = dev_to_bdev(dev);
> +	struct nvmem_config config = {};
> +	struct blk_nvmem *bnv;
> +
> +	/* skip devices which do not have a device tree node */
> +	if (!np)
> +		return 0;
> +
> +	/* skip devices without an nvmem layout defined */
> +	if (!of_get_child_by_name(np, "nvmem-layout"))
> +		return 0;
> +
> +	/*
> +	 * skip block device too large to be represented as NVMEM devices
> +	 * which are using an 'int' as address
> +	 */
> +	if (bdev_nr_bytes(bdev) > INT_MAX)
> +		return -EFBIG;
> +
> +	bnv = kzalloc_obj(*bnv);
> +	if (!bnv)
> +		return -ENOMEM;
> +
> +	config.id = NVMEM_DEVID_NONE;
> +	config.dev = &bdev->bd_device;
> +	config.name = dev_name(&bdev->bd_device);
> +	config.owner = THIS_MODULE;
> +	config.priv = bnv;
> +	config.reg_read = blk_nvmem_reg_read;
> +	config.size = bdev_nr_bytes(bdev);
> +	config.word_size = 1;
> +	config.stride = 1;
> +	config.read_only = true;
> +	config.root_only = true;
> +	config.ignore_wp = true;
> +	config.of_node = to_of_node(dev->fwnode);
> +
> +	bnv->devt = bdev->bd_device.devt;
> +	bnv->nvmem = nvmem_register(&config);
> +	if (IS_ERR(bnv->nvmem)) {
> +		dev_err_probe(&bdev->bd_device, PTR_ERR(bnv->nvmem),
> +			      "Failed to register NVMEM device\n");
> +
> +		kfree(bnv);
> +		return PTR_ERR(bnv->nvmem);
> +	}
> +
> +	/*
> +	 * Free bnv only when the nvmem device is fully released (i.e. when
> +	 * its kref hits zero), not at unregister time. This prevents a
> +	 * use-after-free if a consumer still holds an nvmem_cell reference
> +	 * when the block device is removed: nvmem_unregister() only does a
> +	 * kref_put(), so reg_read could still be called with bnv as priv
> +	 * until the last consumer drops its cell.
> +	 */
> +	if (devm_add_action(nvmem_dev(bnv->nvmem), blk_nvmem_free, bnv)) {
> +		nvmem_unregister(bnv->nvmem);
> +		kfree(bnv);
> +		return -ENOMEM;
> +	}

Please take a look at the series[1] I sent, it seems to address this issue at
the nvmem core level. Help reviewing it is appreciated. :)

In any case: I don't think it will work the way you intend it to: the devres
action will be executed when the nvmem device is "unbound" not when it's
"released". Not only that but the device you retrieve here is not the "parent"
device that's actually bound to the driver but the "logical" nvmem device, the
nvmem core creates to back the struct nvmem_device's functionality and reference
counting. In other words: I believe the devres action will never be called.

In general, it's a very bad idea to schedule devres actions on devices you
don't control and in context different than at probe() time.

> +
> +	mutex_lock(&devices_mutex);
> +	list_add_tail(&bnv->list, &nvmem_devices);
> +	mutex_unlock(&devices_mutex);
> +
> +	return 0;
> +}
> +
> +static void blk_nvmem_unregister(struct device *dev)
> +{
> +	struct blk_nvmem *bnv_c, *bnv = NULL;
> +
> +	mutex_lock(&devices_mutex);
> +	list_for_each_entry(bnv_c, &nvmem_devices, list) {
> +		if (bnv_c->devt == dev_to_bdev(dev)->bd_device.devt) {
> +			bnv = bnv_c;
> +			break;
> +		}
> +	}
> +
> +	if (!bnv) {
> +		mutex_unlock(&devices_mutex);
> +		return;
> +	}
> +
> +	list_del(&bnv->list);
> +	mutex_unlock(&devices_mutex);
> +	bnv->removed = true;
> +	nvmem_unregister(bnv->nvmem);
> +}
> +
> +static struct class_interface blk_nvmem_bus_interface __refdata = {
> +	.class = &block_class,
> +	.add_dev = &blk_nvmem_register,
> +	.remove_dev = &blk_nvmem_unregister,
> +};
> +
> +static int __init blk_nvmem_init(void)
> +{
> +	int ret;
> +
> +	ret = class_interface_register(&blk_nvmem_bus_interface);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +device_initcall(blk_nvmem_init);
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 311cb2e5a5c02d2c6979d7c9bbb7f94abdfbdad1..ee3481229c20b3063c86d0dd66aabbf6b5e29169 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -2154,6 +2154,19 @@ const char *nvmem_dev_name(struct nvmem_device *nvmem)
>  }
>  EXPORT_SYMBOL_GPL(nvmem_dev_name);
>
> +/**
> + * nvmem_dev() - Get the struct device of a given nvmem device.
> + *
> + * @nvmem: nvmem device.
> + *
> + * Return: pointer to the struct device of the nvmem device.
> + */
> +struct device *nvmem_dev(struct nvmem_device *nvmem)
> +{
> +	return &nvmem->dev;
> +}
> +EXPORT_SYMBOL_GPL(nvmem_dev);
> +

That should be done in a separate patch but see my response above.

>  /**
>   * nvmem_dev_size() - Get the size of a given nvmem device.
>   *
> diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
> index 34c0e58dfa26636d2804fcc7e0bc4a875ee73dae..ce387c89dc8e4bc1241f3b6f36be8c6c95e282ed 100644
> --- a/include/linux/nvmem-consumer.h
> +++ b/include/linux/nvmem-consumer.h
> @@ -82,6 +82,7 @@ int nvmem_device_cell_write(struct nvmem_device *nvmem,
>
>  const char *nvmem_dev_name(struct nvmem_device *nvmem);
>  size_t nvmem_dev_size(struct nvmem_device *nvmem);
> +struct device *nvmem_dev(struct nvmem_device *nvmem);
>
>  void nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries,
>  			    size_t nentries);
> @@ -220,6 +221,11 @@ static inline const char *nvmem_dev_name(struct nvmem_device *nvmem)
>  	return NULL;
>  }
>
> +static inline struct device *nvmem_dev(struct nvmem_device *nvmem)
> +{
> +	return NULL;
> +}
> +
>  static inline void
>  nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries) {}
>  static inline void
>
> --
> 2.34.1
>
>

Thanks,
Bartosz

[1] https://lore.kernel.org/all/20260429-nvmem-unbind-v3-0-2a694f95395b@oss.qualcomm.com/

