Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4902D4C19
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 21:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbgLIUlZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 15:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729913AbgLIUlQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 15:41:16 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972E5C06179C;
        Wed,  9 Dec 2020 12:40:36 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id g18so2040182pgk.1;
        Wed, 09 Dec 2020 12:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QK1hbN/x6fHfoT7P0QBbiUi8YpLa9I+Z4XNUZsBJ5YU=;
        b=ggB7vPJ1H3MWZw3bysk5lptIXFrm21OF7KXzDs26iGhfqrMEMr+urWGxLHcGQDk+f0
         lZHJ3+UPUnQ1eWr7Mp9q6qOhSeMeDX47H7T+U5hn58qYa9BIVBRWDaqv4i6+B9vugMRq
         3KKAIkLNUMcYfhIRGiL4NXI87+NlawShDg/Xm+UOE7ST1tf+f2uIuGFeJyB8n6f4sr2v
         L1/620TiIrhgQIQzGMvJuzbj+LbQqwEFwEQ+V0hbAQ3lDZBtAG71mroqxY0XUb14AhSF
         3Kn4nSwy/jWEqtNBePq92EyL8abXCuSL3w1pVNkmHXOyOK5jTDi1lxOl61EJ+My1olqM
         Dh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QK1hbN/x6fHfoT7P0QBbiUi8YpLa9I+Z4XNUZsBJ5YU=;
        b=PpEhSNywuuE3ackJMNDX9KJIjc0Mu3Iye/X1dgC+cFsq6XPsq578tIugMoJP3u0VuS
         groHJE87ZnOq+4gefFZAd8lq0jlhXtUueAjBPuNyV08PHZ3Q0xx9HHjopwWjpS9VC3O6
         9TnXx5n0h2mnTcI0J/b8p10O1r/dsHjxvX1H3tehRI0eND4Ev1DC13N8NADgjXm87ecr
         WyLNvpNNiwn3EqIzycOC5KVToQw9pKqHRzSPCH3o3CpdUNodpQNlVQwYodYXy8VdMQJ+
         i8yHcMiB+BDwgbvNVsxJ438zkJmPrnS4taMOm2oHSzLjeoJr3oHOh9Mr4M86WynRu80D
         YNPw==
X-Gm-Message-State: AOAM5300lu+KxM/F/VA9CP6iEXFV7f6+C7cAXm+63iQIfkPSiEZYaDmc
        OgUSNQUZFZsrqM269gqxOr5ILvmYeEhM8wx2Jw==
X-Google-Smtp-Source: ABdhPJwHfJ6LlFkTcKNTLa+XahMLkWlQu5Vejs+a1LK4YRuVLvSfU225+vfvYwZXUCwN3CFdfxB0ktNfcCppcXjRY5c=
X-Received: by 2002:a17:90b:215:: with SMTP id fy21mr3834803pjb.227.1607546436161;
 Wed, 09 Dec 2020 12:40:36 -0800 (PST)
MIME-Version: 1.0
References: <CALjTZvZZZVqnoV4YFTDHogVHv77=dKfcSSBGj1zC83zpUid9+g@mail.gmail.com>
 <4eb99a1da6342999c4dca355533a0847d0e942a5.camel@intel.com>
 <CALjTZvYwccfOVTTGNo1=oLnwXG2b9Vz1nVZuvLKFV94+3fQ6EQ@mail.gmail.com>
 <20201209091315.2c55e1c6@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com> <CANUX_P1=yuPkK5BzJ99oniMiCgB0z98yNYUSw4_qk2Vg7ucoRQ@mail.gmail.com>
In-Reply-To: <CANUX_P1=yuPkK5BzJ99oniMiCgB0z98yNYUSw4_qk2Vg7ucoRQ@mail.gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 9 Dec 2020 20:40:23 +0000
Message-ID: <CALjTZvYZEbgfLEzxQdafJT6CFz76prA4+YM2EGA8k5Dgn3gigw@mail.gmail.com>
Subject: Re: [BUG] iwlwifi: card unusable after firmware crash
To:     Emmanuel Grumbach <egrumbach@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        "Goodstein, Mordechay" <mordechay.goodstein@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, Emmanuel,

On Wed, 9 Dec 2020 at 20:32, Emmanuel Grumbach <egrumbach@gmail.com> wrote:
>
> Rui, I looked at the register dump and looks like you're using AMT on
> your system?
> Can you confirm?

AMT? You mean Intel Active Management? Heavens, no, not that I know
of! This is a personal laptop (Lenovo B51-80). (And I'd personally
kill the ME with fire, if I could.)

Thanks,
Rui
