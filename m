Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C88CDE27C3
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2019 03:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392747AbfJXBdj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Oct 2019 21:33:39 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42209 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392133AbfJXBdj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Oct 2019 21:33:39 -0400
Received: by mail-qk1-f196.google.com with SMTP id m4so4891765qke.9
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2019 18:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xcmSVZ6hZYBd6lnEzHdiyLJGQhFzsrox7dDuK9wOh74=;
        b=yqRzl0g4bcFhhIO4QZ4w5RdVOW2/G+PqoqiedMjXrDoqTT2MSPjLc9dQ3QkQVYVkix
         xD3fGhkHi0fvXxc7wnCuWN2DdGNjTbISzzWTJLPcoTX2kzC6XgnebMEg7psz5nQhtwLq
         6ioJKsa6HWVoIsGEUy2fi+PjX26Q0HgtOUsZznkcxx2xy1BKQXE2JzpGQXWzh0z5c39T
         iLc4u8zS0r/kyzx/Z4/2gVQ2JQnI6wBspoEWNwxYBU/mK+NRXZUgVhS7CN1NU868zG80
         aAQMAgG4F466QkABZ2hq/FyATP90A5Um/7alfWfwFv6jHFNPxueCyLRH08p5LxjDIKkx
         dXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xcmSVZ6hZYBd6lnEzHdiyLJGQhFzsrox7dDuK9wOh74=;
        b=MpBrHZPNRMFI5uJ0fy2RwDt8ZaCdJRmjzw/3u5+K27tbzzZ7F9oX3KeDf974o9F5wI
         lXnRrBrHjIP8QWiRh9vAV6rKibs+/9s5/e53tZ/tCyiHZ45RuDq57c5HFWGwvpJO9rLc
         NIwcxV93SsaLkTbo0riSRqg+fGr3RZmRBeCWLgKdCRH78ymvF4M6158oLJUgN3+fuqGX
         jgJKbs2bcpHNfZbDrrWA+2Ks5AXuiEqLADWyc0wFPZOdkcpCssc9VETwpSibu2UGe1K9
         2rmbv0qRIF2welBOyRtdMzQbG9pNZQQoz43/xJVQginn2T11oFjSgEcm3mawruwPAYMb
         /VGg==
X-Gm-Message-State: APjAAAWPN3AiWYPknT4Cak3Bsdh7wkkCmAaJnT/TqInqz1kQtP3+EoB7
        mfXCtQU1rjADebAMXG/6Jx1yO1Oh2V2eAb0RTHou1BlkQqg=
X-Google-Smtp-Source: APXvYqwLtNh3FiqWQ8YOclKCEALpdj1EJA/Kj3mm3fvW3vexGZU/dFdQST/Z+AcbKVSHS+gMhEA26cHIynSKW03q/s0=
X-Received: by 2002:a05:620a:2158:: with SMTP id m24mr11826201qkm.250.1571880817013;
 Wed, 23 Oct 2019 18:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191022100420.25116-1-yhchuang@realtek.com> <20191022100420.25116-6-yhchuang@realtek.com>
In-Reply-To: <20191022100420.25116-6-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 24 Oct 2019 09:33:25 +0800
Message-ID: <CAB4CAwdpG5yfEaptLjpMzsG4hCG+Qc9GpxRMkFHpKD7mwEPigw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] rtw88: add phy_info debugfs to show Tx/Rx physical status
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 22, 2019 at 6:04 PM <yhchuang@realtek.com> wrote:
>
> From: Tsang-Shian Lin <thlin@realtek.com>
>
> This commit adds several Tx/Rx physical information to phy_info
> debugfs for 8822B/8822C. By this debugfs, we can know physical
> information, such as Tx/Rx rate, RSSI, EVM,SNR, etc. The
> information is gotten from the packets of Tx/Rx path. It has
> no impact for the performance of 8822B/8822C.
>
> In the fields, we may meet different kinds of problems, but
> we may have no professional instrument to check them. At
> this moment, this debugfs is a good tool, and it may provide
> useful information for debug.
>
> Signed-off-by: Tsang-Shian Lin <thlin@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
Reviewed-by: Chris Chiu <chiu@endlessm.com>

>
> v1 -> v2
>   * No change
>
> v2 -> v3
>   * refine get evm code, use S8_MIN
>
> --
> 2.17.1
>
