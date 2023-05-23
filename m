Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32D470E3AB
	for <lists+linux-wireless@lfdr.de>; Tue, 23 May 2023 19:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbjEWRTk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 May 2023 13:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjEWRTg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 May 2023 13:19:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1768BF
        for <linux-wireless@vger.kernel.org>; Tue, 23 May 2023 10:19:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-510dabb3989so284715a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 23 May 2023 10:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684862373; x=1687454373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IWOkgBIbMkZIc1WF9UN4wiq/5Go9XkeJIfKZrpUg3E=;
        b=PvUyK050ZHvbTSmuASnVQYaYTY3FCRV0fAmPCzsibBJybBOSgsmdFjbZTC0Z4sRhz6
         ERD7oFAnV8/2ojxuM3aXGBqzALtfdv1H+Yb+ZeNLrd9H1rQ1xaLbmmYB5Ur2wCU9oVGC
         rD5pP+UoY6KieDMFj6bSVB0NIFQ56r8syPB8fGQI+DmvfsmOpMaMaT7aLEQkbGVeO1eV
         RNoIOPiXxlskp9j6pXFMPTj4XQ3KpdtIBoHx7SRiEDAoqej4BpBsxvfkBD4RJVfs/9QE
         W2LEek60oY69UHbMmWaLPlSIxTIELGB1oFpiO6UxrFjreKrqk5xrMvZQh4w7QrwfCst3
         Qo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862373; x=1687454373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IWOkgBIbMkZIc1WF9UN4wiq/5Go9XkeJIfKZrpUg3E=;
        b=cOqwjt2TOJ2Wr9JnI8i0JKqZGxfdqDl4OPQL4Gl1Ze4ehm7UPUS9ia7PzhQ6hcOaLM
         Ig5wkbPeq4/N0jvmfahBYICU5+ZpP9mcvUn8be6Xvt1GMeG4w4s4O+nMIbkPUq/gKx9G
         JyBQYQQHKeajMT6jPyJqwK0i2wsatjfxsRohhITMUNd10wjJ50WJ81vhX7fTyh9szdIu
         MDWLKlP9/aajiFwZngEMpG9rkyFPo2CGwwIN9+F4s0DWJQZvNKpIacOfAgx0OrJpRz4w
         cn0lNeL1NdIgV6wKEEaz2ZgJgw+7xd5v8Cdqe/Ad0TlMyeoiW2zAmlS2t9PR/kqP61VQ
         F8ag==
X-Gm-Message-State: AC+VfDxKYjfzzQ19xW3TJIHsnLCchOLi3aWi9M8xFDSaW9WBYsve39W8
        kkD/dof5SEBUQrr34Efh9eeB7jDI1ltG3h12eEjlWL7n
X-Google-Smtp-Source: ACHHUZ5JNda/eZiLhgJzOS/syJqfk7m8HlBKLK290Ra8H0DeGZQd0jEr9sv6kU64lVfpWG1KtT82TeAZn5rsKgkUPi4=
X-Received: by 2002:aa7:db49:0:b0:510:e902:9690 with SMTP id
 n9-20020aa7db49000000b00510e9029690mr12367131edt.33.1684862372960; Tue, 23
 May 2023 10:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAMzNfvPpi9GiFHf0UcBpS8oozg6o_s3wwzOAPJ0FzGy7LaC4pw@mail.gmail.com>
 <777df364-6a1c-4427-ab68-46a9a71fc629@lockie.ca> <6f014d1e-7d50-5688-1ffc-88e00c77a61f@lwfinger.net>
 <33FF0DFF-0FBF-4344-95BA-55C2FE740B49@gmail.com> <0621f2d1-5316-0a0d-62b5-ba4aa3702fa5@lwfinger.net>
 <CAMzNfvNXqKyvy-88y79WnJ6BumAyGLQEkAcUk-9k3JeDLKeCkw@mail.gmail.com>
 <CAMzNfvMAgpHV=7HXydrtGJCLG+Mjny4NU6pFP1YjdrPt+Mcc-g@mail.gmail.com>
 <CAMzNfvPtmGyXDV9m-whhptH5n3xJL1-ZPNed3yrkXG-DSF==+w@mail.gmail.com> <7058acc1-b7e8-b7b5-0c8c-e83907f1b327@lwfinger.net>
In-Reply-To: <7058acc1-b7e8-b7b5-0c8c-e83907f1b327@lwfinger.net>
From:   Fabrizio del Tin <devotedmystic@gmail.com>
Date:   Tue, 23 May 2023 19:19:21 +0200
Message-ID: <CAMzNfvNMqSOUhCRijbqavubiMqaq3aL=4+VXe83ZOiML8sTbNQ@mail.gmail.com>
Subject: Re: Realtek RTL8832CU compatibility
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, James <bjlockie@lockie.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I confirm it works. Kudos!!!

I also don't have a 6Ghz router, so I cannot test that at the moment.
Maybe I get one next month. I wonder if there is a command to see the
supported frequencies of the card.

Fabrizio

On Tue, May 23, 2023 at 6:51=E2=80=AFPM Larry Finger <Larry.Finger@lwfinger=
.net> wrote:
>
> On 5/23/23 08:11, Fabrizio del Tin wrote:
> > I found that rtl8852cu should already be in linux-firmware:
> > https://www.mail-archive.com/kernel-packages@lists.launchpad.net/msg490=
319.html
> >
> > Maybe it is just matter of adding rtl8832cu as a variant.
>
> Those missing globals were due to missing parts in the version of common.=
mk that
> you used. That part will be OK now that I pushed the real version.
>
> There is a major difference between firmware and a driver. The former run=
s in
> the CPU on the chip while the latter runs on the host CPU. At the moment,=
 there
> are no drivers for any of the USB variants of the rtw89 chips.
>
> Larry
>
