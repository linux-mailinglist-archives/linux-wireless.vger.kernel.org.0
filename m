Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95BE574263
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2019 01:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388894AbfGXXzk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 19:55:40 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38629 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388437AbfGXXzk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 19:55:40 -0400
Received: by mail-lf1-f68.google.com with SMTP id h28so33121420lfj.5
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2019 16:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Wfk8aesSMyq3EkvW+x9kZOwpatIbXz/F4YcugXGab8=;
        b=IPxmEQrpl/0qpoqC7qmeMap6Fvz9YIN4VbKKC1BPYScJFeIL/U8QfqtmRyAwNAmD+g
         XrIR7V0uvThOd4W6Ok9nCAZjyUFbXQuWExw4MP6WZl5uAXIc52l3nlCqCiqHkq7hytJk
         /ilWkqayZ/K5vMKJrw+fu3F0KBJvFu8q5s29A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Wfk8aesSMyq3EkvW+x9kZOwpatIbXz/F4YcugXGab8=;
        b=K5a+W4JmhAwfMD17z9TmF8G8AfArM/SSZvSsVAHumcKS4IZL0uTvpHGjz5mgbs/bUM
         P/67u45FB/gx7pYeF7FA5k7W2bPaxnK47yIFOR+CkRM+nTQqptWiJ/VMB/cv0NDRlgKo
         jj6RFXgtIKvhgmGPXbFYqLz/ylRXnxb+ptdTAYZG2SAc9qi5agot5zVyuzssPR0xebQ9
         TLNCG1I3QNUnklBDsmIaY1suzr1xfOZo+jIljfSKbAY7FDFET8E4uynrHMvXErIcU0t6
         wuuGAt6rLPWf+udQ7DL4wFjznvkPRvEO2NXTK+S2OXsazPHWCy0Cehnfu1TblvGKZw6S
         HZLA==
X-Gm-Message-State: APjAAAWipDFXVzldmsQ+1Qmb3ds9O/0H7rtE1ehV26YVpIjDbsKnrUdc
        +SrvwPLQc37OuCj69hcLU4Zf1gLeKEs=
X-Google-Smtp-Source: APXvYqyDiw3tBvvgozyfJ/wwn3z32gVUKCQABsx95JuFu5ETOqaoOLFUrWcsaP/dRrlJXL2WUSMoOQ==
X-Received: by 2002:a19:7509:: with SMTP id y9mr39567890lfe.117.1564012537929;
        Wed, 24 Jul 2019 16:55:37 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id o17sm8837440ljg.71.2019.07.24.16.55.36
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 16:55:36 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id k18so46160045ljc.11
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2019 16:55:36 -0700 (PDT)
X-Received: by 2002:a2e:824f:: with SMTP id j15mr45258506ljh.117.1564012536432;
 Wed, 24 Jul 2019 16:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190703081049.28831-1-luca@coelho.fi> <1d7609a45e38725d57c2f78b5e437b83b7e49197.camel@coelho.fi>
 <87d0irqr2l.fsf@codeaurora.org>
In-Reply-To: <87d0irqr2l.fsf@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 24 Jul 2019 16:55:25 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPjLW+Zrf-uruCLMFGGDaJd=xYWt4tb=T_0HKP=ZnHbTQ@mail.gmail.com>
Message-ID: <CA+ASDXPjLW+Zrf-uruCLMFGGDaJd=xYWt4tb=T_0HKP=ZnHbTQ@mail.gmail.com>
Subject: Re: [PATCH for v5.2] iwlwifi: mvm: disable TX-AMSDU on older NICs
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Luca Coelho <luca@coelho.fi>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        johannes.hirte@datenkhaos.de, steven@uplinklabs.net,
        Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jul 3, 2019 at 4:46 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> Luca Coelho <luca@coelho.fi> writes:
> > Hi Dave,
> >
> > This is an important fix for a bug that has been reported by several
> > users in bugzilla (and elsewhere).  It fixes FW crashes that disrupt
> > throughput and connectivity in general in very popular devices (Intel's
> > WiFi 7000 and 8000 series).
> >
> > I know it's a bit late for v5.2, but if possible, it would be great to
> > take this.  Kalle is on vacation, so we agreed that I would send it
> > directly to you.
>
> Acked-by: Kalle Valo <kvalo@codeaurora.org>

5.2 has come and gone, and I believe Kalle has awoken from vacation.
Can we get this for 5.3?

Brian
