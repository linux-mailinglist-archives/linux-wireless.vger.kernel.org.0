Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9A41131BD2
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 23:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgAFWvR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 17:51:17 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35390 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAFWvR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 17:51:17 -0500
Received: by mail-qk1-f193.google.com with SMTP id z76so41370828qka.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jan 2020 14:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pd6XIV7OgADHPUC0a4p/Mb4IhnpWoH1UAexZuXJ1p3s=;
        b=gR+oYRZ4onpW0u9eAxj2ULlDOyWb/ugEKFPgUuK2O9X4B/ADTb1dAA1I8WaavTN82y
         TKTIz5wUd/O9vHnYgWUUQewQh5/ZQhyv/kzfmjfxmbqrKoLZ8iwhZ4k1SccdXyF2UtbP
         lyWZ0Yw6bvfq+QSjMpFD5XKceAOGyIPdBuN0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pd6XIV7OgADHPUC0a4p/Mb4IhnpWoH1UAexZuXJ1p3s=;
        b=I/iGyUJNSwxr+ZyhnKcw91nJ/mnp3X0nO9X1SctdLeM4IWtQ3fQKpY59XC4x2BoCXy
         GFnwOWYFr/IJ4IfetyETWhK97kMrP2Ioz7IwnRYW000EnNisIAKyN0roT8dGHKk1N0Zp
         oCA3InWFgCHr7Kihv4NM78ko4RDA21Vp5ebqUN5bzfwoXwaftHxBs5jUsyuiQeVeY7TN
         6Fz5115HKVw+7Qy+E/QlF9Tt1Ria/oLwndZNqHaXszPiFnGmbfIPrvMrvbxN2O9K7A7A
         ZkJAqnIg51B2OuzFA45cDlkv9iwTI1SeL4QR0l3F2D56OOb64MUDuQVkKKFW9lywda9c
         a5Lw==
X-Gm-Message-State: APjAAAXMMm5hti5R0iY9anC7xnN0neqUt9498gza3EYJiDSVS0yoPJ0z
        67ClQSRdmXoTlyL6dJUyQIi7hBfoYXU=
X-Google-Smtp-Source: APXvYqzdTX/yGEWwRcVm5mdxZMwhJSCihJdGBO0I/C4oLIym4N2QwwRINqXxVB8db4w3Qg7CpuM0OQ==
X-Received: by 2002:a37:a256:: with SMTP id l83mr85508595qke.252.1578351075264;
        Mon, 06 Jan 2020 14:51:15 -0800 (PST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id e2sm21421398qkl.3.2020.01.06.14.51.14
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 14:51:14 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id j9so41419385qkk.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jan 2020 14:51:14 -0800 (PST)
X-Received: by 2002:a05:620a:2043:: with SMTP id d3mr85418653qka.279.1578351073659;
 Mon, 06 Jan 2020 14:51:13 -0800 (PST)
MIME-Version: 1.0
References: <20200106224212.189763-1-briannorris@chromium.org>
In-Reply-To: <20200106224212.189763-1-briannorris@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 6 Jan 2020 14:51:02 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNN5=97nhN99rPneLGSQAmQ4ULS6Kim1oxCzKWNtPkWFw@mail.gmail.com>
Message-ID: <CA+ASDXNN5=97nhN99rPneLGSQAmQ4ULS6Kim1oxCzKWNtPkWFw@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: fix unbalanced locking in mwifiex_process_country_ie()
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        stable <stable@vger.kernel.org>, huangwen <huangwenabc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jan 6, 2020 at 2:43 PM Brian Norris <briannorris@chromium.org> wrote:
>
> We called rcu_read_lock(), so we need to call rcu_read_unlock() before
> we return.
>
> Fixes: 3d94a4a8373b ("mwifiex: fix possible heap overflow in mwifiex_process_country_ie()")
> Cc: stable@vger.kernel.org
> Cc: huangwen <huangwenabc@gmail.com>
> Cc: Ganapathi Bhat <ganapathi.bhat@nxp.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

I probably should have mentioned somewhere here: the bug is currently
in 5.5-rc and is being ported to -stable already (I'll try to head
that off). So this probably should have said [PATCH 5.5]. Sorry about
that.

Brian
