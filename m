Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA02B375123
	for <lists+linux-wireless@lfdr.de>; Thu,  6 May 2021 10:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbhEFIzX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 May 2021 04:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbhEFIzV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 May 2021 04:55:21 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E01C06174A
        for <linux-wireless@vger.kernel.org>; Thu,  6 May 2021 01:54:22 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso4228235otb.13
        for <linux-wireless@vger.kernel.org>; Thu, 06 May 2021 01:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aleksander-es.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q4IHGEooq3P+sjgPfLgE2uimjvqOzdAedwdUmuZ41V8=;
        b=uJJTlMSh7CgDeLRxaWJ8I8PMnOxkDVU2RFx1QH1Xvf8aFDPZdpShEznsc8E50kHXma
         eC9IeTznEp+vZSPfrfo5RHOVZ4Tv7D1PurJXkO0maUUB+oA+BfQV9y1VBWwa/1Mr7KA6
         kIi/CRVtXaIjiuTr9PNgQBbjsYeeueE5KzhXllDGVEYKoEZvc7iNPtvTM9TZ+VykonJT
         MQdxlqmkO/nRNXglkAgkw3qczqAnDwfvPjZyxawOILCrOwPP54Wn1tM/i6Ior6QFJGhH
         eYse/vk1yEuhgFXJb+veFSY6Zv22aD5N1oK2EnX7MD9NrsCeRPpmF3soZ+fyLyofKKwy
         pG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q4IHGEooq3P+sjgPfLgE2uimjvqOzdAedwdUmuZ41V8=;
        b=npZsmGUz0/vpiCwuNQoUs3OPgPNyR8PHnjyx+RqC1DzqFIo9x7nM9WvonerAULjjRk
         16ygkhBxR4DLyRRngO+Epoj6gZDUm1R2bvUiqYx8xnZHlMeusXL15uTm1EzQd8O0nwFw
         VpOLpJzUgyhmG++152I6m/hFDsTmBcGoqIPAP2JhrhKQRb3jzbuaA60NVUrz3nm990zM
         0miiCHHcGWzXfnfsVRnHrMLR+pWAuXGAcMAkzEzVrTyea55jo5uB8wTqeuGmSlJ543Fq
         UOOTKFlduWKMYC5OzLv9DsvuY26Dy2uaQtbNiIph4NUXAGGFFPEE2h0e9SqymaUEeNjU
         cSvA==
X-Gm-Message-State: AOAM5317ORJj63L7NTLzbYBqw1htrb3MeXii6KRKTTsBuYFa1mTbYice
        mk4Fb3a8gCFEgRpge0fUdlJj6W8LdQ5i645zZrJ+og==
X-Google-Smtp-Source: ABdhPJyMzBmLsV7xvM80Kz3lnaTIUFkGGFrPTmL/AhZCqEZIIGjeeb6BxiiigwqQx3JIgmsfavOPMPgmSt4NrCy+anM=
X-Received: by 2002:a9d:10a:: with SMTP id 10mr2698527otu.188.1620291261869;
 Thu, 06 May 2021 01:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210420161310.16189-1-m.chetan.kumar@intel.com>
In-Reply-To: <20210420161310.16189-1-m.chetan.kumar@intel.com>
From:   Aleksander Morgado <aleksander@aleksander.es>
Date:   Thu, 6 May 2021 10:54:10 +0200
Message-ID: <CAAP7ucLwXqvc8sNpm8NtowFnKxcWKAwqwJEE89s9eME1YgCowQ@mail.gmail.com>
Subject: Re: [PATCH V2 00/16] net: iosm: PCIe Driver for Intel M.2 Modem
To:     M Chetan Kumar <m.chetan.kumar@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Network Development <netdev@vger.kernel.org>,
        linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
        krishna.c.sudi@intel.com, linuxwwan@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hey,

On Tue, Apr 20, 2021 at 6:14 PM M Chetan Kumar <m.chetan.kumar@intel.com> wrote:
>
> The IOSM (IPC over Shared Memory) driver is a PCIe host driver implemented
> for linux or chrome platform for data exchange over PCIe interface between
> Host platform & Intel M.2 Modem. The driver exposes interface conforming to
> the MBIM protocol. Any front end application ( eg: Modem Manager) could
> easily manage the MBIM interface to enable data communication towards WWAN.
>
> Intel M.2 modem uses 2 BAR regions. The first region is dedicated to Doorbell
> register for IRQs and the second region is used as scratchpad area for book
> keeping modem execution stage details along with host system shared memory
> region context details. The upper edge of the driver exposes the control and
> data channels for user space application interaction. At lower edge these data
> and control channels are associated to pipes. The pipes are lowest level
> interfaces used over PCIe as a logical channel for message exchange. A single
> channel maps to UL and DL pipe and are initialized on device open.
>
> On UL path, driver copies application sent data to SKBs associate it with
> transfer descriptor and puts it on to ring buffer for DMA transfer. Once
> information has been updated in shared memory region, host gives a Doorbell
> to modem to perform DMA and modem uses MSI to communicate back to host.
> For receiving data in DL path, SKBs are pre-allocated during pipe open and
> transfer descriptors are given to modem for DMA transfer.
>
> The driver exposes two types of ports, namely "wwanctrl", a char device node
> which is used for MBIM control operation and "INMx",(x = 0,1,2..7) network
> interfaces for IP data communication.

Is there any plan to integrate this driver in the new "wwan" subsystem
so that the character device for MBIM control is exposed in the same
format (i.e. same name rules and such) as with the MHI driver?

-- 
Aleksander
https://aleksander.es
