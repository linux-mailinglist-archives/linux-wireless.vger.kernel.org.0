Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C394286A1
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 08:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbhJKGKs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 02:10:48 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:15942 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233802AbhJKGKs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 02:10:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633932529; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=0LTzsi3F0kgObtV8dSQfr4KycDGjW7GT4c0VGHr4zEQ=; b=NS+xHi9IZS0pOacKHM2KiF4iBh1hd4fcsVuOm5oLzaEt3l/4sc6/QBC08I9sikM58BuDaE3d
 zAn5tYxmIhIAoMTYXLVh0TVqtqZ2TOsb6lJVemSxxGTIpUmHb7MkyLYmv8kWaP/AnKCwGvKP
 AaeynUvpJr3kfhTLqIaBr4H9AZo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6163d4e003355859c8239438 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 06:08:32
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0EE97C4338F; Mon, 11 Oct 2021 06:08:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 50174C4360C;
        Mon, 11 Oct 2021 06:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 50174C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arend van Spriel <aspriel@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: Re: [PATCH] brcmfmac: firmware: Treat EFI nvram ccode=XT the same as ccode=XV
References: <20211003160325.119696-1-hdegoede@redhat.com>
        <87fstgghhr.fsf@codeaurora.org>
        <43e39a93-fed1-acbb-517e-94cf0d6d739c@redhat.com>
        <CAJ65rDyNR+a-4=eY=MFXLgXueaTX7yro4bpEnKtOOEYiWCdcbg@mail.gmail.com>
Date:   Mon, 11 Oct 2021 09:08:27 +0300
In-Reply-To: <CAJ65rDyNR+a-4=eY=MFXLgXueaTX7yro4bpEnKtOOEYiWCdcbg@mail.gmail.com>
        (Arend van Spriel's message of "Tue, 5 Oct 2021 10:37:18 +0200")
Message-ID: <878rz05c10.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend van Spriel <aspriel@gmail.com> writes:

> On Tue, Oct 5, 2021 at 10:02 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Kalle,
>>
>> On 10/5/21 7:36 AM, Kalle Valo wrote:
>> > Hans de Goede <hdegoede@redhat.com> writes:
>> >
>> >> In some cases the EFI-var stored nvram contains "ccode=ALL", "ccode=XV"
>> >> or "ccode=XT", to specify "worldwide" compatible settings, but these
>> >> ccode-s do not work properly. "ccode=ALL" causes channels 12 and 13 to
>> >> not be available, "ccode=XV" / "ccode=XT" may cause all 5GHz channels
>> >> to not be available.
>> >>
>> >> ccode="ALL" and ccode="XV" where already being replaced with ccode="X2"
>> >> with a bit of special handling for nvram settings coming from an EFI
>> >> variable. Extend this handling to also deal with nvram settings from
>> >> EFI variables which contain "ccode=XT", which has similar issues to
>> >> "ccode=XV".
>> >>
>> >> This fixes 5GHz wifi not working on the HP ElitePad 1000 G2.
>> >>
>> >> This was also tested on a Lenovo Thinkpad 8 tablet which also uses
>> >> "ccode=XT" and this causes no adverse effects there.
>> >>
>> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> >
>> > To me worldwide compatible settings mean that channels 12 and 13 should
>> > be disabled, so I'm quite hesitant about this patch.
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

What's the conclusion? Should I take this or drop it?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
