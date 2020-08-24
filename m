Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDC424F1A5
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 05:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgHXDow (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Aug 2020 23:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgHXDov (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Aug 2020 23:44:51 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06E4C061573
        for <linux-wireless@vger.kernel.org>; Sun, 23 Aug 2020 20:44:50 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id t7so6230279otp.0
        for <linux-wireless@vger.kernel.org>; Sun, 23 Aug 2020 20:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GrQzlhBhctCHKiP/gDIXPnIXQOKpz8TySQaMELOBfVM=;
        b=LgwuN4afexiBKOfAy1N3UJH7dFGuc6qEUAUk3gexAEmCHOh/gZI0gVaqNSdWqQw3ap
         Paoc8I8fq3YAMMJr+rB3ORsS79nZ8TrJvIjQ2MlGoEN3sRrQf5dwIROtYwR+N6Wrsk8v
         LHyt4Ei61TSz+7/VqS0PuT5y4qk1TdmhokM5Pq/6gW1HOX/kY7OEp2BQzt53yKUoLgoL
         5SAclmbGJ1ZcZOqxZAipqc6TZnPUifjfjDOAznBPeiBhBgCrrHEsN3w5vSfQ92eR9ok4
         igwA46Lh8eULErW5dvjdinvWngCnoxO/Co/hogt2m1md77mwsC/JZFxcBx+Hp7uBe7TW
         YEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GrQzlhBhctCHKiP/gDIXPnIXQOKpz8TySQaMELOBfVM=;
        b=XDZpcy0wjoKRRrnUSAzl/e4cl9acJQUAxghEKHsMNz5/k3eEe99x9zfWp93xoPa4mH
         34N1JPhTh69+HuTJKDNdXGx3HHSeG4LaMyIc2KC5SWNghR+gfK7vlUbvePcgkPD1LOIE
         gA6r3Fh+TS29hGMpt9plzfpreOq3KMLztZkIUQ7ORorNZhUCd1lfatwfPjOytqk/twBZ
         LcgldTpP4ezQmqce8mIEjnghbT/4346ggKqGmHElhd+3mdRVYKxFmV2U9QB4s9KDGyGJ
         MfY9Gl0AEsvehreFzhW8LOOS0IosTfY+6R8IHFUKLd/w0LSb/QSnWzvOEWu/kZXwk1Ae
         L6bQ==
X-Gm-Message-State: AOAM533CrRFOGuYWV1PdV4K/J9a8BlImcxmkTKevQzJQW2w2+LZjZAb5
        Qd4dGkkDFcc9qD49xbWssUyEUbj882cW25ed5PwwLBnkwHo=
X-Google-Smtp-Source: ABdhPJw+ix8oubSh4Pej2gCX5PS1cQvHP/z9k0/zjueJh3kqAsHrbl1RPuoF/bHj0G1h7yUv5z85E1VHGQ3IKzVW/s8=
X-Received: by 2002:a9d:480d:: with SMTP id c13mr2498834otf.224.1598240689944;
 Sun, 23 Aug 2020 20:44:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aca:b805:0:0:0:0:0 with HTTP; Sun, 23 Aug 2020 20:44:49
 -0700 (PDT)
From:   =?UTF-8?Q?S=C3=A9bastien_Le_Preste_De_Vauban?= 
        <ulpianosonsi@gmail.com>
Date:   Sun, 23 Aug 2020 23:44:49 -0400
Message-ID: <CAGzOMfGZ9nYk7ESvWYspBOQMWre7WnCVLO4Q6+8mvSQOkoXUKg@mail.gmail.com>
Subject: Re: BCM4313 & brcmsmac & 3.12: only semi-working?
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I'am in kernel 5.8.3.

Today I updated from .2 to .3.
I had not used wireless from a long time (+1 year) in this notebook.
So when I successfully connected to the router,  and started browsing,
I had a complete freeze of my system. Not even ssh access.
Later  I had the same complete freeze when I closed the lid; when I
went back to the device it was completely frozen.
journalctl -b -1 --system does not throw anything significant, no
indication of a kernel panic.

Now I am back to wired connection and no problems so far. So I suspect
it's the wireless card.

l$ sudo lspci -vnn -d 14e4:
02:00.0 Network controller [0280]: Broadcom Inc. and subsidiaries
BCM4313 802.11bgn Wireless Network Adapter [14e4:4727] (rev 01)
        Subsystem: Askey Computer Corp. Device [144f:7179]
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at e1500000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [40] Power Management version 3
        Capabilities: [58] Vendor Specific Information: Len=78 <?>
        Capabilities: [48] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [d0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [13c] Virtual Channel
        Capabilities: [160] Device Serial Number 00-00-9f-ff-ff-be-b4-74
        Capabilities: [16c] Power Budgeting <?>
        Kernel modules: bcma

For now I have blacklisted this modules just in case.
 b43
 brcmsmac
 bcma
 mac80211

Has anyone been experiencing this issue in the aforementioned kernel version?
