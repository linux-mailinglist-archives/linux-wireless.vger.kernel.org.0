Return-Path: <linux-wireless+bounces-28435-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55540C23CE7
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 09:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4285601F3
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 08:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73312FBE01;
	Fri, 31 Oct 2025 08:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="LSlR4IXh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9FA2E8B78;
	Fri, 31 Oct 2025 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898955; cv=none; b=OgHnR02gUj/6lika/0QxD3DsXowtyTU5JqT+iGZuNWfJBN6DdYMv7lSPyBqod7gJlsmEBweIBilwc7awAOzWyCNCvh9xb12Jmt6Im9XYDN3BaSsQQQ9q4tqEL9ORU+pExy2f4S2w2dQRWebJw9ZwMGZQk8if682/DUN/Jdooxa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898955; c=relaxed/simple;
	bh=62GjFdGWwbbzA3cm5sko4T/hxx35PdHGWci6ZMG3GSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egRWd693OmMbouaHLH6333yQtCgVfLwBrLgWpZt6JIk6IdZjDyy/lIMjDU+lnSeeL0JIJV9o9+avpJyg43aWRShe7N8tksKWewgnkDXvj/SGyif4nGfVXEs0whXdkow1ywFh++/ncIkwwXXlXBgfwfyO/wE6CHgHTAkiBukgX0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=LSlR4IXh; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 56BF597720A;
	Fri, 31 Oct 2025 09:22:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1761898944; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Qib6qRQMu5LVMMGbQVwGmu5XzHqsEzGPUdm1+2Fg8Jw=;
	b=LSlR4IXhs1thoBJw7RjsbQ2kPHdVT2DjByuTTOkK3UPb9+mxo6NJ4OYEkOnppZbI5rGz/W
	btyKf3Gnc3YLdHGnMQhETaGs4ArrNP2QLS/ZhSyUuV54vKZu8uEyVw/FgOAauVbfwuXUMZ
	kzrB7KIf3FrR95eYqazZFy2UeEjhj8UbsqJLoHE/3nPlWEeL7tcOKL8jWhAWTWTr8qi4k1
	8v8dkeQ7iZdKietWGxL8AJeHat6lUKZrZkdY4rEngTDKP1TO6/UR4HJu5z8Vy18tLzMm7P
	hHs2iaFsAYppKcCTwsCCDkMh4PHmdyxZshGYiwHbZ+Aoe+Aj8y96H87eiutRsg==
Message-ID: <cf6d217f-1f1f-41f9-9ed7-9454aad080df@cjdns.fr>
Date: Fri, 31 Oct 2025 09:22:18 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] wifi: mt76: mmio_(read|write)_copy byte swap when on Big
 Endian
To: kernel test robot <lkp@intel.com>, nbd@nbd.name, lorenzo@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ryder.lee@mediatek.com,
 shayne.chen@mediatek.com, sean.wang@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20251027171759.1484844-1-cjd@cjdns.fr>
 <202510310816.kyDHJNiS-lkp@intel.com>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <202510310816.kyDHJNiS-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 31/10/2025 02:18, kernel test robot wrote:
> Hi Caleb,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on wireless-next/main]
> [also build test WARNING on wireless/main linus/master v6.18-rc3 next-20251030]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Caleb-James-DeLisle/wifi-mt76-mmio_-read-write-_copy-byte-swap-when-on-Big-Endian/20251028-012349
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
> patch link:    https://lore.kernel.org/r/20251027171759.1484844-1-cjd%40cjdns.fr
> patch subject: [PATCH] wifi: mt76: mmio_(read|write)_copy byte swap when on Big Endian
> config: i386-randconfig-061-20251031 (https://download.01.org/0day-ci/archive/20251031/202510310816.kyDHJNiS-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251031/202510310816.kyDHJNiS-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510310816.kyDHJNiS-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>>> drivers/net/wireless/mediatek/mt76/mmio.c:41:24: sparse: sparse: cast from restricted __le32
>>> drivers/net/wireless/mediatek/mt76/mmio.c:41:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __le32 [usertype] @@


This should not be an issue in PATCH v2 because it no longer uses a 
temporary variable.

Thanks,

Caleb


>     drivers/net/wireless/mediatek/mt76/mmio.c:41:24: sparse:     expected unsigned int val
>     drivers/net/wireless/mediatek/mt76/mmio.c:41:24: sparse:     got restricted __le32 [usertype]
>>> drivers/net/wireless/mediatek/mt76/mmio.c:63:23: sparse: sparse: cast to restricted __le32
> vim +41 drivers/net/wireless/mediatek/mt76/mmio.c
>
>      32	
>      33	static void mt76_mmio_write_copy_portable(void __iomem *dst,
>      34						  const u8 *src, int len)
>      35	{
>      36		__le32 val;
>      37		int i = 0;
>      38	
>      39		for (i = 0; i < ALIGN(len, 4); i += 4) {
>      40			memcpy(&val, src + i, sizeof(val));
>    > 41			writel(cpu_to_le32(val), dst + i);
>      42		}
>      43	}
>      44	
>      45	static void mt76_mmio_write_copy(struct mt76_dev *dev, u32 offset,
>      46					 const void *data, int len)
>      47	{
>      48		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
>      49			mt76_mmio_write_copy_portable(dev->mmio.regs + offset, data,
>      50						      len);
>      51			return;
>      52		}
>      53		__iowrite32_copy(dev->mmio.regs + offset, data, DIV_ROUND_UP(len, 4));
>      54	}
>      55	
>      56	static void mt76_mmio_read_copy_portable(u8 *dst,
>      57						 const void __iomem *src, int len)
>      58	{
>      59		u32 val;
>      60		int i;
>      61	
>      62		for (i = 0; i < ALIGN(len, 4); i += 4) {
>    > 63			val = le32_to_cpu(readl(src + i));
>      64			memcpy(dst + i, &val, sizeof(val));
>      65		}
>      66	}
>      67	
>

