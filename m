Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A41758AE39
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Aug 2022 18:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbiHEQfR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Aug 2022 12:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiHEQfQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Aug 2022 12:35:16 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E140B71
        for <linux-wireless@vger.kernel.org>; Fri,  5 Aug 2022 09:35:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kb8so5964459ejc.4
        for <linux-wireless@vger.kernel.org>; Fri, 05 Aug 2022 09:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=YULM/X0a99ROrDBU1vlbZtwnzv+PMxw5j/XQy+3G098=;
        b=DH58QeOUomO8H1sFAsPR3cGvtRWtC06FLuWlRRXvEiqMoVZWUsHdyR+bAqaBgk05qh
         3SBQ7fO6ASqZU+ODlaY5mLk6LbD+3R/vt9oxMTRIuk6TGBGAX/UewmvRIIufU5fQmQJt
         3OayP7gxpm9Js+yr6ThSM6A3fGcqxNz1GHQfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YULM/X0a99ROrDBU1vlbZtwnzv+PMxw5j/XQy+3G098=;
        b=AtJxft7+TcaqliO6I8dd0zqm124o8t4lDmyCJaLtVcZ2EgzM/Rh1Y5bqwROn/EhJ5k
         bbfInUGYnQ8IQRu9hM2eQSUPWqfX3/mRlb9T3rjlr2armGAk7242Gi2eo9P4HgwAoYPR
         gleaZUrV51dWdk5gGlbvEDGF4rDtRo+EF/27q8ibNXoVkwSrVvMWdSfO7DWO9KzvY49A
         5wCCYRR7jRV/Lt/JQ0D+RFuaMoTzn+tnNQpk6yVu1pK6olzERLg7YmQjaiWEQIgLuaX4
         xsM3EKl7BhQSM4EtwbWZbYuEzba35cB2CRxL9OgUrxprP1OyJDqdYip7t0su1iNurl18
         CTRQ==
X-Gm-Message-State: ACgBeo2T8+5vSZz9yJxsOApObHLPnfD0qmfBzA9cxHtrTrZ3eF/PY+k8
        VycjuS0cxsyGHvRqUHa0a8SeQDK9KqN9imyG
X-Google-Smtp-Source: AA6agR6JRySl06pE0s9P5FSKTQ3RE0b/XNoGuDX+sX56zaLPzl3CMOhsoHGY/bVxs+zea+dT2JZTLQ==
X-Received: by 2002:a17:907:969f:b0:730:df57:123d with SMTP id hd31-20020a170907969f00b00730df57123dmr4619185ejc.430.1659717312663;
        Fri, 05 Aug 2022 09:35:12 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id d25-20020aa7d699000000b0043cedad30a5sm135495edr.21.2022.08.05.09.35.11
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 09:35:11 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id l4so3787392wrm.13
        for <linux-wireless@vger.kernel.org>; Fri, 05 Aug 2022 09:35:11 -0700 (PDT)
X-Received: by 2002:a5d:56cf:0:b0:21e:ce64:afe7 with SMTP id
 m15-20020a5d56cf000000b0021ece64afe7mr4740434wrw.281.1659717310912; Fri, 05
 Aug 2022 09:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220803101438.24327-1-pabeni@redhat.com> <CAHk-=wjhSSHM+ESVnchxazGx4Vi0fEfmHpwYxE45JZDSC8SUAQ@mail.gmail.com>
 <87les4id7b.fsf@kernel.org> <877d3mixdh.fsf@kernel.org>
In-Reply-To: <877d3mixdh.fsf@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Aug 2022 09:34:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiW62CSONUNdpPcohmnTOtF_Fa4tSrz-H+pqE3VmpuARA@mail.gmail.com>
Message-ID: <CAHk-=wiW62CSONUNdpPcohmnTOtF_Fa4tSrz-H+pqE3VmpuARA@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for 6.0
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arend van Spriel <aspriel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 5, 2022 at 7:22 AM Kalle Valo <kvalo@kernel.org> wrote:
>
> Linus, do you want to take that directly or should I take it to wireless
> tree? I assume with the latter you would then get it by the end of next
> week.

This isn't holding anything up on my side for the merge window - it's
just a warning, and the machine works fine.

So there's little reason to bypass the normal channels, and getting it
to me by next week is fine.

                   Linus
