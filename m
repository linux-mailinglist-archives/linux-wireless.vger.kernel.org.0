Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152B960549B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Oct 2022 02:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJTAzz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Oct 2022 20:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJTAzy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Oct 2022 20:55:54 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20214160EE0
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 17:55:51 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h12so18407435pjk.0
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 17:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DunVneNoNh+dN8MZSey5HPV8TWJRC19vfrvMZI8e5ss=;
        b=TV/sxBFZIWHrw4Oy/hoj94CyRxpEqAj650tQCpC4Dl0p0mS/PBcdRWHcOsJA1qDkbh
         EKbRk3nqDK9V8Qavms5T5+VhSBd+gg/hmpV+ehpwFuqyi0k5CHMkZkYs/Nj1/ekrGMV2
         zkrDupy8WuVY9jdVexjM2RoRBv8SPBtnq8cPCfv8HAzEtdtI1d5iXoE760+7c1Z1wuiI
         74veGmXWjB1f5QWEmssWq2iVzdhCHv+WCojpv8+tjpREZpuNMbit3t3rJEtcPaZNxqCf
         gSD2++mJwO7CfsFkq2iu+flQo5gh4OL/r0UhiOjgVD/CruZQ5/a8AEwmyzsB4ceHu+2l
         dvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DunVneNoNh+dN8MZSey5HPV8TWJRC19vfrvMZI8e5ss=;
        b=o/AtKtnJBVyG02uyWjjLWso6JaTVMyWZLf86r1seKy1oYjIxoAQb2C1o5LASuudejs
         e/xZXfesIrmNQHkG540a3DSYxaIxapymU0nQdFsxX0J3tVjkK55q4BJ4Mm0DBEQdeed/
         /RaddA7n6jrOo31oYVGvCHQ2q7wQTE0EGfsgUAjIQJKlstMEC/vurbDCee/HXyfuz2kI
         Elp8PQFbC8xo5giPzGcyEYWvfig/wI1upynVhb8vv79nP11Ez1V2ZtLC3tGSC8TXxDzC
         qfeDWH+vXhqlyOslKksTvfVtUrn1NACOlfbO29LyoTa9mjCi8o4naml1uDq+3rV6C5Tp
         1MIQ==
X-Gm-Message-State: ACrzQf0gqLp8FmVcYHzHCZu0YEunDCheze3azLXw2oSpQKcNXVKSbh6w
        GLaUvSxcu7BvoOUP80eDVLVIMS3/UZeVgTyvHQo=
X-Google-Smtp-Source: AMsMyM5OxrATuGv9JeqtEV9UPDzUkisrXLRtTV8l9YHxYH7+CMlGosqZ8wiasNsE9xPoTTb/rydkhESVNAZt0hCKflQ=
X-Received: by 2002:a17:902:e552:b0:179:e795:71c5 with SMTP id
 n18-20020a170902e55200b00179e79571c5mr11182756plf.57.1666227350540; Wed, 19
 Oct 2022 17:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221014132729.2107129-1-james.hilliard1@gmail.com>
 <CA+5PVA5gLBAxbR4qUSUu3vs+nunM+igokVxd=oAQ7OMD2oGiWg@mail.gmail.com>
 <CADvTj4pF_DqwYofL-PU5os7Dco=XyWJ3fY3C1Wxq35pSe=QqFQ@mail.gmail.com> <f4f48fa5df844d9d8d270fb4310e9ff1@realtek.com>
In-Reply-To: <f4f48fa5df844d9d8d270fb4310e9ff1@realtek.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Wed, 19 Oct 2022 20:55:38 -0400
Message-ID: <CADvTj4poSjtCP9iRZNJHf=qLPHBmNQzhcc0Ff_jT-q5jjgTZnw@mail.gmail.com>
Subject: Re: [PATCH] rtlwifi: update firmware for rtl8192eu to v35.7
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Josh Boyer <jwboyer@kernel.org>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <jes.sorensen@gmail.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 19, 2022 at 8:39 PM Ping-Ke Shih <pkshih@realtek.com> wrote:
>
>
>
> > -----Original Message-----
> > From: James Hilliard <james.hilliard1@gmail.com>
> > Sent: Wednesday, October 19, 2022 9:30 PM
> > To: Josh Boyer <jwboyer@kernel.org>
> > Cc: Ping-Ke Shih <pkshih@realtek.com>; linux-firmware@kernel.org; linux-wireless@vger.kernel.org; Jes
> > Sorensen <jes.sorensen@gmail.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>
> > Subject: Re: [PATCH] rtlwifi: update firmware for rtl8192eu to v35.7
> >
> > On Wed, Oct 19, 2022 at 8:10 AM Josh Boyer <jwboyer@kernel.org> wrote:
> > >
> > > On Fri, Oct 14, 2022 at 9:27 AM James Hilliard
> > > <james.hilliard1@gmail.com> wrote:
> > > >
> > > > This is v35.7 firmware for the rtl8192eu.
> > > >
> > > > This adds 2 new firmware variants extracted from vendor drivers that
> > > > were not previously present:
> > > > rtl8192eu_ap.bin
> > > > rtl8192eu_nic_setupbox.bin
>
> I think these two are not suitable to rtl8xxxu, so I suggest to ignore them.

That's correct, and actually only rtl8192eu_nic.bin seems to be used by
rtl8xxxu at the moment, I just extracted all variants for consistency, this
appears to be what was done when these files were originally added.

>
> > > >
> > > > These firmware files occurs as data statements in the latest Realtek
> > > > vendor driver I found for the rtl8192eu in addition to some older
> > > > vendor driver releases:
> > > > rtl8192EU_WiFi_linux_v5.11.2.1-18-g8e7df912b.20210527_COEX20171113-0047
> > >
> > > I have no idea what this is, nor is there any indication that Realtek
> > > wants these published to the linux-firmware repo under redistributable
> > > license terms.  You've extracted firmware from elsewhere and are
> > > assuming it is licensed under the existing license, but there's no
> > > indication that's actually the case.  The provenance of this firmware
> > > is questionable.
> >
> > I just extracted them from the vendor driver same as last time:
> > https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/rtlwifi/rtl8192eu_n
> > ic.bin?id=91d5dd136153e0a199d7bf30fd03763d83586b73
> >
> > The vendor file license just says GPLv2:
> > https://github.com/clnhub/rtl8192eu-linux/blob/5.11.2.1/hal/rtl8192e/hal8192e_fw.c
> >
>
> I'm not a lawyer, no idea about this. I hope someone can comment this.
>
> > >
> > > I've copied Ping-Ke Shih in case they have some insight here, but I
> > > can't really take this patch as it is based on what is represented
> > > here.  An ack or Signed-off-by from someone at Realtek would go a long
> > > way.
>
> I think I can take patches related to Realtek firmware to my github tree,
> and send out pull-request after checking content of firmware patch.
> Does it work to you, Josh?

If possible could you check if v35.7 is the newest available firmware version
for the rtl8192eu?

The v35.7 was the newest I found in vendor drivers for the rtl8192eu, for
example in this dlink release(v35.7 was also in a few earlier revisions):
https://support.dlink.com/resource/SECURITY_ADVISEMENTS/DWA-131/REVE/DWA-131_REVE_DRIVER_v5.11.2.1-18_HOTFIX_LINUX.zip

>
> > >
> > > josh
> > >
> > > > Note that the existing rtl8192eu_ap_wowlan.bin firmware header
> > > > indicates it is actually v18.0 and not v19.0 as indicated by the
> > > > commit that introduced it 91d5dd136153e0a199d7bf30fd03763d83586b73,
> > > > as such it is marked as version 18.0.
> > > >
> > > > So far I have managed to find the following firmware versions for the
> > > > rtl8192eu in various vendor driver releases:
> > > > v18.0
> > > > v19.0
> > > > v27.0
> > > > v35.7
> > > >
> > > > The rtl8192eu_ap_wowlan.bin firmware does not appear to have received
> > > > any updates unlike the other rtl8192eu firmware variants.
> > > >
> > > > Previous firmware load in rtl8xxxu:
> > > > rtl8xxxu: Loading firmware rtlwifi/rtl8192eu_nic.bin
> > > > Firmware revision 19.0 (signature 0x92e1)
> > > >
> > > > Updated firmware load in rtl8xxxu:
> > > > rtl8xxxu: Loading firmware rtlwifi/rtl8192eu_nic.bin
> > > > Firmware revision 35.7 (signature 0x92e1)
> > > >
> > > > Cc: Jes Sorensen <jes.sorensen@gmail.com>
> > > > Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> > > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > > > ---
> > > >  WHENCE                             |   9 ++++++++-
> > > >  rtlwifi/rtl8192eu_ap.bin           | Bin 0 -> 25816 bytes
> > > >  rtlwifi/rtl8192eu_nic.bin          | Bin 31818 -> 32286 bytes
> > > >  rtlwifi/rtl8192eu_nic_setupbox.bin | Bin 0 -> 28554 bytes
> > > >  rtlwifi/rtl8192eu_wowlan.bin       | Bin 25878 -> 29008 bytes
> > > >  5 files changed, 8 insertions(+), 1 deletion(-)
> > > >  create mode 100644 rtlwifi/rtl8192eu_ap.bin
> > > >  create mode 100644 rtlwifi/rtl8192eu_nic_setupbox.bin
> > > >
> > > > diff --git a/WHENCE b/WHENCE
> > > > index 816cf7c..e7ae78a 100644
> > > > --- a/WHENCE
> > > > +++ b/WHENCE
> > > > @@ -3257,12 +3257,19 @@ File: rtlwifi/rtl8723bu_wowlan.bin
> > > >  File: rtlwifi/rtl8723bu_ap_wowlan.bin
> > > >
> > > >  Info: rtl8192eu taken from Realtek driver
> > > > -      rtl8192EU_linux_v4.3.1.1_11320.20140505
> > > > +      rtl8192EU_WiFi_linux_v5.11.2.1-18-g8e7df912b.20210527_COEX20171113-0047
> > > >        Firmware is embedded in the driver as data statements. This info
> > > >        has been extracted into a binary file.
> > > >  File: rtlwifi/rtl8192eu_nic.bin
> > > > +Version: 35.7
> > > > +File: rtlwifi/rtl8192eu_nic_setupbox.bin
> > > > +Version: 35.7
> > > >  File: rtlwifi/rtl8192eu_wowlan.bin
> > > > +Version: 35.7
> > > > +File: rtlwifi/rtl8192eu_ap.bin
> > > > +Version: 35.7
> > > >  File: rtlwifi/rtl8192eu_ap_wowlan.bin
> > > > +Version: 18.0
> > > >
> > > >  Licence: Redistributable. See LICENCE.rtlwifi_firmware.txt for details.
> > > >
>
> [...]
>
