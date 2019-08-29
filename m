Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60D4CA17D8
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2019 13:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfH2LNO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 07:13:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33147 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfH2LNO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 07:13:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id n190so1436229pgn.0
        for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2019 04:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qo9CBG5dwA7rojv0Ol40bhkCmgOPX5RlCcjqFJNsSL4=;
        b=tm1BXQ7A0hFGcueH6FpM5VmobNVfQ+oLwl9S2MEUOJCAVvE4LawUQ+UzQQdKXF+JZA
         FgB2A6gB6I93Fsm6Y2wgaAWE3jDda6QUVNGCjW/yjoJrFkCN1Bse3xs0xFagfol6YhbY
         kZf2bavxW/rOs9QqPM7INCiDe5jbBixQ3TslswBgVjMwOEAzO4gwAlMvZdBy3VDEl8M5
         fXPWvN4BHGQ0xAxt2VO+sGFaB/GGnK+FFL/Mwd/o5cusnPHPiOhBLUS3VrrEzfCIDCrD
         5ilNY1MqQTP2Kt2cQWZ6GfrMMJk4uqgtfAWRGl+yUpdhBJw7ABCl5Xq8JWRY1bWZn6sB
         +gHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qo9CBG5dwA7rojv0Ol40bhkCmgOPX5RlCcjqFJNsSL4=;
        b=H5iVjNakwgDwVKUljqtTbtTPdzIgGFwj3XfQUzzN5S59SNoz6wnJHY6s6vfkSxH0ph
         Csfx27TNNOJIHHWPVinn1LNiRWe3cILmESBP+tMRB6cmwQNeb1IJWvbTy6g7OLGpXeHQ
         x9cu5TRngUNRImNU0ojynNnY91td5eZZhPRTIpEH+qQ/o3Dr7c+GfoXc0B+CRxzpD5vq
         pDMcRVQyP98FXNg0LmzGCJO3M+iMcvkDVRIem/1fGyXXFZI8DRKa3HT6q3BS5QM9qLMK
         Zcv3ubkpnzEes2Sd1cnyAUTciW5GKA5g55NqVjxraRL97gqsvrMxS6IW0AvVUnMe2iGJ
         w7CA==
X-Gm-Message-State: APjAAAU6vGqS0g4lKAt7bNSuLZ449abS/hUFDWEG44VJ3KF7P86AMsgS
        1RrMgaP81oARV1IOcaA9x0upHUgjaQ/Qa3A1oBVyX+SjCZE=
X-Google-Smtp-Source: APXvYqzHDOn8/axkrgHKtmHJA+S9jFtJnR9q80CpDzr3fgh/J1gUZdyTd7QjTic+BP6aDrC1Z7hpBlGBUAqfNCoyINI=
X-Received: by 2002:a62:52d0:: with SMTP id g199mr10877992pfb.32.1567077193321;
 Thu, 29 Aug 2019 04:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAJp6tx-L0Q4_OaUp+xMod0jsLjAByqnbrvk=JbEq5LOxTdhr_g@mail.gmail.com>
 <CAJp6tx-RcubaTdL4tK1fuLv08s-pqU+RQz4m1mb1LRhg3625zw@mail.gmail.com> <20190829100336.GA1930@redhat.com>
In-Reply-To: <20190829100336.GA1930@redhat.com>
From:   Sergey Maranchuk <slav0nic0@gmail.com>
Date:   Thu, 29 Aug 2019 14:13:01 +0300
Message-ID: <CAJp6tx86X+sxv7NtUcg0f7OdLSZu08UDg-Wf-NKnUB6eSzLB=g@mail.gmail.com>
Subject: Re: rt2x00: 5Ghz signal power degradation with linux 5.2 kernel
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yes, it is!
After reverting this commit (i used debian 5.2 kernel sources +
patched rt2800lib.ko mod) i see my home 5Ghz network with -45dBm
tnx for quick help

=D1=87=D1=82, 29 =D0=B0=D0=B2=D0=B3. 2019 =D0=B3. =D0=B2 13:03, Stanislaw G=
ruszka <sgruszka@redhat.com>:
>
> On Thu, Aug 29, 2019 at 12:42:44PM +0300, Sergey Maranchuk wrote:
> > I got some problem after upgrade kernel to 5.2 version (debian testing
> > linux-image-5.2.0-2-amd64). 5Ghz client  stopped to see AP.
> > Some tests with 1metre distance between client-AP: 2.4Ghz  -22dBm, for
> > 5Ghz - 53dBm !, for longer distance (8m + walls) 2.4 - 61dBm, 5Ghz not
> > visible.
> > All works fine with kernel 4.19 and on windows 10, other devices also
> > see AP without any problems with same distance.
>
> After looking on the changlog most possible cause of it seems to be
> commit 9ad3b55654455258a9463384edb40077439d879f:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D9ad3b55654455258a9463384edb40077439d879f
>
> Please try to revert it, and see if that improve rx signal level.
>
> It that would not help, please try to narrow regression to two
> consecutive kernel versions - it is: 4.19 -> 5.0 or 5.0 -> 5.1
> or 5.1 -> 5.2 ?
>
> Stanislaw
