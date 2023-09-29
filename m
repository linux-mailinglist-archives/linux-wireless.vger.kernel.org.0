Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD4D7B2C9E
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Sep 2023 08:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjI2Gtg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Sep 2023 02:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjI2Gtc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Sep 2023 02:49:32 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489AC1B1
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 23:49:30 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c00e1d4c08so222789151fa.3
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 23:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695970168; x=1696574968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IdE47ccEJVgPvSH9BWbF+fIplCXC5Qc2Je9vj/botNc=;
        b=Pr5yvZcp+VjqHWgYEydarW6aRJbG7cJcjTS/gcRyeB27StxQRTRFvXsNbG4eKefuXS
         vintCQ0TkitYH4g/JynVx63syoAkU7cvZL5jKmAUlXV8/GY2NQFRv3n/RpdsEPigrK28
         eYlWxL5sBJVEGEfW/EfPWok55T+6L+ak5gey4NlXwLSHF0emXlB4xdBLgwHicUo6uzr1
         Evjx+J7Eh7UwcOX1VZ25ufqm5KhxLvBNMk9Fr3AwjZK94d5GzcUg5H8Zh8Az5OmIeggH
         L+LUvhWzXN+gU1nwupgOOB0FvL4Ew1pdilMODIMn/bAPD0cqCHZo1pVTn67bp7kkfjb9
         aVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695970168; x=1696574968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdE47ccEJVgPvSH9BWbF+fIplCXC5Qc2Je9vj/botNc=;
        b=FfFxEvrfUkZvAxgN6NFgSDkxznSscP80WNYMKzC7udbowbwWDlV2vz3tK+bOpokeTY
         4RSVnG7IHin2vWDz/0GPkRA0LCkg4Uj2NG831FeGu2j+7za9uvgUZwLeppbDI22T1U98
         YeQ45cTBQyqWNNArOPTFAtk6kTXa55sjn+ImCBPCd/X709Zkk1vpA9xQcnoDrDuTjmBy
         qd4naTc8r5z7ZIWmUK4gqJ6jm+M0ljpBBoS5Pi+OtkBlMTsksntQlYn3Ar+7udppgTuH
         g3goOhE6U+jKMS6tmiTaz0ohe7nkBxRj/nug2Eiua8HF42eU/QafYoCqsepMUwK83OOW
         JNVw==
X-Gm-Message-State: AOJu0YyCKLKrbjj0gOlW/ovw217oZuxXLumEdc8xmtnLOMUSO947Dci3
        w1shlqCjxbIMxlBGZBaaD6R8IA==
X-Google-Smtp-Source: AGHT+IEQRfeGnYjHSeRYcCXQtu0cyPPVk5fpNmgv97WC9LvDlu4SIDZmtlXa76nDC02T9PGxFv2byg==
X-Received: by 2002:a05:6512:4819:b0:505:6ede:20b0 with SMTP id eo25-20020a056512481900b005056ede20b0mr825848lfb.58.1695970168197;
        Thu, 28 Sep 2023 23:49:28 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c378600b00405ee9dc69esm751819wmr.18.2023.09.28.23.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 23:49:27 -0700 (PDT)
Date:   Fri, 29 Sep 2023 09:49:24 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Christian Lamparter <chunkeey@gmail.com>,
        Wu Yunchuan <yunchuan@nfschina.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 wireless-next 2/9] carl9170: remove unnecessary
 (void*) conversions
Message-ID: <d41d0c98-82ef-40f6-8c5c-68a94b5a4655@kadam.mountain>
References: <20230919044916.523308-1-yunchuan@nfschina.com>
 <e544d992-cddd-4ade-81ef-2eed4f3681e8@gmail.com>
 <87zg16iab3.fsf@kernel.org>
 <0b7623f7-561c-4f3b-91c1-aaf1c44f1158@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b7623f7-561c-4f3b-91c1-aaf1c44f1158@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Sep 29, 2023 at 09:43:03AM +0300, Dan Carpenter wrote:
> I don't know anything which would warn about this.  Generally, in the
> kernel we try to avoid casts but perhaps there was a static checker
> which likes casts?
> 
> If removing these sorts of casts were an issue we would have known by
> now.

Thinking about it more, if this caused a static checker warning then
probably every kmalloc() would need a cast.

regards,
dan carpenter

