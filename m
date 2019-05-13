Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53DFC1B488
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 13:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfEMLHn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 07:07:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42920 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfEMLHn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 07:07:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id l2so14735276wrb.9
        for <linux-wireless@vger.kernel.org>; Mon, 13 May 2019 04:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=8qPPqWD2z0kVvPp6nbqZgda8oGIC82fsd1pYy39EkQQ=;
        b=iRv4ybgWM2JAFd7VuYeqp8SUaqDFJd7QfoCasx+UeFbhGS9X2IZZdSFBq1obmwJmHj
         jAxrCZ+aqosCD847t/b18vScxa6+/Q/ZnnBRoJFxJ/jllhe5AWUOhcF4nQGu2LLeg3/Z
         OoyewQ6+yG+AvjvqCyOaMMTx8Y9EbmqE3c3GQ5WGn6Y/ntwXHB1p4OiCN4ars+pLs9Ud
         qU2jdZa7pc+mbTrerilKBAQhVnFRLzk42Rj5PvVS3zBLa0RFR3+vAlmEaI6Lb26Y10Qx
         3m0UrwffoAuzdOC/npIPXgImcvPCl/BYbR/Q/JrWDSoK16C5aWWUg896L0u1N/V6aOfz
         soWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=8qPPqWD2z0kVvPp6nbqZgda8oGIC82fsd1pYy39EkQQ=;
        b=kmyTxyeQZ6BNMzdbvhaWiUoJlYDmRjd2o31HWd2ojTApIHlVjZb1eBMeiacJD4grC9
         DNNOEm9iLvoHrn/Utrb7Nu1BhhxfdffPpTHaYfjZWQ3OtFWakCFHmBZ3oBWhNSg6AhTK
         D6/rAmqY0wucKxEJNrXiKQxzmCLnRegKvn09MkYs2R5itYkQIrC0mdXnUOnZ0wNfsZqG
         xy6U8outjHzYBjmgsyEDmg784iKH+w/QJXgB0Pb3IIXyLf4e8IpEenOoXCap3e4ubnLh
         3rErTQ/wjIDlEl+WaD1iRUmWGs1nO4yKNCvr2Ty9xybOuOzfiCQ2lqk9IWK3HhkWlvX6
         3rfg==
X-Gm-Message-State: APjAAAVwpap2EQ/vyNMLNJGFFSrlynS76k6t68/OGWgawDRqnkhJkN1A
        x7RC0gEN9x8hBsOtk7rBB/ffiduJkL24dPt/KCA=
X-Google-Smtp-Source: APXvYqx1eAYNDOxbTxJVFLgZJHeX4IvNbIyUrKXknGFDmfT5L4fbQqDg7nSg0bzq5e/H0Q5XbeZkjQLwYZO8IV30ueI=
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr17724172wrj.66.1557745661721;
 Mon, 13 May 2019 04:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUX+VNtk00YQnNYCnDeeH2Onq6s1vbdzYrv-OHf7q186Ww@mail.gmail.com>
 <154e3e74-38b5-850b-5993-295f9db8fe3c@intel.com> <CA+icZUWhBeup95PTP_k58xs8Lf2Ofqb0S_gkdBfbuc0-wdpF-w@mail.gmail.com>
 <06fbacb5-7739-1ca1-3bf4-8049a3ef019b@intel.com> <CA+icZUWJ0kZSqogg18LdP2YkNXk=_SNnT7-ufkd_Xp1ak7uchg@mail.gmail.com>
 <20190513095059.GN9224@smile.fi.intel.com> <CA+icZUWXSup0BfXNZXxcrAAbu-b9KCiBU++OkC+eFqacMrTwRg@mail.gmail.com>
 <20190513105745.GR9224@smile.fi.intel.com>
In-Reply-To: <20190513105745.GR9224@smile.fi.intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 13 May 2019 13:07:28 +0200
Message-ID: <CA+icZUVE2ZG3bkMcq2HWX-Av=-H0Xqh5pMgMQOpc7w0my7CqkQ@mail.gmail.com>
Subject: Re: [linux-nfc] ThinkPad T470 and NXP PN5xx (PN547 or PN548)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 13, 2019 at 12:57 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, May 13, 2019 at 12:38:27PM +0200, Sedat Dilek wrote:
> > On Mon, May 13, 2019 at 11:51 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Mon, May 13, 2019 at 11:27:07AM +0200, Sedat Dilek wrote:
> > >
> > > > Sorry to say, I still have not get all correlations...
> > >
> > > Can you provide the output of the following on running Linux system with latest
> > > possible kernel you can install (I am expecting v5.1) and command line with
> > > 'ignore_loglevel'?
> > >
> > > 1. `dmesg`
> > > 2. `grep -H 15 /sys/bus/acpi/devices/*/status`
> > > 3. `acpidump -o t470-tables.dat` # the file t470-tables.dat
> > > 4. `lspci -vv -nk`
> > >
> > > P.S. You may use GitHub gist for this set (please, don't share archives) or any
> > > other resource like pastebin.
> > >
> >
> > Looks like I am unable to use Debian's gist-paste package today or
> > need more coffee.
> >
> > So, I add this here.
> >
> > I added my kernel-config.
>
>
> Thanks. I just sent a series to (hopefully) support it in the vanilla kernel.
> Can you test it?
>
> P.S. I see in dmesg the pn544 tries to bind to the NXP1001. Do you have some
> custom patches for that in your kernel? If so, please drop them.
>

Hi Andy,

I dropped the manually added nxp-pn5xx in driver/misc.

No, I have no custom patches.

Thanks, I amcompiling with your v2 series of NFC nxp-nci...

- Sedat -
