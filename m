Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB1A61666CC
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2020 20:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgBTTEs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Feb 2020 14:04:48 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43795 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbgBTTEs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Feb 2020 14:04:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so5338284ljm.10
        for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2020 11:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=btPbVb9LTvfKfkjVuG7h/W/SC/NNGezLdh26ebvWUx0=;
        b=a5gENgPw92EpGlvptDKBir+OMUlH/d/zBkWYpX0A7q9d9hC065ef8w6nQ0QBhDOgIA
         elAgr+R9f0bF/q+KfZLWQbi7KFnV7oKYUpjn8DcaKWta8p7jPAYp19MFd3Peh7u5M5+L
         ywU8OT6O0NYCFpe+g1esqNDDCHbTrhsRvRQuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btPbVb9LTvfKfkjVuG7h/W/SC/NNGezLdh26ebvWUx0=;
        b=p1dviyMigVWG+7E5rA4CJ6k+ozU0PFsOp6H7W7jNW9P4pqiJy/+7BKLCRm3cdXA4Z1
         sbWMSuhz1or5rdgMm9nKZIagdo8BjRVrrc9xOf2s1W7z6izKnDXJmV3p3kK6mRa7G57u
         AhhOMaI7wsAzYEg4ZT0XQgTJ4VcBYQBPHirKyIcu2mmzaboO/zIMhUsQ4qFCzyC9Uym+
         LNq3r/ANJe103S0u4Ph5pRE1xkjW/QNSSsZRIDaHg3Lmi4dks9tngP2IAPjd+RqEXpdb
         HZSVv07Hs++V326ydiOKPKaeIq9FLkgfnSdae+GkgMNy3L0XcG7kZo34u+dmycE+FpYA
         7uGA==
X-Gm-Message-State: APjAAAUN17AzDszXmqxMc9jegI3F6DYWmheAcDJJ73gJr3c4U1WIFVjs
        kG66rMOLvzhR9jRWh4Dh+46Hffrp9rs=
X-Google-Smtp-Source: APXvYqyAFQsBir6caxA3SjG6uFZxTEtGXeaR8QdZL/wQqwPnpinIFB3MgEuda/Vk998JLo53LkeE4w==
X-Received: by 2002:a2e:8755:: with SMTP id q21mr20095357ljj.156.1582225486023;
        Thu, 20 Feb 2020 11:04:46 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id r15sm192840ljh.11.2020.02.20.11.04.44
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 11:04:44 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id s23so1999930lfs.10
        for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2020 11:04:44 -0800 (PST)
X-Received: by 2002:a05:6512:3f6:: with SMTP id n22mr17795383lfq.59.1582225484193;
 Thu, 20 Feb 2020 11:04:44 -0800 (PST)
MIME-Version: 1.0
References: <20200204120614.28861-1-yhchuang@realtek.com> <CAB4CAwdFez_WbRQb2jZQtqspSkO5ujL31ZLt4XshNcWiSqHByA@mail.gmail.com>
 <CAMrEMU_KJbwAK-onH0sRUgUPxDuZtD5bPJN6XmF=a9NqpfeJ+g@mail.gmail.com>
 <CA+ASDXPHWNN+TvrJFi_6w+ep_TBtLJ0refKenNb0tc8Vs+YjgQ@mail.gmail.com>
 <CAMrEMU93LScySw4mpidAC5pVHV_NOShP1_GMMsvsAk1QBhdJjQ@mail.gmail.com>
 <CA+ASDXPHXFquF2iXvdxZXhkkLPndkACgenLJwMR_9ON7zZZM3w@mail.gmail.com>
 <87wo8xxueg.fsf@kamboji.qca.qualcomm.com> <CAMrEMU-nM1O_iJPVgGg2pL6JYWMdRKdPGe5N2rkfOihdmTeMaw@mail.gmail.com>
 <2c91e4e7b36d42a8abad6ae356c2869c@realtek.com>
In-Reply-To: <2c91e4e7b36d42a8abad6ae356c2869c@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 20 Feb 2020 11:04:31 -0800
X-Gmail-Original-Message-ID: <CA+ASDXMjx8oQzK61rNHwpkKykgS2v_o+HTUyXujY9VXYNiNfxQ@mail.gmail.com>
Message-ID: <CA+ASDXMjx8oQzK61rNHwpkKykgS2v_o+HTUyXujY9VXYNiNfxQ@mail.gmail.com>
Subject: Re: [PATCH] rtw88: disable TX-AMSDU on 2.4G band
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Justin Capella <justincapella@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chris Chiu <chiu@endlessm.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Feb 11, 2020 at 6:56 PM Tony Chuang <yhchuang@realtek.com> wrote:
> Module parameters are really good for me, too. But we've had discussion
> before with Kalle and Brian, they both were trying hard to avoid module
> parameters.

My personal preference is to avoid module parameters when you can fix
the defaults, and that module parameters should never be a workaround
for fixing the default behavior.

I don't think my above preference precludes module parameters: they
can be useful as "extra debug knobs."

But Kalle had a little more nuanced opinion here -- he didn't even
want "debug knobs" for core 802.11 functionality, because (I may be
paraphrasing) one person's "debug knob" easily becomes the next
person's "required knob." Additionally, a mess of disorganized knobs
can make maintenance difficult -- one can't really expect the average
distribution to make a good selection on 100 different parameters; and
for those that do tweak the parameters, it now creates a combinatoric
mess to debug and triage user reports of "it's broken". I can respect
all of those reasons too.

Regards,
Brian
