Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B64F18A833
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2020 23:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCRWaB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Mar 2020 18:30:01 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:38291 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbgCRWaB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Mar 2020 18:30:01 -0400
Received: by mail-lf1-f49.google.com with SMTP id n13so18036lfh.5
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2020 15:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=79/TnNpX+mEVZGVG3PjnOy/4Tom4cY/acPKsvTFYo9U=;
        b=P1w48uamnX7Bj5R4stW+8OYZU4iM5mtDSzSlHfc/LuWFC3TYpMhaUDj30WgCwhIoUO
         tSL7V7MwhOawmAXjG3w1YRA/oU/uT3XtdAmXL+7XhVyo77q/q41Bnoiah4um1ANK+xKa
         +jf0D+k27+Ta9iy5slcwQ3XosMwJVOvi7Wzgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=79/TnNpX+mEVZGVG3PjnOy/4Tom4cY/acPKsvTFYo9U=;
        b=XEkrPsXr094Mm0GnGnIqzd/l+O8cBZfizZ911yPydVAgDKiVSx1AY87Z1xeOcKGJ6/
         7OhDL2Bl5VIeWrtCT+ZPBcR71Yyf4yuas2Yp6gX4/Y3IEFR+nNcQaR4ezBSXIoib7n4s
         xL/j5nyhFtbh7jRbITUqo6GBV7KEB49fxRO/JJpLXWYR/Dax5jXSyA1AR9raOwm1JyZ4
         Odnjvz3R4xB8lGqfH2/mmKnujb0rv9pMJ9Kbvawjr6v+QSOuO0A91/euy/GRD1k0bEht
         Crl90cb9U+kmMLjp0GIQNsARDzBy7rr8/Ita9Snufjf8zAvlbcBayBo6sRBoM4znHMWi
         ZhrA==
X-Gm-Message-State: ANhLgQ3IOr8ClL2xwIdOgohALDpIawHr2kAGGGHlKHlXnUK83nAkZeE0
        gq1XQr4gOb5GZlEePADZ3vXFq30Gi4g=
X-Google-Smtp-Source: ADFU+vuJXZ7a29BL8kNC3hEe8eCAKngBM8zTtS5rSnftDRKi1Sh/A0gjIh586T9sy37ddejOXG/O/A==
X-Received: by 2002:a05:6512:247:: with SMTP id b7mr178979lfo.21.1584570599275;
        Wed, 18 Mar 2020 15:29:59 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id w9sm40166lfk.4.2020.03.18.15.29.57
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 15:29:58 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id f13so267581ljp.0
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2020 15:29:57 -0700 (PDT)
X-Received: by 2002:a2e:96cc:: with SMTP id d12mr123856ljj.87.1584570597082;
 Wed, 18 Mar 2020 15:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200317091837.GA18001@mwanda> <CA+ASDXP80wMrWyc+WZNoGt=DK0EjFjNSjqCi4NGpJgc1mGK3sg@mail.gmail.com>
 <DB7PR04MB52429DE16439F690857070A78FF70@DB7PR04MB5242.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB52429DE16439F690857070A78FF70@DB7PR04MB5242.eurprd04.prod.outlook.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 18 Mar 2020 15:29:44 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPWafANxSEkknMzP_zt7epCdPu4PZKn1ZPUFMOZkvGZ5A@mail.gmail.com>
Message-ID: <CA+ASDXPWafANxSEkknMzP_zt7epCdPu4PZKn1ZPUFMOZkvGZ5A@mail.gmail.com>
Subject: Re: [EXT] Re: [bug report] wireless: mwifiex: initial commit for
 Marvell mwifiex driver
To:     Ganapathi Bhat <ganapathi.bhat@nxp.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 18, 2020 at 7:25 AM Ganapathi Bhat <ganapathi.bhat@nxp.com> wrote:
> > maybe the NULL check is reversed?
>
> I think, it should have been like below:
>
> if (!tx_ba_tsr_tbl || !mwifiex_is_tx_ba_stream_ptr_valid(priv, tx_ba_tsr_tbl)) . . .

Ah, of course.

But I think my point still stands:
It's currently dead code, and even if it were correctly-written, it
would be redundant and unnecessary. So we should just remove it.

Brian
