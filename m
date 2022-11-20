Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C487363160F
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Nov 2022 20:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiKTTvF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Nov 2022 14:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiKTTun (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Nov 2022 14:50:43 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F9C450BE
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 11:50:10 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ud5so24316440ejc.4
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 11:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8LaHKmq7OFJnIyMctlCwRLI+i+Iq0pi+JZ2iY5cq02g=;
        b=AN9rStZCtMgLQUv9/49V7YhZAwRm+PNwNReA0n5gVRkWkdm8EppkQHCh6QfYmbAz19
         nGJx969XrtxRL75oXJIT6O5lutVJn79Z0ZE6S1cOpJcK059OpNDnHAp9V0Z7eqE7Hfs3
         Pq+G1Eg8XcgIwk8HX9ZN+QR/sFd3ln2kak9Gqsnb4wpoxvZNCBL694BDuOy/UHRniyL0
         r1UxjNYXQv/ii4DIYNoRJYVC75SNcjFVpe8TqOtK87CJ4WDOrfirVUlaiB81RVWeM58u
         jpSTDP41uj8SxgB+ObYoDoFRNks6vK6p2GQy3zsznfNqUxXMSuUhoNQbU6qOWNPJTB47
         k4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LaHKmq7OFJnIyMctlCwRLI+i+Iq0pi+JZ2iY5cq02g=;
        b=rVzTuIwm5fubhAMHGfpl2QGo6hOe4jC7RJSgITxlNe4ns3xpAYaVbP5kGzG0UYrkdi
         1WLbHkSRvSILu8PXoKK2E/YQxEmv+VBGgA1gdhOFh0d0Pz74P9T/S+XmqKZdj5VI5LFf
         CdpKDA143uRk1HumzvkNvRVYGgSIf005snwlOUcYuylC4DA6kJRfTZXwb6EuBEnv/eXb
         uPx3UsJQM2KG0chIL9c39mH4lnjna0qE+MEWoyQ51ZteTphNvVc9nIKsoon8QzewzAI/
         SoeMM5xmDx1WqQ7dDqvFyt1COz7kFogHwbVUWT9sY/VeYiTIo8BodjEFfskZTVEo4xnH
         6MHQ==
X-Gm-Message-State: ANoB5pkt5Nh93LqkVRamOCrQqfcF6Jc+876cGm4nHVPP/zsHk9JHUpOU
        nUyogM3DZIjUxcTdc6lWChc00gIVMWjwG0HzODqeP+LI
X-Google-Smtp-Source: AA0mqf5vnTsEtQ4B7Zfkj0WpHo7Db21kB3jusileqnwVejhEjw/O43dzXMhXDsBkoJaFHOVv2M94Gqxmt6lwgfQWnHs=
X-Received: by 2002:a17:906:d785:b0:7ad:a3c6:6797 with SMTP id
 pj5-20020a170906d78500b007ada3c66797mr13487063ejb.665.1668973808804; Sun, 20
 Nov 2022 11:50:08 -0800 (PST)
MIME-Version: 1.0
References: <CAKf6xpuJgj2TPGZsUw7JXvMkpv-wzgPq13ySzMaz0R2Ti9WQ4A@mail.gmail.com>
 <CAKf6xpuKGp6HSB--xNKqKXMAY2Jj13Zzeg8=8G=-YJOsN2UvAg@mail.gmail.com>
In-Reply-To: <CAKf6xpuKGp6HSB--xNKqKXMAY2Jj13Zzeg8=8G=-YJOsN2UvAg@mail.gmail.com>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Sun, 20 Nov 2022 21:49:57 +0200
Message-ID: <CANUX_P0tXpmcia=djC8yzyY0OCS2UNOZjSAuxRjeBfgQqyUrtQ@mail.gmail.com>
Subject: Re: iwlwifi write to PCI_CFG_RETRY_TIMEOUT
To:     Jason Andryuk <jandryuk@gmail.com>
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

On Fri, Nov 18, 2022 at 11:13 PM Jason Andryuk <jandryuk@gmail.com> wrote:
>
> On Thu, Nov 17, 2022 at 2:33 PM Jason Andryuk <jandryuk@gmail.com> wrote:
> >
> > Hi,
> >
> > I was looking at iwlwifi under Xen PCI passthrough and I noticed a
> > curious PCI config space write:
> >
> > https://github.com/torvalds/linux/blob/master/drivers/net/wireless/intel/iwlwifi/pcie/drv.c#L1721
> > /*
> > * We disable the RETRY_TIMEOUT register (0x41) to keep
> > * PCI Tx retries from interfering with C3 CPU state.
> > */
> > pci_write_config_byte(pdev, PCI_CFG_RETRY_TIMEOUT, 0x00);
> >
> > With 00:14.3 Network controller: Intel Corporation Cannon Point-LP
> > CNVi [Wireless-AC] (rev 30)
> > register 0x41 in the PCI config space is the next cap pointer for
> > "Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00".
> >
> > On baremetal, the write seems to be dropped since `hexdump -C
> > /sys/bus/pci/devices/0000\:00\:14.3/config` still shows 0x80 (in my
> > case).  Though I suppose the device could be acting on it even if the
> > value doesn't change.
> >
> > With Xen PCI passthrough, QEMU seems to honor emulating the write and
> > it breaks lspci traversing the capabilities so MSI-X is no longer
> > shown.
> >
> > Is the write to RETRY_TIMEOUT at 0x41 correct?  It seems to be really
> > old.  Here it references being copied from ipw2100:
>
> It seems like lots of drivers copied the write from ipw2100.  And it
> seems like no one knows exactly why it is there.  But it does do
> something for some devices which is why ath9k kept it.
>
> These are some interesting and relevant emails:
> https://lore.kernel.org/linux-wireless/43e72e890912192251r4de4a3c3idb5e4c3723ef87aa@mail.gmail.com/
>
> https://lore.kernel.org/linux-wireless/20090616151258.GA22849@jm.kir.nu/
>
> >> I seem to remember the provenance of this code was copy-paste from
> >> an intel driver, so while it does "something," the comment may not
> >> match the code, 0x41 being vendor-defined.
> >
> > The exact story behind this has been a bit more than trivial task to
> > figure out ;-). I would assume this comment is referring to a madwifi
> > changeset: http://madwifi-project.org/changeset/584
>
> Unfortunately, that link seems to be dead and archive.org doesn't have it.
>

I asked internally and unfortunately I couldn't get any clear answer.
Looks like this setting
has been there for many many years (~15) and nobody really understands
why. It has been
removed for our newest device in another (close source) driver and I
guess we'll do the
same in Linux. I am not sure what we'll do with legacy devices though...
We could remove it and risk a regression, or just ... leave it..
