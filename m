Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEAF613419
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Oct 2022 11:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJaK7Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Oct 2022 06:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJaK7N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Oct 2022 06:59:13 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1128CB15
        for <linux-wireless@vger.kernel.org>; Mon, 31 Oct 2022 03:59:13 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id z192so13287921yba.0
        for <linux-wireless@vger.kernel.org>; Mon, 31 Oct 2022 03:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxJKbL/uB9Fk5GRAFTq6N7NcJtMZZXqSdrFEAnyDSxI=;
        b=etUdpO6Yrazj427irz+ti33iuVuUbPpLnFDNPKLYGkicClLm83FDTkosF7FNJVi/uK
         vg6wHFhCa6JFCMcHwambTBT0Y5dMXf0cAc3hkeDh2EknBvQVTtmjN5XfnOC9Or0bUk9D
         EvL/HxG/C9AzmcGiAam9LtxtEh766PBqh8HcCfBvBW9rNhHA7n2sZKqPHxS6q2lvE2h9
         czGaCjbn0A+XKOyEwJEqKjb7qc/EhrVOEp8shudtdkWJYkYdQYDp87vgEfpj2X2W92Ug
         CrG2BMLbWSJ41qdYeYur36ee8+RWhR4oFWitOFuZj4vIYu7eh/fWfIVJkVebFIZ63bN8
         LkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxJKbL/uB9Fk5GRAFTq6N7NcJtMZZXqSdrFEAnyDSxI=;
        b=MRt29Ow0BuCjdaAladbeF03jZP74fULFQ+dJgMdlumeYtmDvz0z9TDmUxfokz2Eyjh
         qPzXuPcLZIXihht2BAGICMy42+Ey3vsbTAZiaC2wdSI3iFAyhG0K3s8J6SVC4FCVh3mK
         OBAlybZA58QFkRumA9L6dV3I/GRKAX27bTBifrNaGlc9htoEqxI24NIwkhThE0+pPe+k
         7ZfwISEivNx+3soHZ+aW1gutub0gbn86Vss7PqbSs+abeWhqVEzOSRgZpQxTvy8c3bRk
         9dXEdTThjbgK0s+fz8TMU+YBT+GAjcR0qQBgtM167tJllir5lGa6QbFV2UsGdOhkOPTa
         eS1g==
X-Gm-Message-State: ACrzQf1P01ItgHJryj9BkKQe6qgy3cZ6zENSeA6PgSqjFyYjmtqZZupi
        pEfCrEjAhB7sKraZj8U42cp+Hu/V4HSdosVE6xE3YJuryZg=
X-Google-Smtp-Source: AMsMyM7wd3pzWo8VncTByMFjLLgln0OwIwcK3gXl3Zgqfej30UWCt4J+Pxj4+OSJo2pBPh/A1CwgGwxvzKjCTtHu71A=
X-Received: by 2002:a25:9e83:0:b0:6be:ebbb:9d8b with SMTP id
 p3-20020a259e83000000b006beebbb9d8bmr12166374ybq.333.1667213952098; Mon, 31
 Oct 2022 03:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHgcA=uXQWbmm+C-Z+HvzRhYr+AfEOyky6ua4MZThO0+voZhtw@mail.gmail.com>
In-Reply-To: <CAHgcA=uXQWbmm+C-Z+HvzRhYr+AfEOyky6ua4MZThO0+voZhtw@mail.gmail.com>
From:   Tony Thuitai <thuitaitony@gmail.com>
Date:   Mon, 31 Oct 2022 13:59:01 +0300
Message-ID: <CAHgcA=s69E_hzzhB9Ch1sun9eAB4M_2p36eBQAoTBcpUry-v8Q@mail.gmail.com>
Subject: Issue Update with logs: RTL8723DE: System freeze on wake after
 suspend and Turning off airplane mode via keyboard button
To:     linux-wireless@vger.kernel.org
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

To add on the issue that I reported on 7th October 2022, when Wifi is
turned off and then back on by using the Graphical switch accessed by
Wifi button on system tray. Wifi works with errors listed below.
Driver installed on Manjaro freezes boot with a non-blinking
underscore visible in a similar manner like this issue. Please Do not
merge the driver into a stable kernel until the issue is resolved on
affected systems.

[   29.309732] rtw_8723de 0000:0d:00.0: failed to poll offset=3D0x6
mask=3D0x2 value=3D0x2
[   29.309740] rtw_8723de 0000:0d:00.0: mac power on failed
[   29.309743] rtw_8723de 0000:0d:00.0: failed to power on mac
[   29.309745] rtw_8723de 0000:0d:00.0: leave idle state failed
[   29.310103] rtw_8723de 0000:0d:00.0: failed to leave ips state
[   29.310107] rtw_8723de 0000:0d:00.0: failed to leave idle state
[   30.433542] rtw_8723de 0000:0d:00.0: timed out to flush pci tx ring[5]

On Fri, Oct 7, 2022 at 7:09 PM Tony Thuitai <thuitaitony@gmail.com> wrote:
>
> Repository: lwfinger's rtw88
> OS: Linux Mint 21
> PC: HP notebook 15 series laptop
> Wireless module: RTL8723DE
>
> The driver performs better than the inbuilt 5.15 kernel version but it fr=
eezes my PC on wake from suspend or after turning off airplane mode via key=
board button. During the system freeze no logging occurs. Last item logged =
is immediately before the freeze. Workaround for wake after suspend is to u=
se the suspend script from the repository that deactivates the driver befor=
e suspend and activates it on wake via modprobe.
