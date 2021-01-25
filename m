Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD05B302C42
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jan 2021 21:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbhAYUJE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jan 2021 15:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731919AbhAYUIV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 15:08:21 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74D0C061573
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jan 2021 12:07:39 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id v24so19643099lfr.7
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jan 2021 12:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0V5RLYuxyfi79HSO1z2G6UHAPKvksTc4Hw9dlkfpNsw=;
        b=aFUFLSmEuhPPkwyxCujlThHIBpM2BW5rStaXLBo7HXuXZcwI4qUKJIsJuCFa7WpyYw
         FPOkouiyCcdXYHysojTrU0ecLGn6UyDPNdXH8To9eahVjDlqSHgJESUW7XkknFj0h5n0
         itiA7FzDH1IvH+fgmFLkEF6ur9YDGRKA3qxJdQoUNoCzsGm+60zpfIXQXOY2Zi5cRJlf
         SO2y5MraZCoJRaxKGyRphY5Ar3m4TARYkcsBY7FPyQ61NcFAppF/9n8EydywmrPPSA4x
         sbdhGt+pw3wkhUW4Hz3IctR1ZboxGfwpetsBQNr8HI40GL1sAi1J3d2dM+gCaHdIccd+
         cP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0V5RLYuxyfi79HSO1z2G6UHAPKvksTc4Hw9dlkfpNsw=;
        b=QbHCzzMPCW5s/gR8eLYgonnYaARD08AiSJe5SyieKSAHErI2UjV5cCqTYSHqlILbEE
         aQRMDYseraLmYxYp6HDJMPIhYoyEkfwGjOfji1yJ9VWeB0fw25Qv4l8ZPq+wSUPFFrCW
         QrWFv5IgwPoO8VgHbzK8halFyyVrr0r2wwyHKMbEnxBu140hAmqx4pzGGujgWWXFdXh6
         rau94ID0CY/+tWedDjDGJAE/O+Kxe042Vq+HH8eJPsWBr4BRh3ta1qslIazOkoJQISrs
         9fFFNWMwZQYe0RYX4Y7HWivp3grn5U0DTjLM9lCW7t5wqzhptQJ5XqaW999o7BmPKw56
         bvbA==
X-Gm-Message-State: AOAM5301hZ1TQFdFVxwLgP7SRreoC79oFoOXZOu7FMn9UU82pKwbDrsW
        3Fld7uR+lCF9peTLZvrPZNIjf2FGdszgZfcit9TYl+hw2f0=
X-Google-Smtp-Source: ABdhPJyQX4eRXdMQOya7YOKR3xLHM2Avrb1VPSLhFTZMd4Or8xyY1dejH/y/2R+Rfh8mlINWer+LZzubgleILSTeoiM=
X-Received: by 2002:a19:c357:: with SMTP id t84mr967869lff.330.1611605258189;
 Mon, 25 Jan 2021 12:07:38 -0800 (PST)
MIME-Version: 1.0
References: <20210125192046.975-1-chaitanya.mgit@gmail.com> <2027106c42a27eb850217eaae928b7d36e345f4c.camel@sipsolutions.net>
In-Reply-To: <2027106c42a27eb850217eaae928b7d36e345f4c.camel@sipsolutions.net>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Tue, 26 Jan 2021 01:37:27 +0530
Message-ID: <CABPxzYK7jPKbCokST-DMCyvoF_gqhWnBGZvUfgqZTfjeN-X2Ng@mail.gmail.com>
Subject: Re: [PATCHv2] cfg80211: Skip key deletion for open associations
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Chaitanya Tata <chaitanya.tata@bluwireless.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jan 26, 2021 at 1:21 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2021-01-26 at 00:50 +0530, chaitanya.mgit@gmail.com wrote:
> > From: Chaitanya Tata <chaitanya.mgit@gmail.com>
> >
> > From: Chaitanya Tata <chaitanya.mgit@gmail.com>
>
> That's broken, please check your git mail setup.
Fixed.
>
>
> >        * Delete all the keys ... pairwise keys can't really
> >        * exist any more anyway, but default keys might.
> >        */
> > -     if (rdev->ops->del_key) {
> > +     if (wdev->connect_keys && rdev->ops->del_key) {
> >
>
> This is wrong, wdev->connect_keys is not needed to make a secure
> connection.
Ah, I guess it's only for the WEP, right? From a quick look, we are not saving
connect params (connect.crypto), will take a deeper look, thanks.
