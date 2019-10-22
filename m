Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33F30DFE26
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 09:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbfJVHVk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 03:21:40 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:46539 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbfJVHVj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 03:21:39 -0400
Received: by mail-io1-f49.google.com with SMTP id c6so19099686ioo.13
        for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2019 00:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKhRrIcVwkG0rJ9As4nEBuvgFBjR0lcF9sCefS1Wd4A=;
        b=u4wFbrmroBjIzTeovbexU8R9SxLIBDiYtqJ7S9Z7nJQy6BUk2G+bX8qELacosDtsTY
         MyFn4peABnNRhcTp9gEumJxtZWvbLiNXniKG30CcFVyKxJbZ/q9UM3ImZuoWwQt8s/X6
         26DWfWqt5olbxjVt6jVkIiLAInX8wxasjFx7p6rxUB5XTBsQV0lfNhDOgV+6BAMre34w
         iKLb2c6+Ep14lsKTnPW+Vc4O43PtE+TTjxo6DKQKxP+/SF7xJ4UPaTFKwW3SIjkp5tlq
         eBjmaCCLFForfiA3s5B0TaNVXGhXmnz6EehiJJpY8sVGsL51S1MZnuVOIahHwKfO2BaU
         VVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKhRrIcVwkG0rJ9As4nEBuvgFBjR0lcF9sCefS1Wd4A=;
        b=cCPo8DntT+4YDoqIbPcrST9Hw0nUt53nCQcgp4gIzfK0rAG0MVfIHMow7dPmCuhxUO
         DVCDQdARz1OAM5/uGVaSvVfUe6zhdOyGmCfi8kvyHDYCYhjkbVcaR0nZUfukrcfg5M2F
         hw/lTxtahjaENlZ0lC5syNkCP/qlOuhqFAennlvBBt2dqXHPKic61TL5TfMRdxYZQWF9
         rhvD9qC6xs0TgVXvcPH9svBLMqzwplXU+uVlxlQBO80yfuCbtXaV/90tTS/xAH2+5vsB
         +OVzj11DYqSuL2G7uOUTnjKwX2rCtsbz/116y1t9+AQjXjCV8RJYajkUDeWo3dw8jXMd
         02VQ==
X-Gm-Message-State: APjAAAXKnVJC57vZCs4pQ0I1QjotJ7N2KP6F0MMvsrs7zziTsbQYEaQv
        tfjjxr+czAehq2l7D9pNuPycjKeQFk24ReN7Ofrg2g==
X-Google-Smtp-Source: APXvYqxFiYmgfYB1ocgek3j17tfLwBRurLcL/N+rNx3esFlucWX/OnomHg1ypJLmA11I94wUVQAJACgc3Q5sT+UX0Eo=
X-Received: by 2002:a6b:6a0e:: with SMTP id x14mr2274036iog.150.1571728898427;
 Tue, 22 Oct 2019 00:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <CADh-Cm=umBWCkz41-e0-PDnDrbpfQi_PRdT--SePmQLCqj5rwg@mail.gmail.com>
 <CADh-CmnrWe_hrdfs3RqL0mF4ipAxthUgE3=eBSvaiudbEtsQvw@mail.gmail.com> <0f33cba3dd5fdcc4697c26e97e8f265c1bb9958c.camel@coelho.fi>
In-Reply-To: <0f33cba3dd5fdcc4697c26e97e8f265c1bb9958c.camel@coelho.fi>
From:   Ryan Adolf <ryanadolf123@gmail.com>
Date:   Tue, 22 Oct 2019 00:21:26 -0700
Message-ID: <CADh-Cm=bG2wV6Ccy3ATx3g=dsoXa6KAvxwBJ+pPxMSscaQ0AXA@mail.gmail.com>
Subject: Re: Fwd: iw package typo in help command output
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000acb5b305957aa64e"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000acb5b305957aa64e
Content-Type: text/plain; charset="UTF-8"

The patch is attached.
There's only one modified line in it: correcting the typo of timstamp
--> timestamp.

On Mon, Oct 21, 2019 at 1:07 PM Luca Coelho <luca@coelho.fi> wrote:
>
> On Mon, 2019-10-21 at 02:34 -0700, Ryan Adolf wrote:
> > Hello,
> >
> > First of all I'm not sure what the policy of this community is on
> > typos. It's my first time contributing to iw :) If you consider this
> > too minor to fix, I understand. The package has a lot of amazing stuff
> > to it.
>
> Just submit a patch! Then the maintainers will decide whether it's
> worth it or not.  I, particularly, don't see why it wouldn't be taken.
>
> --
> Cheers,
> Luca.
>

--000000000000acb5b305957aa64e
Content-Type: text/x-patch; charset="US-ASCII"; name="event.patch"
Content-Disposition: attachment; filename="event.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k21iqkg80>
X-Attachment-Id: f_k21iqkg80

ZGlmZiAtLWdpdCBhL2V2ZW50LmMgYi9ldmVudC5jCmluZGV4IDEwMGY2NDQuLjRhOTMyZDEgMTAw
NjQ0Ci0tLSBhL2V2ZW50LmMKKysrIGIvZXZlbnQuYwpAQCAtMTE3Miw1ICsxMTcyLDUgQEAgc3Rh
dGljIGludCBwcmludF9ldmVudHMoc3RydWN0IG5sODAyMTFfc3RhdGUgKnN0YXRlLAogVE9QTEVW
RUwoZXZlbnQsICJbLXR8LXJdIFstZl0iLCAwLCAwLCBDSUJfTk9ORSwgcHJpbnRfZXZlbnRzLAog
CSJNb25pdG9yIGV2ZW50cyBmcm9tIHRoZSBrZXJuZWwuXG4iCiAJIi10IC0gcHJpbnQgdGltZXN0
YW1wXG4iCi0JIi1yIC0gcHJpbnQgcmVsYXRpdmUgdGltc3RhbXBcbiIKKwkiLXIgLSBwcmludCBy
ZWxhdGl2ZSB0aW1lc3RhbXBcbiIKIAkiLWYgLSBwcmludCBmdWxsIGZyYW1lIGZvciBhdXRoL2Fz
c29jIGV0Yy4iKTsK
--000000000000acb5b305957aa64e--
