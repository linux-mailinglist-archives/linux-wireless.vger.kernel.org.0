Return-Path: <linux-wireless+bounces-28371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA8AC1C48A
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 17:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331F7660726
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 15:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88B7306498;
	Wed, 29 Oct 2025 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="GMzqksbi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7582E62D0;
	Wed, 29 Oct 2025 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751450; cv=none; b=u8qxT2fUyP2SQ4Ut1nMZL7ENr4NtHwsySkRFQ1lwfchuFkm7L+Wbp/69Po2pvrSu3cRtYWa3X12PYMS33Fccsi6l3waqz+PPq5Xh3uwnEzhD/EOpaMvp0pnu7yOy9BlJLt9dfPk9l+nBfHIOkKKS1LgpoLyZd58CrSEzrjdz3Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751450; c=relaxed/simple;
	bh=Kc7TKxqdTAkBbKBEgmqy8X5D6Sk0jxfuz4PoU0lTyQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioAqAhuQc4b3jtNaHR1WcCtNgHszgNBOWDioeMFwXY03Af9iwxdRJOAckUe9G8XlweUJ6IQO80Wy8oe3vp1aNJdgoambx1dBWybmPfwtPdLeemM8CFBX1Wtv5XreS5J2CIXMIxQTQIci2O8aB7Zv5BgGhtC7EGnkjpKrREk058o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=GMzqksbi; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 720BE97CC4D;
	Wed, 29 Oct 2025 16:24:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1761751445; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=S7JJudnfDv5QPdu5hrZsVzBT2WDQqBEsqAz/usdjoJc=;
	b=GMzqksbihEI9h21HrYWmiGqL8DwFW+vR30PryrlhdUibq9cgDf5RXlAVc6CRsbNd7zE2X7
	Q68OsUnzXYFdexUShEILw0xgdvIb8L5ItovjpLA2IuNBoSdvljt5puOrcp9NS6dpn1k1j7
	J5bmhNBx58AcIZnFGY8MmcD6s2wfr5V4mpoEuTdQy2dIdEIxO+geBHcBdg1Hz7wqiuB7yV
	9gZjtwZ+OaoYAXNi9l0HWhZQ/+iobzThfmOjFpYF1TC2AEUU6dlbrcjaOq/dsJpso0q2tC
	p3IhzixwYum0ISbxztTdN6bwTR13ijFdQzEflGDbIYKaS+Z2tpyQd7mhR0iKlw==
Message-ID: <4d5fe35f-6841-4b73-9c8c-a1f3bce886c8@cjdns.fr>
Date: Wed, 29 Oct 2025 16:24:00 +0100
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
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>
References: <20251027171759.1484844-1-cjd@cjdns.fr>
 <CAOiHx=nSEP=4s2xZuPtLEO43YDbkNEYzw6V11JbXG0H2iPn7Ag@mail.gmail.com>
 <096509d1-4af8-4abc-8068-ca27d8ef601e@cjdns.fr>
 <CAOiHx=nqWEdHEMf5immXO0VwyzDakDV9AMsoDETcJ0F4FqUt=w@mail.gmail.com>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <CAOiHx=nqWEdHEMf5immXO0VwyzDakDV9AMsoDETcJ0F4FqUt=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3


On 29/10/2025 10:15, Jonas Gorski wrote:
> On Tue, Oct 28, 2025 at 10:42 PM Caleb James DeLisle <cjd@cjdns.fr> wrote:
>>
>> On 28/10/2025 21:19, Jonas Gorski wrote:
>>> Hi,
>>>
>>> On Mon, Oct 27, 2025 at 6:19 PM Caleb James DeLisle <cjd@cjdns.fr> wrote:
>>>> When on a Big Endian machine, PCI swaps words to/from LE when
>>>> reading/writing them. This presents a problem when we're trying
>>>> to copy an opaque byte array such as firmware or encryption key.
>>>>
>>>> Byte-swapping during copy results in two swaps, but solves the
>>>> problem.
>>>>
>>>> Fixes:
>>>> mt76x2e 0000:02:00.0: ROM patch build: 20141115060606a
>>>> mt76x2e 0000:02:00.0: Firmware Version: 0.0.00
>>>> mt76x2e 0000:02:00.0: Build: 1
>>>> mt76x2e 0000:02:00.0: Build Time: 201607111443____
>>>> mt76x2e 0000:02:00.0: Firmware failed to start
>>>> mt76x2e 0000:02:00.0: probe with driver mt76x2e failed with error -145
>>>>
>>>> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
>>>> ---
>>>>    drivers/net/wireless/mediatek/mt76/mmio.c | 34 +++++++++++++++++++++++
>>>>    1 file changed, 34 insertions(+)
>>>>
>>>> diff --git a/drivers/net/wireless/mediatek/mt76/mmio.c b/drivers/net/wireless/mediatek/mt76/mmio.c
>>>> index cd2e9737c3bf..776dbaacc8a3 100644
>>>> --- a/drivers/net/wireless/mediatek/mt76/mmio.c
>>>> +++ b/drivers/net/wireless/mediatek/mt76/mmio.c
>>>> @@ -30,15 +30,49 @@ static u32 mt76_mmio_rmw(struct mt76_dev *dev, u32 offset, u32 mask, u32 val)
>>>>           return val;
>>>>    }
>>>>
>>>> +static void mt76_mmio_write_copy_portable(void __iomem *dst,
>>>> +                                         const u8 *src, int len)
>>>> +{
>>>> +       __le32 val;
>>>> +       int i = 0;
>>>> +
>>>> +       for (i = 0; i < ALIGN(len, 4); i += 4) {
>>>> +               memcpy(&val, src + i, sizeof(val));
>>>> +               writel(cpu_to_le32(val), dst + i);
>>>> +       }
>>>> +}
>>>> +
>>>>    static void mt76_mmio_write_copy(struct mt76_dev *dev, u32 offset,
>>>>                                    const void *data, int len)
>>>>    {
>>>> +       if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
>>>> +               mt76_mmio_write_copy_portable(dev->mmio.regs + offset, data,
>>>> +                                             len);
>>>> +               return;
>>>> +       }
>>>>           __iowrite32_copy(dev->mmio.regs + offset, data, DIV_ROUND_UP(len, 4));
>>> Maybe just replace this with memcpy_toio() which does no swapping at
>>> all instead of double swapping on BE?
>>
>> I'm not that informed about how PCI works so I had to test to confirm
>> my understanding, but I can confirm that memcpy_toio() does not solve
>> the problem.
> Ah, right, I misread _iowrite32_copy() to do conversion to LE, but it doesn't.
>
> What architecture is this you have? PowerPC? ARM? MIPS? 32 bit? 64 bit?


MIPS32 (EcoNet EN751221 34Kc)


>
> So the differences I see are:
>
> 1. __iowrite32_copy() uses __raw_writel(), which has different memory
> semantics than writel()
> 2. __iowrite32_copy() assumed src is aligned to 32 bit, while you
> explicitly align it
> 3. memcpy_toio() will handle unaligned src properly, but does 64 bit
> accesses on 64 bit systems (and uses __raw* again).
>
> Is src aligned? If not, then the issue might be 2. And if your system
> is 64 bit, it would explain why 3 didn't help.


I'm not a regular developer of mt76 so I wasn't sure if that was
guaranteed and I just wanted to code for safety.

After reviewing the code, I see that there are a few places where
mt76_mmio_write_copy is being called with stack-allocated u8 arrays
so it's pretty clear to me that this is being treated as a memcpy-like
function and we should be handling unaligned inputs.


>
> As a first step you could try to replace the writel(cpu_to_le32(val)
> with a iowrite32be(val, ...) which should do the same except avoiding
> the doubled byte swapping. If that works, you can try to replace it

This works.

These symbols are a bit of a nightmare to trace, so I ended up making
an .i file so I could confirm what's happening.

iowrite32be() uses the version in iomap.c so I understand that's using 
writel(swab32(val),port), so a writel with an unconditional byte swap.

writel() is more complicated, it's an inline function that is generated 
in a rat's nest of preprocessor macros in mips/include/asm/io.h

The preprocessed is this:

__mem = (void *)((unsigned long)(mem)); __val = (val); if (sizeof(u32) 
!= sizeof(u64) || sizeof(u64) == sizeof(long)) { *__mem = __val;

The source is this:

     __mem = (void *)__swizzle_addr_##bwlq((unsigned long)(mem));    \
     __val = pfx##ioswab##bwlq(__mem, val);                \
     if (sizeof(type) != sizeof(u64) || sizeof(u64) == sizeof(long)) \
         *__mem = __val;                        \

The line "pfx##ioswab##bwlq(__mem, val);" is ioswabl() and the source
of that explains the issue:

  * Sane hardware offers swapping of PCI/ISA I/O space accesses in hardware;
  * less sane hardware forces software to fiddle with this...

So this confirms my initial understanding, the PCI hardware is doing the
byte swapping unconditionally.


> with __raw_writel(), which then would make this the same as
> __iowrite32_copy, except making sure that src is aligned.


This fails.

Since I'm the maintainer of this SoC and it's still fairly new, I wrote
a trivial kmod to verify that unaligned access is not just silently
returning trash, it works as though it were aligned so alignment is
not the issue.


>
> Also you could replace your memcpy() with get_unaligned((u32 *)(src +
> i)); Should do the same but inline.
Good idea, I will do this.
>> The issue as I understand it is that rather than making every driver
>> carefully call cpu_to_le*() every MMIO write, someone decided to make
>> the PCI host bridge itself transparently byte-swap all MMIO on the
>> wire. Since most MMIO is hitting registers and most buffers are
>> transferred by DMA, for the most part everything works and nobody
>> notices.
>>
>> But in the rare case that we need to write a blob to MMIO, it gets
>> transparently swapped in hardware so you need to use cpu_to_le in that
>> case. Doing a search of ./drivers for write.*cpu_to_le I can see this
>> issue comes up a bit.
> Every (PCI) driver does conversion to LE implicitly by using
> writel/readl (or iowrite32/ioread32) etc do the conversion to/from LE.
> So writel(foo, dst )is a __raw_writel(cpu_to_le32(foo), dst) etc. PCI
> memory is assumed to be in LE. If you are on a little endian system,
> then no byte swapping happens, and on BE it will do byte swapping
> before writing the value.

Okay so it seems that in the case of MIPS, that's not always how it
works.

https://github.com/torvalds/linux/blob/e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6/arch/mips/include/asm/mach-generic/mangle-port.h#L17

Since we don't know if the swap will happen in hardware or software
and (AFAIK) this is not a hot enough path that double-swapping will
have a notable performance penalty, I think the most sane thing to
do is use writel(cpu_to_le32()) and not care if it's swapped back
in the kernel or hardware.

I've just tested writel(get_unaligned_le32(src + i), dst + i);
and confirmed this is working.

Lastly, I'd like to just move everybody over rather than
special-casing Big Endian, but I don't have a Little Endian board
with an mt75x2e on it and no matter how trivial it is, I loathe to
submit a patch that hasn't been tested.

Is there somebody here who can get me a Tested-by for LE ?


Thanks,

Caleb


>
> Best regards,
> Jonas

