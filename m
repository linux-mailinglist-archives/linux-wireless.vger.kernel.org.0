Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8579E315D0D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 03:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbhBJCQU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 21:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbhBJCPS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 21:15:18 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C755C06174A
        for <linux-wireless@vger.kernel.org>; Tue,  9 Feb 2021 18:14:33 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id i3so416170oif.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Feb 2021 18:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V90/hBn9j2Q6OSCWu59vY+j+BWO0HaCqBFyxV7f5dII=;
        b=Tbf0oBeJwlih3iqNECCosxvzK25+TpYEKq8jIhO3AsSoqlMdGRxAiX7VUDoWQ/F3ad
         oiUS959tMexEbBeVhisEZbZT1ELFlbjX4vwqHIFmhgH77fVBsxNiEGnyPN8vbn6sCwNF
         yWJXS394xwDsVolwIqM3yZeLMbOBwrtDpJXZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V90/hBn9j2Q6OSCWu59vY+j+BWO0HaCqBFyxV7f5dII=;
        b=npkwbOkliVQ7P5mPIF3RBRcO05qyFVKvD1ksi0H4HfWYzj8hocUftaH04FFj9kyoH6
         byLUYx9nuaKTT8C59UweSp94N0pBJpQTqZNy3lOGpQyzBOO5KNFJL+Ilqx8q7uVOSJWq
         rRgSXNZeIxolnP1uIhx3S6Hs5usBEY/NZtn6h/DscfR8R6uuvlMvoEJ9qEwzzRteWWjC
         AlnyWUOs/xQwJZ4tExsIWi+JABAcnIZOMweF2xupqcNhgSmYYQVA1Y6H7+ha1eSAtvKp
         QcyKtLHqYTkW0i22z6bwdJPu1elXuFkO9I2wH4xe/WxfT/q3lVfIjF1a/KY8y1lWaZWo
         gBlA==
X-Gm-Message-State: AOAM5328ZgkyiQAeXM2jnAdF5WGbFBc0Qz/KF0hols3oO21cJO4DU5jg
        Bg8qblEycLdO15Qr22bKegMt5Y8QKt0sag==
X-Google-Smtp-Source: ABdhPJy3HOovl79LBcuCt/I3kX05bL6k5c3VZRJ3mx76TGSbjZKgcXcI7gxomJArJdgt9otyBohvig==
X-Received: by 2002:aca:adce:: with SMTP id w197mr535195oie.103.1612923271578;
        Tue, 09 Feb 2021 18:14:31 -0800 (PST)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com. [209.85.167.174])
        by smtp.gmail.com with ESMTPSA id q2sm100737otc.28.2021.02.09.18.14.30
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 18:14:30 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id m7so363510oiw.12
        for <linux-wireless@vger.kernel.org>; Tue, 09 Feb 2021 18:14:30 -0800 (PST)
X-Received: by 2002:aca:43c3:: with SMTP id q186mr532173oia.77.1612923270018;
 Tue, 09 Feb 2021 18:14:30 -0800 (PST)
MIME-Version: 1.0
References: <1612839593-2308-1-git-send-email-wgong@codeaurora.org>
 <CA+ASDXN1V2HYA7C6s-q5bQNSxE7L5GCJiqfiJ_67R_hpUn4b_g@mail.gmail.com> <19b6ad684a01718c3823f882581fca36@codeaurora.org>
In-Reply-To: <19b6ad684a01718c3823f882581fca36@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 9 Feb 2021 18:14:18 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNYO+w254D2Uh3OSfTGjJEkbOCX=hq+XaWe9DtjbuOy3g@mail.gmail.com>
Message-ID: <CA+ASDXNYO+w254D2Uh3OSfTGjJEkbOCX=hq+XaWe9DtjbuOy3g@mail.gmail.com>
Subject: Re: [PATCH] ath10k: change len of trace_ath10k_log_dbg_dump for large
 buffer size
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Feb 9, 2021 at 6:12 PM Wen Gong <wgong@codeaurora.org> wrote:
> On 2021-02-10 03:35, Brian Norris wrote:
> so this patch is to dump the top 1024 bytes only,
> its 1st goal is make log smaller.

Agreed. I wasn't objecting to this patch. I just wanted to highlight
the second part should probably also be considered as not exclusively
an ath10k bug:

> its 2nd effect is fix the crash issue,

but I guess if you're not testing the latest upstream, it's a little
hard to tell for sure whether the crash still exist at all anyway...

Brian
