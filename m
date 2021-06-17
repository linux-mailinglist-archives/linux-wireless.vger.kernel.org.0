Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7CE3ABCC3
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 21:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhFQTcV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 15:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhFQTcT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 15:32:19 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA35C061768
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 12:30:10 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m15-20020a17090a5a4fb029016f385ffad0so1640693pji.0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 12:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hrorq9wqViQmhGOFFkZLIlBQLP9XRCmNAgszGBG5cNM=;
        b=UjhBFmj53egtMyJ00ZkClVrgAfvnWzTHeO08/1NVtWDVFp8yUJq6gbvTejf1cL8coa
         ObV+c50VD3mJAHyHt3uHFnS5r9Zpd7tJaP8Te3HYKJ3f9URNkPVzJ2Uq6wIJFO3kCGKR
         m4ob7/oHFin0TmKke8zNIXawcadc37nU0tdnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hrorq9wqViQmhGOFFkZLIlBQLP9XRCmNAgszGBG5cNM=;
        b=R3PTsw5dkvutBw1qpiCQ2hCHgwUe9iFq37lGYxcBc20OGO/vX1+mqrPfSUk0ib9ixZ
         xOyMQgs15qFQProtlL3ilSetYubEISt71mKfth1LGBQ/KbqA55Q4e1HCkegXUchPTMnc
         jWBholrp4b7GeYDgOSbSxFgqNuZB2VNlHuCy0+mT46NOMzAKqzglj1J0rBR4lcS+HARz
         jLSGBTHJNKmRf5p1tOx9N/5NKdcGCfaQl+YOgoeAvO+c6fW4Q3GUHufBMub5kDy584M3
         C2Zi5Ke9v0SJP+rQlhPcgcyPgef7zqA7oNg7uKQgH59KnlCuTRFYdAmUiaYbqNjGevde
         0VOA==
X-Gm-Message-State: AOAM530xdFY+PXzECPynI/va90NAgdEMaun37s+1CNcCBZkcCv1yZVkW
        wgLsD8j0s/acoI9Py0+SOpc9zw==
X-Google-Smtp-Source: ABdhPJwtWc5aurHGuviL31BSdk7TdiEElg8wfkdeWP/DnCBN+SPkw5EaYw3o2oW7ePgTHEHPnG8XEg==
X-Received: by 2002:a17:90a:9f81:: with SMTP id o1mr17428279pjp.96.1623958209933;
        Thu, 17 Jun 2021 12:30:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t12sm6112590pfc.133.2021.06.17.12.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 12:30:09 -0700 (PDT)
Date:   Thu, 17 Jun 2021 12:30:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     netdev@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mac80211: Recast pointer for trailing memcpy()
Message-ID: <202106171229.824139CA76@keescook>
References: <20210617042709.2170111-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617042709.2170111-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jun 16, 2021 at 09:27:09PM -0700, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally writing across neighboring array fields.
> 
> Give memcpy() a specific source pointer type so it can correctly
> calculate the bounds of the copy.

Hmpf, please ignore this patch; sorry for the noise. This fix got
mis-tested on my end and does not solve the problem I was trying to solve.
I will return with a v2. :)

-- 
Kees Cook
