Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547CE253DEE
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 08:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgH0GgH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 02:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgH0GgE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 02:36:04 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5D8C061265
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 23:36:03 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w13so4186490wrk.5
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 23:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=akR5LsWB+L7ENwYAw9D4wcSK8jvQH6F09dbiIXvyFCk=;
        b=H8vbnYW/S+H7tZZYYO5Fs3PPBaCtYQdePiDEDqJOjsMv5DF6G2r7fYacs24CCUEaAt
         M3e1iWPRZPukneXLcYdSJGgvQQ826VwRp17Sv20+QJTNJvXWHfkZABR3zVA0DWOcTzdg
         WEgIW3cZElL+bglDngYnh1LuIaHi/EV/2I1iKVO3m3j4xIQwohTnASGkYv8BwxHFT6Tg
         htWl0SMTHiOOLoP79DFGPB7xALFkOssU25a1B7AThZesH2WFhTlnyAwyQG09UCxIlfQt
         dDsHe95PD32mdOGZohe5PKfcsO5FWScCiMzdkncTi71joxY8dybGZxXjcXIt1WNujlh7
         /dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=akR5LsWB+L7ENwYAw9D4wcSK8jvQH6F09dbiIXvyFCk=;
        b=DpfMFL+TAzf3WJcYjYgd1cbp9BZ858R3QctbtMe4VpS86NxSKj/ys91vu3x7dSfoDw
         fppJRpfqHD9ykoSJLEahk3zReoaB8nZNsnd5preobOq5WKb4srq7cjknQTUoAhUnQX0b
         fL10YOTa6Pr4JWkt456sr5FFRrJisjvjMpBY7e6Wvt7Uqan2IB8ti5MF3haZigHbk7K6
         m9CLEcUJT7rPOkj/LBHtivvFGgj+n5kMpM2RiHEXSrE6arRZAhOeyCFP8toWd2PqXBlE
         SZetIbrWe5sGHzBl0+QQecBa0tTu7PFK1QxTIB0tZqYHPcKqnjPlqNkJP0+8UHcxKZ+f
         dvvA==
X-Gm-Message-State: AOAM533P9QFVchrD+/QCSwfu5gLxub9YmDGkSa9ykh8tMLt+Zlk4p6/X
        Gl6KT/N53kdMyk8Vv9wzN0Elbw==
X-Google-Smtp-Source: ABdhPJyUoPKR71NVAZJhTV3U26Io2C1TwglVVoLwoSOZIX2rFDKJaRv5rbS/qFs4nDKGnwNHN81ydA==
X-Received: by 2002:a05:6000:1c7:: with SMTP id t7mr879463wrx.145.1598510162237;
        Wed, 26 Aug 2020 23:36:02 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id q11sm3530317wrw.61.2020.08.26.23.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 23:36:01 -0700 (PDT)
Date:   Thu, 27 Aug 2020 07:35:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Maya Erez <merez@codeaurora.org>, wil6210@qti.qualcomm.com
Subject: Re: [PATCH 12/30] wireless: ath: wil6210: wmi: Correct misnamed
 function parameter 'ptr_'
Message-ID: <20200827063559.GP3248864@dell>
References: <20200826093401.1458456-13-lee.jones@linaro.org>
 <20200826155625.A5A88C433A1@smtp.codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200826155625.A5A88C433A1@smtp.codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 26 Aug 2020, Kalle Valo wrote:

> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/net/wireless/ath/wil6210/wmi.c:279: warning: Function parameter or member 'ptr_' not described in 'wmi_buffer_block'
> >  drivers/net/wireless/ath/wil6210/wmi.c:279: warning: Excess function parameter 'ptr' description in 'wmi_buffer_block'
> > 
> > Cc: Maya Erez <merez@codeaurora.org>
> > Cc: Kalle Valo <kvalo@codeaurora.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: linux-wireless@vger.kernel.org
> > Cc: wil6210@qti.qualcomm.com
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Failed to apply:
> 
> error: patch failed: drivers/net/wireless/ath/wil6210/wmi.c:266
> error: drivers/net/wireless/ath/wil6210/wmi.c: patch does not apply
> stg import: Diff does not apply cleanly
> 
> Patch set to Changes Requested.

Are you applying them in order?

It may be affected by:

 wireless: ath: wil6210: wmi: Fix formatting and demote non-conforming function headers

I'll also rebase onto the latest -next and resubmit.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
