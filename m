Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236D94EFD7A
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Apr 2022 02:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbiDBAhk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 20:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352520AbiDBAhj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 20:37:39 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0179A152821
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 17:35:46 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id p15so9057293ejc.7
        for <linux-wireless@vger.kernel.org>; Fri, 01 Apr 2022 17:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=f08GXqZtud8OgjECJ8SjYsoAp5Xep/EAO8UcsMYcRMo=;
        b=cKnW3+PJMrbIDZz+f8AuaaqCwKn4AVq1rfarIlLVJPAoK0lHJTFgqI0uqK+n7M/QGT
         Vw0YbouR8SLRWwk3tFrP8xYfSLpPwtt7fgcjTi/xKpU5JZHyMPzHz09mbd04vQgg3oJQ
         0i3mMDw6AwZ4VACWDMYOyxQmw2QkV5zTQ5Dbb5K9g21TTKGJfqaNUNpEKvdcpSCZm8Xr
         9k8LYNpLfl5n19jNxij1UL8h2QuwuC1rvC3mh+0Fql+JNPzRsTyS+hDoA94bIAM97lFj
         YQ83eQEl6HfqXL3CWvLxegMc8cY7XH6rSf/nqdCRtExSzPjabsvsWiuWyI+yFaL8YQB1
         fFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=f08GXqZtud8OgjECJ8SjYsoAp5Xep/EAO8UcsMYcRMo=;
        b=mo3LOMupqLe2I4IBVz0K1GYCEjniraKNBXUf4fkJGOIiXSg9me5pT5Pf0j+n5iQIXp
         au807xXctSYEJjRnyV5HBqSWJX51XExjMW/tiblEjSMC+E86yb6tLqIEbj+C8wx4eE1S
         EdvyPQJOv/DbRXE9OUYTFy5T8eRfwrlbxxu1QJELp6n3abpIWn+SEtMpqYK7tnMPxImH
         0pkBZEZ5zz82yLcmmn4C1JPMCJikwCrOtz4atvEO06RnePXp+Fq9gSHBoUcYG3+8bETs
         xXLOfbCskuA7+d3k72ou3jP4FZS56C2woe9k0T7SxUDo/4Dk0hRqVmXIEZX9g9A6zTUD
         v4FQ==
X-Gm-Message-State: AOAM531ilUbBEOJAMqB4B5iMMqiUqwGPptmex7dkENJNLS4Cks9TTxKC
        s75dEFqvrrSmmEDF5Az5rHBsSWxHAMEiXFxeQbM=
X-Google-Smtp-Source: ABdhPJzb7XOeBgl8qtVm1Y5+oHjxENBGW/o8EiqrTykpbt8f/A/67/czFA6VIzz61oBUZBpaE3kGXlRcW4iabFBF+YU=
X-Received: by 2002:a17:906:d555:b0:6db:148e:5cc with SMTP id
 cr21-20020a170906d55500b006db148e05ccmr1927274ejc.63.1648859744290; Fri, 01
 Apr 2022 17:35:44 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Sat, 2 Apr 2022 01:35:45 +0100
Message-ID: <CAHpNFcPot+RrkVqu1=_Jk6NPRf9r9C4SmKQN9oc64ZMwsVCHGw@mail.gmail.com>
Subject: Nesting a kernel under an unbreakable VM Is now possible with
 GunYeah! ARM8+ only
To:     torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nesting a kernel under an unbreakable VM Is now possible with GunYeah!
ARM8+ only

Rupert S https://bit.ly/VESA_BT

https://www.phoronix.com/scan.php?page=news_item&px=QuiC-Gunyah-Hypervisor-Linux-v1

Qualcomm Posts Linux Driver Patches For New "Gunyah" Hypervisor
Written by Michael Larabel in Virtualization on 24 February 2022 at
04:35 AM EST. 12 Comments
VIRTUALIZATION -- Qualcomm by way of their QuiC innovation center have
been developing Gunyah as an open-source type-1 hypervisor. Posted on
Wednesday were the initial patches providing Linux driver support for
Gunyah.

The Gunyah hypervisor code was originally published last year and to
date its public GitHib repo has seen just ten commits. Gunyah is
self-described there as:
Gunyah is a Type-1 hypervisor, meaning that it is independent of any
high-level OS kernel, and runs in a higher CPU privilege level. It
does not depend on any lower-privileged OS kernel/code for its core
functionality. This increases its security and can support a much
smaller trusted computing base than a Type-2 hypervisor.

Gunyah's design principle is not dissimilar to a traditional
microkernel in that it provides only a minimal set of critical
services to its clients, and delegates the provision of non-critical
services to non-privileged (or less-privileged) processes, wherever
this is possible without an adverse impact on performance or security.

The hypervisor uses the CPU's virtualization mode and features to
isolate itself from OS kernels in VMs. On ARM, this includes trapping
privileged registers, using GIC virtualization support, and the
Stage-2 MMU to provide isolated VMs in EL1/0.

The primary focuses of Gunyah are on providing strong security,
performance especially for mobile devices and delivering efficient
battery life, and being of a modular design.At the moment Gunyah can
only target ARMv8.2+ hardware with no other architectures supported
and older AArch64 hardware not being supported due to depending upon
EL2 in VHE mode. With mentioning mobile devices, only targeting newer
AArch64, and being developed by Qualcomm/QuIC, this hypervisor does
seem to be focused for mobile use-cases moving forward.

Sent out on Wednesday were these 11 patches for the Linux kernel
providing Gunyah hypervisor driver support. The QuIC patch series sums
it up as, "This series adds the initial support for Gunyah hypercalls,
IPC via message queues, communication with the Gunyah Resource Manager
to enable Gunyah's paravirtualized console."

We'll see how much interesr or adoption of Gunyah there is moving forward.
12 Comments
