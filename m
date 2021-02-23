Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046BD32301F
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Feb 2021 19:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbhBWSAK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Feb 2021 13:00:10 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:61711 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhBWSAF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Feb 2021 13:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614103204; x=1645639204;
  h=subject:to:references:from:cc:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=1rynrO3lZE0ekZZDcP6aHAwnhLmfF6m/p6bbH8C8gmE=;
  b=r2uoMMqv6UyjHS246a/BO5LWj9ONNaUnztEyJLod/Qpv+srNcdrNufYH
   QyF7CG0AgiZ4ho4ANqTTtMTyUwQFcBjzllEZovbITyMMEBmmM/HsukWm/
   tid5uphQH1bpnDc04Yv1mg1Wy3f7b3wTh/W0S3jz3dRTi5RERaXDhWzVo
   00v4DP/MPpRFb53hMAZvRzcJ65vA/FqKJPKTuLX3hA6n2NHg9kHQq2otq
   UGcN+UvXMF3vbPmhCZePemJ+M4HvoBT/AGl6CENzkN966Ph8WAKK22H80
   YRqE+AXryWGhTTcy1gbtsCe7ccoO6Z9TyrRay+OZoeOIsVfcFPlxtDZT9
   g==;
IronPort-SDR: 6IVjcw3jjatefB5WYHy+iLqlqeSZFJwOApraisT1UEezkC9ITeRpRjB53V3j3CumJBiUBX8OHy
 w8XjOR6+JDv7XvuSPf1J/2NillegX/k3GlIYeEP8FLn/8j3ItN4wMlF17Z4mEJXOgzXfhZvZtk
 6oGjwY5CNjTUYKiOtWwTcspk0aeJU8LmWZyN86EiAI1bvD8C4L5A9J+bemYKJ6VsEcyhTgZS1w
 18HDy6IwKL5AuRyDw95lcC5A+2GXpQU+LD6nmqNv/oqeSmHIjMRnK5xlILuH4kXFhCFZQVK8p+
 Blw=
X-IronPort-AV: E=Sophos;i="5.81,200,1610434800"; 
   d="scan'208";a="45181885"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Feb 2021 10:58:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 10:58:48 -0700
Received: from [10.171.246.90] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 23 Feb 2021 10:58:47 -0700
Subject: Re: wilc1000 driver
To:     David Mosberger-Tang <davidm@egauge.net>,
        <Ajay.Kathat@microchip.com>, <linux-wireless@vger.kernel.org>
References: <e8ed97f214f6087b7ac59298c8efe2d1144f7d55.camel@egauge.net>
 <eb6c6b39-f168-7237-d220-585f99532fd9@microchip.com>
 <f3e0540462ed8bcc59787f71e3b1b258945a6142.camel@egauge.net>
 <5fc9c8ad5d93e2172f03515f8275851af285a895.camel@egauge.net>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
CC:     Claudiu Beznea <Claudiu.Beznea@microchip.com>
Message-ID: <b7074cf6-0075-6081-cb72-e97e17a0c6d7@microchip.com>
Date:   Tue, 23 Feb 2021 18:58:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5fc9c8ad5d93e2172f03515f8275851af285a895.camel@egauge.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi David,

On 23/02/2021 at 17:23, David Mosberger-Tang wrote:
> OK, the problem below is caused by wilc_set_power_mgmt().  If I change
> that function into a no-op, the driver actually works!  Does this make
> any sense to you?  From what I saw so far, it looks like relevant code
> is pretty much identical to the one in the linux-at91 tree and that one
> works fine.

One thing that comes off the top of my head is that we use 
power-sequencing drivers in the Linux4SAM trees. The use of pwrseq 
drivers allow us to adapt the power/sequencing/delays/reset to the 
actual board the wilc1000 but moreover the wilc3000 is soldered to.
Indeed the wilc3000 needs special sequence to be up'n running if some 
clock signals are connected to the SoC output for instance.

You can have an example of a pwrseq driver here:
drivers/mmc/core/pwrseq_wilc.c
(https://github.com/linux4sam/linux-at91/blob/master/drivers/mmc/core/pwrseq_wilc.c). 
There are other pwrseq drivers for other WiFi chips and boards there.

True thing is that this sequencing seems dedicated to mmc sub-system and 
I don't know if it can be used for SPI-based WiFi connections or if 
another mechanism exists.

Anyway, hope that it helps.

Best regards,
  Nicolas

> On Mon, 2021-02-22 at 18:49 -0700, David Mosberger-Tang wrote:
>>
>> Now the driver loads the firmware and generally seems to be happy.
>> However, as soon as a packet is received, things go awry.  I'm seeing
>> this:
>>
>> WILC_SPI spi1.0 wlan0: ChipID [1003a0] loading firmware
>> [atmel/wilc1000_wifi_firmware-1.bin]
>> WILC_SPI spi1.0: Failed cmd response, cmd (ca), resp (09)
>>
>> On the SPI bus, I see these commands:
>>
>>   MOSI: 0xC8 0x00 0x00 0x00 0x00 0x00 0x38 (DMA_EXT_READ addr 0 size 56)
>>   MISO: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xC8 0x88 (command response)
>>   -----
>>   MOSI: 0x00
>>   MISO: 0xF3 (DATA header, last packet in this transaction)
>>   -----
>>   MOSI: 0x00*56
>>   MISO:   xx*56 (56 data bytes that may be a legitimate packet)
>>
>> So far so good.  I don't know if this matters, but the last 8 bytes of
>> data all contain 0x09.
>>
>> The problem from then on is that no matter what command is sent, the
>> chip always returns only 0x09 bytes.  For example, the first command
>> after the DMA read is:
>>
>>   MOSI: 0xca 0x00 0x10 0x6c (SINGLE_READ)
>>
>> but the MISO line only returns 0x09, hence the above "Failed cmd
>> response" error.
>>
>> It's as if the chip wants to send much more than 56 data bytes.  The
>> byte-order for the DMA size matches that of the working driver though,
>> so maybe that's not it.
> 
> 
> 


-- 
Nicolas Ferre
