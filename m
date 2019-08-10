Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE2C887CE
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2019 06:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbfHJEH3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Aug 2019 00:07:29 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:40926 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfHJEH3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Aug 2019 00:07:29 -0400
Received: by mail-lj1-f177.google.com with SMTP id m8so60230339lji.7
        for <linux-wireless@vger.kernel.org>; Fri, 09 Aug 2019 21:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GDkcv9528LMuk3r6zE9uQ0bQYJzFzdeJtGWSE4om+0c=;
        b=Rwo4b9Pvw6eEAPtkCA/Mz8oe4Pl6httPaJAB1D1UMUg7R6ZBsmALU0JIDjC24D2v5C
         v+ayCCcMmYeHi2jCHKouXpzXb8JGZmVpIE8XiyAqYgSXmvon40MZhSVxdhxLQgPJpFuX
         ppei13dzbtutYkBnqNRPVqHxUZJAD2QVW/FaA5XjSfm2QeS6u0iEOM4LpHyKARs9ngON
         N6m/e8WQBOldCYLGMCTgnJOi4pqM+Nb8VcaT6rkn35jv0V1No/Sx6ebIFAPB2038o6jA
         2L8t2T6Bv9IpZXNej4laTYEFWqOTQ9n2lQOzTHs/IP+Fn4dcK2eYb0CXrVT9F95k9+M3
         uDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GDkcv9528LMuk3r6zE9uQ0bQYJzFzdeJtGWSE4om+0c=;
        b=nAq5mywZOz1EQI+0S4WUUIu3rEPxZAf4zsjFHT8hL1TNPe2/V2sXbSbmpHJmT6L6xU
         +EGAdP9xtRbmcbz5fr00dAwmWgBXA9wF8o/tW3XGDZTF0ybJR77skVJF3vseG+jO8oT+
         vu75dgHkCeXBoqJ50xYKagd+ow4PRwQmHNC5i2sipyE0Hzzz5Ycgp0In5Giph9ry3KaU
         hwlj01vDkMv24XsGiRfB00uYuacU/KOWbz0tCcJlO7cwLvjQyVC4u0qvkcZ2zON6tQld
         3z2bGl7LylcHmvqID9wvSyOUhXBifAyeZq4EEFP1akPpyg3wKbK+xIy2xVhbo76nf6tm
         nRRw==
X-Gm-Message-State: APjAAAWuEPpZzF5CydNfQTFyexoPaG9zJHEHBC7rNjpz0RrUSr6ImOON
        buJMMokr0TyP3035eN0WauaHcEXpTSi43IEh5O8/4j/E
X-Google-Smtp-Source: APXvYqytxtAwLNV9TuSQWXWMpnxH/EtQyW7eHYriayB1LH8aaW6QGLEPjWk4VeW2K+Y/pCWJnFF2dlPX9+VfYVlsFqc=
X-Received: by 2002:a2e:80c8:: with SMTP id r8mr13315836ljg.168.1565410047035;
 Fri, 09 Aug 2019 21:07:27 -0700 (PDT)
MIME-Version: 1.0
From:   Guo Wei Lim <limguowei@gmail.com>
Date:   Sat, 10 Aug 2019 04:07:15 +0000
Message-ID: <CAJSNYx0k7k8RyRT6siC1xv_0xqf3ggKSwNp7sp9c7y-kOgSeAg@mail.gmail.com>
Subject: Unaligned Memory Access on mesh_*.c files
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I have traced a large number of unaligned memory access on mips cpu
due to ether_addr_equal(), is_multicast_ether_addr(),
is_broadcast_ether_addr() being called on odd addresses.

Even though the values are u8, the inlines in etherdevice.h converts
them to u16 causing the issue.

I can replace ether_addr_equal() with ether_addr_equal_unaligned() but
it doesn't seem like a proper fix. Anyone has better ideas?
