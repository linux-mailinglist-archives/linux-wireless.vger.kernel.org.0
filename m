Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7005F422011
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Oct 2021 10:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhJEIF0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Oct 2021 04:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55664 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232997AbhJEIEm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Oct 2021 04:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633420957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nVJNKvBiD/1meIFu145oWdtm5Y7SQgO6RyfrEsUyC/8=;
        b=Q30P+V87o0ON33GorEvYXfW0SFUOM5aqoTz72ju+6C14UBfPncQ/sUIavXcoJXh7vQbzgZ
        aM5OBAemdmwn9P+xcbKzl11xS3yihe2uaCPAKQEluzSD6JOTrML2EWb1DbRdX80hJmZ9Gk
        Vd9BHW+TgTIqbPvYB9oF9QrplE4fKK0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-0juU3n_LP6-QRPNhQn_e_w-1; Tue, 05 Oct 2021 04:02:36 -0400
X-MC-Unique: 0juU3n_LP6-QRPNhQn_e_w-1
Received: by mail-ed1-f72.google.com with SMTP id 1-20020a508741000000b003da559ba1eeso19936555edv.13
        for <linux-wireless@vger.kernel.org>; Tue, 05 Oct 2021 01:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nVJNKvBiD/1meIFu145oWdtm5Y7SQgO6RyfrEsUyC/8=;
        b=yzwuyQKK0RpaNif3Su95hZCrzVWr17vG+53Gab8x0BUWl9vzCpdGcuX1b6ILevFh40
         hfjUN8PfDR48BXzcCIEdrsgNlde16rwP0kxfxb8HcmeQLOyM4BB1YBB1sJNCpcIMu+ZB
         wLEBIvpN6Jijc//t5fOIplDliTGU7q4WcAb0zGtq6RQwW025A32GSWj8k6xYTR2Ll5sq
         iGKDo0yRpuRgLcHkrboLb1Y1Qk/KfL8KLZPWAkmN5Tk9UdxMU18I+wxEDSUR6LHTrgsO
         fAB2rKOa08dQMoOw340bHIzgeB+cgQYvYLbrOkk4aaQkk3A6i9NDY/PYmfbfOvE6TkBi
         oM2w==
X-Gm-Message-State: AOAM531tu6Gel32MQ6Jxbrx6irKrwqId8w7UcQwu5m2CFC/zfreB5rG6
        ttROjp1kZk+Le9ee4UiH/vF469ZoDfbHihQj6Xisczd30QdtNI/nn7XwuGC74HjTRzlCJUPo68I
        lqhlUfYodOdBftH7Lq2StHzcoxCQ=
X-Received: by 2002:aa7:c418:: with SMTP id j24mr8392969edq.227.1633420955110;
        Tue, 05 Oct 2021 01:02:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmgXDWFQLlmB565FfObTt6Kz3kd4BoGvi+TPjN7LjNJw6yR6ubkyV+q7HTNqQzWkS+CsMwBA==
X-Received: by 2002:aa7:c418:: with SMTP id j24mr8392949edq.227.1633420954884;
        Tue, 05 Oct 2021 01:02:34 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id k20sm7347192ejd.33.2021.10.05.01.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 01:02:33 -0700 (PDT)
Subject: Re: [PATCH] brcmfmac: firmware: Treat EFI nvram ccode=XT the same as
 ccode=XV
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
References: <20211003160325.119696-1-hdegoede@redhat.com>
 <87fstgghhr.fsf@codeaurora.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <43e39a93-fed1-acbb-517e-94cf0d6d739c@redhat.com>
Date:   Tue, 5 Oct 2021 10:02:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87fstgghhr.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On 10/5/21 7:36 AM, Kalle Valo wrote:
> Hans de Goede <hdegoede@redhat.com> writes:
> 
>> In some cases the EFI-var stored nvram contains "ccode=ALL", "ccode=XV"
>> or "ccode=XT", to specify "worldwide" compatible settings, but these
>> ccode-s do not work properly. "ccode=ALL" causes channels 12 and 13 to
>> not be available, "ccode=XV" / "ccode=XT" may cause all 5GHz channels
>> to not be available.
>>
>> ccode="ALL" and ccode="XV" where already being replaced with ccode="X2"
>> with a bit of special handling for nvram settings coming from an EFI
>> variable. Extend this handling to also deal with nvram settings from
>> EFI variables which contain "ccode=XT", which has similar issues to
>> "ccode=XV".
>>
>> This fixes 5GHz wifi not working on the HP ElitePad 1000 G2.
>>
>> This was also tested on a Lenovo Thinkpad 8 tablet which also uses
>> "ccode=XT" and this causes no adverse effects there.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> To me worldwide compatible settings mean that channels 12 and 13 should
> be disabled, so I'm quite hesitant about this patch.

The X2 setting puts channel 12 and 13 in passive / listen-only modes
and only starts using them if there is an AP on them.

AFAIK this is the same with the XT/XV settings. The problem is that the XT
setting results in 5G not being available on some boards even though the
hw supports it.

Also note that we already use the X2 setting for any EFI supplied nvram
files where ccode=ALL or ccode=XV, this just extends the handling we
already have to also patch ccode=XT.

Regards,

Hans

