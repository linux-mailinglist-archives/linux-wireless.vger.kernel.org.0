Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4868031FD70
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Feb 2021 17:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhBSQzV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Feb 2021 11:55:21 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34652 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhBSQzT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Feb 2021 11:55:19 -0500
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by linux.microsoft.com (Postfix) with ESMTPSA id 94F0120B6C40
        for <linux-wireless@vger.kernel.org>; Fri, 19 Feb 2021 08:54:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 94F0120B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613753678;
        bh=XlXQPkEP8BxlCQPNS1+CSw7BrL2WwrsNq3SitkMgg8A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ihwfuQd9DjvItVO9ZHDevE4tsTYN/9cWCdEZWcWm/sS+WRtN6FmeNZSbPG7Evd34y
         AhnYTItXKoG9uovTuUjrK6/EzsnlicMiNm92b7BaSVhv01vmIVz6uN6B5fzEjFibU/
         2D7WE3/Wc5O7LeuVQ63nj3go8SSRHhNuAGq9evsQ=
Received: by mail-pg1-f169.google.com with SMTP id p21so4902234pgl.12
        for <linux-wireless@vger.kernel.org>; Fri, 19 Feb 2021 08:54:38 -0800 (PST)
X-Gm-Message-State: AOAM533zSlpFqEKTP4VkL3Qy4ns14sol0dlxNft+poSZY4Y+lDRQnK0T
        lOIOoJNGVI8FHHIVXc2zm22JeScHtoZg5bHJ5N8=
X-Google-Smtp-Source: ABdhPJynz8zDt6RUkDIV/GZnE9mLu/bJF34+anzY3585ZOiXcgyOoFK112trHfYtwV54Sljl+zYalv1OrjpZ6w9wuIg=
X-Received: by 2002:a63:686:: with SMTP id 128mr9213088pgg.421.1613753678187;
 Fri, 19 Feb 2021 08:54:38 -0800 (PST)
MIME-Version: 1.0
References: <20210208113356.4105-1-mcroce@linux.microsoft.com>
In-Reply-To: <20210208113356.4105-1-mcroce@linux.microsoft.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Fri, 19 Feb 2021 17:54:02 +0100
X-Gmail-Original-Message-ID: <CAFnufp0ypkeR65sRCPUo-08aHxift9siw5+kd1=s0xFfdi2L2w@mail.gmail.com>
Message-ID: <CAFnufp0ypkeR65sRCPUo-08aHxift9siw5+kd1=s0xFfdi2L2w@mail.gmail.com>
Subject: Re: [PATCH RESEND mac80211-next] cfg80211: remove unused callback
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Feb 8, 2021 at 12:34 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> From: Matteo Croce <mcroce@microsoft.com>
>
> The ieee80211 class registers a callback which actually does nothing.
> Given that the callback is optional, and all its accesses are protected
> by a NULL check, remove it entirely.
>
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> ---

Hi,

Quick follow up, did anybody look at this?

Cheers,
-- 
per aspera ad upstream
