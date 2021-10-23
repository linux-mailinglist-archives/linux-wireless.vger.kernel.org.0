Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8CC438344
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Oct 2021 13:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhJWLPZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Oct 2021 07:15:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34972 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229901AbhJWLPY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Oct 2021 07:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634987585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MfXUnGZmQ7WldyAvacNwVyBtB/6xxzgo3pW08Mk5b+s=;
        b=ciNmnoPGYQKzEvd/9JQ1JGIeVUusJWpBpmsbcYDSKDtRgjPIKGdPUgcCN9Zoekl0g4bjX0
        dTI9A6y8lfqJs6h/ztcayaSAEyBg6ovZmhJYu+xLce1AulO73WOdoRPtHhcUqbMNqXkBEs
        m81rDr2lKx5V/50x+qTX23pPbVCMcCo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-TbVh7LwyPCaENS82YuPNyg-1; Sat, 23 Oct 2021 07:13:01 -0400
X-MC-Unique: TbVh7LwyPCaENS82YuPNyg-1
Received: by mail-ed1-f69.google.com with SMTP id v11-20020a056402348b00b003dcf725d986so5976128edc.1
        for <linux-wireless@vger.kernel.org>; Sat, 23 Oct 2021 04:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MfXUnGZmQ7WldyAvacNwVyBtB/6xxzgo3pW08Mk5b+s=;
        b=3O65gCdqvWLcDlmpfvJFHse9+gD9lf6dV/ooFb+bf9OSi1aIRAORO3KnPfEL1V9MOS
         /28j+Slweom7/LpVLb9JqjSluQnYorguCikpDNHECw27qB89wNEldtOysfWtPbXP43hb
         J4urKpB6a1O5J2zTr6yjIIL0lw5wR0mAgh096Cv6O7XRO5h9Xpb1aVrdTQEmxqeJ/gKe
         kEZTXUGXs7h7QeISy21hQOLRivFd7Wt/sfJaiBRsaUGSI1BoUhWEiNpB70g0wJYCt2tQ
         KPidEqhB9b5N2F/g5FPHE/K+LJday5TAYjdxSgo1Il9DghoswpR4QSEZkh0yxpQj/0lP
         oihQ==
X-Gm-Message-State: AOAM533R8hKOgnZPrNX4u8y3D22ZUVWygYkh60Sf6/pEUKL0bh9L85QS
        rulErnA/iXATfTkMbN/DGR4sIroSUQgMCrEL4fNqa0TmcrF5uFhv9Y0SLFKk7UU5DSYKv9wDxOy
        c3ORgL1nouPZK5Um+zmR8+KB5cN4=
X-Received: by 2002:a17:907:7f14:: with SMTP id qf20mr7092821ejc.110.1634987580337;
        Sat, 23 Oct 2021 04:13:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgdHhA+OOx58JB7YAzoz0xLi5DA6u4ocluRQIF+YF6KR46EqOFa7GwVHLeQ/KqT7Bq4V2t1Q==
X-Received: by 2002:a17:907:7f14:: with SMTP id qf20mr7092792ejc.110.1634987580110;
        Sat, 23 Oct 2021 04:13:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ht20sm1391161ejc.97.2021.10.23.04.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Oct 2021 04:12:59 -0700 (PDT)
Message-ID: <b5c23b85-0780-1ff5-5d98-2992f8ee9524@redhat.com>
Date:   Sat, 23 Oct 2021 13:12:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] brcmfmac: firmware: Treat EFI nvram ccode=XT the same as
 ccode=XV
Content-Language: en-US
To:     Arend van Spriel <aspriel@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
References: <20211003160325.119696-1-hdegoede@redhat.com>
 <87fstgghhr.fsf@codeaurora.org>
 <43e39a93-fed1-acbb-517e-94cf0d6d739c@redhat.com>
 <CAJ65rDyNR+a-4=eY=MFXLgXueaTX7yro4bpEnKtOOEYiWCdcbg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJ65rDyNR+a-4=eY=MFXLgXueaTX7yro4bpEnKtOOEYiWCdcbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 10/5/21 10:37, Arend van Spriel wrote:
> On Tue, Oct 5, 2021 at 10:02 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Kalle,
>>
>> On 10/5/21 7:36 AM, Kalle Valo wrote:
>>> Hans de Goede <hdegoede@redhat.com> writes:
>>>
>>>> In some cases the EFI-var stored nvram contains "ccode=ALL", "ccode=XV"
>>>> or "ccode=XT", to specify "worldwide" compatible settings, but these
>>>> ccode-s do not work properly. "ccode=ALL" causes channels 12 and 13 to
>>>> not be available, "ccode=XV" / "ccode=XT" may cause all 5GHz channels
>>>> to not be available.
>>>>
>>>> ccode="ALL" and ccode="XV" where already being replaced with ccode="X2"
>>>> with a bit of special handling for nvram settings coming from an EFI
>>>> variable. Extend this handling to also deal with nvram settings from
>>>> EFI variables which contain "ccode=XT", which has similar issues to
>>>> "ccode=XV".
>>>>
>>>> This fixes 5GHz wifi not working on the HP ElitePad 1000 G2.
>>>>
>>>> This was also tested on a Lenovo Thinkpad 8 tablet which also uses
>>>> "ccode=XT" and this causes no adverse effects there.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> To me worldwide compatible settings mean that channels 12 and 13 should
>>> be disabled, so I'm quite hesitant about this patch.
>>
>> The X2 setting puts channel 12 and 13 in passive / listen-only modes
>> and only starts using them if there is an AP on them.
>>
>> AFAIK this is the same with the XT/XV settings. The problem is that the XT
>> setting results in 5G not being available on some boards even though the
>> hw supports it.
>>
>> Also note that we already use the X2 setting for any EFI supplied nvram
>> files where ccode=ALL or ccode=XV, this just extends the handling we
>> already have to also patch ccode=XT.
> 
> I am not overly excited about this approach that is already in use.
> AFAIK these worldwide codes are tailored for specific
> devices/customers based on their RF components. Using it as fallback
> for other devices in such a generic way could even result in exceeding
> regulatory limits. However, I do not have a better solution for this.
> I am surprised to learn there are nvram out there with ccode=ALL as
> that is for internal use only, but if these devices has SROM than the
> nvram value is ignored. Hopefully, that is the case although given the
> fact that changing it to X2 helps suggests otherwise :-(

Ping? How should we move forward with this. Not having working 5Ghz wifi,
where it does work under Windows really is not good. So we need to fix
this one way or the other.

I would prefer to just treat ccode=XT as we do ccode=XV and replace it
with ccode=X2, but alternatively we could also look at the regrev.

ccode=XT it self seems to be fine, it is the combination of ccode=XT with
regrev=29 (IIRC) which is the problem. The Toshiba wt8-a-102 tablet uses
ccode=XT with regrev=13 and that works fine.

I believe that the issue is that the firmware which we are shipping in
Linux does not support regrev=29 and thus fallsback to some safe
defaults which completely excludes 5G bands.

Patching the regrev is going to involve adding some extra nvram
patching code to the kernel; and should probably be limited to
brcmfmac43241b4 with ccode=XT but if that is more acceptable I
would be happy to do this instead.

Regards,

Hans

