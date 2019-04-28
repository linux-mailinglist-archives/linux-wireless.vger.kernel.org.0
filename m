Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAC97BDBC
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 00:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfD1WU5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Apr 2019 18:20:57 -0400
Received: from 4.mo1.mail-out.ovh.net ([46.105.76.26]:44904 "EHLO
        4.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfD1WU5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Apr 2019 18:20:57 -0400
X-Greylist: delayed 2104 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Apr 2019 18:20:56 EDT
Received: from player799.ha.ovh.net (unknown [10.108.35.215])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id DD88E16981D
        for <linux-wireless@vger.kernel.org>; Sun, 28 Apr 2019 23:35:55 +0200 (CEST)
Received: from RCM-web2.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player799.ha.ovh.net (Postfix) with ESMTPSA id 7DBA85314347;
        Sun, 28 Apr 2019 21:35:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 28 Apr 2019 23:35:48 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com
Subject: Re: [PATCH] brcmfmac: print firmware messages after a firmware crash
In-Reply-To: <2ccb4482-7561-0812-92dc-5de3d639cc3e@broadcom.com>
References: <20190427183008.27111-1-zajec5@gmail.com>
 <2ccb4482-7561-0812-92dc-5de3d639cc3e@broadcom.com>
Message-ID: <904ea13804cc1e1edacbe9485729d1d8@milecki.pl>
X-Sender: rafal@milecki.pl
User-Agent: Roundcube Webmail/1.3.9
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
X-Ovh-Tracer-Id: 2070248457268727424
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddriedtgdduieeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-04-28 23:06, Arend Van Spriel wrote:
> On 4/27/2019 8:30 PM, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>> 
>> Normally firmware messages are printed with debugging enabled only. 
>> It's
>> a good idea as firmware may print a lot of messages that normal users
>> don't need to care about.
>> 
>> However, on firmware crash, it may be very helpful to log all recent
>> messages. There is almost always a backtrace available as well as 
>> rought
>> info on the latest actions/state.
> 
> nice... there is one minor nit below, but other than that...
> 
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>>   .../broadcom/brcm80211/brcmfmac/pcie.c        | 24 
>> ++++++++++++++-----
>>   1 file changed, 18 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c 
>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>> index 637973fe8928..f519b050aff3 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>> @@ -764,15 +764,22 @@ static void brcmf_pcie_bus_console_init(struct 
>> brcmf_pciedev_info *devinfo)
>>   		  console->base_addr, console->buf_addr, console->bufsize);
>>   }
>>   -
>> -static void brcmf_pcie_bus_console_read(struct brcmf_pciedev_info 
>> *devinfo)
>> +/**
>> + * brcmf_pcie_bus_console_read - reads firmware messages
>> + *
>> + * @error: specifies if error has occurred (prints messages 
>> unconditionally)
>> + */
>> +static void brcmf_pcie_bus_console_read(struct brcmf_pciedev_info 
>> *devinfo,
>> +					int error)
> 
> Given how it is called I would say 'bool error' makes a bit more sense.

I even call that function passing "true" or "false" as argument. Nice
catch!
