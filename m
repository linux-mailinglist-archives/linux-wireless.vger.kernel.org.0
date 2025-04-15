Return-Path: <linux-wireless+bounces-21551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6515EA89F32
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 15:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32E1C7AAF89
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 13:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC25288CBE;
	Tue, 15 Apr 2025 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="sgJB+9+e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9635336D
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744723029; cv=none; b=q3tBMhBWEpjRQ/fOQy/TChNik8UviqNMRMjk+xfDTlsUU+Q+TuS5koFNkCpDay8/jm5PVzGsWISiyGVoBsVBxceIldExlFc2XVr2c41UQVO6evkCA4hBG+raAxpWSXL2h6vMC8m1RHbTEyHV5Rt0jd6IRKq09rErurHXRpkNbXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744723029; c=relaxed/simple;
	bh=hwhtiNQ+Hse8QHVB//6AxRSnC1EIIrg9Ad9WJVi7u/M=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=IAh4AOubq8eM2lARuf8iRordSRr8bV9E3Kg7wA0ZomZCyKm++dc7bSWiM0EKNxrR9ERscgaDnF1t3Q+K/J27K4km5Pn/bR1ZlkyZ+OpR0yv/Z1YezjweYLaIGKjOJZjO2SBwBgzhysmSUVH7sU/5KdhbWWKODjcDjYBnbQG5XE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=sgJB+9+e; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:2ea3:0:640:da3e:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 6798761461;
	Tue, 15 Apr 2025 16:09:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Q9HXMC1LfGk0-ookFfsyN;
	Tue, 15 Apr 2025 16:09:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1744722567; bh=YOmmrwTULFOSKqHnSHOLttVrLv4+sVQFw7OqFpETIIo=;
	h=In-Reply-To:Subject:To:From:Cc:Date:References:Message-ID;
	b=sgJB+9+e34nBd1nHjzRdNMOV/wH9Tx80Uj/wHcg/IXiD1SYK04NSSYWWSj51OCynI
	 Bh8MYAqNTzIGK1De5Zi0TCUqMdUXJnWVvBN6fm6CEkmutsnk05jsbEmO+MDqDFJBH7
	 ZmCb2cXQGVRvvAAOlSUDHP+7YP+OhfPwjKk+zq3I=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <2764c59b-025a-48ef-ab1a-6ea199954a28@yandex.ru>
Date: Tue, 15 Apr 2025 16:09:26 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org
References: <20250414083403.561646-1-dmantipov@yandex.ru>
 <d59805fc-578b-4421-90e3-40e322be0652@broadcom.com>
Content-Language: en-MW
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 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
 A/UwwXBRuvydGV0=
Subject: Re: [PATCH] wifi: brcmfmac: avoid calling
 platform_driver_unregister() more than once
In-Reply-To: <d59805fc-578b-4421-90e3-40e322be0652@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/14/25 12:22 PM, Arend van Spriel wrote:

> When the platform_driver_probe() fails it means that brcmfmac_pdata will
> be NULL so it provides the same info as the returned error. So the
> net result is the same and no platform_driver_unregister() will be called.
I'm not sure whether the following model is 100% accurate against the real
driver, but it always crashes (in platform_driver_unregister() explicitly
called from module init function) when non-zero (say, -ENOMEM) is returned
from probe (e.g. t_platform_driver_probe()) function:

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/platform_device.h>

static struct platform_device t_platform_device = {
	.name = "testdev",
};

struct t_driver_data {
	int dummy;
} *t_pdata = NULL, driver_data = { .dummy = 1 };

static void t_platform_driver_remove(struct platform_device *pd)
{
	printk(KERN_ERR "remove platform device@%p\n", pd);
}

static struct platform_driver t_pd = {
	.remove = t_platform_driver_remove,
	.driver = {
		.name = "testdev",
	}
};

static int t_platform_driver_probe(struct platform_device *pd)
{
	printk(KERN_ERR "probe platform device@%p\n", pd);
	t_pdata = &driver_data;
	return 0;
}

static int t_always_error(void)
{
	return -ENODATA;
}

static int __init
t_platform_driver_init(void)
{
	int err;

	err = platform_device_register(&t_platform_device);
	if (err) {
		printk(KERN_ERR "unable to register platform device\n");
		return err;
	}

	err = platform_driver_probe(&t_pd, t_platform_driver_probe);

	if (err == -ENODEV)
		printk(KERN_ERR "No platform data");

	err = t_always_error();

	if (err) {
		if (t_pdata) {
			printk(KERN_ERR "going to unregister platform driver@%p\n", &t_pd);
			platform_driver_unregister(&t_pd);
		}
		platform_device_unregister(&t_platform_device);
	}
	return err;
}

static void __exit
t_platform_driver_exit(void)
{
	if (t_pdata)
		platform_driver_unregister(&t_pd);

	platform_device_unregister(&t_platform_device);
}

module_init(t_platform_driver_init);
module_exit(t_platform_driver_exit);
MODULE_LICENSE("GPL");

Dmitry

