Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D86324185
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Feb 2021 17:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbhBXP7l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Feb 2021 10:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbhBXPsh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Feb 2021 10:48:37 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9585BC06178A
        for <linux-wireless@vger.kernel.org>; Wed, 24 Feb 2021 07:47:52 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id n14so2465741iog.3
        for <linux-wireless@vger.kernel.org>; Wed, 24 Feb 2021 07:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=OloZDzC+D3v75sqs6pQ7mQy0oX0oZe0/HD4XavOq9iQ=;
        b=CyvTluf2GrP0gEMKAjC8/qVZnEGp1VFIhoIQJebtZU15TeKyJxxShM98bycOirBouo
         qoSbpLDuj7OTbNp9YzBOrCT2cLQXOqR3jnjA+wQDrp7Q6X7xpUhMbpSjtx791mGUmVfT
         WqwA8e1LKMT0BaE/tDiBzuE3j+bjkQ7Cvn4oPuMRLzz6ZMUDLGoCKFsxwSshZ7La5Ahe
         1wZGrisvltuQcbCX5nf20QNzqcc3bZtftvPLCjLP7IE6tP83LOcp26eyXeQKcCWwFuVl
         2r1MVDs/Jp3XJL2u/53OSlMlOrgfUwgobYwGzLunvbTwbs079h2ULzmSOtSPM5uTZL8u
         qPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=OloZDzC+D3v75sqs6pQ7mQy0oX0oZe0/HD4XavOq9iQ=;
        b=ISXulqxnSAWJD6DIU/ghyJpTm0KukSAJ5VVj2rLyP5jPKOB5xXQ4d8NZkfw0p6LgXh
         nBYeCOUW+mBbKo9EBVqEumA1z5xjcbeoeLT2l5JwUuDLAg+PXFd/OpU0iC/H+ZjXP4PX
         ai92lvMCyPvh3LZ4DLU1cy9mLMETutL+6YcSoF7esFtNODy2Q0GztmjEX8Gq/A0QIzt6
         lYl6AJ64b0bQXiSh/Ad9T/mafkr72L/fANKEBo0ZnVYN6taNbB7+BHdupSxhBWsrE103
         bUQblVSkXG6bU6lc4tR/08bB9GAwrAH1DJYRBBFC921RYDYrw7NpfHTLSTmlS3kBQFUc
         NnVQ==
X-Gm-Message-State: AOAM533rP9veTR9iPsYTwP/kyQqV1NQ4fEBAjGDc/hE+wbjTth7R+oNq
        DUdGGtqCfc3HxQ0WtCkE6E3G
X-Google-Smtp-Source: ABdhPJxZwk6BHU3sIreZvbTotTEt5oCoiFlRJaeigqqlc85i2aZHvPmTb7Tt8uNoRegoWqxw/6t09Q==
X-Received: by 2002:a05:6602:26cb:: with SMTP id g11mr23737327ioo.180.1614181671994;
        Wed, 24 Feb 2021 07:47:51 -0800 (PST)
Received: from ?IPv6:2601:281:8300:4e0:15e9:5454:c5f7:acb0? ([2601:281:8300:4e0:15e9:5454:c5f7:acb0])
        by smtp.gmail.com with ESMTPSA id o8sm1711254ilu.55.2021.02.24.07.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 07:47:51 -0800 (PST)
Message-ID: <33012e779ee172e688cac2e710fa1ddab68fc611.camel@egauge.net>
Subject: Re: [PATCH 4/4] wilc1000: Add support for enabling CRC
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Ajay.Kathat@microchip.com, linux-wireless@vger.kernel.org
Cc:     Claudiu.Beznea@microchip.com
Date:   Wed, 24 Feb 2021 08:47:50 -0700
In-Reply-To: <a4261e8e-3693-2aa0-e23a-3bd3c6eb5686@microchip.com>
References: <20210224055135.1509200-1-davidm@egauge.net>
         <20210224055135.1509200-4-davidm@egauge.net>
         <a4261e8e-3693-2aa0-e23a-3bd3c6eb5686@microchip.com>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ajay,

On Wed, 2021-02-24 at 13:35 +0000, Ajay.Kathat@microchip.com wrote:
> 
> One more observation.
> I am not clear if the below block is really needed. Have you faced any
> issue here and did the below logic of skipping data helped to come out
> of it. Also checking the limit of 16384(2*8KB) byte looks odd when the
> max limit for data packet is around 8KB. Am I missing something here.
> 
> > +
> > +                               {
> > +                                       u8 byte;
> > +                                       int i;
> > +
> > +                                       for (i = 0; i < 16384; ++i) {
> > +                                               byte = 0;
> > +                                               wilc_spi_rx(wilc, &byte, 1);
> > +                                               if (!byte)
> > +                                                       break;
> > +                                       }
> > +                               }

Ouch, that's definitely not supposed to be there!  It's left-over debug
code from when I was tracking down the power-save issue.  Not sure how
I missed that.  Thanks for catching it and being so gentle about it! 

How do I fix this best?  Do I resend the entire patch series or is it
OK to create a V2 of just this last patch?


  --david


