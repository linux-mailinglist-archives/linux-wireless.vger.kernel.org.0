Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6CDD63D4F
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2019 23:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfGIV2L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jul 2019 17:28:11 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42084 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfGIV2L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jul 2019 17:28:11 -0400
Received: by mail-io1-f66.google.com with SMTP id u19so108901ior.9
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jul 2019 14:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6xuVNtto2i+j8dGWYiMsCcIcli6lEjhIoEXTrMKI510=;
        b=mgn5jqhDsssTjORHlWne5iOQcte/3D+9lSVnvL+aVRe0U9NlV7bIUQUU6Pqu2JLA8w
         kxKV1S1UCRJJEHb0svwxcZ99UTqlU+ZZSfPZcKECQjHPjPF8AeA/u5XY/s2p17w3uGQ7
         /YMSMTKaUrSK+Oeb68cun7y5z4QBBxqHrwSck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6xuVNtto2i+j8dGWYiMsCcIcli6lEjhIoEXTrMKI510=;
        b=spKbzzbbfl6fY28keWf6DT+rmV+GygJCFKIjxWaM1VRkbce4gCVbnDqja4Qn5QTMNs
         +QXEgqrguJGktjdPgVU96JO4ojNEdmtY4hIcODJlpai8b+fjIABZK7Z+BO5MQ3HaBvg1
         gYf3jS41KBdx3S1VwvL9ZauqP3BH3gb4emD/YGNnowIISEw0wAi1Fj/FxAtfMrSj32Qk
         M84H9JTYmL8nZJco4cjs491Q5Yh4j6NU2Cvn3avd/sV21QVsxtvokaBTeNf+pOfGwppn
         GhsYoQuIYxtvCqGhQZBmMbma6cdGTT2YZB3AdeNsifTp2q/lbsu/8Fx68J2lbSFW/m3a
         e64A==
X-Gm-Message-State: APjAAAVm0YXS4epk14RIQ8hzeKLx0t9nlwZNR8lP1ZzuPU+GJY9j+6Mt
        7BHstI+psJO4KbtguaK0jdHNul22P+s=
X-Google-Smtp-Source: APXvYqxAe7CxXr2d7D6sIwH2VW5x5SzgD6LmRfkYGaqzWQlsHAtPGvMB85c1sdXBBzpRBZFEuCLX6Q==
X-Received: by 2002:a02:380c:: with SMTP id b12mr30909802jaa.85.1562707690137;
        Tue, 09 Jul 2019 14:28:10 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id i4sm28777419iog.31.2019.07.09.14.28.09
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 14:28:09 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id h6so132574iom.7
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jul 2019 14:28:09 -0700 (PDT)
X-Received: by 2002:a5d:96d8:: with SMTP id r24mr26902780iol.269.1562707689155;
 Tue, 09 Jul 2019 14:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190618153448.27145-1-ulf.hansson@linaro.org> <20190618153448.27145-4-ulf.hansson@linaro.org>
In-Reply-To: <20190618153448.27145-4-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 9 Jul 2019 14:27:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V-guTEPqi42q8rhiw+v5PB-87MTdAFb+22nGZ4sEGdYg@mail.gmail.com>
Message-ID: <CAD=FV=V-guTEPqi42q8rhiw+v5PB-87MTdAFb+22nGZ4sEGdYg@mail.gmail.com>
Subject: Re: [PATCH 3/7] mmc: sdio: Move comment about re-initialization to mmc_sdio_reinit_card()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Tue, Jun 18, 2019 at 8:35 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The comment in mmc_sdio_power_restore() belongs in mmc_sdio_reinit_card(),
> which was created during a previous commit that re-factored some code. Fix
> this by moving the comment into mmc_sdio_reinit_card().
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
