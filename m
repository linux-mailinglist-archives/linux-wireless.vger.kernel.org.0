Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D2B324790
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 00:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhBXXhh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Feb 2021 18:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhBXXhf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Feb 2021 18:37:35 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75B1C061574
        for <linux-wireless@vger.kernel.org>; Wed, 24 Feb 2021 15:36:55 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id k2so3333761ili.4
        for <linux-wireless@vger.kernel.org>; Wed, 24 Feb 2021 15:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=Xnx5YCELXGugULeGE4MpmhZ4uvev3/xHPGHOZI7+C1I=;
        b=CzFRIfSP6jrZnWsLuhUGWLYnluq3RGPkrN+mIDPmMUn4q0cw6wmJ+DA9glfhBPhY0L
         3ny4yzu/FC4iG2gI3ywX/Qu5rSTRDjrgk0KingR1it9BZDfIJpSUjkKr9W4KkydF1+rZ
         v90SVfEyaN1y1SOY3hJTk9dsRee1xOTnHOVQCEChq4KXmKAwLun4Jlfd9YUaUYrxaZ+A
         l7MnC1dCUCkcxeshpX4u6Z39I4ufJgbJtIcsUACcNH1SvrmcTyCzxDWhbQhGfqanqxcZ
         OdRf56VVI/DkDXnaQBu8HCpyn2vsSmKneElOR36KaVBEp8fLDu8Ol/YfFUWahAdD/sqW
         OILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=Xnx5YCELXGugULeGE4MpmhZ4uvev3/xHPGHOZI7+C1I=;
        b=n0n17sUkO25RD5RV+6w90DnbIHVZuJpoijCrUh/JU3++pb2x+RWNYhd5uWBINZtMmn
         /qBoGw1MlxfLcTHi9EFPTfGCkyRrEsjZN5lB+bIVa83SNj2VDttUBqbJt3XjRR/Ih3QX
         3cXvbUASQ4bIWER6MxPSfwdAhgAdbLZszduH535BOOIhTQGk/xe8vjGpnPfw2waOgc4N
         PiHAXllw93wTMAd+/FQdrwfv1ClwmUhKALXkcYc84dbkfB7KQxRuVYZMungjapJbA4y3
         I3mykxtdQVkutRs8LJsLP4BL4YMPOMyv/WE4l7DpTBZZMcXsBXHFNVz7wBGV/izTPV+X
         J0yA==
X-Gm-Message-State: AOAM533TDDvmlFYdAkkJcn95+Jvkfgsalv0V9mjgYsZC9FAPe1aXLSCI
        kz+EJjspHH3rsaQ6SChX1Tnp
X-Google-Smtp-Source: ABdhPJyA+mTq2N9kKs0U1g0B0bf6gS7wPBNZCi57s0vVriob4O/71uFHjgBRXzHucZ4e3i79f0MjOQ==
X-Received: by 2002:a05:6e02:1885:: with SMTP id o5mr129976ilu.78.1614209815070;
        Wed, 24 Feb 2021 15:36:55 -0800 (PST)
Received: from bixby ([2601:281:8280:3560:dc4c:ffc8:6468:4a5b])
        by smtp.gmail.com with ESMTPSA id j1sm2171837ilu.78.2021.02.24.15.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 15:36:54 -0800 (PST)
Message-ID: <70567db1d625086e051b305320c9d4be7deb1b82.camel@egauge.net>
Subject: Re: [PATCH 4/4] wilc1000: Add support for enabling CRC
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Julian Calaby <julian.calaby@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Date:   Wed, 24 Feb 2021 16:36:53 -0700
In-Reply-To: <CAGRGNgUR7wHgprWcqz5orJNuhcxeLMSE1C3WCi1_UH_MCwJ6Cg@mail.gmail.com>
References: <20210224055135.1509200-1-davidm@egauge.net>
         <20210224055135.1509200-4-davidm@egauge.net>
         <CAGRGNgUR7wHgprWcqz5orJNuhcxeLMSE1C3WCi1_UH_MCwJ6Cg@mail.gmail.com>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Julian,

On Thu, 2021-02-25 at 08:19 +1100, Julian Calaby wrote:
> Hi David,
> 
> On Wed, Feb 24, 2021 at 6:56 PM David Mosberger-Tang <
> davidm@egauge.net> wrote:
> > 
> > +#define ENABLE_CRC7    0       /* set to 1 to protect SPI commands
> > with CRC7 */
> > +#define ENABLE_CRC16   0       /* set to 1 to protect SPI data
> > with CRC16 */
> 
> Should these be Kconfig variables instead?

I'd certainly like that.  Ajay, would you be OK with that?

  --david


