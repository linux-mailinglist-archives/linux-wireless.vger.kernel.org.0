Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF76797B06
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Sep 2023 20:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240844AbjIGSAW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 14:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbjIGSAV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 14:00:21 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B4010FB
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 10:59:55 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31f71b25a99so756901f8f.2
        for <linux-wireless@vger.kernel.org>; Thu, 07 Sep 2023 10:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694109586; x=1694714386; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aE7vJQ21e8Yb5nhmBCR4D+bvKfnELhlwtCmehPemd6k=;
        b=EMD6Bv6lgXEpJCVFEw0jwqGBAg4XSENezmcj2KGZ2856jVJQ67gEYZsuKvsppelfJZ
         ENgGheGsdGukqqDKf+elt7AxElReG+G1MJljL+6dbAp5lziz7e484wufBAt3DvcS4WUb
         X9NZvlTrTQm1aO0uZR7SdISMKSS06RfE6Dh7jRu+6ipVcNg/JSDcIMT68Tw6rslADRMe
         BPP6+kPpYYhV9p0OsQWRd38P1OXWFEMI2dQ3gL4KVDuDti2Ml3oEP326QwkDsiFUOz4F
         Luk7gjPgconr2EWzrmY+XwG2ue8Da5nUKyRjnDJfNGrRzdQTFLtV0ZQX7FyiQQi9Dn5Q
         qs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694109586; x=1694714386;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aE7vJQ21e8Yb5nhmBCR4D+bvKfnELhlwtCmehPemd6k=;
        b=dEDAgdvZKpnWKZ7ICsS5zQ4z8n+pWsjUWsOU0wEV2P+GqqkaDXakRKCDIdTX2IM59H
         feGqbXHPw4/7N4jR+Ki0+s92iJzdCEhiNwgFueQufimb50YoG52NR9Vh8zGRprGi4pqw
         C1IpmkU1/tLsU8GUl1iSkMOf/7jjRCWfZYVX+BRR7o6FR81WzMr3fy2Z9kGrLVPE7LVy
         RPQPLsF+dtpDema2hW8ie/r9VxXPbEH8GHEZyRXJfMcib2Fs7IlKpgvXZQFUpCCtseis
         meC8QUUu35tIjG5vIrQ8AFixKyGwW6ujhdLQinVCjU0G2S5pvwZc+e8ns2Yb5Fyu+U1g
         83nw==
X-Gm-Message-State: AOJu0YweGq8esID0pf2koJ/sBZv+AU5076v1DJhBDzGlKk/CRgltRIWq
        LofjM/y8JVhkCN7Io4WfCNYExclnd5qQIqDGgGc=
X-Google-Smtp-Source: AGHT+IGQPcYGYPVwLKav68vZ77AytVa8Y+KuNIGyLdm9jK0D3P5KS5nbDeYyCDqnJCAVNeCyjjOSdA==
X-Received: by 2002:a05:600c:3b9b:b0:400:57d1:491b with SMTP id n27-20020a05600c3b9b00b0040057d1491bmr4554264wms.2.1694084544881;
        Thu, 07 Sep 2023 04:02:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l4-20020adffe84000000b003176eab8868sm23062193wrr.82.2023.09.07.04.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 04:02:24 -0700 (PDT)
Date:   Thu, 7 Sep 2023 14:02:21 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, Kalle Valo <kvalo@kernel.org>,
        Sujith Manoharan <c_manoha@qca.qualcomm.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        hust-os-kernel-patches@googlegroups.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ath9k: fix null-ptr-deref in ath_chanctx_event
Message-ID: <7a766c54-ec81-4ee2-8904-66adebd31b84@kadam.mountain>
References: <20230901080701.1705649-1-dzm91@hust.edu.cn>
 <87y1hqtbtu.fsf@toke.dk>
 <317b9482-d750-9093-e891-21f73feeac0c@hust.edu.cn>
 <87il8uta8f.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87il8uta8f.fsf@toke.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Sep 01, 2023 at 01:16:00PM +0200, 'Toke Høiland-Jørgensen' via HUST OS Kernel Contribution wrote:
> > Before sending this patch, I searched in the code, there are many call 
> > sites of ath_chanctx_event with argument vif as NULL.
> >
> > Functions calling this function: ath_chanctx_event
> >
> >    File      Function                   Line
> > 0 beacon.c  ath9k_beacon_tasklet        459 ath_chanctx_event(sc, vif, 
> > ATH_CHANCTX_EVENT_BEACON_PREPARE);
> 
> But only this one has ATH_CHANCTX_EVENT_BEACON_PREPARE as an argument,
> which is required to hit the code path you are changing.
> 

Btw, if you have the cross function database enabled then Smatch will
parse this code correctly.  No false positive.

regards,
dan carpenter

