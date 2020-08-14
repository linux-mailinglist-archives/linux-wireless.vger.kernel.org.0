Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0A9244CD8
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 18:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgHNQkw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 12:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgHNQku (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 12:40:50 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4019C061385
        for <linux-wireless@vger.kernel.org>; Fri, 14 Aug 2020 09:40:49 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c80so7992304wme.0
        for <linux-wireless@vger.kernel.org>; Fri, 14 Aug 2020 09:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=C0VMfkRWA8AVEJH0W35su4CS32q6ZmoTQPUzDqNON/Q=;
        b=Hp2szV86GPRdWh24sdQj6GUdqhaQ1TAqh4R2Im75U8JCfrBE71+991QL/Rzg33fCx5
         oddn1aoEU5jkfCh6fKXF+J635sKxKyXNBntwcDkvwQJ7eCzYddqF24Nomn4vVjV+PL4/
         8urCVXdG3m38kdamxccY5JQsUFiJSKLPzF3EAydu+BfxtbplzTautPE9qd755XhsZli+
         m8NEKSrWPHLC9GbuGm7vXg8R9guvAqTZg7QZp9pO29g4opyyhxeJP+kqKcd0OdZmcIsu
         cFGNjvfHuwZAbhCmI12T+/urrxQxBT4OUb3DYF57EuWrQjkDOqBDnVrQoXr68hbupC6Q
         5rCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=C0VMfkRWA8AVEJH0W35su4CS32q6ZmoTQPUzDqNON/Q=;
        b=MB2H2alxnEwkXJ33I12dJ/yH46dkbHf9V5YUoiKXNLWWehyaJrTEOQRrHFMmzwV/yF
         kat+xnYJaeA591N9s4V8bmJVhy+oEyPV1jYhlUvl6MoH1w8F8hM/4NZj0EYmCkeCnpN9
         xjP2YGdN62cwbBMhs/zfucZzXXQ+cIv4hqzyjSAqB8UhuTkyO0b2EIR5ccUbGXBY7TOR
         oQnNQFe3jL6ER+uEI89/utICLjqO82pVKbA1Mdiy1ZGROD5aL5Q9wKRz5XSb2UnXORsq
         /UA5hVx4bq2fLFphnvsE+4YtArnSlohtqmNo4iJZf6nMiHIF15APFhYasGy/rb9ltABy
         I3Ig==
X-Gm-Message-State: AOAM5336iwwzudvFda1kCY8TOGykM/R/lE82dlhCW1zw4nZtYwXDIwub
        TmJUi/5hVE3gKUkkgFWcj2lb5Q==
X-Google-Smtp-Source: ABdhPJz0626RiN8pqrM5vG3scAtzKYW2Er/MxO4P2GlIrSH0O8ldy/hocYvhf1OzYi6rXeAv0HZ6Yw==
X-Received: by 2002:a1c:7f4e:: with SMTP id a75mr3142516wmd.62.1597423248697;
        Fri, 14 Aug 2020 09:40:48 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c4sm16458313wrt.41.2020.08.14.09.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 09:40:48 -0700 (PDT)
Date:   Fri, 14 Aug 2020 17:40:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        Christian Lamparter <chunkeey@googlemail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 08/30] net: wireless: ath: carl9170: Mark 'ar9170_qmap'
 as __maybe_unused
Message-ID: <20200814164046.GO4354@dell>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
 <20200814113933.1903438-9-lee.jones@linaro.org>
 <7ef231f2-e6d3-904f-dc3a-7ef82beda6ef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ef231f2-e6d3-904f-dc3a-7ef82beda6ef@gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 14 Aug 2020, Christian Lamparter wrote:

> On 2020-08-14 13:39, Lee Jones wrote:
> > 'ar9170_qmap' is used in some source files which include carl9170.h,
> > but not all of them.  Mark it as __maybe_unused to show that this is
> > not only okay, it's expected.
> > 
> > Fixes the following W=1 kernel build warning(s)
> 
> Is this W=1 really a "must" requirement? I find it strange having

Clean W=1 warnings is the dream, yes.

I would have thought most Maintainers would be on-board with this.

The ones I've worked with thus far have certainly been thankful.  Many
had this on their own TODO lists.

> __maybe_unused in header files as this "suggests" that the
> definition is redundant.

Not true.

If it were redundant then we would remove the line entirely.

> >   from drivers/net/wireless/ath/carl9170/carl9170.h:57,
> >   In file included from drivers/net/wireless/ath/carl9170/carl9170.h:57,
> >   drivers/net/wireless/ath/carl9170/carl9170.h:71:17: warning: ‘ar9170_qmap’ defined but not used [-Wunused-const-variable=]
> > 
> > Cc: Christian Lamparter <chunkeey@googlemail.com>
> > Cc: Kalle Valo <kvalo@codeaurora.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Cc: linux-wireless@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >   drivers/net/wireless/ath/carl9170/carl9170.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/ath/carl9170/carl9170.h b/drivers/net/wireless/ath/carl9170/carl9170.h
> > index 237d0cda1bcb0..9d86253081bce 100644
> > --- a/drivers/net/wireless/ath/carl9170/carl9170.h
> > +++ b/drivers/net/wireless/ath/carl9170/carl9170.h
> > @@ -68,7 +68,7 @@
> >   #define PAYLOAD_MAX	(CARL9170_MAX_CMD_LEN / 4 - 1)
> > -static const u8 ar9170_qmap[__AR9170_NUM_TXQ] = { 3, 2, 1, 0 };
> > +static const u8 __maybe_unused ar9170_qmap[__AR9170_NUM_TXQ] = { 3, 2, 1, 0 };
> >   #define CARL9170_MAX_RX_BUFFER_SIZE		8192
> > 
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
