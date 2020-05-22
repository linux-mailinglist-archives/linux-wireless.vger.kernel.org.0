Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984A61DE5E2
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 13:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgEVLtf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 07:49:35 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:46728 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728409AbgEVLtf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 07:49:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590148174; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=CaBNehdl9YUvZtml2EZG/wfTsnotSusNOcw0nP51B/c=; b=nYKlzClW26Rw9UzzSGqCyTYRPgdkUKybpQFqt/6lTrUK3feqL6Xp9df0XB67kO3Qmir6Jbay
 dcCY/2hmc8IHzPSzR5QwWAtoCeMHrmagFnS2hiP0zXxF6hBnyGAGQK8rtkh1L229YWaerhtK
 /Uk416l1xgizmV2Zb4F1exJDz2k=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5ec7bc4e8075f6e58c6e25e4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 May 2020 11:49:34
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7AA85C43387; Fri, 22 May 2020 11:49:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C958C433C6;
        Fri, 22 May 2020 11:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C958C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Michael =?utf-8?Q?B=C3=BCsch?= <m@bues.ch>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
        <CALjTZvaPi2FL-epk-Vd2wOLye2O0J8G5aZPsqzHXt2b7u=HyuQ@mail.gmail.com>
        <263e247c-3bf9-6d42-996b-bc513efe4b71@lwfinger.net>
        <CALjTZvauK0Hh+aoabcDX9kkQZ4zN2ZjPnB+aq7YrJ9+-4ihiAg@mail.gmail.com>
        <87fffd5d-242a-7195-c4cc-80260dbd53c5@lwfinger.net>
        <CALjTZvYCFNSQ6HMN4owkiGTVrYaiU8R-P1KXgvkwGqcOo8uMuw@mail.gmail.com>
        <CALjTZvYMF_ERBfzkhaHvsTu6kt7MW+L_979sOVs8hcH7zF_Nyg@mail.gmail.com>
        <20200521124608.4b5c78f2@wiggum>
        <CALjTZvan46UTwcUxOSN=RiE6XHm-29Ln8B6wiv40V_RVxWewtA@mail.gmail.com>
        <20200521134011.656381ad@wiggum>
        <CALjTZvZcfT-aURMa=j-1ksWyVdu42bLEsGOaq+Hw39ioiPFKAA@mail.gmail.com>
        <CALjTZvY3_wjAx9DOEgYxpc4_fG-HWh_=O7veFxeEoygPzTJptw@mail.gmail.com>
        <2b22b778-2f89-9c42-93a0-5c165de26f35@lwfinger.net>
        <CALjTZva70Ni-s5VjRZL5BPswEtz5VZsX+dvE6rq2ztLJQ9v3kA@mail.gmail.com>
        <CALjTZvbvE_cDg9mfszscSBowznp1UpxqiN1LQfbgeCOYatKMNg@mail.gmail.com>
        <f6152cd7-1043-dde2-7fc1-634d8b07a231@lwfinger.net>
        <20200522121910.254aefc1@wiggum>
Date:   Fri, 22 May 2020 14:49:28 +0300
In-Reply-To: <20200522121910.254aefc1@wiggum> ("Michael \=\?utf-8\?Q\?B\=C3\=BCs\?\=
 \=\?utf-8\?Q\?ch\=22's\?\= message of
        "Fri, 22 May 2020 12:19:10 +0200")
Message-ID: <87a720gpfb.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Michael B=C3=BCsch <m@bues.ch> writes:

> On Thu, 21 May 2020 16:47:41 -0500
> Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
>> On 5/21/20 3:23 PM, Rui Salvaterra wrote:
>> > On Thu, 21 May 2020 at 20:19, Rui Salvaterra <rsalvaterra@gmail.com> w=
rote:=20=20
>> >>
>> >> Sure, I'll give it a spin. I'm now compiling the kernel for the laptop
>> >> with the other b43 card (BCM4311).=20=20
>> >=20
>> > Nope, kmsg is clean. I'm pretty sure the condition is evaluating to
>> > false because we do have the firmware, it's just that the crypto
>> > engine doesn't support the required algo.
>> > Is hardware encryption an all-or-nothing thing in mac80211? Wouldn't
>> > it be possible use the hardware as much as possible and fall back to
>> > software only for the unsupported features? (I guess the answer is
>> > "no, because the firmware gets in the way", but I had to ask.)
>> >=20=20=20
>>=20
>> My first failure indicates the mac80211 needs to know from the start tha=
t=20
>> software encryption is to be used. The only places that the driver makes=
 note of=20
>> the nohwcrypt is in b43_op_set_key() where it returns -ENOSPC, and our n=
ew one=20
>> where MFP_CAPABLE is set. Otherwise, the packet flags indicate that encr=
yption=20
>> is not needed.
>
>
> Thank you all very much for benchmarking this.
>
> As we see, hwcrypto has a major effect on CPU load.
> But I'm still in favor of changing the default to nohwcrypt=3D1.

I'm thinking the same.

> That would be a trade off between a wifi that does work with "bad"
> performance vs. a wifi that does not work at all by default.

And did the "bad" performance even have any real visible changes to the
user? IMHO this "bad" performance is small price to pay from getting
WPA3 supported out-of-box, especially when the data throughput is
unaffected.

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
