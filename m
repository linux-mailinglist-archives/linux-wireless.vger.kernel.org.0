Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFEDFCB873
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 12:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387754AbfJDKh3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 06:37:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58576 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387734AbfJDKh3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 06:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570185447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SDEjJlFGnZEVLKwp53YSkjo+Xm6OguhGW8Vu0chTKKk=;
        b=Qr4YT3KkZtqL3/ThOhJwUqnvuiL2fuMBUA5sCkDC30jCa8Y6d9QDAYloJqtl59lq58pFZk
        5pnqUj2sHlGVjkPBj8cpzfzuSGC4ADpnE8VtsZRQaRMvtiANM/41OiZkpeyHQQZ13ye29v
        3WwYd9DxDAsLYTRAIaBfK+n+0Lc09WU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-JyBuzyrhN46WuAXjtMxoOQ-1; Fri, 04 Oct 2019 06:37:25 -0400
Received: by mail-wr1-f71.google.com with SMTP id k2so2518290wrn.7
        for <linux-wireless@vger.kernel.org>; Fri, 04 Oct 2019 03:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TEaVNH3A7e7GBPdlA+cAKBgNZsoDT0//X3uinQHMMwc=;
        b=NOE7QDWA8lw68lsttIBuHTowRRXTeizE1QlrX/gF/lJxgNKT0XhI/e3CATsEjFRRzz
         ofS0HN0vv3KZxbNPs4hUGRuiWF9eLMQ4k0pgzHOiAXWWMe5duAXTeQM082dJdA4xz3te
         ip9QZ1c+L0yLIoBaX6UO+RYuSYRppZE9ImTqb+35lBBXOCL2p8O6AmiWVe1xG8Vdz2MH
         O6CJj8J/8ifA5buZ7hzxhxQ+vyVczkXrPL0pPWoHtZ3FJEa9ioMR2Juek0QZDDQRJ3tE
         jvcloDfilRHjPOKGfyPUJ5+SKxsqrB3BE/6Jwxs7ZV8u6EYQlath91nAJPXGr4zI+yuV
         8MJA==
X-Gm-Message-State: APjAAAW3EzlADKqXlvx14yRweroqCSTBKqamYNjoSb09FpRrXhtZHgvZ
        JDt2aWHEqrTQR8KuwHna6SMJocYujouODv3YR+hq3dL3/4iA5t9GuYdfy7qgbVzf3eYSFpeJ3GC
        CkVtSJQhF2sViqD40kCnDUgkJvyY=
X-Received: by 2002:a7b:c7d7:: with SMTP id z23mr6566523wmk.137.1570185444156;
        Fri, 04 Oct 2019 03:37:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz8rpVuMWOvRhgaU3ejQq/62DCxgNKxxWaENZh5MnlEcBe0jd3wjb/OmyBqLqnqwlyMWshF8A==
X-Received: by 2002:a7b:c7d7:: with SMTP id z23mr6566507wmk.137.1570185443925;
        Fri, 04 Oct 2019 03:37:23 -0700 (PDT)
Received: from dhcp-44-196.space.revspace.nl ([2a0e:5700:4:11:6eb:1143:b8be:2b8])
        by smtp.gmail.com with ESMTPSA id b186sm11867365wmd.16.2019.10.04.03.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 03:37:23 -0700 (PDT)
Subject: Re: [PATCH 5.4 regression fix] brcmfmac: Fix
 brcmf_cfg80211_get_channel returning uninitialized fields
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
References: <20191003200821.819594-1-hdegoede@redhat.com>
 <87r23ssssh.fsf@codeaurora.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0d86c109-78d3-3858-ae56-e4cdcb056fe4@redhat.com>
Date:   Fri, 4 Oct 2019 12:37:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87r23ssssh.fsf@codeaurora.org>
Content-Language: en-US
X-MC-Unique: JyBuzyrhN46WuAXjtMxoOQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 10/4/19 12:34 PM, Kalle Valo wrote:
> Hans de Goede <hdegoede@redhat.com> writes:
>=20
>> With the new edmg support struct cfg80211_chan_def has been extended
>> with a number of new members. brcmf_cfg80211_get_channel() was not setti=
ng
>> (clearing) these causing the cfg80211_edmg_chandef_valid() check in
>> cfg80211_chandef_valid() to fail. Triggering a WARN_ON and, worse, causi=
ng
>> brcmfmac based wifi cards to not work.
>>
>> This commit fixes this by clearing the entire passed struct to 0 before
>> setting the members used by the brcmfmac code. This solution also makes
>> sure that this problem will not repeat itself in the future if further
>> members are added to the struct.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c=
 b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> index e3ebb7abbdae..480c05f66ebd 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> @@ -5041,10 +5041,10 @@ static int brcmf_cfg80211_get_channel(struct wip=
hy *wiphy,
>>   =09}
>>  =20
>>   =09freq =3D ieee80211_channel_to_frequency(ch.control_ch_num, band);
>> +=09memset(chandef, 0, sizeof(*chandef));
>>   =09chandef->chan =3D ieee80211_get_channel(wiphy, freq);
>>   =09chandef->width =3D width;
>>   =09chandef->center_freq1 =3D ieee80211_channel_to_frequency(ch.chnum, =
band);
>> -=09chandef->center_freq2 =3D 0;
>>  =20
>>   =09return 0;
>>   }
>=20
> Is this a separate issue from the cfg80211 fix:
>=20
> cfg80211: initialize on-stack chandefs
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git/commit=
/?id=3Df43e5210c739fe76a4b0ed851559d6902f20ceb1

No it is the same issue, I was actually wondering if I should do a generic =
fix
instead... I'm glad someone has already fixed this with a generic fix. Assu=
ming the
generic fix is going upstream soon, then this (my) patch can be dropped.

Regards,

Hans

