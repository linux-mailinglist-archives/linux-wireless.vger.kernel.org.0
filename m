Return-Path: <linux-wireless+bounces-24038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09919AD6940
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 09:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960563A5EB2
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 07:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4162036EC;
	Thu, 12 Jun 2025 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U5KSS3ly"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F60D20FA84
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749713895; cv=none; b=jhTXP40ixrVn72aoVdnX8lmJiNtOZDcA/8DWHW7DWA2aIIfrFqpDcP4dH62yOpZksRCgaH8KcvVoUUj0hYODqJWa8kDRSZRF8YYoKRgwQWDvcjEfjkgUHn+p1XKv9XRjBlwLW6teU1wlTGERGUjQ7OsLqJaYoTsQQEfwTnyXGuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749713895; c=relaxed/simple;
	bh=O0uKNONQAM06He1DbHIBCwngiKzf+B66ZozgA04c9Es=;
	h=To:From:Subject:Message-Id:Date; b=T/ulHH07Q/fZ1aHYvAGtUaH4aIZNAbNM92FU5h/0uUnuWhxuMTeSwP+NIi1bYd9Z8dl7jtPBw81ZU+4/v9Ma/nuB5tC5LkkpXVZ4LlpLJCEI3h4ZyaIlEcp5RkdA2qYsDQm5JQoSCojgfKRKj8547kZ/DDprGYu4T+BAvOZF5XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U5KSS3ly; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=To:From:Subject:Message-Id:Date; bh=dpFOUh279hQn+px
	IZBd1hP7pxRgO5ZboNF8AjaBRYAc=; b=U5KSS3lyJuDfXa4QTo12W9Hz95UkZlv
	KmpYkSBsoifPIVfW8Huo3l44p2a+dNYTR2NS+ml2rlx2qGwVvE2LbXPVocIFpWSV
	/IdQxvYqSMEPfLmGCIwbjsXKxhffnqAfRXJRW8OCC0/5xYi53qHIL58btVRIRk2A
	w46cd4SN9Y/k=
Received: from MBP (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDn79PNg0po+qcUIQ--.57708S3;
	Thu, 12 Jun 2025 15:38:06 +0800 (CST)
To: linux-wireless@vger.kernel.org
From: lonthn@163.com
Subject: Re: [rtw89] PCI Passthrough Issue: rtl8852be on ARM VM (Ubuntu host/OpenWrt guest)
X-CM-TRANSID:_____wDn79PNg0po+qcUIQ--.57708S3
Message-Id:<684A83E1.25166C.00001@m16.mail.163.com>
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1fJw47XF1UCw48JryfXrb_yoWDGFb_WF
	1DuFyDZr1DuF13Ar4xur1I9rWkCa9rWr9xZrn5Jw1rAa4jyFyfCF1fZw4av3s5X39agrW5
	ZFy5J3yrGw1I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRAL0n3UUUUU==
Date: Thu, 12 Jun 2025 15:38:09 +0800 (CST)
X-CM-SenderInfo: horq3xrq6rljoofrz/1tbiXQlqB2hKgWE8YAAAsn
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Thanks for your quick response.

> This looks like interoperability problem of 36-bit DMA.
> If you have below commit in your guest OS:
> 1fd4b3fe52ef ("wifi: rtw89: pci: support 36-bit PCI DMA address")
> 
> Please also have below commit to rollback 32-bit DMA.
> aa70ff0945fe ("wifi: rtw89: pci: early chips only enable 36-bit DMA on specific PCI hosts")
> 
> With the latest kernel, you can just comment code as below to use 32-bit DMA.

I tried it and found that it still doesn't work

> I have not ever tried passthrough, so I'm not sure if it can work.
> Can I know how different the passthrough is?

You can refer to this: https://docs.kernel.org/driver-api/vfio.html

> Does rtl8852be work on host OS?

I'm trying, but when I load the 8852be driver, strangely, I get nothing. 
$> dmesg |grep 8852be
no message!
$> lsmod |grep rtw
rtw_8852be             16384  0
rtw_8852b             352256  1 rtw_8852be
rtw89pci               61440  1 rtw_8852be
rtw89core             569344  2 rtw89pci,rtw_8852b
It looks like my device is not detected


