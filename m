Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089BF632425
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 14:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiKUNqP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 08:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiKUNqK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 08:46:10 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52ABDF0B
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 05:46:06 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id gv23so28654725ejb.3
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 05:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vK4Kx9qOErf2M8VouVIvtgoyy6LtAnvCR5+lEejBHrQ=;
        b=aUWImpaEPlYdG5tmdxsrNxY7BnFB6di6fKLyPu3rcRTRwBnMgZcOoNYuYnj+GtjClV
         yzm74Mn0vSBUQLSpoS0hVvr84Fc9xdu9gg2vpoB99arHYQs4OXZz4y/uNNdTT+MeQtp4
         v248Q+1DWbm4GPRKirJRBwOgULQxrfYM7F2X10LU6M9xsRQf+wi4NtzGvXVBxwSittvv
         MGPoLoe5UGMlAHVbxpaFWWTeQw6jVpheStwy6e670em/LW64ivrTRtwBykn3Kcb44l9I
         8F2fMhPNcWzXxLM4WyyymgaThxscScmHpQROAIGYwChfW023GHH+syucvdpomo5iZzSP
         lANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vK4Kx9qOErf2M8VouVIvtgoyy6LtAnvCR5+lEejBHrQ=;
        b=s45+xY8/aYVq87BfDgUlopxvUhJX3vJqx/6Y5yH7e2mm7sAknCfSxTv32cDt95oDkk
         E1XXc+8VFvYRG5wZcxs6eud9jS93C+2GDTzijfuwt7DMi2Jz8NfcjsLR8z47guPvGcOz
         IfeumEZYJo03ppTXpjm4ArsYzWAEuXNO2NL0v/AWKXfvDbjGvXdk7HcuxMms5H73U/Sn
         BWhfQx82jbTZYyppstj2OIFWyAfgPsIZPMiwUojMH7IVc+mJXf2HEc2jUA8ZROIitVdn
         iGlUKqz8SikizoFAmg3XiB1JN+zVPj8mN9+RQ9VtpgAdhlMDMYBYJr3jtKddnhhaRqo8
         R5sw==
X-Gm-Message-State: ANoB5plinu07TmG/btE1rii18NXw7vH9NJXYvPZM064JN88QRFrg9Had
        ubZa1lPtwhCYHx2jqyrIc2qLkMWl9HFvXUtJM79x9AdW
X-Google-Smtp-Source: AA0mqf4p8wcuIx0hEDIzJks6t57kDlb572ebEKb5h0w31iFAPTDQv/DYcgdcC6qT8hiICU3FnTWouMlmgEbPMo/UZI0=
X-Received: by 2002:a17:906:5a8b:b0:7a5:f8a5:6f80 with SMTP id
 l11-20020a1709065a8b00b007a5f8a56f80mr16211265ejq.202.1669038365133; Mon, 21
 Nov 2022 05:46:05 -0800 (PST)
MIME-Version: 1.0
References: <CAKf6xpuJgj2TPGZsUw7JXvMkpv-wzgPq13ySzMaz0R2Ti9WQ4A@mail.gmail.com>
 <CAKf6xpuKGp6HSB--xNKqKXMAY2Jj13Zzeg8=8G=-YJOsN2UvAg@mail.gmail.com> <CANUX_P0tXpmcia=djC8yzyY0OCS2UNOZjSAuxRjeBfgQqyUrtQ@mail.gmail.com>
In-Reply-To: <CANUX_P0tXpmcia=djC8yzyY0OCS2UNOZjSAuxRjeBfgQqyUrtQ@mail.gmail.com>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Mon, 21 Nov 2022 08:45:52 -0500
Message-ID: <CAKf6xpvd46nnvPeK6bdA6n7g3++i3zxOBRev=G6_jYRnF3nW1g@mail.gmail.com>
Subject: Re: iwlwifi write to PCI_CFG_RETRY_TIMEOUT
To:     Emmanuel Grumbach <egrumbach@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Nov 20, 2022 at 2:50 PM Emmanuel Grumbach <egrumbach@gmail.com> wrote:
>
> On Fri, Nov 18, 2022 at 11:13 PM Jason Andryuk <jandryuk@gmail.com> wrote:
> >
> > On Thu, Nov 17, 2022 at 2:33 PM Jason Andryuk <jandryuk@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > I was looking at iwlwifi under Xen PCI passthrough and I noticed a
> > > curious PCI config space write:
> > >
> > > https://github.com/torvalds/linux/blob/master/drivers/net/wireless/intel/iwlwifi/pcie/drv.c#L1721
> > > /*
> > > * We disable the RETRY_TIMEOUT register (0x41) to keep
> > > * PCI Tx retries from interfering with C3 CPU state.
> > > */
> > > pci_write_config_byte(pdev, PCI_CFG_RETRY_TIMEOUT, 0x00);
> > >
> > > With 00:14.3 Network controller: Intel Corporation Cannon Point-LP
> > > CNVi [Wireless-AC] (rev 30)
> > > register 0x41 in the PCI config space is the next cap pointer for
> > > "Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00".
> > >
> > > On baremetal, the write seems to be dropped since `hexdump -C
> > > /sys/bus/pci/devices/0000\:00\:14.3/config` still shows 0x80 (in my
> > > case).  Though I suppose the device could be acting on it even if the
> > > value doesn't change.
> > >
> > > With Xen PCI passthrough, QEMU seems to honor emulating the write and
> > > it breaks lspci traversing the capabilities so MSI-X is no longer
> > > shown.
> > >
> > > Is the write to RETRY_TIMEOUT at 0x41 correct?  It seems to be really
> > > old.  Here it references being copied from ipw2100:
> >
> > It seems like lots of drivers copied the write from ipw2100.  And it
> > seems like no one knows exactly why it is there.  But it does do
> > something for some devices which is why ath9k kept it.
> >
> > These are some interesting and relevant emails:
> > https://lore.kernel.org/linux-wireless/43e72e890912192251r4de4a3c3idb5e4c3723ef87aa@mail.gmail.com/
> >
> > https://lore.kernel.org/linux-wireless/20090616151258.GA22849@jm.kir.nu/
> >
> > >> I seem to remember the provenance of this code was copy-paste from
> > >> an intel driver, so while it does "something," the comment may not
> > >> match the code, 0x41 being vendor-defined.
> > >
> > > The exact story behind this has been a bit more than trivial task to
> > > figure out ;-). I would assume this comment is referring to a madwifi
> > > changeset: http://madwifi-project.org/changeset/584
> >
> > Unfortunately, that link seems to be dead and archive.org doesn't have it.
> >
>
> I asked internally and unfortunately I couldn't get any clear answer.
> Looks like this setting
> has been there for many many years (~15) and nobody really understands
> why. It has been
> removed for our newest device in another (close source) driver and I
> guess we'll do the
> same in Linux. I am not sure what we'll do with legacy devices though...
> We could remove it and risk a regression, or just ... leave it..

Thanks, for checking, Emmanuel.

Yes, it seems safest to just leave the write and avoid the risk of
regression.  It is curious how this "mystery" write made its way into
so many drivers.

Regards,
Jason
