Return-Path: <linux-wireless+bounces-2348-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8729B837469
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 21:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B837E1C277F1
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 20:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480E24BA99;
	Mon, 22 Jan 2024 20:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b="iyE1XNo2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from o1.ptr2625.egauge.net (o1.ptr2625.egauge.net [167.89.112.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCEA4BA88
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.112.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956291; cv=none; b=YQBXIjNgQtLUfchL4gZxEudOcnWfptpV8LbEGSh/5R2FUWOBGHOfvZtDGIM5jNCSKE01Li97S9u5Z1YrGRco/XnDZPhxptaNNd3vDNDZB/egBhNy5mHXlfovyIVI9glIrYQEvz0+/2+uGYyouu233QaR2q7pD0kgvFtudblAH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956291; c=relaxed/simple;
	bh=f8pPZmoTrLU6YMNkYqZAHLAwHdZTX4TrXXn+H4Xsjao=;
	h=Message-ID:Subject:From:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:To:Cc; b=p06vHsoQPZsb+noisOaXTm3GBrH2Qj5/NhKvoXtBuNQgCl+rDza+JME5LiI0iT2djFw8ayAimG9JYRcV94buIcA7jFJmYX+gQW+vJZbJDFkwyS1d54fVERXzy4pQVCIN2fFXFTYrcsmjBeLIlroj2cquUC2Te7H0wOT3WQLbALI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net; spf=pass smtp.mailfrom=em1190.egauge.net; dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b=iyE1XNo2; arc=none smtp.client-ip=167.89.112.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1190.egauge.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
	h=subject:from:in-reply-to:references:content-type:
	content-transfer-encoding:mime-version:to:cc:cc:content-type:from:subject:to;
	s=sgd; bh=Mumv6OUhZ7sgiQs5eu+Juy8WzkG6uYV1/9GdJ8fymR0=;
	b=iyE1XNo2hFKklPuQmXh4L1bIvbmUbB5b+mUuSHakbGh+sa9OycH5WMG/76+IzXlEpg5I
	D03pbaCsz/MVAyHXXLvjcLB7gk+WFXY5rqwAUEi+Rjxfhn5jBGcnabSlAaVrElVYqZHPnR
	zSyvjoVhw+W0iGPA2wtRBtXQSOVD3kzqF+9/HiBoMNq2tfUp0FcXgk2Qekn6sHliMhxCHR
	Dx4jjjSKlYA1LkyWcHDUc1oovr4cmRJX4qqz7YZcUHVyWg+9xV+wuH6nuWv0YRbS9rWZGm
	knTjROwOk1gpyln+ZANlwEvs836xiZZFh3m0+LoJlwG9/ztO+NjaYuGBNfrFNsnA==
Received: by filterdrecv-6b68c9f446-kzvqf with SMTP id filterdrecv-6b68c9f446-kzvqf-1-65AED3C0-1B
        2024-01-22 20:44:48.56642919 +0000 UTC m=+2197873.105117938
Received: from bixby.lan (unknown)
	by geopod-ismtpd-7 (SG) with ESMTP
	id 4vdG3BG1Rh2OMoXaxug4RA
	Mon, 22 Jan 2024 20:44:48.432 +0000 (UTC)
Message-ID: <3e496666cf293c97ff92ebea2a86449878beb346.camel@egauge.net>
Subject: Re: RFQ: wifi: wilc1000: make wilc1000-spi bus-probe useful
From: David Mosberger-Tang <davidm@egauge.net>
Date: Mon, 22 Jan 2024 20:44:48 +0000 (UTC)
In-Reply-To: <1776feff-0886-4db8-896c-c542d3e626b0@microchip.com>
References: <90fb762e5840f9d5a6ae46f81692fb947a7796a4.camel@egauge.net>
	 <1776feff-0886-4db8-896c-c542d3e626b0@microchip.com>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvA52BItr=2FT8XoVqNc?=
 =?us-ascii?Q?FVDJyju0DBKf2nqoZa5zfufWEmZE97Pd07Jq7DR?=
 =?us-ascii?Q?FT8=2FLOLslmZIf1I6dlanB3zdjCFk8=2FHUmy2LUfn?=
 =?us-ascii?Q?wqBsuvmChdV9+Dr1KXheYSttNP3aHZUts8QDFK4?=
 =?us-ascii?Q?1HmAvQLfWEg706Jp7S6Lm3bwmCXcA=2FysLkAwYJt?=
 =?us-ascii?Q?zsPjVVs97nNmnxNuTyAwQ=3D=3D?=
To: Ajay.Kathat@microchip.com
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==

On Mon, 2024-01-22 at 16:57 +0000, Ajay.Kathat@microchip.com wrote:
> On 1/19/24 14:51, David Mosberger-Tang wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > The current version of the wilc1000 driver has a probe function that si=
mply
> > assumes the chip is present. It is only later, in wilc_spi_init(), that=
 the
> > driver verifies that it can actually communicate with the chip. The res=
ult of
> > this is that the net device (typically wlan0) is created and remains in=
 place as
> > long as the wilc1000-spi driver is loaded, even if the WILC1000 chip is=
 not
> > present or not working.
> >=20
> > Is there any reason not to detect the chip's present in wilc_bus_probe(=
)? The
> > patch below (relative to 5.15.147) works for me, but perhaps I'm missin=
g
> > something? Would it make sense to merge something along these lines int=
o
> > mainline?
> >=20
>=20
> I think it is the WILC driver design that the firmware/chip operations
> are executed only when the netdev interface(wlan0) is up. The firmware
> is started only after the interface is up. However, it should be okay to
> read the register values since the bus interface is up.

Yep, I didn't see any issues in my testing.

> As I understand, this condition is raised since the auto-load started to
> work after the patch[1], now the driver is getting loaded at the boot-up
> time.
> Actually, the auto-detect(hot-plug) for SPI bus can't be supported like
> the SDIO bus where the driver gets loaded/unloaded when the device is
> connected/removed. In case of SPI devices, the driver probe will be
> called at the boot-up time based on the Device-tree(DT) entry. If the
> SPI device is connected after board boot-up, the board reboot is
> required for probe function to get called i.e. even wilc_bus_probe()
> returns failure for first time then the probe will not get called again.
> One way to handle this is by modifying the DT entry of the system to
> define whether the SPI device is connected or not.

Makes sense.  In our system, we don't have the ability to dynamically patch=
 the
device tree so we rely on driver probing to confirm that a device actually
exists.

  --david


