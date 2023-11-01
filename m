Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062827DE19E
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Nov 2023 14:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343969AbjKANZy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Nov 2023 09:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343828AbjKANZx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Nov 2023 09:25:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0EE110
        for <linux-wireless@vger.kernel.org>; Wed,  1 Nov 2023 06:25:50 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so10661563a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 01 Nov 2023 06:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698845149; x=1699449949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l7dYfY4/Q3qjzALeokbjPzM7YiHGzhe3bW4UqrFKSJw=;
        b=IB5LCa5/bnTe0R8tpO8g8ptj1B6V0X2YHSOtqCRn7zlbMHEhXG0MC/OwEmxn0KyxYw
         wr1ptuV6a2IKFVjZWnuEKRJvuThsTmpriKIbwzNrybFZNATp//ASBbegFCLqITRI7XsR
         oPKZI8YhX1hzeDtlyb/TGcd993NKttYs/m4YuG5GStvfr49TofEembCZB60bwGA3FZOn
         BgVwatRLaD/kCC3/pES6Jw+I07WlVV0FTgpA9VMixcbH1uHy2WwPCU6aYZPD+ixTKwgX
         G0IZJkeS7Au0SUNYvey55j4xG/+1n8ZQBHzUoStWINVuwk7doCMZMoAq/mgwVXP26Bxq
         FmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698845149; x=1699449949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7dYfY4/Q3qjzALeokbjPzM7YiHGzhe3bW4UqrFKSJw=;
        b=H+ajxoGo4pZqu/5c6Ivl/bkIMnUFF9cy0L7Vm9Z7dNak7jcUjxfDkE5UaG2oID8aRk
         cNRh10tu1HbAnkt2Z01VZYN1r+uIminl41ncVYVDE6kUFOzxCGSdqeSB+IN19xPgCPkm
         vkmzzgs0OJEqtcFAs/z1gCSS9MT7kZ9Ub+YoZ6xRReAPY5ABARznE4/aJQFmAV5wKnG/
         67nT0aPOFsjDIOzxI/seCp5yUibSnuc5stvgPWvVDAenxfGjZohKeDieMBMGGzwVee9I
         w0wZe8UJKZgqXmzsluNtEPucLhFfa4R/dhGX/vG8kSb3Z+eh5glRDfD4Ka3mDPx9nFeO
         KqVQ==
X-Gm-Message-State: AOJu0YxfYkCG/vhFFqaZTn+doGCBRDcF6ZcQfoqQUaOB7wVZoy9mnrrH
        tdRbY5rlfEdysn4qWjzgiXW8HEmkPTfY3ugUXQI82LDB
X-Google-Smtp-Source: AGHT+IHVGv31WPL8Nlk0KbvJTRIVmJetZhIUBJzgHC7X2v+WJQCembmW/pG/xLGlRm1yObDkrqYrn7oBwaKHp4wqgog=
X-Received: by 2002:a50:9e05:0:b0:543:72cf:5056 with SMTP id
 z5-20020a509e05000000b0054372cf5056mr3816405ede.9.1698845148625; Wed, 01 Nov
 2023 06:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAKPbyNCpkGB3e3adK1+kPrQnGq6dfO8cEEUyULowgaMu4c_9jg@mail.gmail.com>
 <58cbb526061446d6b236dd83a6a77b96@realtek.com>
In-Reply-To: <58cbb526061446d6b236dd83a6a77b96@realtek.com>
From:   4javier <4javiereg4@gmail.com>
Date:   Wed, 1 Nov 2023 14:25:37 +0100
Message-ID: <CAKPbyNBA5v-=XOK+ZxvpmyRSbwqZBAnf5mUgvizeNA1CrpxO4g@mail.gmail.com>
Subject: Re: Realtek 8852BE: bluetooth interference with wifi power_save
 enabled on Linux
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks a lot.

I just tried that new firmware and had no playback issue for at least
an hour of playing.
I didn't have the chance to test mic yet, but I'm confident the
problem is solved for that too.
If I'm wrong, I'll reply here again.

Cheers.

Il giorno mer 1 nov 2023 alle ore 01:52 Ping-Ke Shih
<pkshih@realtek.com> ha scritto:
>
>
>
> > -----Original Message-----
> > From: 4javier <4javiereg4@gmail.com>
> > Sent: Wednesday, October 4, 2023 1:47 AM
> > To: linux-wireless@vger.kernel.org
> > Subject: Realtek 8852BE: bluetooth interference with wifi power_save enabled on Linux
> >
> >
> > Good morning
> >
> > I'm experiencing issues with this Realtek WiFi/BT comb chip on an HP 470 G9.
> > My bluetooth device gets choppy audio when wifi_powersave is on.
>
> I have uploaded new firmware [1] that I suppose it can fix this problem. Please
> download and copy it to /lib/firmware/rtw89/rtw8852b_fw-1.bin
>
> [1] https://lore.kernel.org/linux-wireless/baed3fc347269c3dd34244f34946e09dff183825.camel@realtek.com/T/#u
>
> Ping-Ke
>
