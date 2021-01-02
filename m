Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513FA2E8960
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Jan 2021 00:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbhABXtJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Jan 2021 18:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbhABXtJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Jan 2021 18:49:09 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5BCC061573
        for <linux-wireless@vger.kernel.org>; Sat,  2 Jan 2021 15:48:29 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id n9so22026249ili.0
        for <linux-wireless@vger.kernel.org>; Sat, 02 Jan 2021 15:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=rU5QM1CDUO1YgkzgrbuDDCA2BAU5bRA0PesTaPSTo5o=;
        b=LCLcEFCqcHmODd8twHTto99NjJWnEsnPUpg+gTD3c0D4zO1wNdVZlnniDjRWGPM0As
         ow46byKGly2fXL9BICPFL438NQzekkL5Z+GL0QH/6P5njBddbiRJJyKQdwMu0Dzqet8V
         pHEV5OJaaGEylvB24q2qsh39pczvJtZDspBZIsbIaBeyp8j9/QESg4/U3P+Zt3FbKBNd
         uZytxzwk7sDXNnrOtR27DholBmY2ZGRQxGEKHeP2u7CT/sCjJxiqMDtvHSycge07sHZe
         OOJ5NzVJQfg6u9lrRKd3DLe9k0dIjo6yDqH4ar+1y0zojwKSkyGhjMB2R+vixO2a7bNl
         SS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=rU5QM1CDUO1YgkzgrbuDDCA2BAU5bRA0PesTaPSTo5o=;
        b=XuJVeyRkY/L/pSZLBWZYfjY0ZRWWHh/0ZPgyte/6y6CgfDRAtHV7NDaQLMt0ooaacW
         E8mteTdlh2aKuXtFqjLA8Xyu0AQqEXJrHRVPvjgn97TZmHFhtgl6nv/kTC7eR1rri3lw
         eJvFhRZmJWfq8l/VEDPdwD6AjlWIKroqi+AdyMP41IabI31KqTUtB6UpsyJFNmioeaEa
         rNaA1pjeQInEYMBpnYKiiyJBMBMFRneqcHVGaI/bQvBa899dpeXoIF24nU4C7jALkwb9
         Cz9ZMcfCNz9IMUVCw5RsrFMX1fCh3EwwjtFiDjPuC67mlXQbe3KxT8hTzfcZIQFnd6XC
         X3vQ==
X-Gm-Message-State: AOAM533Zi37nHS2NiOPXedP2YqwWpzFdDvMBs03m1sitJBPzdOOHkUZC
        jFy8AfCnmgb+mNxhKAgI/DxQX1SDGs8Q57/5gnY=
X-Google-Smtp-Source: ABdhPJxxM0Z7BpcPc7x1nSGichq4ABDfj3BDYbuquAPnZPpbz0MCavE/D9b+puvRr/wwoM9J5w0qgKkTFP1AFHxBURI=
X-Received: by 2002:a92:dc03:: with SMTP id t3mr66762634iln.215.1609631308337;
 Sat, 02 Jan 2021 15:48:28 -0800 (PST)
MIME-Version: 1.0
References: <CAM+r-RhxY4TA4zPm6e6ah9RWdBY67J=5oRS3+=+EQMomKa10QQ@mail.gmail.com>
In-Reply-To: <CAM+r-RhxY4TA4zPm6e6ah9RWdBY67J=5oRS3+=+EQMomKa10QQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 3 Jan 2021 00:48:17 +0100
Message-ID: <CA+icZUWcuka-6j139+89pSV5Z-r1fYVriz+wJE0gma4RO_PL9Q@mail.gmail.com>
Subject: Re: [BUG] Stacktrace in ath11k_pci
To:     Luca Versari <veluca93@gmail.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Jan 3, 2021 at 12:27 AM Luca Versari <veluca93@gmail.com> wrote:
>
> Hi all,
> I recently updated to kernel 5.10.3, which has the module for my WiFi
> card (QCA6390 - Hardware name: Dell Inc. XPS 15 9500/0XWT2F, BIOS
> 1.4.0 08/14/2020).

I have no ath11k hardware but looking at the commit logs:

$ git log --oneline v5.10.3..v5.10.4 | grep 'ath11k:'
6003ff9ca725 ath11k: Fix incorrect tlvs in scan start command
01c0691ead1e ath11k: Fix an error handling path
08c7e5615496 ath11k: Reset ath11k_skb_cb before setting new flags
345511c3f496 ath11k: Don't cast ath11k_skb_cb to ieee80211_tx_info.control
7688ca1121ba ath11k: Fix the rx_filter flag setting for peer rssi stats
00f7592609c9 ath11k: Handle errors if peer creation fails
8a8fe3e58c3e ath11k: fix wmi init configuration
e3f640e6a085 ath11k: Fix number of rules in filtered ETSI regdomain
ce79baf7b3eb ath11k: Initialize complete alpha2 for regulatory change

Upgrade to Linux v5.10.4 and check again?

- Sedat -
