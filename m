Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5E34C795C
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Feb 2022 20:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiB1T5R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Feb 2022 14:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiB1T5P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Feb 2022 14:57:15 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842A317E0C
        for <linux-wireless@vger.kernel.org>; Mon, 28 Feb 2022 11:56:36 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id dr20so2358481ejc.6
        for <linux-wireless@vger.kernel.org>; Mon, 28 Feb 2022 11:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gT/mxIYbzDn15+z84Rt0/ZmLFqIl34ZjMPCseIzUB9o=;
        b=Tm2RrZZp9rg85Q2lAdsba4a3IH+hQMy5xZCbUizCCXmPzyfZ+2VRqEslWXZB4tPt3B
         Xz8lYe63CHEdQCuWSaPC9nNMhFWrnR54Ihwd0u2qPZVZ4zvhHacXKCw+SJS4BR1PfT62
         xCFGBc0xrmrOEo0QPHvZeTHUhXNuWYmty+udI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gT/mxIYbzDn15+z84Rt0/ZmLFqIl34ZjMPCseIzUB9o=;
        b=sPvMN+KmePEpVCRzzsHHQAhUQNjfE4eABf7Cvjy+KjGX3u0OnC82CIfymV+OLuBnST
         0JyR9QmSFPjtCC/esRNmoESbAe8UmEtNp/5yLxcgcWiePk7BYQcLWILk0gVeOpKELy/G
         sDaruOCQ4wXulp5cbvcFyKA+Kli4z5Hw7WUPlXChoUyKiuiJzAfWS1+/gQ3bSX7Ng164
         /966HR6JxSM0sWzreWOIw9QxSAL7JXcfpXASAIKzpjSpx+UcltGptrg/15ICLOm4e/55
         qPbD2K2dwsRYU+AOjKdkxcethHoMnP9nHRiW+wO0ih0jLJO+IqK5GPGLVwgRDsXjTrmy
         9rDQ==
X-Gm-Message-State: AOAM531mOfRfAIp7c9AnQggjVcK2DDjMnck1Vmn1g9uK0iImIu3bKkin
        nc6gve/oZfaAzeKlTo+Yrm6jI3TuT/mMiZXK3iE=
X-Google-Smtp-Source: ABdhPJysTif5qPymCIDM0LA0YHNbyi+qfHhjc9T8ZAc8JJ/gWWSCkj7c6L+YDmDU2VHcv6cnA1FLDg==
X-Received: by 2002:a17:906:7185:b0:6cd:e09c:e5f5 with SMTP id h5-20020a170906718500b006cde09ce5f5mr16101736ejk.287.1646078194871;
        Mon, 28 Feb 2022 11:56:34 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id eo8-20020a1709069b0800b006ce6eef6836sm4620381ejc.131.2022.02.28.11.56.33
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 11:56:34 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a23so27064552eju.3
        for <linux-wireless@vger.kernel.org>; Mon, 28 Feb 2022 11:56:33 -0800 (PST)
X-Received: by 2002:ac2:5313:0:b0:443:99c1:7e89 with SMTP id
 c19-20020ac25313000000b0044399c17e89mr13183568lfh.531.1646078183366; Mon, 28
 Feb 2022 11:56:23 -0800 (PST)
MIME-Version: 1.0
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com> <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
In-Reply-To: <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Feb 2022 11:56:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
Message-ID: <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
Subject: Re: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        alsa-devel@alsa-project.org, linux-aspeed@lists.ozlabs.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-iio@vger.kernel.org, nouveau@lists.freedesktop.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        samba-technical@lists.samba.org,
        linux1394-devel@lists.sourceforge.net, drbd-dev@lists.linbit.com,
        linux-arch <linux-arch@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-staging@lists.linux.dev, "Bos, H.J." <h.j.bos@vu.nl>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        intel-wired-lan@lists.osuosl.org,
        kgdb-bugreport@lists.sourceforge.net,
        bcm-kernel-feedback-list@broadcom.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergman <arnd@arndb.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        v9fs-developer@lists.sourceforge.net,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sgx@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-usb@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        tipc-discussion@lists.sourceforge.net,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: multipart/mixed; boundary="00000000000064a3e305d91971a9"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--00000000000064a3e305d91971a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 28, 2022 at 4:19 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> I don't think that using the extra variable makes the code in any way
> more reliable or easier to read.

So I think the next step is to do the attached patch (which requires
that "-std=3Dgnu11" that was discussed in the original thread).

That will guarantee that the 'pos' parameter of list_for_each_entry()
is only updated INSIDE the for_each_list_entry() loop, and can never
point to the (wrongly typed) head entry.

And I would actually hope that it should actually cause compiler
warnings about possibly uninitialized variables if people then use the
'pos' pointer outside the loop. Except

 (a) that code in sgx/encl.c currently initializes 'tmp' to NULL for
inexplicable reasons - possibly because it already expected this
behavior

 (b) when I remove that NULL initializer, I still don't get a warning,
because we've disabled -Wno-maybe-uninitialized since it results in so
many false positives.

Oh well.

Anyway, give this patch a look, and at least if it's expanded to do
"(pos) =3D NULL" in the entry statement for the for-loop, it will avoid
the HEAD type confusion that Jakob is working on. And I think in a
cleaner way than the horrid games he plays.

(But it won't avoid possible CPU speculation of such type confusion.
That, in my opinion, is a completely different issue)

I do wish we could actually poison the 'pos' value after the loop
somehow - but clearly the "might be uninitialized" I was hoping for
isn't the way to do it.

Anybody have any ideas?

                Linus

--00000000000064a3e305d91971a9
Content-Type: application/octet-stream; name=p
Content-Disposition: attachment; filename=p
Content-Transfer-Encoding: base64
Content-ID: <f_l073sb6w0>
X-Attachment-Id: f_l073sb6w0

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbGlzdC5oIGIvaW5jbHVkZS9saW51eC9saXN0LmgK
aW5kZXggZGQ2YzIwNDFkMDljLi5iYWI5OTU1OTZhYWEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGlu
dXgvbGlzdC5oCisrKyBiL2luY2x1ZGUvbGludXgvbGlzdC5oCkBAIC02MzQsMTAgKzYzNCwxMCBA
QCBzdGF0aWMgaW5saW5lIHZvaWQgbGlzdF9zcGxpY2VfdGFpbF9pbml0KHN0cnVjdCBsaXN0X2hl
YWQgKmxpc3QsCiAgKiBAaGVhZDoJdGhlIGhlYWQgZm9yIHlvdXIgbGlzdC4KICAqIEBtZW1iZXI6
CXRoZSBuYW1lIG9mIHRoZSBsaXN0X2hlYWQgd2l0aGluIHRoZSBzdHJ1Y3QuCiAgKi8KLSNkZWZp
bmUgbGlzdF9mb3JfZWFjaF9lbnRyeShwb3MsIGhlYWQsIG1lbWJlcikJCQkJXAotCWZvciAocG9z
ID0gbGlzdF9maXJzdF9lbnRyeShoZWFkLCB0eXBlb2YoKnBvcyksIG1lbWJlcik7CVwKLQkgICAg
ICFsaXN0X2VudHJ5X2lzX2hlYWQocG9zLCBoZWFkLCBtZW1iZXIpOwkJCVwKLQkgICAgIHBvcyA9
IGxpc3RfbmV4dF9lbnRyeShwb3MsIG1lbWJlcikpCisjZGVmaW5lIGxpc3RfZm9yX2VhY2hfZW50
cnkocG9zLCBoZWFkLCBtZW1iZXIpCQkJCQlcCisJZm9yICh0eXBlb2YocG9zKSBfX2l0ZXIgPSBs
aXN0X2ZpcnN0X2VudHJ5KGhlYWQsIHR5cGVvZigqcG9zKSwgbWVtYmVyKTsJXAorCSAgICAgIWxp
c3RfZW50cnlfaXNfaGVhZChfX2l0ZXIsIGhlYWQsIG1lbWJlcikgJiYgKCgocG9zKT1fX2l0ZXIp
LDEpOwlcCisJICAgICBfX2l0ZXIgPSBsaXN0X25leHRfZW50cnkoX19pdGVyLCBtZW1iZXIpKQog
CiAvKioKICAqIGxpc3RfZm9yX2VhY2hfZW50cnlfcmV2ZXJzZSAtIGl0ZXJhdGUgYmFja3dhcmRz
IG92ZXIgbGlzdCBvZiBnaXZlbiB0eXBlLgo=
--00000000000064a3e305d91971a9--
