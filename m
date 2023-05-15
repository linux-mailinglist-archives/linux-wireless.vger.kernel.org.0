Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70DA703F66
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 23:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244852AbjEOVL0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 17:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjEOVL0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 17:11:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5D0129
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 14:11:24 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bc1612940so23978137a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 14:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684185083; x=1686777083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kHm8JXHryz59Pz/h+bANMPHGSwNqLQEsgqPvJPxUIf0=;
        b=pD57wyzp0sFnY7RfwOofxokS600cIG/SRBlW7osH5PHSua1rvPGD25siD1OiiKkAGb
         awXIE9+OzOGQRKR5bPs9z3xTNjEkkGaRgtmQzw5AiX7fNLPGkL42Mg/kotRyM2OPwr+I
         /6cBjyHnoWBSih05m2LHA73ySO6p1K6OcDsRDooLbgnD9NyAakYIimMQIQmi0ji0mThl
         XQa/Tdw2eh+snQmZCyfqZJzJZkS8xD3WIZ+wjgz55uk4WC4OmmPeIWXauLMXUWRvlsqA
         ZZ/YSuoY33W3/7mapXp+iIadjR9d0+rJFDQQ4AfiXCDJfvuVXTFLzz9fv9TxbkMuzI+T
         wwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684185083; x=1686777083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHm8JXHryz59Pz/h+bANMPHGSwNqLQEsgqPvJPxUIf0=;
        b=EPyX9lrC8b1/sJsYotllO8bfQtO9HXB8oybbIFNroW4onRMhHctQp6TDSH5l0WHvN1
         PhbD6BJp/E1rgwFtilpXqhVOxaWN1fOHXqjuQ+YxjwpEeUqKeFxugeldTAxn64io3QQ5
         rHhXQpN+s9nPE0rQ7wgFwVtC9knasnb+XAEDP4/Axk+HbJM6bnp6HNMrazX70qZmpGSn
         7n5lKa/gMaEuZ+9wr5cUfwMQ0X2I5v1N2Ii3wTc3f23n1xc6yl4DahuVWX/DnK6dBiE5
         6zueS+mjM3njCWvBxZAM7XPaF6UWIZFhVi7SOCv9iwA4vnMLZ1uC3MZHvRqTE/u4R4WA
         X5cQ==
X-Gm-Message-State: AC+VfDxC1mz2noHxLMVo+IcFqc0/xa37gwC/yuuaOGi8wPSPoExz9JbH
        HIkBIBkE3peO+MaMAD1/S5fdFFYykQNqEtNwST5InAh7
X-Google-Smtp-Source: ACHHUZ6ca1cf8Ts7cmE54cQNpEq1Ia+8Uqa//HTlvwTMLgEFHdyvTXj43ZcKOjhYKoonqfOJ2Qs4sWbvpylxodXy/vU=
X-Received: by 2002:a17:906:478f:b0:96a:3b67:40bb with SMTP id
 cw15-20020a170906478f00b0096a3b6740bbmr19193956ejc.40.1684185082450; Mon, 15
 May 2023 14:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
 <3162376.5fSG56mABF@jernej-laptop> <cee4e4f8-78e9-1bf7-c1a9-8ae5c662c785@lwfinger.net>
 <1855371.CQOukoFCf9@jernej-laptop>
In-Reply-To: <1855371.CQOukoFCf9@jernej-laptop>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 15 May 2023 23:11:11 +0200
Message-ID: <CAFBinCCjzLH7ZZJ9Siw1Lp49qneO+qRJp-g8rGwAYuRwNj2Oyw@mail.gmail.com>
Subject: Re: Driver for rtw8723ds
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000093699a05fbc1e5b9"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--00000000000093699a05fbc1e5b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jernej,

On Mon, May 15, 2023 at 10:37=E2=80=AFPM Jernej =C5=A0krabec
<jernej.skrabec@gmail.com> wrote:
[...]
> > With aggregation disabled, we still get "Invalid RX packet size!" messa=
ges. I am
> > changing the statement to log (curr_pkt_len + pkt_desc_sz) > rx_len. I =
will let
> > you know when the OP responds.
>
> Yeah, I saw. I just find another possible reason, which fits nicely in cu=
rrent
> situation. Vendor driver parses drv_info_sz and shift fields only if pack=
et
> is normal, e.g. not c2h type. However, rtw88 always parses those fields. =
It's
> possible that they have some value which should be ignored on 8723ds. I
> appended another patch to test.
I tried that patch and it didn't work for me (I can't get the card to
assoc to my AP with that patch).
Additionally I tried a simplified version (attached) and it didn't work.

I'm out of time for today though so I cannot continue testing.


Best regards,
Martin

--00000000000093699a05fbc1e5b9
Content-Type: text/x-patch; charset="US-ASCII"; name="sdio-check-is-c2h.diff"
Content-Disposition: attachment; filename="sdio-check-is-c2h.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lhpcad3a0>
X-Attachment-Id: f_lhpcad3a0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvc2Rpby5jIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9zZGlvLmMKaW5kZXggMDZmY2U3YzNh
ZGRhLi5mOTZlOTg4MTgxODQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODgvc2Rpby5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgv
c2Rpby5jCkBAIC05NjEsOCArOTYxLDEwIEBAIHN0YXRpYyB2b2lkIHJ0d19zZGlvX3J4Zmlmb19y
ZWN2KHN0cnVjdCBydHdfZGV2ICpydHdkZXYsIHUzMiByeF9sZW4pCiAJCXJ4X2Rlc2MgPSBza2It
PmRhdGE7CiAJCWNoaXAtPm9wcy0+cXVlcnlfcnhfZGVzYyhydHdkZXYsIHJ4X2Rlc2MsICZwa3Rf
c3RhdCwKIAkJCQkJICZyeF9zdGF0dXMpOwotCQlwa3Rfb2Zmc2V0ID0gcGt0X2Rlc2Nfc3ogKyBw
a3Rfc3RhdC5kcnZfaW5mb19zeiArCi0JCQkgICAgIHBrdF9zdGF0LnNoaWZ0OworCisJCXBrdF9v
ZmZzZXQgPSBwa3RfZGVzY19zejsKKwkJaWYgKCFwa3Rfc3RhdC5pc19jMmgpCisJCQlwa3Rfb2Zm
c2V0ICs9IHBrdF9zdGF0LmRydl9pbmZvX3N6ICsgcGt0X3N0YXQuc2hpZnQ7CiAKIAkJY3Vycl9w
a3RfbGVuID0gQUxJR04ocGt0X29mZnNldCArIHBrdF9zdGF0LnBrdF9sZW4sCiAJCQkJICAgICBS
VFdfU0RJT19EQVRBX1BUUl9BTElHTik7Cg==
--00000000000093699a05fbc1e5b9--
