Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3F547BDDB
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 11:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhLUKF1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Dec 2021 05:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhLUKF1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Dec 2021 05:05:27 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9382CC061574
        for <linux-wireless@vger.kernel.org>; Tue, 21 Dec 2021 02:05:26 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id u198so7835550vkb.13
        for <linux-wireless@vger.kernel.org>; Tue, 21 Dec 2021 02:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=bVET9xn9UgvEVv3B6rsQX/0OeE6jBro+5TuqIgi/dvo=;
        b=TURJuWmKo31m8x1odZA8MM11mtkJgolR4sV5I7hBdpbrizabbleRYT+EG/Qpi7bVRm
         h5+ZGBKZtwBnJUgsMt4ArXn67vkcDYlYtTDIfLpIk7Bzst1NOjKA5oEk3Hkh1WJa6Ezi
         Ulw9VCop53GSKJp+7t48b5ki7jAyQIjKEJO6QL4cfHtyu3Qqdu3gD0VT9zr+bEZlLvKD
         bG+XRXjXSJeMO/WkjSS2Qzh7NbY1ypIvqnYdY82G3wOuVUDzRuIyD7YiWEWh6h/Wh3+/
         aXswj4ekl/Ay+SA4F3ETVui0IcABZ475fS0Jcjl2dLRUlzd5jmxO3PndlOHe8akzdKPV
         VRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=bVET9xn9UgvEVv3B6rsQX/0OeE6jBro+5TuqIgi/dvo=;
        b=TPuvdgkNsmjMZ1ak4aDIh3Bai1Xy2SGOAbsDj8rCZk6JxWHKnHLtb2H6sFcGWfVRC1
         W5E8/m9EFQjufzslSlFH4Km28q/5+VJsPqXkQyM3ss67G9OAs3NFNI0TF1udYt7IhEUW
         eVT+wI37bJYZDDTZlOqlqVwnQxsTOS1OuiMmV5PCpiN1T8vgMoEXzlHSqFQI6M2l4/CI
         sOZsvKkh/tJp2KdnNWch7q4l8z9Y5Ghhr8hFqQDQmgw9hifqRTkiQ4tjoc4fgBJp04zP
         qtNCPEDGuqyjJRRcQTT4PyRg4Fkyg/0odHjbJwhYupeUTaug/DeORCX95rZSxa7sjkAl
         g21Q==
X-Gm-Message-State: AOAM533AivZkc46o+Fmii2iD2we/I97mOqSYt21hHGL3cYhvI+WmR2c0
        lavzbvysxDjzN1VLXaJ0J7npkIWTETbhS/DHzMOEBLxsth8=
X-Google-Smtp-Source: ABdhPJyFw51byRz+fpH15wTv4UASyA4th7yDfTfbqpCDE17ON9mFTWX93I0LQuiWVjDtyl6UBak08OHeBXcS0oaL4oE=
X-Received: by 2002:a05:6122:b64:: with SMTP id h4mr884826vkf.21.1640081125631;
 Tue, 21 Dec 2021 02:05:25 -0800 (PST)
MIME-Version: 1.0
From:   Jupiter <jupiter.hce@gmail.com>
Date:   Tue, 21 Dec 2021 21:04:49 +1100
Message-ID: <CAA=hcWQ9WMwgd=bWCDmtdHD_rkj7L4aytyMhcqzKF=ABXq=j-g@mail.gmail.com>
Subject: Is mwifiex-firmware an open source?
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Avinash Patil <avinash.patil@nxp.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        James Cao <zheng.cao@nxp.com>, Cathy Luo <xiaohua.luo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I am developing a WiFi module based on the Marvell Avastar 88W8801
chipset, I think that Marvell Avastar 88W8801 chipset is now a NXP
product. I thought the mwifiex-firmware/mrvl/sd8801_uapsta.bin and
mwifiex in kernel branch linux-5.10.y can be running for Marvell
Avastar 88W8801 chipset, right?

Is the mwifiex-firmware an open source, who is the maintainer for
mwifiex-firmware/mrvl/sd8801_uapsta.bin? Who owns the source code, NXP
or Marvell? Is it still active or not?

Is NXP or Marvell or anyone interested in providing commercial support
and consultancy for the 88W8801 firmware and drivers?

Thank you.

Kind regards,

jupiter
