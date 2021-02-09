Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21653152FF
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 16:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhBIPmw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 10:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbhBIPmv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 10:42:51 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD016C061786
        for <linux-wireless@vger.kernel.org>; Tue,  9 Feb 2021 07:42:10 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o21so11284431pgn.12
        for <linux-wireless@vger.kernel.org>; Tue, 09 Feb 2021 07:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=HGhzD2n8ENZ+9Ec86+xCQyVCG02w4u1hmjyaVQPFYDo=;
        b=cr0XD5mRv1N7OinaucwXNyX4GBGWVWcBYje9MfxnMqE1Kg2KQqPZ+S1lehS90Ye3XR
         tiHtVIeVy3YLW39AKR6O+KPopkAkMivI4HxY7zjHnpVa0mR85Z23jDM8lPGGAbvwMgMZ
         MmaFBZoyd69rwuYzfx/5ABQ8+sTmJf+hKfz1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=HGhzD2n8ENZ+9Ec86+xCQyVCG02w4u1hmjyaVQPFYDo=;
        b=FPrgP9JZDQfW21ggAYqK6QvgiQG/r1/0MZnBtBsJFiBY5OKM+b08WA/6Y/ApbeqlnW
         QuDBYbCyZtXFn1fCEVSwAVqB/OIsT9wc1fxCK15KzGAW5lM1X/FXbwPCvGjPXpI/P9fl
         2HcMtycb00GHphQyR2B9y19ERLzTclsAgMiPuSBaWLpkB1bYA5AqqutRttVXwW+7FECI
         19S8Jg6SiOohHrVpBbvOlgvbhWoSBClRUKI7v1kRqsuSbSrMDkNkZJgr/HJ66Ax+9XTZ
         8RHE5Y2ceK4XEC5PXnIOSMlKnJHOolkhn+e0ox3pixFiqA6VZx4KnXeZq5iE6dF78zF6
         Goag==
X-Gm-Message-State: AOAM530MwVNaHp08ZHgyUP7IsYz07UqiRj9S9SVpFJc9Dp60AvLH6e8p
        JDrTpl6UTcvHxgYHZI7arVoR4UyyBDncp8Dqd9k9pSapRVRjD7jCF2raIXzREAPspOJpGkcEBFH
        7Pj0//hL04l7aXzDcgX4MUAEcUoR/B5E/TcdlTb9qgixP84X0rWDxbJc03+n7qtPCOyZ5uiEeig
        PD2Ul5MC/x45alBRSgbq0=
X-Google-Smtp-Source: ABdhPJz3QMnEjkR81Ah9xGu7hfD4uScayJmaQMq6iMTmpWpbMqswAbMTf1TPBXxXpkl9hqRUlOpw5Q==
X-Received: by 2002:aa7:9790:0:b029:1d8:263e:cc9b with SMTP id o16-20020aa797900000b02901d8263ecc9bmr21502580pfp.2.1612885329561;
        Tue, 09 Feb 2021 07:42:09 -0800 (PST)
Received: from [10.230.40.53] ([192.19.152.250])
        by smtp.gmail.com with ESMTPSA id u127sm5827624pfb.180.2021.02.09.07.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 07:42:08 -0800 (PST)
Subject: Re: [RFC] Introduce NL80211_IFTYPE_MLO_LINK_DEVICE for MLO link (IEEE
 802.11be)
To:     usdutt@codeaurora.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <1607526302-8063-1-git-send-email-usdutt@codeaurora.org>
 <9320c4f30cd3ba67ababf8e245963b656e2bf1ad.camel@sipsolutions.net>
 <73cb65ef-8635-5aad-d22d-3764e919f55d@broadcom.com>
 <3ca768c27ba95438b3867c03d17e2cef@codeaurora.org>
 <dab75b5e16e0c1a4b97632e5f4cc3310@codeaurora.org>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5e229fce-2468-425f-404b-3a059cac7a94@broadcom.com>
Date:   Tue, 9 Feb 2021 16:42:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <dab75b5e16e0c1a4b97632e5f4cc3310@codeaurora.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002c335d05bae9218a"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--0000000000002c335d05bae9218a
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/9/2021 3:48 PM, usdutt@codeaurora.org wrote:
> On 2020-12-23 21:59, usdutt@codeaurora.org wrote:
>> On 2020-12-14 14:55, Arend van Spriel wrote:
>>> On 09-12-2020 16:36, Johannes Berg wrote:
>>>> Hi,
>>>>
>>>>> Multi-link support is introduced in 802.11be specification.
>>>> [...]
>>>>
>>>> I'll definitely have to take a closer look at this and the spec and
>>>> think about it - but a couple of quick comments below.
>>
>> Thanks for your comments. Please allow me to address your comments in
>> the subsequent patches.
>> Our main intention through this RFC is to get the view on the proposal
>> to introduce a new NL80211_IFTYPE for an MLO Link.
>> Please suggest on this.
>>
>>
>>> Did not get my hands on the spec yet, but just firing random thoughts.
>>> This multi-link support sounds a bit like bonding. Could that be
>>> leveraged for wireless? I wonder why there is a need for a non-netdev
>>> interface. Does networking layer need to be aware of the multi-link
>>> for scheduling traffic to it? Is there one driver per multi-link or
>>> per radio?
>>
>> The following is what the Bonding driver / interface does for the
>> multiple network interfaces.
>> 1. Bonding driver aggregates multiple network interfaces into a single
>> logical bonded interface.
>> 2. Each network interface is called as a slave in the bonding driver.
>> 3. It=E2=80=99s the Bonding driver that schedules the traffic across the=
se=20
>> slaves.
>> 4. Bonding interface operates on one of the following modes (
>> mentioning for a quick reference ).
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 balance-rr : Round-robin policy: Tr=
ansmit packets in sequential
>> order from the first available slave through the last.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 active-backup : Only one slave in t=
he bond is active. A
>> different slave becomes active if, and only if, the active slave
>> fails.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 balance-xor : Transmit based on the=
 selected transmit hash policy.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 balance-tlb : channel bonding that =
does not require any special
>> switch support. The outgoing traffic is distributed according to the
>> current load
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 balance-alb : includes balance-tlb =
plus receive load balancing.
>> 5. With the above modes, the scheduling of the traffic is determined
>> with in the kernel / bonding driver and have the host driver /
>> firmware follow it.
>>
>> The following are the factors for not considering the MLO Link as a
>> bonding interface and further to propose this RFC
>> (new NL80211_IF_TYPE -> NL80211_IFTYPE_MLO_LINK_DEVICE).
>>
>> 1. For MLO, our intention is to allow the traffic scheduling (among
>> the MLO links) to be closer to the lower layers in
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the driver/firmware, etc, unl=
ike the bonding driver where
>> kernel schedules the traffic.
>> 2. If MLO Link has to use a bonding interface, each MLO link has to be
>> associated with a network interface and thus each
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of the MLO link has to be of =
NL80211_IF_TYPE=C2=A0 ->=20
>> NL80211_IFTYPE_STATION.
>> 3. This further means that NL80211_CONNECT / NL80211_ASSOCIATE needs
>> to get triggered on each of this MLO Link of the
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MLO connection.
>> 4. Our intention is to consider the MLO station as a single network
>> interface . More specifically, have a single
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NL80211_CONNECT / NL80211_CMD=
_ASSOCIATE triggered for each MLO
>> connection ( MLD + MLO Links).
>> 5. The reason we had to introduce a new NL80211_IF_TYPE ->
>> NL80211_IFTYPE_MLO_LINK_DEVICE is to have the corresponding
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link connection specific informatio=
n ( e.g., Connection State,
>> Connected BSS Info, Connection Frequency/properties, etc),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for each wdev / MLO Link and at the=
 same=C2=A0 time have a single
>> connect / association request to the driver / AP.
>> 6. Further, these NL80211_IFTYPE_MLO_LINK_DEVICE link devices shall
>> represent an MLO Link and attribute to a network interface ( MLD ) of
>> an
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MLO connection.
>> 7. The current proposal to introduce a new NL80211_IF_TYPE should
>> support the architectures of MLO links across the multiple wiphy
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interfaces or on the same wip=
hy interface. These wiphy
>> interfaces can be from different drivers too.
>>
>> Please review the above.
>>
>>>
>>> [...]
>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *msg;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *hdr;
>>>>> +=C2=A0=C2=A0=C2=A0 struct nlattr *nested, *nested_mlo_links;
>>>>> +=C2=A0=C2=A0=C2=A0 struct cfg80211_mlo_link_device_params *mlo_link;
>>>>> +=C2=A0=C2=A0=C2=A0 int i =3D 0;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg =3D nlmsg_new(100 + cr=
->req_ie_len + cr->resp_ie_len +
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 cr->fils.kek_len + cr->fils.pmk_len +
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (=
cr->fils.pmkid ? WLAN_PMKID_LEN : 0), gfp);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (=
cr->fils.pmkid ? WLAN_PMKID_LEN : 0) +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (=
cr->n_mlo_links ? cr->n_mlo_links * 32 : 0), gfp);
>>>>
>>>> 32 probably should be some NLA_SIZE or something constant?
>>>
>>> Probably sizeof(*mlo_link) ?
>>>
>>>> There's also no point in the ternary operator since 0 * 32 is 0 :)
>>>>
>>>>> =C2=A0 /* Consumes bss object one way or another */
>>>>> @@ -833,7 +849,9 @@ void cfg80211_connect_done(struct net_device *dev=
,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ev =3D kzalloc(sizeof(*ev) + (params->=
bssid ? ETH_ALEN : 0) +
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 params->req_ie_len + params->resp_ie_len +
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 params->fils.kek_len + params->fils.pmk_len +
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (params->fils.pmkid ? WLAN_PMKID_LEN : 0), gfp);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (params->fils.pmkid ? WLAN_PMKID_LEN : 0) +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (params->n_mlo_links ? params->n_mlo_links *
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 sizeof(struct cfg80211_mlo_link_device_params) : 0),=20
>>>>> gfp);
>>>>
>>>> same here, no need for the ternary
>>>>
>>>>
>>>> It feels strangely asymmetric to have stop and no start ... but I gues=
s
>>>> that's the part where I need to think about it and look a bit at how i=
t
>>>> all works :)
>>>
>>> Had the same feeling in my gutt (wherever that is ;-)
>>
>> Sure. Will take this point. In fact, this was documented in the commit
>> message to consider the start (say start_mlo_link), but do not want
>> the drivers to depend on this trigger for starting the MLO link.
>> For example, the host drivers with SME can as well start the MLO Link
>> after getting the Assoc response for MLO links from the AP.
>>
>>
>>>
>>> Regards,
>>> Arend
>=20
> Hi,
>=20
> Can you please provide your comments on the proposal.
> We wanted to hear your feedback on the following points.
>=20
> Represent MLO link of an MLO connection by a wdev of type=20
> NL80211_IFTYPE_MLO_LINK_DEVICE.
> MLO link wdev does not have an active netdev associated to it but will=20
> be similar to that of NL80211_IFTYPE_STATION, w.r.t maintaining link=E2=
=80=99s=20
> connection information ( connected channel , BSSID, etc).
> MLD interface of an MLO connection will be a station interface=20
> (NL80211_IFTYPE_STATION wdev) This station interface shall link the=20
> wdev=E2=80=99s of all the MLO link wdev=E2=80=99s part of the MLO connect=
ion. Cfg80211=20
> layer shall link all such wdev=E2=80=99s.
> Such MLO Link wdev=E2=80=99s shall be part of the same wiphy or different=
 wiphy=20
> (if host driver's register a single wiphy for each supported band/MAC/PHY=
).
> MLO link wdev (NL80211_IFTYPE_MLO_LINK_DEVICE) is created by the user=20
> space prior the MLO connection.

 From your explanation earlier it makes more sense to me now.

> User space can as well change the interface type among=20
> NL80211_IFTYPE_STATION wdev To NL80211_IFTYPE_MLO_LINK_DEVICE wdev. To=20
> support the use case where an existing STA wdev can change to a MLO wdev=
=20
> and vice versa.

This seems complicated especially for the "vice versa" scenario where=20
wdevs may be linked to it across different wiphy instances. btw. would=20
that also mean different drivers. I suspect it does, right?

Your explanation seems to focus on the station side of the MLO link, but=20
I think on the AP side one would also setup a MLO link. Would the MLD=20
interface be an AP interface in that case?

Actually, if I am not too confused here then what you call an "MLO link"=20
device is called MLD in the spec.:

"""
multi-link device (MLD): A device that is a logical entity and has more=20
than one affiliated station (STA) and has a single medium access control=20
(MAC) service access point (SAP) to logical link control (LLC), which=20
includes one MAC data service.
"""

The spec refers to AP MLD and non-AP MLD.

Regards,
Arend

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--0000000000002c335d05bae9218a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
pra5sIx/TR6gNtLG9MpND9zQt5j42hInkP81vqu9DG8lovoPMuR0JVpFRbPjHZ07cLqqbFMVS/8z
53iSewIDAQABo4IB0zCCAc8wDgYDVR0PAQH/BAQDAgWgMIGeBggrBgEFBQcBAQSBkTCBjjBNBggr
BgEFBQcwAoZBaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NwZXJzb25hbHNp
Z24yc2hhMmczb2NzcC5jcnQwPQYIKwYBBQUHMAGGMWh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNv
bS9nc3BlcnNvbmFsc2lnbjJzaGEyZzMwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAw
RAYDVR0fBD0wOzA5oDegNYYzaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc3BlcnNvbmFsc2ln
bjJzaGEyZzMuY3JsMCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYD
VR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUaXKCYjFnlUSFd5GAxAQ2SZ17C2EwHQYDVR0O
BBYEFHAaaA+cRo3vYiA6aKVu1bOs4YAYMA0GCSqGSIb3DQEBCwUAA4IBAQCYLdyC8SuyQV6oa5uH
kGtqz9FCJC/9gSclQLM8dZLHF3FYX8LlcQg/3Ct5I29YLK3T/r35B2zGljtXqVOIeSEz7sDXfGNy
3dnLIafB1y04e7aR+thVn5Rp1YTF01FUWYbZrixlVuKvjn8vtKC+HhAoDCxvqnqEuA/8Usn7B0/N
uOA46oQTLe3kjdIgXWJ29JWVqFUavYdcK0+0zyfeMBCTO6heYABeMP3wzYHfcuFDhqldTCpumqhZ
WwHVQUbAn+xLMIQpycIQFoJIGJX4MeaTSMfLNP2w7nP2uLNgIeleF284vS0XVkBXSCgIGylP4SN+
HQYrv7fVCbtp+c7nFvP7MYICbzCCAmsCAQEwbTBdMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gMiBDQSAtIFNI
QTI1NiAtIEczAgxR3m7Pj6LvQiWjJy0wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIE
IF7QQ2qe87+B+HvkoL+u28+TvjuSQthLIqi1HpDdnpjVMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIxMDIwOTE1NDIxMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQow
CwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA/u9La8b3NqzA5iA/C
ZjwHC1zxuliSmtGxbm3PMLM4RJIxCybQsQOZa8EKuG8QdQ8HnHOOGmRNgjrUPp7+CgP/eWmyGIcU
YadoO7HH6+UAVLaC8w2ZCAAMrXt4OyAXQQOPosVcFAsv0Tqr14kDDTVGV2uotStjNbi+S8Q6R9eY
4zOAT6/v95qGoGWhrG8xN2JSdiiHUAL9/+PNa0B9YG8znmkz8QStlsmXtDbK4DY4WviZZKdHAp6q
gGBrOVpTPsNWBfElywaMf8QeiGt/nkQHaXxXOd53z12oUVVpVooorlJkYiLL6+XRujFx8jV1NBPw
/TjWGr9hk/EACAnO41ZK
--0000000000002c335d05bae9218a--
