Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9AD62FF26
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Nov 2022 22:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiKRVHg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Nov 2022 16:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiKRVHe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Nov 2022 16:07:34 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CCE99E9D
        for <linux-wireless@vger.kernel.org>; Fri, 18 Nov 2022 13:07:32 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id f18so16000602ejz.5
        for <linux-wireless@vger.kernel.org>; Fri, 18 Nov 2022 13:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hsBFF6CLvSGQgYqfBGsSga8xVozq3EjdMhoiericRrs=;
        b=AZklXBj9DgKOkIGjby5yhfkVjiFid17RotWzbMveFTCLgaybzB5SMrilTd6/agcpqH
         3tdxg+t8L+IHXwZIYqScZiTQiRPtN+48WcplIT/NRdisdVuLTCD783/l1xiBzs6KyfUG
         AHtfGyyEZ4hVwagRNvRD0yCNWitzit7COab9a/tZRNofjSFTXU9fBd0Qu0chf64s8uwe
         XPZg69+TziaJbkFPMEUL8CBkvpu/F7rfdCpOZQLu0j/tKAxveHrds79tiE4pKH9fbQvs
         UceXeVW2Qxnq3oqSlBiA/Plqn8/h6vXucIQvS5qe0vuyjNzRPvZo/FMaxVGxzQsgEfGh
         lCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsBFF6CLvSGQgYqfBGsSga8xVozq3EjdMhoiericRrs=;
        b=qRcabDKIKVnq4KxZSov284ORMw9EVMiiiJemFCmxVbdTghGto1N1yCWYL/TEOyoaVR
         hTX39JAkmibKrl+sbEyxCCLg7uaxAIgpM6/7DMwLtu0cho050eFsVgy3hJtMi0bJV42Y
         9mQ8KhqrFDyQkF1Ih2caFNsgcD28I/BeFiDwYCPV2YhRquVXdxt1NZ9Mbwrf3+18w/4R
         DeKh9HiBtLCl7Uu5P9a3ShebD0WZKlVU532Fd44jdFaxFsSJXdUcnUv+T/pZ4DlciKy2
         xcPn16OSf2HDCsyOnGV8q5KIU/wdF/0Kz7mFXcXT1ioDvxG5h+zmFeFvn6YR8nlsqeNO
         wzpw==
X-Gm-Message-State: ANoB5pkHZ0/Z8Aae6tshfxU7lMFoKBnTt0o6UZW7dHf55/tn9V43f1q4
        anvHH/7UHzjhz8t+XdKG998PH4cuvcLS3vKENh/V4PrWKNo=
X-Google-Smtp-Source: AA0mqf7ZA42ig6JwbYHZFzFQMa6lnO9rZ8ZjXmCC5LCogfE6h6OpW9JKf4dLhltcgzpce7RBcO7jnm4XgMJ8qMGrWFE=
X-Received: by 2002:a17:906:cc8f:b0:78b:8ce7:fe3c with SMTP id
 oq15-20020a170906cc8f00b0078b8ce7fe3cmr7407002ejb.557.1668805650564; Fri, 18
 Nov 2022 13:07:30 -0800 (PST)
MIME-Version: 1.0
References: <CAKf6xpuJgj2TPGZsUw7JXvMkpv-wzgPq13ySzMaz0R2Ti9WQ4A@mail.gmail.com>
In-Reply-To: <CAKf6xpuJgj2TPGZsUw7JXvMkpv-wzgPq13ySzMaz0R2Ti9WQ4A@mail.gmail.com>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Fri, 18 Nov 2022 16:07:18 -0500
Message-ID: <CAKf6xpuKGp6HSB--xNKqKXMAY2Jj13Zzeg8=8G=-YJOsN2UvAg@mail.gmail.com>
Subject: Re: iwlwifi write to PCI_CFG_RETRY_TIMEOUT
To:     linux-wireless@vger.kernel.org
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

On Thu, Nov 17, 2022 at 2:33 PM Jason Andryuk <jandryuk@gmail.com> wrote:
>
> Hi,
>
> I was looking at iwlwifi under Xen PCI passthrough and I noticed a
> curious PCI config space write:
>
> https://github.com/torvalds/linux/blob/master/drivers/net/wireless/intel/iwlwifi/pcie/drv.c#L1721
> /*
> * We disable the RETRY_TIMEOUT register (0x41) to keep
> * PCI Tx retries from interfering with C3 CPU state.
> */
> pci_write_config_byte(pdev, PCI_CFG_RETRY_TIMEOUT, 0x00);
>
> With 00:14.3 Network controller: Intel Corporation Cannon Point-LP
> CNVi [Wireless-AC] (rev 30)
> register 0x41 in the PCI config space is the next cap pointer for
> "Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00".
>
> On baremetal, the write seems to be dropped since `hexdump -C
> /sys/bus/pci/devices/0000\:00\:14.3/config` still shows 0x80 (in my
> case).  Though I suppose the device could be acting on it even if the
> value doesn't change.
>
> With Xen PCI passthrough, QEMU seems to honor emulating the write and
> it breaks lspci traversing the capabilities so MSI-X is no longer
> shown.
>
> Is the write to RETRY_TIMEOUT at 0x41 correct?  It seems to be really
> old.  Here it references being copied from ipw2100:

It seems like lots of drivers copied the write from ipw2100.  And it
seems like no one knows exactly why it is there.  But it does do
something for some devices which is why ath9k kept it.

These are some interesting and relevant emails:
https://lore.kernel.org/linux-wireless/43e72e890912192251r4de4a3c3idb5e4c3723ef87aa@mail.gmail.com/

https://lore.kernel.org/linux-wireless/20090616151258.GA22849@jm.kir.nu/

>> I seem to remember the provenance of this code was copy-paste from
>> an intel driver, so while it does "something," the comment may not
>> match the code, 0x41 being vendor-defined.
>
> The exact story behind this has been a bit more than trivial task to
> figure out ;-). I would assume this comment is referring to a madwifi
> changeset: http://madwifi-project.org/changeset/584

Unfortunately, that link seems to be dead and archive.org doesn't have it.

Regards,
Jason
