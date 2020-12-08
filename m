Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE552D1EC0
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 01:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgLHADZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Dec 2020 19:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgLHADY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Dec 2020 19:03:24 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D33EC061285
        for <linux-wireless@vger.kernel.org>; Mon,  7 Dec 2020 16:02:36 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id x13so5092497uar.4
        for <linux-wireless@vger.kernel.org>; Mon, 07 Dec 2020 16:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upb/CqjljGMq0mDhDOTo+ddS28Jk9ogwKt4euX8NQs4=;
        b=FL1MkXJu3M0BAsQbDDwOhOO07lK8vxkNwD3gVvvAFsHzWvAVD4uVocaZxFmag3g/mB
         7wb405alpjK9lwL5NGrDPVV8pPeW0G/kivR+vySa+9Yh+v7vqyALp0zMV8t8RdWciWxT
         Wgy9Q4cy1HuJdqY5aJDn0xcqqodUnwgQ+cBYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upb/CqjljGMq0mDhDOTo+ddS28Jk9ogwKt4euX8NQs4=;
        b=LcMNSc7faNR+/CKpxr/yG5oBWk97DFOhLm+zh3KvfkjMNdOpUKL7t7BYgV/kD5FE1O
         TKj5f5Z6Shgwjdx76yagjoEII30YhqaQzEi5vcopdl/qvikuxAfncYOOIvWyIVEyuc/Z
         /lqZxQ8a1eOqD0JMZya6Qs86sHcj9UEgmvT8t91hyaFHEJFFfbF2f2sqVsw+V9MpFuJV
         894l40tt0HU6dupNIx4cSfDDuLGWLx/W0jh469k02BzE8zM3dCaraCBUc3D6Y4OBUkGx
         z5yIUebJiR52BKXTnYynW79l5kpooN9cqgYGpOCVCQZhZMmDAFq65Df3IJrnTeRe7AvU
         zn1g==
X-Gm-Message-State: AOAM533Tre7pUBt5zTQQ5ol/Nl4bT3TGk/64B2mXI2DyyOOkd3Isox/U
        KncF3r4QfMGN/rRbokFwzB3uTdKHYKYgVQ==
X-Google-Smtp-Source: ABdhPJwX2DjC6sQ3AbCH1s7MGuzo8BLwoCw3pj/H+AtpC3qeg7LWrwrpJCGXVE1cKiJnrs4BGHiWHA==
X-Received: by 2002:a9f:2191:: with SMTP id 17mr13806076uac.83.1607385755296;
        Mon, 07 Dec 2020 16:02:35 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id b81sm1894651vka.53.2020.12.07.16.02.34
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 16:02:34 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id y26so5093315uan.5
        for <linux-wireless@vger.kernel.org>; Mon, 07 Dec 2020 16:02:34 -0800 (PST)
X-Received: by 2002:ab0:35fa:: with SMTP id w26mr13479881uau.90.1607385753680;
 Mon, 07 Dec 2020 16:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20201207231824.v3.1.Ia6b95087ca566f77423f3802a78b946f7b593ff5@changeid>
In-Reply-To: <20201207231824.v3.1.Ia6b95087ca566f77423f3802a78b946f7b593ff5@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 7 Dec 2020 16:02:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UyCboywA0xG68ZhJB6MZ2ncx478WntD_1iGg=q+G8AmA@mail.gmail.com>
Message-ID: <CAD=FV=UyCboywA0xG68ZhJB6MZ2ncx478WntD_1iGg=q+G8AmA@mail.gmail.com>
Subject: Re: [PATCH v3] ath10k: add option for chip-id based BDF selection
To:     Abhishek Kumar <kuabhs@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Mon, Dec 7, 2020 at 3:23 PM Abhishek Kumar <kuabhs@chromium.org> wrote:
>
> In some devices difference in chip-id should be enough to pick
> the right BDF. Add another support for chip-id based BDF selection.
> With this new option, ath10k supports 2 fallback options.
>
> The board name with chip-id as option looks as follows
> board name 'bus=snoc,qmi-board-id=ff,qmi-chip-id=320'
>
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2-00696-QCAHLSWMTPL-1
> Tested-on: QCA6174 HW3.2 WLAN.RM.4.4.1-00157-QCARMSWPZ-1
> Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
> ---
>
> Changes in v3:
> - Resurreted Patch V1 because as per discussion we do need two
> fallback board names and refactored ath10k_core_create_board_name.
>
>  drivers/net/wireless/ath/ath10k/core.c | 41 +++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 11 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
