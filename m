Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AC27D079A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Oct 2023 07:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjJTFbQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Oct 2023 01:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjJTFbO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Oct 2023 01:31:14 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EFE119
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 22:31:09 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7b5f7f4e733so166427241.3
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 22:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697779868; x=1698384668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kf6uWwuj/p1QTyWsLbeO61soCn3K6rBcnzJEXreDgDo=;
        b=VRJWadiJu06UmV4/qOPzXqDg+hGZnBGvxDhXMxMNoRsDiA1aqHw4vXlsO6PvyNNDHJ
         wOMYt5dawb+TMaad4yXQI9Av+kyOEa1+cOO/L4/jkR+uWTpL0TCBIrUNF45TVF8/YsW5
         3IJnjKqH41jiAWKK3TYR9VlqRlKsfAezdiRxcJarzWnIWg0LcqIQ0x6fy0lMHE9cqKhf
         vAAbkWr1s0imSRrN7lzZNG8ibNClyL0gCeBPWHS0RZdME2eKm03+Fd759kf5WiRSMf+G
         SwgnQQ7jcQIZ51W7ktAIPGk8lW8UMz/tkHaeijJv6himHXXJl/IZXdX0CLGUcixp7NiZ
         m2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697779868; x=1698384668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kf6uWwuj/p1QTyWsLbeO61soCn3K6rBcnzJEXreDgDo=;
        b=R7micRHyVUR/93Dw9lScyeuIWGDzoL87E1cZJdvZ127/YuxSHpfMEj+YW8jsrs2Wip
         qle5T1s7k7ljbOQWi1Gztpg2sn/gScuXqjDY4gIz0OKfH/aX+OeVy4fHy2uma3DnGZyT
         ZP+5WMySe/Ua9m64L7x0WglHGIHn4D9bps9dE2Lo7Hw+0SE04VO33oEpuvxp2K8Pahzy
         JlPOn2WYWaDBsKmhnTiKGgKRvJyy9qddyZ3vWt4154TGa9uM6DRze5GQp5enkPIl6B5H
         Q4S4IbhrnaYGwp/buWKPqy+1hDIOydX6+2BFDNMOiYB81BfjkZL/smyyBGw5P5lh1+6t
         ex7g==
X-Gm-Message-State: AOJu0YzM0cvae1oEHQeBR4sk/ARRw9zNSJb4VjRtSjoSu0dZW0+kG6TE
        zPuJ1CvUmNSXcP3e0ErzuPEmTIz4qEdLa3uVAbW8tJ4K
X-Google-Smtp-Source: AGHT+IEC7X265f+UCg6SJwwSdkW5GO5G8UvisZc6CH9rYrH3U5g3CGkhAzZXlmaVe4S9wZANySQvYO6CtlfqMzxLjhw=
X-Received: by 2002:a67:c204:0:b0:452:62b2:36b with SMTP id
 i4-20020a67c204000000b0045262b2036bmr1050649vsj.30.1697779868377; Thu, 19 Oct
 2023 22:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAMes48--xvNjYZdO1DKjfkXRv7AJcqJaWYzJ9fYSPPxQ_M7muw@mail.gmail.com>
 <ce544a72-2af6-4448-8817-1d4cb54f456a@lockie.ca>
In-Reply-To: <ce544a72-2af6-4448-8817-1d4cb54f456a@lockie.ca>
From:   Jon Doe <tuksgig@gmail.com>
Date:   Fri, 20 Oct 2023 07:30:57 +0200
Message-ID: <CAMes488xPhpKuYUxgHd1WnnQUCUwmeOseCGtTv+Y9Z52b4MRnQ@mail.gmail.com>
Subject: Re: rtw88 usb adapter can't authenticate
To:     James <bjlockie@lockie.ca>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I re-tested with different SSIDS on 2.4 and 5GHz, same problem, fails
to authenticate. Tested with 3 different access points. Latest kernel
I tested with is 6.5.5 on Manjaro Linux.

On Thu, Oct 19, 2023 at 6:11=E2=80=AFPM James <bjlockie@lockie.ca> wrote:
>
> Oct 19, 2023 11:00:56 AM Jon Doe <tuksgig@gmail.com>:
>
> > Hi,
> >
> > I have a Cudy AC1300 model WU1400 USB Wifi adapter that fails to
> > authenticate properly. Driver for this device is rtw88_8822bu.
> > Reported this previously at
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2188243 with logs of the
> > error messages.
> >
> > Scanning works but authentication fails after 3 attempts. Any ideas?
> Have different SIDs for 2.4ghz and 5ghz.
> That causes problems.
