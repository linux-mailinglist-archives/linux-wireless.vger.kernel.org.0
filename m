Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 190B0199FF1
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2020 22:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgCaU36 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Mar 2020 16:29:58 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:32775 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgCaU36 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Mar 2020 16:29:58 -0400
Received: by mail-ua1-f68.google.com with SMTP id v24so8232974uak.0
        for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2020 13:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJIrV8WSBPS4i99bnQZVAckbKhr6mR/e6J29lAGvlwE=;
        b=AiT5iySlxsxU0uRrDsJ9zoRfaQvLuzBVU5vVVWfsUhqsFgEPiv+uKb5SW1JgNl2Kks
         G4IbHd4Jf5+bexrza3ifYcMZlMw1GAlifN2Qim7Z3a0UkxFvGgEInrI0Ukru4/dCVh43
         c/smt1FUUTSmypVRG3myyvOlCE5lDsnq6/00UyszT9GVlN2RLt75jf4PIJX8Ap0nSQbz
         vKI5XTHZGseArYLOumLzBTsF1zlcXlLTju+0tPNiLhwfTZBsXA7DFPaXlMHOPlZFKeT+
         4vun/LnlNxXDSNvFgHpKQwYB1boIHn2qtsGj6+ngTndhsBmP9pVp3wd9+Q5HqYsOORhE
         T8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJIrV8WSBPS4i99bnQZVAckbKhr6mR/e6J29lAGvlwE=;
        b=qg0ayig2wkDhexEfn+2TuwLx6cryxwvg5Rn/sc8i2H0+VHXxFVGRWMmVBtWsllp3gv
         sxAFWA9wgYQw80duRgMWT4y5n4A46zSaBjNBc+OLbJQ30obxWlRMpEpxvFwocLM5JvH3
         E4Ysqs1K/HdOGfNysvy8sMIDsrvm5tU4abUxoN/HZOMkwAYGvqgNBlvluOqjfwoV2eUL
         sg5MiOd+9Hq0Y4rqt0yFcxzFfOWArjK4dgm9pp3I38MmJk+yyBUvcuQbIYCdvdTmwlND
         N9HYE8RhKdhkI/I+68NettJ5D7SkxqsUHmibR7/24e0zwqWoXMwKaGi3Rc8KXyY7ZXe6
         JJnw==
X-Gm-Message-State: AGi0PuaYvPXx0sUc8tTmq5LX+4QLxa1+WVL3QFk65QmRq+9FXsrLl89k
        35yDf3XwFG071rc0jtwSGJcKguQK/uH9UmZAD6s=
X-Google-Smtp-Source: APiQypK4YZt6nBo7u8vQQvoSZ7WS0Nns05bfpQxIDYrrmIMRmETyWzRai7QsBAb+N1YCHs5NCz8NhatIcSgviPFuqt0=
X-Received: by 2002:ab0:6796:: with SMTP id v22mr13022781uar.41.1585686597404;
 Tue, 31 Mar 2020 13:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <iwlwifi.20200318081237.46db40617cc6.Id5cf852ec8c5dbf20ba86bad7b165a0c828f8b2e@changeid>
 <20200323163858.A1183C44788@smtp.codeaurora.org> <CAMP44s0xmss2sOpJ7e-Vx-bq8mx+Q+pO3B-SDaaST_iEPOM_3g@mail.gmail.com>
 <87ftds1v7s.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87ftds1v7s.fsf@kamboji.qca.qualcomm.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 31 Mar 2020 14:29:45 -0600
Message-ID: <CAMP44s3=+81syF=PgrYjK4a3xucyg-=+5ZhbqLDnQcHNZwDQEQ@mail.gmail.com>
Subject: Re: [PATCH v5.6] iwlwifi: don't send GEO_TX_POWER_LIMIT if no wgds table
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Luca Coelho <luca@coelho.fi>,
        linux-wireless Mailing List <linux-wireless@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan McDowell <noodles@earth.li>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Mar 28, 2020 at 7:10 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:

> > This should be applied to the stable tree, shouldn't it? 5.5 stable
> > releases have this issue.
>
> It's now in Linus' tree so I think you can just send a mail to the
> stable team and they will queue it.

Ok. Done.

-- 
Felipe Contreras
