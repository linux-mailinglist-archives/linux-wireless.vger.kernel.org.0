Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233384234CD
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Oct 2021 02:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhJFAMI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Oct 2021 20:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhJFAMI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Oct 2021 20:12:08 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2DBC061749
        for <linux-wireless@vger.kernel.org>; Tue,  5 Oct 2021 17:10:17 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id b5-20020a4ac285000000b0029038344c3dso314012ooq.8
        for <linux-wireless@vger.kernel.org>; Tue, 05 Oct 2021 17:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ED1SxDey3Z4okNwRyGQyA6XxQlFLbzg8074JskrL5E8=;
        b=d3G7oao7ay8wgeHKYFdjtMz6KumjAAZihQKAELWFeD0BU2Ha+BU9sAPCIlFRaVhOkE
         CC2bOXLY9MX7UN0iMp1H4kFQtj4hnYJwGsfxHVi0xcLH4zTtYmM8ZYEZOVfIDq1mPhmt
         /2qJvCCFazV+94KkH5t0i+rdjMOjc3AU1AV9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ED1SxDey3Z4okNwRyGQyA6XxQlFLbzg8074JskrL5E8=;
        b=j2zSYZhBMNUSpcuxBaRI84BrmGee+U0TJlDxLc8hlhtiR5blCDG3X4/sFFgKq8LkF3
         cxo9eoCeFiMjYnnibeIMQLnZ36wI7+ln5Xw/TEsoLWzZ2F8nPNrKrqVuOCXz/lKCayJs
         Lw9lkd7Ig/ph2bfZbRFXWvDjMH96/E2AS5K6NLF89tVBTARhVUb2RTPCAmFqwkFVtz/y
         XCGeQhEcIZ9tzpWkYTIC6jcZSEsS8jg9jq8p91WUcbJLiDy+gsl+eoGOje4sgUpzCUwv
         znKFjNiCXXXdwk7tSPyaRAY8vjbws4AiaaLfyPL5tX2t5gWhNVw6XGhcuL6klPjzGrbS
         wN2Q==
X-Gm-Message-State: AOAM533dLwkysQFHJd/ytjpTrqb1ZeZr0ic4hLTJmnGgHlu+lmkZBbTt
        +5ydNdjF9c6jf0VDP3HfAzbZX7ZFQOLhXg==
X-Google-Smtp-Source: ABdhPJxUcDLfD617IHrrU7BWtRqeO+L8z+cW+VDIG8SuO8rc6L9a1/mDspP/JnjN6tN9nV5gTlZ+5A==
X-Received: by 2002:a4a:7610:: with SMTP id t16mr2016116ooc.42.1633479016090;
        Tue, 05 Oct 2021 17:10:16 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id x28sm4110423ote.24.2021.10.05.17.10.14
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 17:10:15 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 5-20020a9d0685000000b0054706d7b8e5so1017667otx.3
        for <linux-wireless@vger.kernel.org>; Tue, 05 Oct 2021 17:10:14 -0700 (PDT)
X-Received: by 2002:a9d:75c2:: with SMTP id c2mr17231628otl.230.1633479014381;
 Tue, 05 Oct 2021 17:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210820043538.12424-1-pkshih@realtek.com> <8735pkiu0t.fsf@codeaurora.org>
 <9b54e3c321a4414cbae62616d8a913f4@realtek.com> <877desggrm.fsf@codeaurora.org>
In-Reply-To: <877desggrm.fsf@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 5 Oct 2021 17:10:03 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPeNZVVWGPyYGAnxcf2nhhjXQE5yOxmgCKx1Hauj62NJg@mail.gmail.com>
Message-ID: <CA+ASDXPeNZVVWGPyYGAnxcf2nhhjXQE5yOxmgCKx1Hauj62NJg@mail.gmail.com>
Subject: Re: [PATCH v6 00/24] rtw89: add Realtek 802.11ax driver
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Pkshih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Oct 4, 2021 at 10:52 PM Kalle Valo <kvalo@codeaurora.org> wrote:
> This reminds me, if anyone has any objections about taking this to
> wireless-drivers-next speak up now. Otherwise I assume everyone are
> happy with the driver.

I realize I never provided any formal tags to this series. I'm not
sure I can count a full Reviewed-by, but we've been playing with it
here for some time, and while not perfect, it's certainly a start:

Tested-by: Brian Norris <briannorris@chromium.org>
