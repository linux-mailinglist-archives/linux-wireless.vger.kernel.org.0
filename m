Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0DA704A6A
	for <lists+linux-wireless@lfdr.de>; Tue, 16 May 2023 12:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjEPKW5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 06:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjEPKWq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 06:22:46 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4565C46AF
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 03:22:45 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc2feb320so21266484a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 03:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684232563; x=1686824563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9M+3zvEs7MDkEDkOfZLDXBOdDgZB/D2hpS6+6+qhcng=;
        b=kRES/NZ5K/vXJ7IrT8zSFp80SBLenkoGXxoRmEk033/6qSRUlp1ixlaTUgJxt8dRIT
         Qur0b7MWfJ+KHvO4bCtEe+T+fSkCSV2B2l8I/vqDVX1McWT7JQQXTVLBgXp5yZyIRppl
         oo9Z/JD5YmJXgjkJbc9hI+o7ZqsbPfoPTJ6E44wvqlQTOiseHPry3/Z7IRfwBFf6cBxM
         HVt4SAiJG4zoBcsD8lMusWwu+u6Cs4K1K/POdEHKV/i51ImzR2qugdJzgTm4cI7rbpv6
         L9mGCCk6PZfZJlNbsHdfqGmRIk4AwL2kAcJTKDGAFPf3mUS/+1nzzBpss3kwafWxJ31g
         7+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684232563; x=1686824563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9M+3zvEs7MDkEDkOfZLDXBOdDgZB/D2hpS6+6+qhcng=;
        b=HkqrWmkMYmknYvkzBT0lmp0of38vXAfq5LU/SvkhSk1N3G/AMkB8HFhqacRKKiPfiD
         qaIxcYSSrlvD+rFN9Rnh0xta95Jj29LsH8TPU3boweklwUsRMZG0OtgHF90Y8dDyhRpK
         yXuFCsDjc00HNc0MqKeJBuCJhs7RkXDpEmDEk15ePkNA5y5xuDDcy/gMV+YA9AWcVB7N
         ZKnQJReAJzVgmnMcYQgTt1W3gjcJNX0mMYztwZAW2rXedU4besqB1ABuR4BXwJXsZR4k
         0dThXsAt7mrHDYCZPMxnPKSEvm5dIESNeDmVY8VQ7DsSXyL8DTLy1oYMJta9eAmtfLIS
         Erlg==
X-Gm-Message-State: AC+VfDzY6/qHK7M8bsAA8UAtO8ZJu7Jx/Z0uXFrzzCVuDz5IoBa9N9B4
        TzlR37mjDgadA+4sVeIMUEE7IbBflqHvj6Ns6HSkTjHPX/Y=
X-Google-Smtp-Source: ACHHUZ7LAmqGUjLEDwm4GS/HTvEJiibTbjjZk2b0irzPmHVIA+crVlZ88FzKTpLKkFg5zeCSLKm8uj1hGjU0+Jtfu1k=
X-Received: by 2002:a17:907:8690:b0:96a:3119:ac0 with SMTP id
 qa16-20020a170907869000b0096a31190ac0mr19266632ejc.69.1684232563308; Tue, 16
 May 2023 03:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
 <3162376.5fSG56mABF@jernej-laptop> <cee4e4f8-78e9-1bf7-c1a9-8ae5c662c785@lwfinger.net>
 <1855371.CQOukoFCf9@jernej-laptop> <CAFBinCCjzLH7ZZJ9Siw1Lp49qneO+qRJp-g8rGwAYuRwNj2Oyw@mail.gmail.com>
In-Reply-To: <CAFBinCCjzLH7ZZJ9Siw1Lp49qneO+qRJp-g8rGwAYuRwNj2Oyw@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 16 May 2023 12:22:32 +0200
Message-ID: <CAFBinCAD-7Mi06z-RGVREDQ3bYsDUOyDkBgoNW5mDLuKM8H7sg@mail.gmail.com>
Subject: Re: Driver for rtw8723ds
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000a7ee2b05fbccf3f6"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000a7ee2b05fbccf3f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 11:11=E2=80=AFPM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Jernej,
>
> On Mon, May 15, 2023 at 10:37=E2=80=AFPM Jernej =C5=A0krabec
> <jernej.skrabec@gmail.com> wrote:
> [...]
> > > With aggregation disabled, we still get "Invalid RX packet size!" mes=
sages. I am
> > > changing the statement to log (curr_pkt_len + pkt_desc_sz) > rx_len. =
I will let
> > > you know when the OP responds.
> >
> > Yeah, I saw. I just find another possible reason, which fits nicely in =
current
> > situation. Vendor driver parses drv_info_sz and shift fields only if pa=
cket
> > is normal, e.g. not c2h type. However, rtw88 always parses those fields=
. It's
> > possible that they have some value which should be ignored on 8723ds. I
> > appended another patch to test.
> I tried that patch and it didn't work for me (I can't get the card to
> assoc to my AP with that patch).
> Additionally I tried a simplified version (attached) and it didn't work.
>
> I'm out of time for today though so I cannot continue testing.
I took time during my lunch break for some more experiments and came
up with the attached patch (the vendor driver does something similar
and I only noticed that after I observed some rtw_rx_pkt_stat with
pkt_len being zero).
It survived 30 minutes of uptime, updating my system and several
iperf3 runs (in both directions).
iperf results:
- RX: 48 Mbit/s
- TX: 33 Mbit/s

And to be clear, those results are with:
- the word IO bugfix
- the initial two patches from this series
- Larry's addition of the second RTL8723DS SDIO ID
- the attached patch


Best regards,
Martin

--000000000000a7ee2b05fbccf3f6
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="rtw88-sdio-rx-isr-check-rx-request-bit.diff"
Content-Disposition: attachment; 
	filename="rtw88-sdio-rx-isr-check-rx-request-bit.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lhq4iol50>
X-Attachment-Id: f_lhq4iol50

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvc2Rpby5jIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9zZGlvLmMKaW5kZXggMDZmY2U3YzNh
ZGRhLi5hOTRjNGUxNTIwNGIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODgvc2Rpby5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgv
c2Rpby5jCkBAIC05OTgsNyArOTk4LDcgQEAgc3RhdGljIHZvaWQgcnR3X3NkaW9fcnhmaWZvX3Jl
Y3Yoc3RydWN0IHJ0d19kZXYgKnJ0d2RldiwgdTMyIHJ4X2xlbikKIAogc3RhdGljIHZvaWQgcnR3
X3NkaW9fcnhfaXNyKHN0cnVjdCBydHdfZGV2ICpydHdkZXYpCiB7Ci0JdTMyIHJ4X2xlbiwgdG90
YWxfcnhfYnl0ZXMgPSAwOworCXUzMiByeF9sZW4sIGhpc3IsIHRvdGFsX3J4X2J5dGVzID0gMDsK
IAogCXdoaWxlICh0b3RhbF9yeF9ieXRlcyA8IFNaXzY0SykgewogCQlpZiAocnR3X2NoaXBfd2Nw
dV8xMW4ocnR3ZGV2KSkKQEAgLTEwMTIsNiArMTAxMiwxOCBAQCBzdGF0aWMgdm9pZCBydHdfc2Rp
b19yeF9pc3Ioc3RydWN0IHJ0d19kZXYgKnJ0d2RldikKIAkJcnR3X3NkaW9fcnhmaWZvX3JlY3Yo
cnR3ZGV2LCByeF9sZW4pOwogCiAJCXRvdGFsX3J4X2J5dGVzICs9IHJ4X2xlbjsKKworCQkvKiBT
dG9wIGlmIG5vIG1vcmUgUlggcmVxdWVzdHMgYXJlIHBlbmRpbmcsIGV2ZW4gaWYgcnhfbGVuCisJ
CSAqIGNvdWxkIGJlIGdyZWF0ZXIgdGhhbiB6ZXJvIGluIHRoZSBuZXh0IGl0ZXJhdGlvbi4gVGhp
cyBpcworCQkgKiBuZWVkZWQgYmVjYXVzZSB0aGUgUlggYnVmZmVyIG1heSBhbHJlYWR5IGNvbnRh
aW4gZGF0YSB3aGlsZQorCQkgKiB0aGUgY2hpcCBpcyBub3QgZG9uZSBmaWxsaW5nIHRoYXQgYnVm
ZmVyIHlldC4gU3RpbGwgcmVhZGluZworCQkgKiB0aGUgYnVmZmVyIGNhbiByZXN1bHQgaW4gZW1w
dHkgcGFja2V0cyBvciByZWFkaW5nIHBhY2tldHMKKwkJICogd2hlcmUgcnR3X3J4X3BrdF9zdGF0
LnBrdF9sZW4gcG9pbnRzIGJleW9uZCB0aGUgZW5kIG9mIHRoZQorCQkgKiBidWZmZXIuCisJCSAq
LworCQloaXNyID0gcnR3X3JlYWQzMihydHdkZXYsIFJFR19TRElPX0hJU1IpOworCQlpZiAoISho
aXNyICYgUkVHX1NESU9fSElTUl9SWF9SRVFVRVNUKSkKKwkJCWJyZWFrOwogCX0KIH0KIAo=
--000000000000a7ee2b05fbccf3f6--
