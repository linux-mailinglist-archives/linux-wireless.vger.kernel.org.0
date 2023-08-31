Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8892A78F330
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Aug 2023 21:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344941AbjHaTSe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Aug 2023 15:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjHaTSd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Aug 2023 15:18:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1151BF
        for <linux-wireless@vger.kernel.org>; Thu, 31 Aug 2023 12:18:31 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf092a16c9so9544015ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 31 Aug 2023 12:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693509511; x=1694114311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GsqiH/F0uiLsgZIOirUAxv8nRkz7x6zqX7vHcWml97w=;
        b=c6Z1i7tbOl0pBGpw7EAB3G5WmSTikIg6ZqDWf/YIHaVKo8BRqj0K5M9bGo7GnBZPOZ
         F8hQGw+1tQPmhlJmajGIqg6VgSIKa3s+ETXKfrP87Fj8GaWmkQ7p/UzIQmNZEjXreHU7
         Dsly0nsqDp1M66pziR+EQCiwhCU7kVP6CBz54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693509511; x=1694114311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsqiH/F0uiLsgZIOirUAxv8nRkz7x6zqX7vHcWml97w=;
        b=KV8nCsme1likULygil0pZHjBL2XWoF8InTjnRz+BbJAAXQ6bf3Wqek2WtNzoWELVlc
         VaYeCLgr1kbDVXGPja/O5fC0bmxHpSmdOKH0bh3VZY2nxgBKs4k40SEPjosX9HFcmXoZ
         1WAZVFw7Dp7dKvwwOSene1nMGcm+5WkjJpvjuh1fdnzS64rlxg5XmzKJIfGY9G8PK4/l
         53TW7IJDv663EG+WyMJAg+te2y+xQ3Tf+s5PxXLFRYJdjDJfM5rZJxuofR1PkhozvCvo
         WyL7wGC0glNJoCMdRh5As+8/l4YXR5MSIUryVyjjSnis4ZSst520DBbyWL9/s5jgfSEe
         JTgQ==
X-Gm-Message-State: AOJu0Yw/ZYihfcFhVeyolSkPNzYvTpxjrV0sZ+iqn/cUiuDwErpxqFLo
        YnYGTS2xvEvAA+G1V1pEvx6MRw==
X-Google-Smtp-Source: AGHT+IHAB09QJKFbJyJ6Mj/J8+vjv8IjfbkJCAe02z4bfIN2Qk8IUL2743Wr0Yrhw/3xqxR3apNxNg==
X-Received: by 2002:a17:903:26d4:b0:1c0:aa04:dc2f with SMTP id jg20-20020a17090326d400b001c0aa04dc2fmr632850plb.11.1693509510884;
        Thu, 31 Aug 2023 12:18:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jf13-20020a170903268d00b001b8b07bc600sm1573727plb.186.2023.08.31.12.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 12:18:30 -0700 (PDT)
Date:   Thu, 31 Aug 2023 12:18:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     kernel@quicinc.com, Kalle Valo <kvalo@kernel.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mac80211: Use flexible array in struct
 ieee80211_tim_ie
Message-ID: <202308311218.D82D90A@keescook>
References: <20230831-ieee80211_tim_ie-v3-0-e10ff584ab5d@quicinc.com>
 <20230831-ieee80211_tim_ie-v3-2-e10ff584ab5d@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831-ieee80211_tim_ie-v3-2-e10ff584ab5d@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 31, 2023 at 11:22:58AM -0700, Jeff Johnson wrote:
> Currently struct ieee80211_tim_ie defines:
> 	u8 virtual_map[1];
> 
> Per the guidance in [1] change this to be a flexible array.
> 
> Per the discussion in [2] wrap the virtual_map in a union with a u8
> item in order to preserve the existing expectation that the
> virtual_map must contain at least one octet (at least when used in a
> non-S1G PPDU). This means that no driver changes are required.
> 
> [1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> [2] https://lore.kernel.org/linux-wireless/202308301529.AC90A9EF98@keescook/
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Looks good to me! Thanks for the conversion. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
