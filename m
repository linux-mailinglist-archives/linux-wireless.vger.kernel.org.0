Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A74F4A91D7
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 02:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbiBDBER (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 20:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbiBDBEK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 20:04:10 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F375FC061714
        for <linux-wireless@vger.kernel.org>; Thu,  3 Feb 2022 17:04:09 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id s1so3596773ilj.7
        for <linux-wireless@vger.kernel.org>; Thu, 03 Feb 2022 17:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vsYnyVvYFGHo7pOeom7DUE8A4xMG+flUzg/LtgljbN4=;
        b=IJ5u1uWSq0s7u7LuVWfv07ojvWBmS+JM/hf6zVjeQjLvT6bLj6520JMwiGvCnp7U2f
         aYiFVIM9p+g0FT8Jc7uzOhgkgWE1q7TtEkhHkAy1TX3n/SMbp7+pGazO1sHZAcr04y+V
         wywSLBdItMbYTgz39aVXqPFRwgu2xMP3mX1jVG/APi7Ctjb2QVwkjP22Y5Ot7xoeUAmC
         Kl0cuxOaSdV9fjXSDo1Bqsubu3lffU51xG9OMCHkGid296K9HJvHRJ4TqnzaDxsZVIlc
         vuMxOYpvYhvh97dc6hrFav6tnjSlRfwhVPv7XOg4TOAOoX9LEwlaR0rbFjKJAlA6yXfN
         8+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vsYnyVvYFGHo7pOeom7DUE8A4xMG+flUzg/LtgljbN4=;
        b=RyUaJxuKFhZp9jepCJGpGoGytakQ4kL67zfHvvaD1Y/7yFKBMceRapI9Z/nO5zSORh
         OaK4E7C1m2X59RxxBsV2qh37BacFiV9Tc3LE9yZZFrrzitn24JBV7VpqFHutWvhFbDQx
         gGy/uOx5ouvjj4TWog+dXcHjACL1Z3TkkjqDtn4OSSPriY4GVg1KH+yv4TJckNpgjPuN
         eFNeTHDZ7Johgwx+oodp8IWeXuYf6EQGYwh+3QmasZcKxR0HRwabrEkGaXpqE8NflWsz
         3c2CTpnOseu8kRCz8EYfryXKCYNvmMYNgsdrhmulKJTIs6c9F0kmz3IfA4uOjxbDLpp5
         V2oQ==
X-Gm-Message-State: AOAM532pmtbonwhv5dMMW1XFz6+EmP8+xQqagVuj2merW7HJjT7zYmzD
        qacfW5j+Ae0qSbjwrG/xq1Ts9rbRzSdsAzpCnNLm8ZJ9WVeQ+yJR
X-Google-Smtp-Source: ABdhPJy/+UXHdodcb+v5q944XnHDzMcp7XY0yDek/JB6f+X5QgxJxzsMorNaDpU8whRqd5y+cFQLaw0sEeHqEDlgN4g=
X-Received: by 2002:a92:c566:: with SMTP id b6mr315541ilj.79.1643936649279;
 Thu, 03 Feb 2022 17:04:09 -0800 (PST)
MIME-Version: 1.0
References: <CA+pv=HNuxZXTxu2S5vcz=zF81wWxykQe2im6oKgKiaDPujVjiw@mail.gmail.com>
 <3721475a-a154-7a1a-ad23-b8a77873f951@lwfinger.net>
In-Reply-To: <3721475a-a154-7a1a-ad23-b8a77873f951@lwfinger.net>
From:   Slade Watkins <slade@sladewatkins.com>
Date:   Thu, 3 Feb 2022 20:03:58 -0500
Message-ID: <CA+pv=HMyUOF2Nfdx4GW-+5W=fw5P_ha9jpubntaR1v-Buyb1gQ@mail.gmail.com>
Subject: Re: rtw89 driver
To:     Larry Finger <larry.finger@lwfinger.net>
Cc:     Wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Feb 3, 2022 at 7:57 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> If for some reason, you do not like my version of the kernel code in the GitHub
> repo that you reference, then you could use the Backports Project.
>
> Backporting a driver into one of the stable trees is not a sanctioned activity.
> Stable kernels only get fixes for bugs, not new features such as a complete driver.
>
> At least one distro packages rtw89 as kernel modules the same as my GitHub repo.
> That distro is openSUSE, which gets its source from that very repo. There may be
> others that provide similar packages.

Alright thanks for the info, Larry! I really appreciate it :-)

All the best,
Slade
