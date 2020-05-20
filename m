Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308CC1DB0C4
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 12:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgETKzg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 06:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETKzg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 06:55:36 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B73C061A0E
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2020 03:55:35 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id 14so1077341uaq.11
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2020 03:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xogcsC1PDYO4tt9telvTYSybbsqc2itTHfyESpqeig=;
        b=NV4CkdgVaXrJLjR8P+H7JegAOVCNMkSGO7R8zGLSmZnkROfTDbpdfUl9d53F2BHrze
         z46QhhsTMkM7w20wIypW9Gp6ytmxiRE2Muh+mp/iRcFoPmadQEcWhH165UJHNESeveOq
         lqx8OikCS5bQEo1RjH9K9dUnTg9TPBTkBMYK7LOJhLPUhXxj+PRp4x+FqGX49Gm2uodS
         +D9heMnSIk/s7GGw2eGhkljFkvWBrY90FQk6v9WNRUkM0GR8u8Nuhlxq9HUVOmlXp7RZ
         2A6XG5MmN+bbQCog5C1rHLRYIVqqIYWnsUC8g9gbciIYBOtMlWfZQKjYIi58CpifS7Dl
         j78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xogcsC1PDYO4tt9telvTYSybbsqc2itTHfyESpqeig=;
        b=sd1tIXz2HPiBfJUBFHnqSsvuaa7XFTrv8kq3qRSzW9nr0K41UCjlOstk4siL5sQduV
         0cNmeJl+Yw8J/7kXmCHQT8fEqq1Cvg9qkfE31o+9Wd0eimu837SXsQ8AuHYp566+I6OU
         1uMsT+6m3f1HXEgJw44MNzhF/L/YSTnSuP//PA0YWvb2mfGSAnrDN4SXsSXF+1S2+Y3t
         FhlFaU1BcsL0tLX2RZQotF8R5O4BKUhcwjgaLMTBr9adJSlNyRSOYsW9IfcLz3egaHIA
         SLfFgCWyGbzxuBl20hFBFpJBsqIvIy7aUCg2rVupU+9NZ8q7Mcs/UG0yexWcAptrZZFx
         fGyA==
X-Gm-Message-State: AOAM531P3MEV7CimDjPq938IvvncfjcVQnWtxvp+iQVY/2OKBDlZiwlK
        zYpayS+fZ2zrF+CepdssOj3+QK3fRCrZMW23oQ==
X-Google-Smtp-Source: ABdhPJwoGuMRhXKfQOkJ0VxTVCDRDF7OkMT3j2YJ2zWa/XrsIusDgy4eUHRB5FQv+IJ3FkyMBz3Dg/6QESXgXteQweI=
X-Received: by 2002:ab0:268a:: with SMTP id t10mr2718952uao.20.1589972134999;
 Wed, 20 May 2020 03:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
 <3483242e-c2ad-ec83-0c2c-ce952bc9b638@lwfinger.net> <CALjTZvatxQ2BvUeZGcTFijBf1PiLizJuDdENxg2b=tPQL_NAzQ@mail.gmail.com>
 <CALjTZvYSJOx0xeMVkN6dHcGTdgW9O9NVbgXPKK4d6-31VX+0JQ@mail.gmail.com>
 <29f5e3de-a32c-6292-9197-19dcc57fa6a3@lwfinger.net> <CALjTZvaroTrgK9=W8uTwq9YcYayfuEU31BUc0qNYJr+08hevfg@mail.gmail.com>
In-Reply-To: <CALjTZvaroTrgK9=W8uTwq9YcYayfuEU31BUc0qNYJr+08hevfg@mail.gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 20 May 2020 11:55:24 +0100
Message-ID: <CALjTZvaPi2FL-epk-Vd2wOLye2O0J8G5aZPsqzHXt2b7u=HyuQ@mail.gmail.com>
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 20 May 2020 at 09:24, Rui Salvaterra <rsalvaterra@gmail.com> wrote:
>
> Hi, Larry,
>
> On Wed, 20 May 2020 at 01:16, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> >
> > It is necessary to load the driver with option nohwcrypt set to 1. I expect that
> > you probably did that, but I forgot to mention it.
>
> Yes, of course. I don't use modules, so I pass b43.nohwcrypt=1 in the
> kernel command line. I confirmed in sysfs the nohwcrypt parameter is
> correctly set to 1.
>
> > It would likely help if you can get verbose logs from wpa_supplicant.
>
> No problem! Attached is a wpa_supplicant -d log. Let me know if you
> need extra verbosity.
>
> Thanks,
> Rui

By the way, I just tested with WPA2 forcing MFP (pmf=3 in the Network
Manager connection) and it also doesn't connect.
