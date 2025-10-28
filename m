Return-Path: <linux-wireless+bounces-28346-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738DCC1714F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 22:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81793A79F3
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 21:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A202D0634;
	Tue, 28 Oct 2025 21:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="inp9/OsL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC797483;
	Tue, 28 Oct 2025 21:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687729; cv=none; b=ZzSDm/dpFSnradyvhYSVZWRQmMTNe46b7+aIFiNpnhJ19K4aDnRMl5NvF+enTX1wKnoUsbbS771V3L5SeuBLhZ2kULGXGmwrVM8kUOyo6X9CVPv0XjhZx3Zt7eicGONXmw9n3O4KIdgG+SG0SCIwMzXM6jAo3LdJbmK/OKYlgYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687729; c=relaxed/simple;
	bh=v7LYUfsNkmz/JAzdgXVKmsHX6f9E2tz/b7wzoTXnsAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SV8M7RSBk3+mKbN2s1frFcIQM8s519N1hV/BfQZ6jnQFrd+BnLV8LH6eNEKYzi6C/jvyJZRpVnI989o7/kMrlJgdiwiAiuXOzm7Nbw+zGjjMGOdbK20ixyr1RyIUFGhf7komHYisSg6nCl7nfMKgAn9TuV7VOIOltcJbp2Xp+S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=inp9/OsL; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 35D6896376D;
	Tue, 28 Oct 2025 22:41:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1761687718; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=gZ5NbpYQJrK4cD/+AbyhMOYq6Bv8S/UjgbyYkKNU+Oo=;
	b=inp9/OsLLdIqL8yyl4LVrqRp7grNsLNrIOtcJILxcGEu/QUVCKR9ud7G174KyZVXqm1xzA
	EXUJfGhDh9E1YpGwn3jyzJg6/GQHDb/pnME1+IGe/tA3zpyXJwKBRK56OK6b3I0dD/iy2M
	Cr4xYL0mDojMOuPbAvRj1Yvvmz0EivIT/jvRpsLOU366duDdg9ouea40+CvU8BNsdhrU8L
	vWctRfTHt6c65LkpEQqilThB6hE1j1jnwOyKR/+jZXW8J0gndcAXUGa1yAilqmkfxoNLtL
	vLvOUj/0Hted5+u0GOrjO4mCTPpUAwox8n44YbVFZdbhgy7k0VPceUcgLdq7Qg==
Message-ID: <096509d1-4af8-4abc-8068-ca27d8ef601e@cjdns.fr>
Date: Tue, 28 Oct 2025 22:41:52 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] wifi: mt76: mmio_(read|write)_copy byte swap when on Big
 Endian
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
 shayne.chen@mediatek.com, sean.wang@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20251027171759.1484844-1-cjd@cjdns.fr>
 <CAOiHx=nSEP=4s2xZuPtLEO43YDbkNEYzw6V11JbXG0H2iPn7Ag@mail.gmail.com>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <CAOiHx=nSEP=4s2xZuPtLEO43YDbkNEYzw6V11JbXG0H2iPn7Ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3


On 28/10/2025 21:19, Jonas Gorski wrote:
> Hi,
>
> On Mon, Oct 27, 2025 at 6:19 PM Caleb James DeLisle <cjd@cjdns.fr> wrote:
>> When on a Big Endian machine, PCI swaps words to/from LE when
>> reading/writing them. This presents a problem when we're trying
>> to copy an opaque byte array such as firmware or encryption key.
>>
>> Byte-swapping during copy results in two swaps, but solves the
>> problem.
>>
>> Fixes:
>> mt76x2e 0000:02:00.0: ROM patch build: 20141115060606a
>> mt76x2e 0000:02:00.0: Firmware Version: 0.0.00
>> mt76x2e 0000:02:00.0: Build: 1
>> mt76x2e 0000:02:00.0: Build Time: 201607111443____
>> mt76x2e 0000:02:00.0: Firmware failed to start
>> mt76x2e 0000:02:00.0: probe with driver mt76x2e failed with error -145
>>
>> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
>> ---
>>   drivers/net/wireless/mediatek/mt76/mmio.c | 34 +++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mmio.c b/drivers/net/wireless/mediatek/mt76/mmio.c
>> index cd2e9737c3bf..776dbaacc8a3 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mmio.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mmio.c
>> @@ -30,15 +30,49 @@ static u32 mt76_mmio_rmw(struct mt76_dev *dev, u32 offset, u32 mask, u32 val)
>>          return val;
>>   }
>>
>> +static void mt76_mmio_write_copy_portable(void __iomem *dst,
>> +                                         const u8 *src, int len)
>> +{
>> +       __le32 val;
>> +       int i = 0;
>> +
>> +       for (i = 0; i < ALIGN(len, 4); i += 4) {
>> +               memcpy(&val, src + i, sizeof(val));
>> +               writel(cpu_to_le32(val), dst + i);
>> +       }
>> +}
>> +
>>   static void mt76_mmio_write_copy(struct mt76_dev *dev, u32 offset,
>>                                   const void *data, int len)
>>   {
>> +       if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
>> +               mt76_mmio_write_copy_portable(dev->mmio.regs + offset, data,
>> +                                             len);
>> +               return;
>> +       }
>>          __iowrite32_copy(dev->mmio.regs + offset, data, DIV_ROUND_UP(len, 4));
> Maybe just replace this with memcpy_toio() which does no swapping at
> all instead of double swapping on BE?


I'm not that informed about how PCI works so I had to test to confirm
my understanding, but I can confirm that memcpy_toio() does not solve
the problem.

The issue as I understand it is that rather than making every driver
carefully call cpu_to_le*() every MMIO write, someone decided to make
the PCI host bridge itself transparently byte-swap all MMIO on the
wire. Since most MMIO is hitting registers and most buffers are
transferred by DMA, for the most part everything works and nobody
notices.

But in the rare case that we need to write a blob to MMIO, it gets
transparently swapped in hardware so you need to use cpu_to_le in that
case. Doing a search of ./drivers for write.*cpu_to_le I can see this
issue comes up a bit.


Thanks,

Caleb


>
>>   }
>>
>> +static void mt76_mmio_read_copy_portable(u8 *dst,
>> +                                        const void __iomem *src, int len)
>> +{
>> +       u32 val;
>> +       int i;
>> +
>> +       for (i = 0; i < ALIGN(len, 4); i += 4) {
>> +               val = le32_to_cpu(readl(src + i));
>> +               memcpy(dst + i, &val, sizeof(val));
>> +       }
>> +}
>> +
>>   static void mt76_mmio_read_copy(struct mt76_dev *dev, u32 offset,
>>                                  void *data, int len)
>>   {
>> +       if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
>> +               mt76_mmio_read_copy_portable(data, dev->mmio.regs + offset,
>> +                                            len);
>> +               return;
>> +       }
>>          __ioread32_copy(data, dev->mmio.regs + offset, DIV_ROUND_UP(len, 4));
> And memcpy_fromio() here.
>
> Best regards,
> Jonas

