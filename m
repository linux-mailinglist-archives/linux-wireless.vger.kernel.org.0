Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8655D2E899F
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Jan 2021 01:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbhACAfV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Jan 2021 19:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbhACAfV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Jan 2021 19:35:21 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22694C061573
        for <linux-wireless@vger.kernel.org>; Sat,  2 Jan 2021 16:34:41 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e7so18335520ile.7
        for <linux-wireless@vger.kernel.org>; Sat, 02 Jan 2021 16:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=J585tB89NAC6zlB2wCXSJ5KsBBZdSORzdVLWSqsnFkw=;
        b=aH8vOft6qZlQ7pky2wyoKNzH5FnkKVu1TxSX3Oe064ug0vlSsykNEIJATTOxYdiCfd
         f1F5YoXh0Wrn8C70kum+VQMkdOCNLAucZmiRi3g+HnxCFs/0WVdPUppkKqNSWnrcoOR8
         IzvE8IKWfuCApDDRJndLV8z+11Rd15Ogo5rLWA6chmlR3/ZQkeAjTyxP3DVSvc9XLeux
         vlq8I/osNGTosRCY6kzR8lquxS0wuvAsrqjXpYZ8Ue84haICXkZW9vdJgSn/IHaBDF2E
         GTKKQ0jZgLmHR05ncObmOoQrAPYmairQ7Y5ZRUBX3Y6ivGJxxrd3LbiuCgGX1xNz43L+
         f8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=J585tB89NAC6zlB2wCXSJ5KsBBZdSORzdVLWSqsnFkw=;
        b=TOlcoOQuTV0E9I9HXaS/UemQLotuoWeW33GyUxvO7dO31dQk61qjaH+HeYFBu85WyV
         9Yp5Agfhyi3dz1k/VuHQ5zqfw6OIvsImJFBjFY4KJrl0ZbvC4VLgX20ieyRkqhF5DVzE
         WYgTiHKAVJj9lUZL7Agfq4K8/3FmnAH576RTiDfBNCJ242SFjcTVU8+MiTH2cQg0yQ4s
         bnYEeqdoIbMDu+vh8vuj8BrQECUjwlUQ8DawngHCiCM/LsNoUaeHGuDlEIDZv+JUJ1Mr
         ePNAKYxX2T1RCq1251lVFe4so4snopLKwKQSXG5sSJzxAO6hSPt0lT+KKXrDamf1lMSQ
         9Ibw==
X-Gm-Message-State: AOAM532a4Z5//cfohJTHmuFofNigXovxMWB8D+MFQ3/TTFEhsqaCD2Uf
        ngZ6moVaphvX/U7c0j49vPee+cvdwXZUOnLucoo=
X-Google-Smtp-Source: ABdhPJyyU+jp75cC9KADq49h0lSF90zILan6+jJ0M11n1aIDUvhz+UcnWo5zAo7x9/pUYc6Rfu2SnOsU60ZwCJJj9cg=
X-Received: by 2002:a92:dc03:: with SMTP id t3mr66874065iln.215.1609634080555;
 Sat, 02 Jan 2021 16:34:40 -0800 (PST)
MIME-Version: 1.0
References: <CAM+r-RhxY4TA4zPm6e6ah9RWdBY67J=5oRS3+=+EQMomKa10QQ@mail.gmail.com>
 <CA+icZUWcuka-6j139+89pSV5Z-r1fYVriz+wJE0gma4RO_PL9Q@mail.gmail.com> <CAM+r-Rj3y6DGonMPQ_V7qCwWH7v1bgh5x7YmAzMh5-cY68jJiw@mail.gmail.com>
In-Reply-To: <CAM+r-Rj3y6DGonMPQ_V7qCwWH7v1bgh5x7YmAzMh5-cY68jJiw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 3 Jan 2021 01:34:28 +0100
Message-ID: <CA+icZUXkwN=WT+hOop2WjwdVOp8UB93XKd07KB_EdCP5U_znsg@mail.gmail.com>
Subject: Re: [BUG] Stacktrace in ath11k_pci
To:     Luca Versari <veluca93@gmail.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Jan 3, 2021 at 1:18 AM Luca Versari <veluca93@gmail.com> wrote:
>
> Thanks for the quick reply!
> Unfortunately, this didn't seem to work - I'm still getting the same
> stack trace:
>

Latest ath11k firmware?

- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/ath11k
