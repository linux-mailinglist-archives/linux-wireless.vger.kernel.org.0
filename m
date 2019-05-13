Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0151B541
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 13:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfEMLuO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 07:50:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38193 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbfEMLuO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 07:50:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id f2so13395368wmj.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 May 2019 04:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=8Iv1H9IVtWYDs79W1H1Cik2yB+/Wcr66be8hSM8L1w0=;
        b=MGnqeZDsgS1O3xxWJrkluSjw+DHoHLVg+6MAiVIG6ipY0E9uHwEGS6zosM11E961pf
         tzRRjnvtU/Kt88uDapU/lE/aeqp2HtOuczNsJ+vWBW/ZimZoO4mnTvQtlUgLdoxDTEjR
         ryn52JHGdrr1KO3gbEdnC5GNihDkh+Tx7Sfb0m9v02jVjxEtZwTV1JgrXHe1djwPSCiF
         OQLvbuTG8vBI0O1Z7DjerF4E1AlyzCSJSMF4rxrMx+lhJ8fCjuBq4maO/S4lmEr3JVEm
         rRDV5Aw/y0U4aE+UoGYasBKTwdekSjUcMWGuJ4DlHZyTxc0DZkpxcqEI9fgiUU2B+nNd
         mILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=8Iv1H9IVtWYDs79W1H1Cik2yB+/Wcr66be8hSM8L1w0=;
        b=maFkPqGOY1nto2YWM0vjSCMh/RV59MwowWmWLosr0BkCBxPQCByPqGND536YSPSZxn
         QDXWo+2o8F2LwDTlVrK4bdPOn6CWr51PwqT2tm8dJsaXxdg4eQeAwz3LtzfJyt2su6EH
         ZHbfalF13S3pP19M53OQoUDJRItghnIBbggzLsj876/xFlSoqQk1wGu6A11YdJ8HUwUv
         0b/95Sw0wuyMW/Ddi09FRyXf7hp/cySLY+6YHiyIkG4svmj/hL+NnZ0XFm5kU9MZvmSo
         LwOWKsRWyZm8pVxV5s0MpvgrDhpjtuTj3Mk0UEXWyb0urzz8jyyG8U62yFoAXNfqAe4P
         GjGw==
X-Gm-Message-State: APjAAAV+13Pnie0mzXeT3SHLa63dHnsPulXv/fIFqIDQUrgw64cwPUG7
        emS5knnCbQ5Bzk/V3TP6NqyJNyoBdXwI7gI+Tso=
X-Google-Smtp-Source: APXvYqyotmCBEy1JptG9GAIy5wK3/0jIikJZpXH4ntVKtn25K+YO2Fe2hBZSF1HFiHC5WFGyTAvN2ChUpuicu/NgIbY=
X-Received: by 2002:a1c:f606:: with SMTP id w6mr14387665wmc.130.1557748212005;
 Mon, 13 May 2019 04:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUX+VNtk00YQnNYCnDeeH2Onq6s1vbdzYrv-OHf7q186Ww@mail.gmail.com>
 <154e3e74-38b5-850b-5993-295f9db8fe3c@intel.com> <CA+icZUWhBeup95PTP_k58xs8Lf2Ofqb0S_gkdBfbuc0-wdpF-w@mail.gmail.com>
 <06fbacb5-7739-1ca1-3bf4-8049a3ef019b@intel.com> <CA+icZUWJ0kZSqogg18LdP2YkNXk=_SNnT7-ufkd_Xp1ak7uchg@mail.gmail.com>
 <2b1bd56f-8797-fb90-e2af-218edaedd089@intel.com> <CA+icZUVMjCWwuC-ee1-+EPU6+mYqFZ7w4ai4t4EJcrsvZ2_BYg@mail.gmail.com>
 <3b7065a2-694f-63bf-fba3-a1641a03ea76@intel.com>
In-Reply-To: <3b7065a2-694f-63bf-fba3-a1641a03ea76@intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 13 May 2019 13:50:00 +0200
Message-ID: <CA+icZUVJbr_GLCccZQ+h8z+cSFj6hBAaywb97=s8SvnR6AbOVA@mail.gmail.com>
Subject: Re: [linux-nfc] ThinkPad T470 and NXP PN5xx (PN547 or PN548)
To:     Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 13, 2019 at 1:28 PM Oleg Zhurakivskyy
<oleg.zhurakivskyy@intel.com> wrote:
>
>
> Hi Sedat, Andy,
>
> Andy, thanks a lot for extending and cleaning that up.
>
> > Unsure, why the pn544_i2c NFC driver shipped with the Linux v5.1.1
> does not work.
>
> I briefly looked into drivers/nfc/pn544, that seems like an HCI based chip (as opposed to NCI based PN547).
>
> It might be that changes that Andy posted are already sufficient for PN547 to just work with neard (if I am not missing anything).
>
> # sudo apt-get install neard neard-tools
> # man nfctool
>

With the nxp-pn5xx (plus acpi support) and running the nfcDemoApp
demo-app I saw this in the logs...

$ grep PN548 nfcDemoApp-poll.txt
NxpHal:     phNxpNciHal_deriveChipType Hw Version (0x68) Not Found:
Setting Default Chip Type : PN548C2
NxpHal:     phNxpNciHal_deriveChipType NxpNci > Product : PN548C2

- Sedat -
