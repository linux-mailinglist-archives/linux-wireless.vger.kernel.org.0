Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96EA68F646
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2019 23:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbfHOVLZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Aug 2019 17:11:25 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41320 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730865AbfHOVLZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Aug 2019 17:11:25 -0400
Received: by mail-lf1-f68.google.com with SMTP id 62so2587358lfa.8
        for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2019 14:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6rHFZp7Q9zNEGDrlZI7ThtXxX4J4GssJHaVlX0BDsnU=;
        b=YBegRkSr9nfqFrxMWcrxZCGSuYot01qXHOoTtm5wN3VBHueQZiKwl9WSchw77Q+TVJ
         diHdRMiSGJr/k7xx6YnJCegoZ29R5fc/EOgx0U44Ph81JtctlLRfL3KuiGAvGt04RhUV
         1EzhB489KpLuTy17vHo7QbM5pjo5eMPKZECMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6rHFZp7Q9zNEGDrlZI7ThtXxX4J4GssJHaVlX0BDsnU=;
        b=CuxhLDN4LHcJyNmmi+V28zKw2J09t5SEJzDfiwGkXpkVUt3HZQxcnVWx/vue5oBKoq
         pbSdYlzvLAmXcJCLXvUguZRkdyhG/4EuhUYRD5Ku2axDlp2l91x3mI380ABSI7DlO2qC
         nHAlz05RBRKk08+T9/ZkGaryxTpGckO5gAcLJ3CnZevH5An58I7D+n+gEZln/5rV4hEr
         rg8v7X/0egz6oCdznkecikqkD6BofGfwiaJIZ5o9KlNJ8vm8jodlOLRNlHZNp7ptlitL
         gnhO4CC8IJjWvvCvnfJaKpXp0bbKdTUK49n/gUL9l+6c5gg2rIL2kBmC3MK/r1xM6P1b
         NXIg==
X-Gm-Message-State: APjAAAX+4wXN4U31vLVJrthsjx/i3S7rEHEe4r2gAy+DF2OuAkSG7ZHf
        ls0k6ClpyqtPPFEfZ4p8OPSK9KKjqoo=
X-Google-Smtp-Source: APXvYqxu9qr/58JGSW4DyyzcxBNQtb6ix+6mHuibgLN6xL9YwlZByXnkkMpSFF7QpneYaavumFZJ/w==
X-Received: by 2002:ac2:5104:: with SMTP id q4mr3593155lfb.56.1565903482650;
        Thu, 15 Aug 2019 14:11:22 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id z83sm661602ljb.73.2019.08.15.14.11.21
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 14:11:21 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id m24so3423522ljg.8
        for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2019 14:11:21 -0700 (PDT)
X-Received: by 2002:a2e:b0e6:: with SMTP id h6mr3455892ljl.18.1565903481377;
 Thu, 15 Aug 2019 14:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <1564575767-27557-1-git-send-email-yhchuang@realtek.com> <1564575767-27557-3-git-send-email-yhchuang@realtek.com>
In-Reply-To: <1564575767-27557-3-git-send-email-yhchuang@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 15 Aug 2019 14:11:10 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPJiNTXAihzohT06RS57gkJU9Q-u3kpp0piJP-3U1miFw@mail.gmail.com>
Message-ID: <CA+ASDXPJiNTXAihzohT06RS57gkJU9Q-u3kpp0piJP-3U1miFw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] rtw88: enclose c2h cmd handle with mutex
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I understand this is already queued up, but I still have a question:

On Wed, Jul 31, 2019 at 5:23 AM <yhchuang@realtek.com> wrote:
> C2H commands that cannot be handled in IRQ context should
> be protected by rtwdev->mutex. Because they might have a
> sequece of hardware operations that does not want to be
> interfered.

Can you elaborate on what interference you're looking at, exactly? I'm
not a big fan of defensive addition of global locks, and this
particular mutex isn't very targeted. It claims to be for mac80211
callbacks, but you use it in quite a few places (some of which clearly
don't make sense), and many of them are not related to mac80211
callbacks AFAICT.

To the contrary: this handler is called from the mac80211 work queue,
which is ordered and therefore shouldn't be getting "interrupted"
(e.g., conflicting commands). But then, you added the 'irqsafe'
command, which gets run from the ISR...and doesn't hold this lock,
obviously.

It may well be that you're correct here, but I'd like to see a better
explanation for stuff like this. And maybe an update to the
rtw_dev::mutex comments.

Brian
