Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746C67A23E2
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Sep 2023 18:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjIOQrz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Sep 2023 12:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbjIOQre (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Sep 2023 12:47:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D1E2134
        for <linux-wireless@vger.kernel.org>; Fri, 15 Sep 2023 09:47:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40472f9db24so21273755e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 15 Sep 2023 09:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694796447; x=1695401247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XWZZ3chG7hRkgu8VDS2btocBEwICjkACUgERrowKVFk=;
        b=oMGfGvZPI5P4TeZ2aPBGHsrqFLoy6thIRVSEJANrOPVNBbia/V7ZXW0ba8ZXfk3yab
         4LdoG8Gf3Co7qa6n28ADH+0XAtQIdFqQaN+a3JIE7Rk5WFNxV0ncZCI0u4oICQCMSqO3
         ZzKkiNDDATbq6d806NRi0OS0VStl68HdMvRTo0XN2KVnJ0BNBB2dicRQC5JV7nycb3ys
         bQ97R3lyrtiTuSPH0aUFCf57mjitq3JNfpsgEXoV4w6tebibbasKcc0jyvQGKkYW7vZ+
         lcNIbYz5V3Mrl/5HWfBO4Aur4bd85biWEBREW/53+7UHbuGNq1eUca8zNHLyOVEoCom6
         xaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694796447; x=1695401247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWZZ3chG7hRkgu8VDS2btocBEwICjkACUgERrowKVFk=;
        b=cUPoohiUiAkAIyPDI4v1oz9v7nCvuoeWq5TjYzNSr6Qrt+Yo3t9EqoC80yS335jwPg
         /KPkrPk+xAopA5CttFkplWapAsViJkfCIBaDN+yJ1g4Iautzz9rkSz1L8SFEvz5kXv+e
         aAoi5SJGLSUkCO3Ox47rxqPW0gpUoEUZfRP8GGAZfI1wUWHejRxAxR+Lcr1DxSHMxiat
         FbH9y6aqTR5pDt1zg9Y/Ofnw+S5XwtYFRCvT0VUTVR8/x8G/bnAyhq+qk9RlNsPIhoy6
         h+8AS8p9we2WEUZl3EQ443eSxNLmPJ50a3hqYHEzd+/0zxz6gwm9Yzlv4HPuTZzqrM3S
         4V3w==
X-Gm-Message-State: AOJu0YxRT/TlI2xrfYC9Gv9rYY7WxLAb50csIXya66vKJcG6p0sC74It
        DtEAPWZQWMvUa4JJAZ+n/BozKhsf7UM5bMDFmzA=
X-Google-Smtp-Source: AGHT+IHL8rjLM9TOkQFSvo0SenL/kpsJSjVavVfD4gQ432fuB9Lnvg1NF1tRDiWrpZCj3+vS6nRaKg==
X-Received: by 2002:a05:600c:246:b0:401:38dc:891c with SMTP id 6-20020a05600c024600b0040138dc891cmr1977647wmj.5.1694796446797;
        Fri, 15 Sep 2023 09:47:26 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v26-20020a1cf71a000000b003fe1630a8f0sm7996705wmh.24.2023.09.15.09.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:47:26 -0700 (PDT)
Date:   Fri, 15 Sep 2023 19:47:22 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [bug report] mac80211: accept key reinstall without changing
 anything
Message-ID: <4b30551a-f8db-441b-aba4-889a09d46009@kadam.mountain>
References: <220d9f82-c010-4c57-82ec-60bdedc5efcd@moroto.mountain>
 <bb7444d9833236ee5ab5474bc34049eebd5e2c09.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb7444d9833236ee5ab5474bc34049eebd5e2c09.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Sep 15, 2023 at 06:37:45PM +0200, Johannes Berg wrote:
> On Fri, 2023-09-15 at 11:29 +0300, Dan Carpenter wrote:
> > Hello Johannes Berg,
> > 
> > The patch fdf7cb4185b6: "mac80211: accept key reinstall without
> > changing anything" from Sep 5, 2017 (linux-next),
> 
> Huh that's kind of old :-)
> 

Someone shuffled the return paths in ieee80211_key_link() so it became
easier to parse.  I normally don't report old bugs because normally it's
abandoned and forgotten by that time.  But I know you're still around
fixing bugs and no good deed should go unpunished.  ;)

regards,
dan carpenter

