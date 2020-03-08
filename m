Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9D717D3BE
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Mar 2020 13:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgCHMoP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Mar 2020 08:44:15 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:35709 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgCHMoO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Mar 2020 08:44:14 -0400
Received: by mail-wr1-f47.google.com with SMTP id r7so7700804wro.2
        for <linux-wireless@vger.kernel.org>; Sun, 08 Mar 2020 05:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wOh1qUUVnR8SdAU+BUkdObJe8zqZ9QD+giXo3CmNXvo=;
        b=fnL0PTxzvn7Gzlzu08V0EjADystsFNkPy3kv5WjxQzvWsGDg4s7/CojA32cS0tk4PJ
         yJOuUCmiqSLVCAbyBS2D/Dhjn37X4LuY2VQMFAE8f+QrjuDk02O8HWGQBcLwh4KIj1Vy
         8lp6JmMycPU4p+OpCQEhy37Z1AdGwRx6uqCRb4rUZ8dyhy3g5dMs/h1H66Q4sDjgE57P
         cKa/vevMWcS9Y3loQtM800HUQwZfek52gmFPSev+7diYl9k6qpAIi3u9+jr5IMMiXkJs
         2JhVcyUIQY+1uRypejxVdIQK8SlIt5EHQOvC4x0SYEFbviNHLNjdAKKxnOVNCa8g2nLU
         B5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wOh1qUUVnR8SdAU+BUkdObJe8zqZ9QD+giXo3CmNXvo=;
        b=kjIGSxclBZeECdlk3Ds/fjUgkRbB1WFRgwqK4i3MOUggyoapGLZn4TgQy+UZyDc7tJ
         GtLHJZK0mRIQFPbqgKCWl/EcaqZVoB/tURnJUrZ4ZQW26WbouG24352kxcN0ov9avNHB
         i36216qbAEJWqslSv7Crf3m/qMhJ7y2H6hbj2h98gOUoSYdCp1vsIca76ZxtUkfwyTl8
         +ibIHNuTYknbVEKmCBMcszQc7c6OEo6NSD68ysq32Ija81bLsZTOUjYEL2SWdWGWme09
         4IV9AJTDBXCdnAgQmrDgpTnXFUe2xpzPu2qCENiic/5uILiuklpk8JA/TnejcZuEqfoX
         82Bw==
X-Gm-Message-State: ANhLgQ13IJVUpXrqfONwHr/0i0MV8KN/72BYOAXKWFcF787bwPyToZTl
        NPAJ9Avx8jB/u5p/e/Dy7nE=
X-Google-Smtp-Source: ADFU+vtBqzg5Q8sjlMTz5C0BvD3s9bp/LVNAJyW85HvWffjRIbvye240wqsTygKunpWv7i6eGc7I9A==
X-Received: by 2002:adf:9501:: with SMTP id 1mr15338142wrs.426.1583671452566;
        Sun, 08 Mar 2020 05:44:12 -0700 (PDT)
Received: from t2b3 ([109.175.104.3])
        by smtp.gmail.com with ESMTPSA id g206sm21583174wme.46.2020.03.08.05.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 05:44:11 -0700 (PDT)
Date:   Sun, 8 Mar 2020 13:44:07 +0100
From:   Tobias Predel <tobias.predel@gmail.com>
To:     yhchuang@realtek.com, Bjoern Franke <bjo@schafweide.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [rtw88] Linux 5.6-rc1 / RTL8822BE WiFi adapter
Message-ID: <20200308124407.GA1447@t2b3>
References: <20200214214134.GA12764@t2b3>
 <c76d37cc-2cab-a8f2-e570-a444c06ad020@schafweide.org>
 <028ea5d3-1459-b37e-f996-72958be0ff4c@lwfinger.net>
 <dcd22888-4a60-59f4-3a8e-0b1a49b1e922@schafweide.org>
 <20200218094514.GA13937@t2b3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218094514.GA13937@t2b3>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

well, now I get troubles back with Network controller: 
Realtek Semiconductor Co., Ltd. RTL8822BE 802.11a/b/g/n/ac WiFi adapter,
still on 5.6.0-rc2-next-20200217.

Are there any *other* firmware files for testing or update?

I get a lot of timed out to flush queue 1 and
firmware failed to restore hardware setting together with poor performance,
100 kbps and so on. Not a router issue, because tethering with smartphone 
works fine (800 kbps).

So this might be a firmware issue?

Kind regards,
Tobias

On Tue, Feb 18, 2020 at 10:45:14AM +0100, Tobias Predel wrote:
> Hi,
> 
> I withdraw my issue. Linux-next has been working well so far.
> 
> Regards
> Tobias
> 
> On Sun, Feb 16, 2020 at 02:40:17PM +0100, Bjoern Franke wrote:
> > Hi Larry,
> > 
> > > I deliberately stay behind the official kernel repo so as to avoid implementing
> > > any regressions. As you are the one with the problem, you need to perform a
> > > bisection to discover which change to rtw88 introduces your difficulty!!
> > 
> > Somebody commented the DKMS-package for your rtw88-branch with
> > 
> > "Thank you so much for this ! After kernel 5.5, that's the only way i can
> > get functional wifi on my machine. (RTL8822BE) Deeply appreciate it."
> > 
> > So I assume I'm not the only one experiencing this issue.
> > 
> > But I can do a bisect if I find some time.
> > 
> > Regards
> > Bjoern
> > 
> > [1]https://aur.archlinux.org/packages/rtlwifi_new-rtw88-dkms/
> 
> -- 
> Bitte denken Sie an die Umwelt, bevor Sie diese E-Mail ausdrucken.

-- 
Bitte denken Sie an die Umwelt, bevor Sie diese E-Mail ausdrucken.
