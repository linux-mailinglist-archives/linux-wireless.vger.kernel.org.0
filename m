Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04D7A49E60
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2019 12:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfFRKj6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jun 2019 06:39:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35384 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfFRKj6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jun 2019 06:39:58 -0400
Received: by mail-qk1-f195.google.com with SMTP id l128so8197607qke.2
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2019 03:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QUjvDqJpac2tWAcPmVihCXHdjeBt4L6Xc+eSlRSPug0=;
        b=ftTL5A/2Ms+voYrgMwb0dpQCUamHvrh22tvxMVuC9NnC3JtDe3uVt5r2uGu92c3lVy
         tcdup6uFgVItOwnTjFZSAmXhKsGUm1pW8QvHu5JBkAmG8vtDJDIs+7Qgy7qKiWxmhexW
         6tzVtilLa+4W5twTAqf+LoZoKU+0mkkuLRsdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QUjvDqJpac2tWAcPmVihCXHdjeBt4L6Xc+eSlRSPug0=;
        b=j8xG69m/fcJVQ6fX/Pb1ScVwMwgoA4dInoaVN04yI+5K+AL5YfRlMV6qzjDRH40eRx
         NOLZ2qPN63ol+Tj3GZRMW/G0L7VI7AOE8hHSGPYsA//6Fd/PgQaiFwkhvFem6MN+eLTt
         raz3bfsPVMLSkt7qLJbTTz4pE7BXgLKQK1a2jCQV+b3W7UZb9efjFrazB4vETT5esL3c
         iYT+NhGd/ahcFfqYJ2uX+zyPD3dlTVS/9BTpwFTsxWi7f/dbPsiMnLcUCcsBgCNay4je
         F1N/86Gea2TTWj4JOGoGXzhHrW4+wE+eaPcGcIaCHCEfmJgLHHdngJF4i7d5YphQplJB
         XUmA==
X-Gm-Message-State: APjAAAWXiXzFWSFBT/w8BH0C6YtYcTDsOcisqA9YPLTT7AkVWBOCKDjH
        G2uu+Uc13llUISUSNyFcis74C5foSqv45FJ/QR6Tiw==
X-Google-Smtp-Source: APXvYqx0S4+mjl+uTEs207t+KiTBcOXlFlw+UmQ+BCF+LoJi85/9/uZjoaR+Jb31lAhfyAplPcrJC6Pn59+/Ge9hcvA=
X-Received: by 2002:a37:a244:: with SMTP id l65mr76059118qke.118.1560854397557;
 Tue, 18 Jun 2019 03:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <1556417825-13713-1-git-send-email-wgong@codeaurora.org>
 <CANEJEGug_YregN5vZq_R=ppUV5ptb4WUq_TB+JApzQ4DEO_AfQ@mail.gmail.com>
 <36950ff25c0747629e60ccb68819e93a@aptaiexm02f.ap.qualcomm.com>
 <87pnour4jg.fsf@codeaurora.org> <CAPDyKFrs1rO38yd-yQ50y2Oo1JE=R2hWM-5FWp=Ng_TM1df7ww@mail.gmail.com>
In-Reply-To: <CAPDyKFrs1rO38yd-yQ50y2Oo1JE=R2hWM-5FWp=Ng_TM1df7ww@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 18 Jun 2019 19:39:46 +0900
Message-ID: <CANMq1KD7tjG4dq4YP=oKTs_Ki6Wd1E_VbT7+b7e4UeBGY-KMsw@mail.gmail.com>
Subject: Re: [PATCH] ath10k: remove mmc_hw_reset while hif power down
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Wen Gong <wgong@qti.qualcomm.com>,
        Grant Grundler <grundler@google.com>,
        Wen Gong <wgong@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        Claire Chang <tientzu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 28, 2019 at 9:46 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
[snip]
>
> In the end, it seems like this needs a more detailed debug study, to
> figure out what exactly happens during the re-initialization of the
> SDIO card, rather than just papering over the problem by removing the
> call to mmc_hw_reset() in the SDIO func driver. Hope this helps.

To close the loop on this, we fixed this on the platform by driving a
reset/enable pin during reset:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1657506
(device tree for this device is not upstream yet).

The problem has to do with the fact that on re-init (without power
cycle or reset/enable pin cycling), the device still sets S18A=1 in
CMD5 response (that's incorrect, the device should set S18A=0 if it's
already using 1.8V), so the host tries to switch voltage using CMD11,
which fails, as the device is already in 1.8V mode (that's correct
according to the specs).

Thanks,

>
> Kind regards
> Uffe
