Return-Path: <linux-wireless+bounces-1560-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED138263A0
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jan 2024 10:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88BD282719
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jan 2024 09:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E034212B7B;
	Sun,  7 Jan 2024 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OWDvEciX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F79212B72
	for <linux-wireless@vger.kernel.org>; Sun,  7 Jan 2024 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so984678a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 07 Jan 2024 01:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704621092; x=1705225892; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5/999Cfhsz+SwKZTShzr63KrMrwtIwSJkPRK20Kxlk=;
        b=OWDvEciX659viUEH8dBypx7pjITeHHM4D0vcm2EqdI7ZL5R785zy16lsGIUPMtaA71
         PYEI75k/bB+7JW7h2TlrvZAtGMSK91n3q5iYiuqItIDaDNlrLWGue9Hybma7dBQJQ+s4
         8cfhKCiioAOyyygPtOEtTBEklmya0BYr70UAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704621092; x=1705225892;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D5/999Cfhsz+SwKZTShzr63KrMrwtIwSJkPRK20Kxlk=;
        b=Rw8w81zms/ORVCXIErjKui6b3oJm4d/+AwIPG7mHCsFNFNomvw9KRlEhv8zNbjYcW4
         5tidcSw+GHIFu8DqYRdfd0G8AZ/iCACBJavxjXcJbkI6rOMMaLA17qWa/xjfUnw38ZAz
         Rdg54SVz2iJr+B3hKfnscAvz0nZoFcLwoFbFc0xq24NzbEUKhq7veX8G9Se5OvfS/WNl
         hHrrJPXl+PGpmqLuhb3cxfDrd0uhlE8VF0RmPPG3TZoOcoa4HhsttFZVRoTpNVSCDqej
         QKuQNg0sjnSwBdO1eQrrEqLbuzhmfmcTPUTPO2hAxArHf8dHgfft3a/mqJZAPnRR/+MW
         Vd3Q==
X-Gm-Message-State: AOJu0YxQLgRSV3eYMMXSH9gAGVYHNFpbl4/2BQ1ZWgktZ4jI82tAoUAQ
	vQajp+E6BiUZPCZc1L/p/4wYeflE2oXD
X-Google-Smtp-Source: AGHT+IHsT6xXAoewArnNzMzTd8fDZ9U3aCLoAz06Q20CbRlmqBAryRMUJpX1cmgcaJxrBkvmCa1EiA==
X-Received: by 2002:a50:9f62:0:b0:557:1bc9:2cb4 with SMTP id b89-20020a509f62000000b005571bc92cb4mr869927edf.120.1704621091675;
        Sun, 07 Jan 2024 01:51:31 -0800 (PST)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id w11-20020a056402070b00b0055706e6b1f5sm3115027edx.89.2024.01.07.01.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 01:51:30 -0800 (PST)
Message-ID: <596043b6-e6fa-4530-b140-57a5a55e33bb@broadcom.com>
Date: Sun, 7 Jan 2024 10:51:28 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
To: Hector Martin <marcan@marcan.st>, Kalle Valo <kvalo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Berlin <dberlin@dberlin.org>, Arend van Spriel
 <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>, asahi@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, David Airlie <airlied@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
 <170281231651.2255653.7498073085103487666.kvalo@kernel.org>
 <18c80d15e30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <1b51997f-2994-46e8-ac58-90106d1c486d@marcan.st>
 <c392f901-789a-42e2-8cf7-5e246365a1ca@broadcom.com>
 <CAF4BwTXNtu30DAgBXo4auDaDK0iWc9Ch8f=EH+facQ-_F-oMUQ@mail.gmail.com>
 <87r0jiqmnx.fsf@kernel.org> <01bd8c68-1b9c-49b2-8ace-1c7d1b5192ad@marcan.st>
 <CAHk-=whDLKZZEuxU_jEhZRdeWjXAkL8=J_JRk2Ar6wp9UK3h2w@mail.gmail.com>
 <871qbhqio8.fsf@kernel.org> <4c89b71e-8667-40fe-add0-205748de51ef@marcan.st>
 <bdb078c0-2f45-485a-86a0-bb7d0b5e3516@broadcom.com>
 <d5e26dd4-483d-4662-ba83-5cb19187b24a@marcan.st>
 <31292508-f881-4457-a4bf-2ca0b8e8f435@broadcom.com>
 <37bd3f8a-1000-4d74-8909-5e821cb5c1dc@marcan.st>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <37bd3f8a-1000-4d74-8909-5e821cb5c1dc@marcan.st>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000adc30e060e580643"

--000000000000adc30e060e580643
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/22/2023 6:10 AM, Hector Martin wrote:
> 
> 
> On 2023/12/21 18:57, Arend van Spriel wrote:
>> - SHA-cyfmac-dev-list@infineon.com
>>
>> On 12/21/2023 1:49 AM, Hector Martin wrote:
>>>
>>>
>>> On 2023/12/21 4:36, Arend van Spriel wrote:
>>>> On 12/20/2023 7:14 PM, Hector Martin wrote:
>>>>>
>>>>>
>>>>> On 2023/12/20 19:20, Kalle Valo wrote:
>>>>>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>>>>>
>>>>>>>> Just recently a patch was posted to remove the Infineon list from
>>>>>>>> MAINTAINERS because that company cares so little they have literally
>>>>>>>> stopped accepting emails from us. Meanwhile they are telling their
>>>>>>>> customers that they do not recommend upstream brcmfmac and they should
>>>>>>>> use their downstream driver [1].
>>>>>>>
>>>>>>> Unquestionably broadcom is not helping maintain things, and I think it
>>>>>>> should matter.
>>>>>>>
>>>>>>> As Hector says, they point to their random driver dumps on their site
>>>>>>> that you can't even download unless you are a "Broadcom community
>>>>>>> member" or whatever, and hey - any company that works that way should
>>>>>>> be seen as pretty much hostile to any actual maintenance and proper
>>>>>>> development.
>>>>>>
>>>>>> Sadly this is the normal in the wireless world. All vendors focus on the
>>>>>> latest generation, currently it's Wi-Fi 7, and lose interest on older
>>>>>> generations. And vendors lose focus on the upstream drivers even faster,
>>>>>> usually after a customer project ends.
>>>>>>
>>>>>> So in practise what we try to do is keep the drivers working somehow on
>>>>>> our own, even after the vendors are long gone. If we would deliberately
>>>>>> allow breaking drivers because vendor/corporations don't support us, I
>>>>>> suspect we would have sevaral broken drivers in upstream.
>>>>>>
>>>>>>> If Daniel and Hector are responsive to actual problem reports for the
>>>>>>> changes they cause, I do think that should count a lot.
>>>>>>
>>>>>> Sure, but they could also respect to the review comments. I find Arend's
>>>>>> proposal is reasonable and that's what I would implement in v2. We
>>>>>> (linux-wireless) make abstractions to workaround firmware problems or
>>>>>> interface conflicts all the time, just look at ath10k for example. I
>>>>>> would not be surprised if we need to add even more abstractions to
>>>>>> brcmfmac in the future. And Arend is the expert here, he has best
>>>>>> knowledge of Broadcom devices and I trust him.
>>>>>>
>>>>>> Has anyone even investigated what it would need to implement Arend's
>>>>>> proposal? At least I don't see any indication of that.
>>>>>
>>>>> Of course we can implement it (and we will as we actually got a report
>>>>> of this patch breaking Cypress now, finally).
>>>>>
>>>>> The question was never whether it could be done, we're already doing a
>>>>> bunch of abstractions to deal with just the Broadcom-only side of things
>>>>> too. The point I was trying to make is that we need to *know* what
>>>>> firmware abstractions we need and *why* they are needed. We can't just
>>>>> say, for every change, "well, nobody knows if the existing code works or
>>>>> not, so let's just add an abstraction just in case the change breaks
>>>>> something". As far as anyone involved in the discussions until now could
>>>>> tell, this code was just something some Cypress person dumped upstream,
>>>>> and nobody involved was being responsive to any of our inquiries, so
>>>>> there was no way to be certain it worked at all, whether it was
>>>>> supported in public firmware, or anything else.
>>>>>
>>>>> *Now* that we know the existing code is actually functional and not just
>>>>> dead/broken, and that the WSEC approach is conversely not functional on
>>>>> the Cypress firmwares, it makes sense to introduce an abstraction.
>>>>
>>>> Just a quick look in the git history could have told you that it was not
>>>> just dumped upstream and at least one person was using it and extended
>>>> it for 802.11r support (fast-roaming):
>>>>
>>>>
>>>> author	Paweł Drewniak <czajernia@gmail.com>	2021-08-24 23:13:30 +0100
>>>> committer	Kalle Valo <kvalo@codeaurora.org>	2021-08-29 11:33:07 +0300
>>>> commit	4b51de063d5310f1fb297388b7955926e63e45c9 (patch)
>>>> tree	ba2ccb5cbd055d482a8daa263f5e53531c07667f
>>>> /drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>>> parent	81f9ebd43659320a88cae8ed5124c50b4d47ab66 (diff)
>>>> download	wireless-4b51de063d5310f1fb297388b7955926e63e45c9.tar.gz
>>>> brcmfmac: Add WPA3 Personal with FT to supported cipher suites
>>>> This allows the driver to connect to BSSIDs supporting SAE with 802.11r.
>>>> Tested on Raspberry Pi 4 Model B (STA) and UniFi 6LR/OpenWRT 21.02.0-rc2.
>>>> AP was set to 'sae-mixed' (WPA2/3 Personal).
>>>>
>>>> Signed-off-by: Paweł Drewniak <czajernia@gmail.com>
>>>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>>>> Link: https://lore.kernel.org/r/20210824221330.3847139-1-czajernia@gmail.com
>>>
>>> Sure, but we also had user reports of it *not* actually working (maybe
>>> it regressed?). We didn't know whether it was functional with the
>>> linux-firmware blobs in any way, I wanted confirmation of that. And we
>>> also didn't know that the patch *would* break it at all; perhaps the
>>> Cypress firmware had also grown support for the WSEC mechanism.
>>>
>>> That's why I wanted someone to actually confirm the code worked (in some
>>> subset of cases) and the patch didn't, before starting to introduce
>>> conditionals. There is, of course, also the element that the Cypress
>>> side has been long unmaintained, and if nobody is testing/giving
>>> feedback/complaining, perhaps it's better to err on the side of maybe
>>> breaking something and see if that gets someone to come out of the
>>> woodwork if it really breaks, rather than tiptoeing around the code
>>> without knowing what's going on and without anyone actually testing things.
>>
>> That is because you distrust the intent that Cypress was really
>> contributing. They were and I trusted them to not just throw in a
>> feature like WPA3. When Infineon took over they went mute. Upon
>> reviewing your patch (again) I also sent an email to them asking
>> specifically about the status of the sae_password interface. I did not
>> use the mailing list which indeed bounces these days (hence removed
>> them) but the last living soul that I had contact with about a year ago
>> whether they were still comitted to be involved. I guess out of
>> politeness or embarrassment I got confirmation they were and never heard
>> from him again. The query about the sae_password interface is still pending.
> 
> If only corporate acquisition politics didn't repeatedly throw a wrench
> into this one... :/
> 
> This is where we are though, Infineon clearly doesn't care, so it's time
> to move on.
> 
>>> It's not about this *specific* patch, it's about the general situation
>>> of not being able to touch firmware interfaces "just in case Cypress
>>> breaks" being unsustainable in the long term. I wasn't pushing back
>>> because I think this particular one will be hard, I was pushing back
>>> because I can read the tea leaves and see this is not going to end well
>>> if it's the approach we start taking for everything. We *need* someone
>>> to be testing patches on Cypress, we can't just "try not to touch it"
>>> and cross our fingers. That just ends in disaster, we are not going to
>>> succeed in not breaking it either way and it's going to make the driver
>>> worse.
>>
>> I admire you ability of reading tea leaves. You saw the Grim I reckon.
>> Admittedly your responses on every comment from my side (or Kalle for
>> that matter) was polarizing every discussion. That is common way people
>> treat each other nowadays especially online where a conversation is just
>> a pile of text going shit. It does not bring out the best in me either,
>> but it was draining every ounce of energy from me so better end it by
>> stepping out.
> 
> The hilariously outdated kernel development model surely doesn't help
> either (I've stated my opinion on this quite a few times if you've
> followed around) ;)

It is not a fair statement to call the kernel development process 
outdated. It is a vast code base that needs agreed upon steps to keep it 
rolling as it is. Attend a plumbers conference or collaboration summit 
or better become a speaker and vent all your opinions there and have a 
discussion with community members. They are held yearly and maybe over 
the past years things have been introduced that give more churn than 
value and that would be a great topic for discussion. However, it is 
better left outside of the development workflow.

> This stuff gets *really* frustrating when you're trying to improve what
> is, I hope we can all admit, an undermaintained driver (that is not to
> say it's anyone's fault personally), and end up getting held back due to
> everything from coding style nitpicks to people not having the time to
> be responsive. It's just not helpful. It's important to know when to
> step aside and let people actually get stuff done.
> 
> When Daniel started sending me brcmfmac patches downstream, I took a
> look at a few of them, decided he knew what he was doing, and just
> started pulling in his branches wholesale. Was it perfect? No, I had to
> debug at least one regression at one point. But it took me less time to
> do that than it would've to go through the commits with a fine toothed
> comb, so it was clearly the right decision.

With the patch that started it all I simply had another view based on 
trusting my peers. Infineon has been pulling away from brcmfmac off the 
bat, but Cypress was serious enough about the driver not to drop a heap 
of dung on it. Based on that I felt regressions would be around the 
corner if we took it as is.

> That is not to say that should be the standard upstream (we make a point
> of moving fast and breaking things more downstream, since it's a proving
> ground for what eventually will be upstreamed), but I think it does
> demonstrate the kind of delegation ability that is sorely lacking in
> many drivers and subsystems in the kernel these days. Maintainers become
> entrenched in their position, long beyond the point where they have the
> time/motivation/ability to drive the code forward, and end up in the way
> of new people who are trying to make a difference. I think Linus knows
> full well the kernel maintainer community is stagnating.
> 
> That doesn't mean people should step down entirely. But it does mean
> they need to recognize when this is happening and, at least, proactively
> try to bring new people in, instead of just continuing to play a
> gatekeeping role. The role of maintainers should not be that of a wall
> people have to climb over to get their changes in, it should be to guide
> new contributors and help onboard people who can contribute, as peers
> and eventually as future maintainers.
> 
> Kalle, in the other thread you said "this is not fun anymore, this is
> more like a business with requirements and demands coming from
> everywhere.". That's what it feels like to us when our changes get
> rejected because the local vars aren't in reverse Christmas tree order,
> or because our commit messages have "v2:" in them. It feels like some
> manager is trying to justify their position by creating busywork for
> everyone else. Nobody should actually care about any of those things,
> and if they do, they need to step back and really ask themselves how
> they ended up believing that. If the goal is to enforce a reasonable
> shared coding style so things don't spiral into chaos, FFS, let's just
> do what every other project does these days and adopt clang-format. Then
> *all* of us can stop wasting time on these trivialities and go back to
> getting stuff done. And really, nobody cares about commit messages as
> long as the tags are right, the subject line is succinct, and the
> important information is in there. Extra stuff never hurt anyone.

https://docs.kernel.org/process/clang-format.html#clangformat

Enjoy!!

>> I added the ground work for multi-vendor support, but have not decided
>> on the approach to take. Abstract per firmware interface primitive or
>> simply have a cfg80211.c and fwil_types.h per vendor OR implement a
>> vendor-specific cfg80211 callback and override the default callback
>> during the driver attach, ie. in brcmf_fwvid_wcc_attach(). The latter
>> duplicates things, but lean towards that as it may be easier on the
>> long-term. What do your tea leaves tell you ;-)
> 
> FWIW, I was hoping you'd stay on at least as a reviewer. Your
> contributions are valuable. You obviously know the driver and hardware
> much better than most people. I encourage you to, at least, post a v2 of
> the MAINTAINERS patch with yourself as an R: line.
> 
> As far as the actual driver abstraction architecture, I'm going to leave
> it to Daniel to decide what makes the most sense, since he's the one
> introducing new mechanisms for that already. There's always room for
> refactoring later though, depending on the direction things take with
> the vendor split. BTW, clang-format also makes refactoring a lot less
> painful ;)

Refactoring a single driver is not so painful, but rather a nice 
relaxing puzzle ;-)

--000000000000adc30e060e580643
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCsAoEnlOQKRAsS7hhz
X9kuO68++/GQQK8LS5xZ5tQkgzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDAxMDcwOTUxMzJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAbj7Yg1yAeEamw5EXs0s84DblBkF1RyUWmjJA
qDXbqUbfP9GuacoRqX7C8pZkdmgAmFcMBhnoyvpTNobanXaU5Qk8RMkktX8jTX0hanINKGfS9ckd
DH+WSnWarrV4qY39quxDdhNsklivy2eEzHBG8IZbdbjq1ewdlcCLmwqDiUnEQpohXh4yScFVQVtN
IelMe7ov5ZmB2XCx8h8QdIfmmnQERfeJTF8yW8VFyLOy1UIbjHs+8IZEiO0LgUuQi9ZYmVLLMAJ6
adeZLpdh7Cs8DRNbiOtGi8E8hWqx6qgz6x9S5snUlnxLTttXrWRbK8fOETGpZjoTHS3MQsNAz03F
lw==
--000000000000adc30e060e580643--

