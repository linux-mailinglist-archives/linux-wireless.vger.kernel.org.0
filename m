Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54ED4245F0A
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Aug 2020 10:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgHQIQg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Aug 2020 04:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgHQIQf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Aug 2020 04:16:35 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895BFC061389
        for <linux-wireless@vger.kernel.org>; Mon, 17 Aug 2020 01:16:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c15so13995931wrs.11
        for <linux-wireless@vger.kernel.org>; Mon, 17 Aug 2020 01:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=v0v5oAhK9ZVu7ovOwqOvE+wqvWkBm0oVu1Bsq+aOlJ8=;
        b=U1X/n6Y2nOB/AkHYnuRono0OIPa1lG/Ad9wHL9UMl7ZDeL7MlXjj0WQupSbF4F1Orr
         9KBe0QHHmSQKzSWv4rczHjO+sx+LUBChDEI00ECHcWZU99YOh25Uww+6sbhCw6gkv6pS
         HV/nSbSLOCEcuhojJ63oc3/H3cKQVBBC+VKsL5SkIEkusvRZ7C+V46DNqAzmUbaDIPYg
         a0Kq4xxPlX0ChcJ8w3voY6XCREmJUDZTyxZKS6f6wAdw7P9edycL4GBIBTodJiJPt0ZG
         /3QO2ipKPvvcnu1Twa6wtlu8PkCLb/RqVdylG3qmE065qvyqmKMnN/QzKkkgCSwpAwdy
         AOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=v0v5oAhK9ZVu7ovOwqOvE+wqvWkBm0oVu1Bsq+aOlJ8=;
        b=A3LGqntKFj5iJLlNVeIPZpdIwKv+USXppY3/ylwa8KqCpwkl7OfuZ+Tzu64yPgilx3
         0WDgBrfoFRJUP4rYcseQ71LmVQmGsqYQfui5hZTAHjtn36C7nTMUOmSAkkcfKk/CivBt
         hRz/tq9whamTBdS35m2W9vn2g9USiNaRGpaESMIkJ4XSXYgAqU6D/joFcYHeIx6ekKqu
         OwhNCG+QF4c9rzPOGxP13bdq3OEnIyb6EuKGbkJZw3KaIDakT1ag707pxrk4S0PAheNf
         BRsg8ewIdvnyXlmjQ5tWedKydt69kumGjmk5fRX0rRkZEc33a0jgKrOnXPMmbeuxi/67
         yICg==
X-Gm-Message-State: AOAM532V3hryiSIqtLRmfXGC0an8NlSuC/t/0nmoq0kyF/dn1t2qBS2+
        qvBdK5r0SMuzVpEsMrgWWcJIPA==
X-Google-Smtp-Source: ABdhPJy/BLnuS3vaKXKzvZ3zU4W6SNGjZlok/pABOU9qDhMciYnLzr/yhSQSUi1OrOkOtS/Ig/+orw==
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr13989325wrn.110.1597652193175;
        Mon, 17 Aug 2020 01:16:33 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id p25sm28081510wma.39.2020.08.17.01.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:16:32 -0700 (PDT)
Date:   Mon, 17 Aug 2020 09:16:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 00/30] Rid W=1 warnings in Networking
Message-ID: <20200817081630.GR4354@dell>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
 <87eeo88pdr.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eeo88pdr.fsf@tynnyri.adurom.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 15 Aug 2020, Kalle Valo wrote:

> + linux-wireless
> 
> Lee Jones <lee.jones@linaro.org> writes:
> 
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> >
> > There are quite a few W=1 warnings in the Networking code.  My
> > plan is to work through all of them over the next few weeks.
> > Hopefully it won't be too long before drivers/net builds clean
> > with W=1 enabled.
> 
> In the future please send wireless patches in a separate patchset and cc
> linux-wireless. That way it's easier for me and Dave.

Oh, I see.  I didn't realise it was maintained as it's own entity.

Will keep the separate in the future, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
