Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0781456407
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 21:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhKRU2W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 15:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhKRU2V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 15:28:21 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161C1C061748
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 12:25:21 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id m14so7183162pfc.9
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 12:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DmOUcqBTfTwJf0imYr9PhDvqApkQ9EskRtnB2cooYQk=;
        b=mmuEGToIWYQyDJXdvCkb5egnftKAdKxWHNnjluSOz1AYCDoHc7VhUgg5R56XDiAca+
         GbZdxV6Cm+i4feHYppaF6xnSDA+gSWG5XqPgJKzN/UWvg1OkTIEKx6hRmEg5QQMPp9KK
         GSnAHLJky368YvZRx5GkuKUnZ4OLMBKO4gKJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DmOUcqBTfTwJf0imYr9PhDvqApkQ9EskRtnB2cooYQk=;
        b=Q3reWd2nkKPmeYxvv2XmSrP64SWSaCqWrhZBkp0BJRsimZ6l8zhYHkLodhaIPQFYdf
         yd/3RaIGuRUssSvgYbDkp0Ok7w3mWDXRD0VFDvHjDxB8+uBm46QBwhTmjT5Y8iKCZdAH
         CQGQnS9GqRmwdLMyX+JrpYQDndpltMHZqPCAoq6mz0JdPPRGXBMe4s7wKKkJ495F83ZK
         B8loqdQw25Aor4TRtm+Ph37Yzuj2iDK8Z8wTIxFORXFotVuUQM15MeLVFzYvk6jn64ds
         2jWv9cbk2MMj3rcSSqqTdfMp2bvvUsDWYlxSBmcHQ7cvr6jWZ5CntisGqU1pmCu56nha
         t1ug==
X-Gm-Message-State: AOAM531nhSon1G7cVSjT7x4KeV16D7t+uOik5EJyFt3dFmt4pKo6C8qe
        GCuT3htKDqxJhQ9c9MSmEA5JmA==
X-Google-Smtp-Source: ABdhPJz8o7m8VkVNvWarBWqsLDSqI+0t1S2A22KnaRzhJK6QAcXNV7pv+4ZwjYk9dM90zC9JW/FDxA==
X-Received: by 2002:a63:30a:: with SMTP id 10mr12849060pgd.229.1637267120689;
        Thu, 18 Nov 2021 12:25:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q13sm485919pfj.26.2021.11.18.12.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 12:25:20 -0800 (PST)
Date:   Thu, 18 Nov 2021 12:25:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Jouni Malinen <j@w1.fi>, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] intersil: Use struct_group() for memcpy() region
Message-ID: <202111181224.088CD29@keescook>
References: <20211118184158.1284180-1-keescook@chromium.org>
 <c5d8c214b5df75b5b77450d71c7aec9f3bd97a67.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5d8c214b5df75b5b77450d71c7aec9f3bd97a67.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 18, 2021 at 08:46:11PM +0100, Johannes Berg wrote:
> On Thu, 2021-11-18 at 10:41 -0800, Kees Cook wrote:
> > 
> >  	/* 802.11 */
> > -	__le16 frame_control; /* parts not used */
> > -	__le16 duration_id;
> > -	u8 addr1[ETH_ALEN];
> > -	u8 addr2[ETH_ALEN]; /* filled by firmware */
> > -	u8 addr3[ETH_ALEN];
> > -	__le16 seq_ctrl; /* filled by firmware */
> > +	struct_group(frame,
> 
> Arguably, that should be 'header' rather than 'frame' :)

Works for me. :) I will rename it. Thanks!

-- 
Kees Cook
