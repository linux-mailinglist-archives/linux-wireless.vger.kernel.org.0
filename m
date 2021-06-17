Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6767A3ABF1C
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 00:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhFQW4x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 18:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhFQW4x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 18:56:53 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED46C061574
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 15:54:44 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id r9-20020a4a37090000b029024b15d2fef9so1747194oor.7
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 15:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZTu3Ni0mS8UfVq79jN5CnksmHBT6Flvr1DCNZOJ/NUo=;
        b=kEb1rZteJCHiliHpAXj2Pvi/SeJ6SI3Z49i5PNcfZuzhK1C8ZsWDUY+FIMhBbwdTBF
         HV5KstBBzakibdqCLun3n1yScquq+YUAI8H2/GZQUNH9soBB0LpVkYdygmqSBArCl2qe
         QkvvJIoSdftc00VA6D/Phn4DbVvOzfMpf7e9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZTu3Ni0mS8UfVq79jN5CnksmHBT6Flvr1DCNZOJ/NUo=;
        b=Z9YaFEEJG4V54QbSBBviG251Gfu+e7wpK3oEKTGdzYAQ4uTi56VXmNy0oa2HbZ6rWi
         24TO/tOJVbVYtuUKizgX9K9KIzj+gvTSmkD+qDYfGdrdwwhvIcI4woPZN3jOqCjX/GnX
         WyvX0sqJpeOhOSQe5XwV9628iSYD2dgu/rYQxR+mboecPg5WXaD239A2wzVVIypZRAyG
         JKw01fQC3gLfq55cDgdVm1M0cMUlzSC2x8WDwb2YO+XWeoOs1VmCkpCSW5mwK+M5ObVp
         nKufBcXS4RMXR5S2SoSvEyYijPy5BNhZQOQLAD0CiAq4Cmfihq/LGs96iLgPf3aDHNcS
         QM/g==
X-Gm-Message-State: AOAM533/5+AMmU8FwxWYpsXnZWjReizorKzkmD19fZVmUVJ9eoRuFgFB
        2mQcJ+SBWS/6MbMhvQt5M9RZRcZ48YxhaA==
X-Google-Smtp-Source: ABdhPJw1kK4mxOP0fbqohdTEmT3INMG4qPO9QZtmQCaCys9Jbl+OIAIwR4qOQcYuuPCnjSHaoV+v0Q==
X-Received: by 2002:a4a:8749:: with SMTP id a9mr6342666ooi.71.1623970483337;
        Thu, 17 Jun 2021 15:54:43 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id z5sm1609169oth.6.2021.06.17.15.54.42
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 15:54:42 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id w23-20020a0568301117b029044c37262dadso2450216otq.8
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 15:54:42 -0700 (PDT)
X-Received: by 2002:a05:6830:168a:: with SMTP id k10mr6722572otr.203.1623970481971;
 Thu, 17 Jun 2021 15:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <83a9aeff-ce2c-3442-90fa-7e190acf3dfe@lwfinger.net>
 <1af1e1f4-caa4-323e-0a2a-b3fdf1cac6b8@justmail.de> <92a3ff23-2763-44e2-a20e-25190d46d4bd@lwfinger.net>
In-Reply-To: <92a3ff23-2763-44e2-a20e-25190d46d4bd@lwfinger.net>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 17 Jun 2021 15:54:27 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOY8HRjU6JK8a_Z9KUnXr3w_qXVU7hK56+6c2DQKiyFVg@mail.gmail.com>
Message-ID: <CA+ASDXOY8HRjU6JK8a_Z9KUnXr3w_qXVU7hK56+6c2DQKiyFVg@mail.gmail.com>
Subject: Re: Memory leak in rtw88-pci
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     =?UTF-8?Q?Klaus_M=C3=BCller?= <kmueller@justmail.de>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Apr 11, 2021 at 12:35 PM Larry Finger <Larry.Finger@lwfinger.net> w=
rote:
>
> On 4/8/21 11:12 PM, Klaus M=C3=BCller wrote:
> > May I kindly bring up this reported problem again? Is there anybody wor=
king on
> > this problem? Or did I miss the already existing fix?
>
> A fix has been found. The patched code is available at
> https://GitHub.com/lwfinger/rtw88.git. Patches are being prepared for
> wireless-next. From there, they will propagate into the Linux distributio=
ns.
Did you ever submit the second half of that patch?
https://github.com/lwfinger/rtw88/commit/0eed97166d54cf6fa03e20735b9c208375=
b8c949
(modifications to rtw_fw_c2h_cmd_rx_irqsafe())

We're still seeing leaks here with kmemleak, although I'm using a
5.4.y kernel, so maybe don't have all the latest fixes yet.

NB: I *do* have this: https://git.kernel.org/linus/191f6b08bfef
as it made it to 5.4.y.

Thanks,
Brian
