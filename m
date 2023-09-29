Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FBE7B2C88
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Sep 2023 08:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjI2GnN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Sep 2023 02:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjI2GnL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Sep 2023 02:43:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581421A7
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 23:43:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-317c3ac7339so13151120f8f.0
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 23:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695969786; x=1696574586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c111TxV4LsaZkNFxtorudE/xiCMDuqLd7PyPIRPDzic=;
        b=WLXk2l1am48w8W/AIcmZftEzunBVfCfZfJLEwgMC28hxsUU9DIHp+T72fpiw+VeVmL
         lXGLqIYbFdqkibclddlgEOTTNwiBVEO7NsM7NX1tcYE1/vpdyncXl6Qiybr999izNb0q
         kz91BLqA9iRecPMm4Sw3GMP6Ay1b6SFi1gTKdpuur0gl5wQ2Gb5e/Trj5o/BnlkhThuL
         VkT3XtkomN7XCyKdx4tGFIt2YB3fCiiKx5wPb+4vkHPQGE22r68meozAgKF7k0Da4t8P
         aV15uPrkl0nGJFe5z4vlWXZRm9Nu1iGTCbq2/dw7AKGOrEFNJxg3zcAQaoMmX7WGIVxY
         cJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695969786; x=1696574586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c111TxV4LsaZkNFxtorudE/xiCMDuqLd7PyPIRPDzic=;
        b=qLj/V+WutuoFQC5Dv0tevNUzA9asWOQxg5NxfPj2yWid6GPIA5PPm1lkldOLVbXPUy
         TmB43nWizbItgUQKZc/5YcbZ9LIOrXshK/jeqg3xD57EEgC3p1Wz6fjjfzAYHQhQntEn
         RvtLLEX3uDaP7WrJjCrQQrcxskX9aqpDVDbVCvAW8vVSGNgwOoY2dHR2SPstDsdhIVXk
         jLDrExORlbg+gt8RhWQ3/Nmpuj5sI2q9jClX8UiXxsjzjb3PEZRpPc7NJWTbYbtSwfA9
         onfl9slxQsy9jsYb6kyF3OXS0VRNA2ZJ3YnXhGLNDz+YMOukGctb92rKPv+zN5Rr6C4a
         dJ3g==
X-Gm-Message-State: AOJu0YzU72fG2awtYr4Elqi7WrDsW3XZvYrfXOnU7fTTRGMM4lT3nFFM
        NKgkv1+ZDSecHei/uNszP/9Q/A==
X-Google-Smtp-Source: AGHT+IEDol4wmJM4q7PwQeoCPFVL1+bTQtJagyVB3S67aWJXbdjUevr+b3uO8jUY+r/CU2uIS4XipQ==
X-Received: by 2002:a5d:6e53:0:b0:324:8353:940e with SMTP id j19-20020a5d6e53000000b003248353940emr2925201wrz.34.1695969786653;
        Thu, 28 Sep 2023 23:43:06 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g16-20020adfa490000000b003232380ffd5sm12868643wrb.106.2023.09.28.23.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 23:43:05 -0700 (PDT)
Date:   Fri, 29 Sep 2023 09:43:03 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Christian Lamparter <chunkeey@gmail.com>,
        Wu Yunchuan <yunchuan@nfschina.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 wireless-next 2/9] carl9170: remove unnecessary
 (void*) conversions
Message-ID: <0b7623f7-561c-4f3b-91c1-aaf1c44f1158@kadam.mountain>
References: <20230919044916.523308-1-yunchuan@nfschina.com>
 <e544d992-cddd-4ade-81ef-2eed4f3681e8@gmail.com>
 <87zg16iab3.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zg16iab3.fsf@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I don't know anything which would warn about this.  Generally, in the
kernel we try to avoid casts but perhaps there was a static checker
which likes casts?

If removing these sorts of casts were an issue we would have known by
now.

regards,
dan carpenter

