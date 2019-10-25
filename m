Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0947CE4237
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2019 05:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404266AbfJYDyk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Oct 2019 23:54:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43956 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391314AbfJYDyk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Oct 2019 23:54:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id t20so1254140qtr.10
        for <linux-wireless@vger.kernel.org>; Thu, 24 Oct 2019 20:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ms3b5fs5uO/JSvXU7FwUYyCVlSJ2Jil76zBkQI+alw=;
        b=wWKz/f/OmdOSyAGZMWeZKnRwt29vUldgDuJuUiYrsZJjJL3MmfMsYsNSyo4bJNuVK6
         n66X2BddhF+ddKWFZNS6HifRnOEU3iWXeZ4r4gy4hKeGenGovcCW4R1BZhkHEPqPgrs8
         X1duxg9DAQKXEIs4VS2PhP2laYiVu+SzUzJvSBevuAv3w2fe4iEZpsMbyqCiPJOpUkiv
         ndPt6aPQBajRLq+56aAfdVG57dkYP3O4lHNxUIiINrpDeXw09Sr5+VorWb98TghQQ2uz
         2b8L2pnM0zvIhYviuS6vIkIZcuCVep0qHGkfnFZFFIEcy/EtX/s3pmDDVxkO7qrjgKYi
         7fZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ms3b5fs5uO/JSvXU7FwUYyCVlSJ2Jil76zBkQI+alw=;
        b=PVDOPQ0HxbnXxnMjcOHayhv4AwDwa++asCUymj5NnanCyXbi1AEAPocmyiI7BJAP1w
         xDa1pnVoBI2yYSHTutkOYPRO2oC0j/IYB8J0pzKJgiYcqDm9HQtB8GKH2WYK3wxb8Wbl
         BYp63VZaPa3AB1NHxbp00GnuoIamHl5JgjHUTLqziv9ZnV+Yf6HPMOzwAQ3lfFHaB8wI
         Vf7NS/lE4XvOtAbXo2GC790eWxeqaTwECWEn/hcSzJ/TGoXw7/KRjf2mLXGlBWksUtxw
         0/mplvTgd3gLzq8JSVYsi7bv7YUr5l2nZ2dc0EuFDKxJ42VbihzrY8/0tHOg1gIcUE35
         F7dg==
X-Gm-Message-State: APjAAAX6xUDC0eErosB/MY4KR3P2QGcYFzhN+ODrBGbkB/LWg66rB9P2
        JosnmoJ75Xhd2a5sEzTDfnQN0tkR+lIceHOudchvQA==
X-Google-Smtp-Source: APXvYqyPjCOJo0pucu/QfckiGZKuhUmyqbuaB4LwtQIK32sPfMC3aLzkv1xMPwo2wZ1K1cvHOnukCAwKDPyeSipWSTw=
X-Received: by 2002:a0c:f8c2:: with SMTP id h2mr1316914qvo.234.1571975679416;
 Thu, 24 Oct 2019 20:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191022101229.26044-1-yhchuang@realtek.com> <20191022101229.26044-2-yhchuang@realtek.com>
In-Reply-To: <20191022101229.26044-2-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Fri, 25 Oct 2019 11:54:28 +0800
Message-ID: <CAB4CAwf9vanVf7JA5ZD52Yn-ngtEkA6S6YqhUZssXaLsHYio1w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] rtw88: add regulatory process strategy for
 different chipset
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 22, 2019 at 6:12 PM <yhchuang@realtek.com> wrote:
>
> From: Tzu-En Huang <tehuang@realtek.com>
>
> There are two kinds of country/regulatory efuse settings
> for Realtek's chipset, one is worldwide and the other is
> a specific country. For both settings, REGULATORY_STRICT_REG
> will be set, telling stack that devices original regulatory is
> the superset of any further settings.
>
> For the chipset with the country setting being a specific
> country, Realtek does not apply any new regulatory setting
> notifiers to the card.
>
> For the chipset with a worldwide regulatory setting,
> Realtek's custom worldwide regulatory setting will be
> provided via wiphy_apply_custom_regulatory().
> And if a new regulatory notification is set by
> NL80211_REGDOM_SET_BY_COUNTRY_IE, the new setting will be
> applied to the card.
>
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
Reviewed-by: Chris Chiu <chiu@endlessm.com>

Looks good to me.

Chris
> ---
>  drivers/net/wireless/realtek/rtw88/main.c |  6 ++-
>  drivers/net/wireless/realtek/rtw88/main.h |  1 +
>  drivers/net/wireless/realtek/rtw88/regd.c | 58 +++++++++++++++++++----
>  3 files changed, 53 insertions(+), 12 deletions(-)
>
>
> --
> 2.17.1
>
