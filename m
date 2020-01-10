Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48E89136C0D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2020 12:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgAJLih (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jan 2020 06:38:37 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42865 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgAJLig (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jan 2020 06:38:36 -0500
Received: by mail-oi1-f196.google.com with SMTP id 18so1569320oin.9
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2020 03:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OEIFJr+GmGk8WocgujnwIkVDO/F3Z6l/Md+EkF8+Kno=;
        b=qeijmgoXDNEHwPlrB6+Bgzs5L7Qx/4Hm+g2oqEwNOTaTea6Z08blR0WKvaHynSGY7U
         UGNnmekcq8ENuEXwJSqgyS4IZZQeqpfknwc5fY9/Gn8cFbWqNRbWWCapXNG5rxyoX4/b
         uGUy5i4x5V5hLoXvwWod2UX6xTkkhfoiRUfCPYp8gaCvL/o7a9q9jqNTRPDqPx76jrAb
         XdVdKZczehlxva2j3vv6mFI0f1NhfV+RpbUOPADoxVHSpGQOz2U4E4KOZiKW0QmzPFrp
         gd6BToJqrV1hSGF331+28CAdCTuSz9RdyyEfJwuquJohUP1mu4hB/A5qZEFKIiEmSqS6
         ccAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OEIFJr+GmGk8WocgujnwIkVDO/F3Z6l/Md+EkF8+Kno=;
        b=soMKy/yDG0jTeOsLkitpPvBUuKTKAguxi215EF3p+VakxJ2s5KgUKm7YYF6PS+ivG8
         425FN/5ubFL0AKCYoluslaWIyTWtESaGpTIsob9aN8Mgl89536XuzBDZU/WNgAzAGtlk
         VMBU3U4yKRx5iP2z5i9SKE3oIKaoeZDNKRhoUD5JYIed3uMSKjwtPrfKeeqCdEPBZAmB
         CpbkXmGn3St2kga3jHWcZUlo4MR8mA/84bXvpivDLc6KjuK9A/esj/ikr3wzuNP64WSN
         V/MDNjkG5DpqZYKB4siHI//7zpNjBQZivv4XgyG6TYfjlqQjqM+gl6H0M3NkkKuv3mwx
         Fi3Q==
X-Gm-Message-State: APjAAAX5A2jEhuDdaOGQpgGnshVLpLuGooUvLbbo9CB7m3q7GRaRRTcl
        3JGfG2vP9Nvh1Ya1w0a1wpAjYWB53xKLZZ+xDwk=
X-Google-Smtp-Source: APXvYqwEjEjH2uDXh1QSrp0qpNWq44L+0Q93LINVxh3wSi9AMY7JwcRY17Dr4pvkQ6dx9vaRNPsPU/z3ZbmyxG3hXJ0=
X-Received: by 2002:a05:6808:319:: with SMTP id i25mr1965720oie.128.1578656316349;
 Fri, 10 Jan 2020 03:38:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:362:0:0:0:0:0 with HTTP; Fri, 10 Jan 2020 03:38:35 -0800 (PST)
In-Reply-To: <87v9pjsom7.fsf@codeaurora.org>
References: <CAKoLU8M+QU-96vnfet-759nnXyxxJmsf1Csba4FgNas8ZVOnOQ@mail.gmail.com>
 <87v9pjsom7.fsf@codeaurora.org>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Fri, 10 Jan 2020 12:38:35 +0100
Message-ID: <CAKR_QVLBuW-FhRVdm6h2prRqSwoSpyt1GF=cUtXd_KPJjU5V+g@mail.gmail.com>
Subject: Re: [PATCH 1/1] ath9k: fix firmware bug in some of Mikrotik
 R11e-2HPnD cards
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Denis Kalashnikov <denis281089@gmail.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/01/2020, Kalle Valo <kvalo@codeaurora.org> wrote:
> Denis Kalashnikov <denis281089@gmail.com> writes:
>
>> Some of the Mikrotik R11e-2HPnD cards have EEPROM where is
>> flashed that a card has 3 chains, but actually all this cards
>> have only 2. This leads ath9k to write periodically into the logs:
>> 'ath: phy0: Unable to reset channel, reset status -5' and
>> stations don't see that AP.
>>
>> Mikrotik R11e-2HPnD is based on AR9582 chip.
>>
>> Signed-off-by: Denis Kalashnikov <denis281089@gmail.com>
>> ---
>>  drivers/net/wireless/ath/ath9k/ar9003_eeprom.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
>> b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
>> index b4885a700296..554a81400648 100644
>> --- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
>> +++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
>> @@ -3373,6 +3373,15 @@ static int
>> ar9300_eeprom_restore_internal(struct ath_hw *ah,
>>                 cptr -= (COMP_HDR_LEN + osize + COMP_CKSUM_LEN);
>>         }
>>
>> +       /**
>> +        * Fix firmware bug of some Mikrotik R11e-2HPnD cards (based on
>> AR9582)
>> +        * that claim that they have 3 chains, but actually have only 2.
>> +        */
>> +       if (AR_SREV_9580(ah)) {
>> +               eep = (struct ar9300_eeprom *)mptr;
>> +               eep->baseEepHeader.txrxMask &= 0x33;
>> +       }
>
> What about 9580 devices which really have 3 chains, doesn't this broke
> those? Or is such setup impossible?
>
> --
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>

See this:
https://openwrt.org/_media/media/tplink/tl-wdr4310/tl-wdr4310_11.jpg

This commit would definitely break it. The fix should involve PCI sub
id of the miktrotik card
