Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC206FB834
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 22:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjEHUQo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 16:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjEHUQn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 16:16:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738CD5597
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 13:16:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94a34a14a54so996156666b.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 May 2023 13:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683577000; x=1686169000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xZSZxOD+GkL3nQXyXjg78xEuXRHeGU0fTul0TeZFweg=;
        b=Q+HIxhhHV43UXBi6spfAuoKYCRIpCC83pCeyOjvgn3Vd7JEraQcexQhOh1+5JMcNTJ
         5imoRCsQzTR9d2G7VlzCr/2DYGFqt9++LYHzJQBcby1LQ8CtaJup6LcjtvgEWr/YOpgz
         X6w3uf7+bep38WOX/Kk+vPCTlZfG2xol4RA3Pol/pEUOc11NAosu5nc4rcGFPQG+6Mvs
         WsXNaIKI6EEt1Ac64w7A9htB+SJGWBbBzaUd3Jjq/YQZ1u8K1o4sOPAvVVgxRqn2Hm7X
         lQxVP/B26cL/q+N1UBSLsPAsE3tcvMrSt/P4QDAVbmhJenUmMMtih6uLSeLktJPalMX5
         sUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683577000; x=1686169000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZSZxOD+GkL3nQXyXjg78xEuXRHeGU0fTul0TeZFweg=;
        b=c26Ciwv6/3aGIvw18TMXDtFgn1QgSHncVvgjl4ZUzMSy4N4DlcHgbmCp76ebswu0RD
         9f3rcZim07MWNy1Bnitpy8DJ9wdT6nJ/1q9tWyKUgMxLxOK6xnrgot4aAuOr8cCyMl9u
         g3EUAr430LhMhXs7ESuipodHvyADiuGI32eNZLc7YOnwvuhC4hsYAy1D8jetp2uklLa0
         hAlqrr8lwdhv+U0Z4chh/tBF7b8PUpmj0sxMABKkDQWl6jkeEkftmuI7y5yZh/RcxDY/
         RG0RAoPTrU9OLcH2Zm4kMUsrWxh8bSOnQ614FyaU0NxWsEDErcaf3THw0DyI+m0K23Rk
         QOow==
X-Gm-Message-State: AC+VfDzSCYDqGDtW4CoOlRQeMoGkgUWrd4trSt4PsuSBkyUw7Z2P7e1u
        x0jUCPdg04kfUKl0Ucsfmrccbc7ndTQcMgluKcZOWtrx
X-Google-Smtp-Source: ACHHUZ4p5jSvrLgAYUf0i50+lG6p4AI42CDy/xVIUO5Il6PwsXd5NaGzrbHPKXGm+mZBhJ4A+ulrgDmVBEaqADUOCEc=
X-Received: by 2002:a17:907:9283:b0:953:5049:73a8 with SMTP id
 bw3-20020a170907928300b00953504973a8mr8741879ejc.35.1683576999829; Mon, 08
 May 2023 13:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
 <5930608.lOV4Wx5bFT@jernej-laptop> <813d74b8-6d9f-c7b0-40b4-c661fca13002@lwfinger.net>
 <CAFBinCB3xnCrLvEvqsFMQuDxL+xC9tkxnwubfC+xEMP3-ZXqSg@mail.gmail.com> <527585e5-9cdd-66ed-c3af-6da162f4b720@lwfinger.net>
In-Reply-To: <527585e5-9cdd-66ed-c3af-6da162f4b720@lwfinger.net>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 8 May 2023 22:16:28 +0200
Message-ID: <CAFBinCCdbt0OAHMnGPYA+xH8WC1nWqJPP5aBU48R=LHRu_xuew@mail.gmail.com>
Subject: Re: Driver for rtw8723ds
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000007194f05fb3451d7"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--00000000000007194f05fb3451d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Larry,

On Mon, May 8, 2023 at 8:55=E2=80=AFPM Larry Finger <Larry.Finger@lwfinger.=
net> wrote:
>
> Martin and Jernej,
>
> It took a bit of working through some problems, but the user now has the
> rtw8723ds loading and starting. The first problem other than the mechanic=
s of
> building and installing the driver on his SoC was that there is a second =
SDIO
> vendor ID/device ID for his device, namely 0x024c:0xd724. As I am carryin=
g a
> local copy of sdio_ids.h, that was relatively easy to fix.
Thanks for this hint - I guess we need to find out how to name that
0xd724 device and add it's ID to sdio_ids.h when I upstream the
patches then.
But let's look at the other problem first.

> At the moment, when the device starts, the log shows the following:
> [    3.640866] rtw_8723ds mmc1:0001:1: Firmware version 48.0.0, H2C versi=
on 0
> [    3.645302] sunxi-mmc 4021000.mmc: unaligned scatterlist: os b00 lengt=
h 2
> [    3.654556] sunxi-mmc 4021000.mmc: map DMA failed
> [    3.659268] rtw_8723ds mmc1:0001:1: sdio read16 failed (0x10040): -22
> [    3.665710] sunxi-mmc 4021000.mmc: unaligned scatterlist: os b00 lengt=
h 2
> [    3.672499] sunxi-mmc 4021000.mmc: map DMA failed
> [    3.677208] rtw_8723ds mmc1:0001:1: sdio write16 failed (0x10040): -22
> [    3.683739] sunxi-mmc 4021000.mmc: unaligned scatterlist: os b00 lengt=
h 2
> [    3.690528] sunxi-mmc 4021000.mmc: map DMA failed
> [    3.695236] rtw_8723ds mmc1:0001:1: sdio write16 failed (0x10100): -22
> [    3.873173] sunxi-mmc 4021000.mmc: unaligned scatterlist: os b00 lengt=
h 2
> [    3.879978] sunxi-mmc 4021000.mmc: map DMA failed
> [    3.884690] rtw_8723ds mmc1:0001:1: sdio read16 failed (0x10002): -22
> [    3.891141] sunxi-mmc 4021000.mmc: unaligned scatterlist: os b00 lengt=
h 2
> [    3.897931] sunxi-mmc 4021000.mmc: map DMA failed
> [    3.902640] rtw_8723ds mmc1:0001:1: sdio write16 failed (0x10002): -22
> [    3.909172] sunxi-mmc 4021000.mmc: unaligned scatterlist: os b00 lengt=
h 2
> [    3.915962] sunxi-mmc 4021000.mmc: map DMA failed
> [    3.920672] rtw_8723ds mmc1:0001:1: sdio read16 failed (0x10008): -22
> [    3.927116] sunxi-mmc 4021000.mmc: unaligned scatterlist: os b00 lengt=
h 2
> [    3.933906] sunxi-mmc 4021000.mmc: map DMA failed
> [    3.938616] rtw_8723ds mmc1:0001:1: sdio write16 failed (0x10008): -22
This looks like an issue with the Allwinner SDIO controller. We can
try to work around this with the attached patch.
Please note that I've only compile-tested that patch.
In theory it can hurt 16-bit register access (read/write) performance
a bit (since we now require two MMC commands instead of one). Whether
this can be measured in the real world is unknown to me. Let's see if
it fixes the observed issue first.


Best regards,
Martin

--00000000000007194f05fb3451d7
Content-Type: text/x-patch; charset="US-ASCII"; name="rtw88-byte-wise-word-io.diff"
Content-Disposition: attachment; filename="rtw88-byte-wise-word-io.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lhfa79fe0>
X-Attachment-Id: f_lhfa79fe0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvc2Rpby5jIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9zZGlvLmMKaW5kZXggYWYwNDU5YTc5
ODk5Li4wNmZjZTdjM2FkZGEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODgvc2Rpby5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgv
c2Rpby5jCkBAIC04NywxMSArODcsNiBAQCBzdGF0aWMgdm9pZCBydHdfc2Rpb193cml0ZXcoc3Ry
dWN0IHJ0d19kZXYgKnJ0d2RldiwgdTE2IHZhbCwgdTMyIGFkZHIsCiAJdTggYnVmWzJdOwogCWlu
dCBpOwogCi0JaWYgKHJ0d19zZGlvX3VzZV9tZW1jcHlfaW8ocnR3ZGV2LCBhZGRyLCAyKSkgewot
CQlzZGlvX3dyaXRldyhydHdzZGlvLT5zZGlvX2Z1bmMsIHZhbCwgYWRkciwgZXJyX3JldCk7Ci0J
CXJldHVybjsKLQl9Ci0KIAkqKF9fbGUxNiAqKWJ1ZiA9IGNwdV90b19sZTE2KHZhbCk7CiAKIAlm
b3IgKGkgPSAwOyBpIDwgMjsgaSsrKSB7CkBAIC0xMjUsOSArMTIwLDYgQEAgc3RhdGljIHUxNiBy
dHdfc2Rpb19yZWFkdyhzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LCB1MzIgYWRkciwgaW50ICplcnJf
cmV0KQogCXU4IGJ1ZlsyXTsKIAlpbnQgaTsKIAotCWlmIChydHdfc2Rpb191c2VfbWVtY3B5X2lv
KHJ0d2RldiwgYWRkciwgMikpCi0JCXJldHVybiBzZGlvX3JlYWR3KHJ0d3NkaW8tPnNkaW9fZnVu
YywgYWRkciwgZXJyX3JldCk7Ci0KIAlmb3IgKGkgPSAwOyBpIDwgMjsgaSsrKSB7CiAJCWJ1Zltp
XSA9IHNkaW9fcmVhZGIocnR3c2Rpby0+c2Rpb19mdW5jLCBhZGRyICsgaSwgZXJyX3JldCk7CiAJ
CWlmICgqZXJyX3JldCkK
--00000000000007194f05fb3451d7--
