Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF82C5EB406
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 00:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiIZWBo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Sep 2022 18:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiIZWBc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Sep 2022 18:01:32 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BA7DED6D
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 15:01:31 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s90-20020a17090a2f6300b00203a685a1aaso8317063pjd.1
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=cwy5GYd8Dih14UwvwShPmCNz0QAIoJi79OciA/VYVJI=;
        b=dJR17a7Ct4TbA+qmnfIAWKuT4kiKvu439jsP/3qW67iCancIZqKV0UP7bDw7eDJ5KE
         4QlBNhhrMIHTB6AMbclxjdavsP+nctpOT2lMWMWD5TpY4qa/G3EML5ita9DAe54UCnkR
         a46WplXriSCVp3+Q/J7jg9xnmquuuFHQaAMQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=cwy5GYd8Dih14UwvwShPmCNz0QAIoJi79OciA/VYVJI=;
        b=n+P9pbewmpE+ktzkWUO8Qv1tU9cVLXGk0f1sP2yIpvyjqlMvrty4T0kRlCClEGzAsX
         NqyTW756siuX//Z7wzdecmoRS7L1vVqAHpKwDXBmvDWC7S0lQkR0wIsnv9NAqkPnPH6p
         H7FImLWke03BkjwyuIshCMrSgoO6rHNlgo11MClaUShxncsctFYzKcaI63Jxvyxp/+k+
         /eIKfw72OvQvQDdnTA4BgZKDneGMQg9zFA7aopIFi/UabeLutA8EiQz9AJ26/ttZNZ2Z
         Plqs6gidjA4neNfO4dQS6/tiH2LMznw1c4yg6yNol8+OWor1eyDmTm/wgy+A200CGnqk
         /JCQ==
X-Gm-Message-State: ACrzQf0S+36lduESW7P3fLtMQOaBPTq8TBhsUFFbEV9JElT30JRKTz8b
        B7+Td9zIwRWMFMX9x7pdJihCMHV1EkUk/Q==
X-Google-Smtp-Source: AMsMyM64nw0QwPnYBVhr8wkQ2W4B/t9MdaS2y1Q0lHJKsoI1ufso/FQpWXEXNJO9lqYED/FVqRf2zg==
X-Received: by 2002:a17:902:d88a:b0:178:e0ba:da21 with SMTP id b10-20020a170902d88a00b00178e0bada21mr23746398plz.139.1664229690634;
        Mon, 26 Sep 2022 15:01:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id jg11-20020a17090326cb00b001769ee307d8sm11764542plb.59.2022.09.26.15.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:01:30 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:01:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Christian Lamparter <chunkeey@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] carl9170: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261501.31320B5@keescook>
References: <YzIdWc8QSdZFHBYg@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIdWc8QSdZFHBYg@work>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Sep 26, 2022 at 04:44:57PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/215
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
