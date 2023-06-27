Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FC373FF5A
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jun 2023 17:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjF0PNH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jun 2023 11:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjF0PNG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jun 2023 11:13:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2121FD8
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jun 2023 08:13:05 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98934f000a5so557425066b.2
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jun 2023 08:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687878784; x=1690470784;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yqvEFLxhLAXCPzW7XtrlDd0Zp0iWcQAucdkhIBiz1ao=;
        b=RhwcS7ZAzao7cSsM6kazzQpIaDU2JZgPeWNB09F+oV9FHqv3p2GRuEs5BKC5Grr5/3
         Lyjb4dHhS9SQqwp1v8yGu8OWMRaww7xeOdIrgb1IQ3y4cwF/llM+yBe8pZ63me2iCxj+
         hTBC2p6uR4N25AptqkYfAbwmCyBizJ3H8rjxrd2xp9h3/Arv6TlXJluLF7h2ahhx7nCD
         Tux8TGApg6ClgQ2n//yvfY20EnFaAe4FlBIgqryaKJvNLxVyZOc85DJ3fsdc2FZ50LSP
         s0holU/7qeDyF35krmHKC5Qhh8swmrClPiM0TZaFH6v/jLBMBZygG1I9z0Tip0nZztpt
         vlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687878784; x=1690470784;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yqvEFLxhLAXCPzW7XtrlDd0Zp0iWcQAucdkhIBiz1ao=;
        b=EKZBq0VF30oRyJ0/RIAoA+8cN3+/knU+ILLsFqgYmaoxY/lJmJNmAW0B6pVfL2K+mO
         NaYd31+z+QUxOc4MoHKE2yEWZL4ECRye/zBNaiR8ZBQDEuLdPoyprxROJ+/ZAUWzzm+n
         QW9w+FooSHEkKfay6DKMx7qiYju+ule7Au7tzj4J7c2kPJe2e9WI/wOJZk+A1AgSMPV4
         VLI+i/x37sjBLk2gHkdS4JLrmT4vjRfejn7G8vvgvwxFRwhn1Lz6Ut23AOAm/T88ojQX
         cwZ76ciJvKCGdfHuRjfze/obNac8m6C9fBihTVG0mkvRhg6s+ehuqOwoxUpQiB2tjkN6
         LEtQ==
X-Gm-Message-State: AC+VfDykC4R2Fjdb2pgYZTOdiB3YbaoKIsoCkxuW+sxZcqzZn6Yz74AT
        AGVrvCxvdCk5wJHv501INKX9MT0J4KPoY+4QwfyaDsP78A==
X-Google-Smtp-Source: ACHHUZ7nf4HpxehujY9bvhYklUwIAxeNfj2EEuJzFqtS0jTVbwvSKmCglgZAAjNzIeaRJtYI5bcNJzV/9CxvYkHaIqE=
X-Received: by 2002:a17:907:d0f:b0:979:43d2:fee6 with SMTP id
 gn15-20020a1709070d0f00b0097943d2fee6mr31294988ejc.1.1687878784225; Tue, 27
 Jun 2023 08:13:04 -0700 (PDT)
MIME-Version: 1.0
From:   Giulio Paci <giuliopaci@gmail.com>
Date:   Tue, 27 Jun 2023 17:12:52 +0200
Message-ID: <CA+zRt5HKvOQihOwoSj_G1eKFQ5ap9L4uRK2hvtV_SxOqwn-2Dw@mail.gmail.com>
Subject: Realtek 8822ce connection is very unstable
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi everybody!

I am trying to install Debian Bookworm on a HP 250 g9, which includes
a RTL8822CE wireless network adapter. Unfortunately I am experiencing
very unstable connection.

I started with a default installation (with Gnome and NetworkManager)
and the connection dropped quite often, just after a few minutes.
Usually when the connection dropped dmesg reported some AER errors. I
reported the issue at
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1037145.

Then I attempted in several way to improve the situation (so far
without much luck):
- I added pcie_aspm=off to the Linux command line. The AER errors
disappeared, but the connection is still unstable;
- I tried to force bssid in NetworkManager, but I did not notice any
visible change in stability;
- I upgraded BIOS and all software for this laptop as provided by HP;
- I tried to upgrade Linux and related firmware from Debian unstable.
Initially I updated to Linux package 6.3.7-1 and firmware 20230404-1,
and the stability degraded a lot (i.e., the connection hangs after
just a few seconds). Then I upgraded firmware to 20230505-1 and now
the system is quite stable at the beginning (i.e., the connection is
stable for a few minutes) and then it becomes very unstable after the
first issue (i.e., the connection hangs after just a few seconds). I
noticed some correlation between system suspend and the first issue,
but sometimes the connection just hangs, even if the system does not
attempt to suspend. Executing "rmmod rtw88_8822ce rtw88_8822c
rtw88_pci rtw88_core" and then "modprobe rtw88_8822ce" does not seem
to solve the issue, instead the connection is very unstable after
that;
- I tried to set disable_aspm=1 and disable_msi=1 for rtw88_pci. I
tried both options individually and together. Some additional errors
appear in dmesg, such as `rtw_8822ce 0000:03:00.0: failed to do dpk
calibration` when I use disable_aspm=1 and `rtw_8822ce 0000:03:00.0:
firmware failed to report density after scan` + `rtw_8822ce
0000:03:00.0: failed to get tx report from firmware` when
disable_msi=1. When setting both options together the situation seems
worse. When set individually it seems very similar to not setting any
option;
- I tried using drivers from  https://github.com/lwfinger/rtw88/, but
I was not able to load the driver, since it failed to load the
firmware (I have reported the issue at
ihttps://github.com/lwfinger/rtw88/ssues/150).

What can I do to better identify the issue and possibly solve it?

Best regards,
Giulio
