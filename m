Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4701DA53A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 01:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgESXN5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 May 2020 19:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgESXN4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 May 2020 19:13:56 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C902EC061A0E
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2020 16:13:56 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id g15so735928vsb.5
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2020 16:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jb5TrPmyRiGoq4P8G0LO5+ceLeAkI5ybri0s413IZBM=;
        b=bcIezp7cDg8VBsw+G/u7xnRe90zrbzCHYNSdAZxNrC/2/xC2Rg4fMoFFr/7lK5t0TL
         Fqs7NAszbrUJY+3BuH0zgXoxUNvRbf6ZMZVvuCsI/wBQdWz0i4f2PmanpsAmS+5N93d7
         27J9epyGxpHwZZdnLzctw1NglnkkMaILMF5FQieWnsKJrF+t+KI8QEBXYsNrxW4TB7ZS
         jRNj6pV2W6huz1fHOGRl1IZAon4WEsOqWbgLsvKgIcaZFmKeTTUU9coxLzOFd2B9DeOk
         Uo78TdHoPxRXjScux+X0Twb3zMEWYygUED2OBDyD0TeeVLQB6x852/AxNrnvxR89fEC4
         NGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jb5TrPmyRiGoq4P8G0LO5+ceLeAkI5ybri0s413IZBM=;
        b=udmM6t513vNdUysm2GWkXdTa4SMdoItK5ThMbE/7f7ZvH2wKGnMbdfS5QCykWxOs4F
         nKhdsjF9+Bsxs0d1zizoRHlN2MZna3u5Mij+ZHpgB/meVjBVG7XE3LdhWkhTNxMHA0+1
         d4B4JqW40zs1f2jK/Ggdn7skSLxffgs97G/jEts3RzOVYHCey2zwn003jHP1p3T+mOn/
         OofuHdAE1ceAW16/alsJGsfV+EjfDnC2etsttZQb9pYu2kHm0dWMErLIGuNu5++13DxJ
         e6eNYVuUhuR4mzqh3Y9PGuLvRDEvY6pbFTkJ8zgP0sgQ1y0CogoE/XIMxlS2cuCT6G9f
         pPyg==
X-Gm-Message-State: AOAM533zw7dV6Ws6hI/sGvS43UPOsyl//iLsI9XBmLBCZYI/bcQchTa+
        KF2o3w02DSxyp6RAtBNy3FqmL0Bre59tWHWaniJAXtecHQFx
X-Google-Smtp-Source: ABdhPJzDRuZbZKNBs5VEupHCaZavel/AxZk2yTuEtokCQrXPNyNNaDQvzKsIV0ukeGTvDs65N1IDYOd2usKWTeIx4vc=
X-Received: by 2002:a67:6dc7:: with SMTP id i190mr1284679vsc.75.1589930036051;
 Tue, 19 May 2020 16:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
 <3483242e-c2ad-ec83-0c2c-ce952bc9b638@lwfinger.net> <CALjTZvatxQ2BvUeZGcTFijBf1PiLizJuDdENxg2b=tPQL_NAzQ@mail.gmail.com>
In-Reply-To: <CALjTZvatxQ2BvUeZGcTFijBf1PiLizJuDdENxg2b=tPQL_NAzQ@mail.gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 20 May 2020 00:13:44 +0100
Message-ID: <CALjTZvYSJOx0xeMVkN6dHcGTdgW9O9NVbgXPKK4d6-31VX+0JQ@mail.gmail.com>
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     b43-dev@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 19 May 2020 at 21:36, Rui Salvaterra <rsalvaterra@gmail.com> wrote:
>
> Hi, Larry,
>
> On Tue, 19 May 2020 at 21:30, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> >
> >  From other drivers, it appears that handling WPA3 might be as simple as setting
> > MFP_CAPABLE in the hardware capabilities. Please try this patch:
>
> Fantastic, thanks for the quick reply! I will do it ASAP and get back to you.

Unfortunately, looks like in this driver it's not so simple, the
association is still rejected. I looked at the other drivers too and,
sure enough, they just set the MFP_CAPABLE flag unconditionally with
software crypto (I would expect mac80211 to magically handle it, but
with b43 it doesn't seem to be the case).
