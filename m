Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A165468A0F4
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Feb 2023 18:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjBCRzH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Feb 2023 12:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbjBCRzD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Feb 2023 12:55:03 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8592ADBBF
        for <linux-wireless@vger.kernel.org>; Fri,  3 Feb 2023 09:54:45 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id v23so6027555plo.1
        for <linux-wireless@vger.kernel.org>; Fri, 03 Feb 2023 09:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2zabOkk8raGucj5VBxNY2tARuoOEYzucUnuxzxeg5Ek=;
        b=e2zuiUIvvKN3Gi+i2FXmXzqNNZNed6qIioC591AO051BLb5lFWdx5GvErKtXMfoArh
         VIobYDCEk+RoXMVrGxIbfaRh3SGu5KdEXkVUL9IF1qgx942TVYCJAJ3hQSDwq4Im+YSn
         Rfa3ZWZamyNDaMSGLuskNYBrisL1lTsVgJxTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zabOkk8raGucj5VBxNY2tARuoOEYzucUnuxzxeg5Ek=;
        b=12pWlCLlbLkubXm20Nc/D23Ok+6uMR3O4s8xyfBSO25N8+uy/b7ROitcZyXz7u4KdE
         bV1gV3fD4PYW8USwUHs1xiJ1Z9CFXHnmncDQXOKMovocDsFNFpvBumoIEDDVsZSjpU/f
         JTPCT1vViJZ8zrSfAC6lak608GrDTi/9pKPxgQmnI3GIGaUOan2q+uFdOZ1PK0TklH8k
         1QRvizCLEWAtgB2qVEg+UUlC4ap6JiE5pUywDZEtwUrOtQtgmV1iNvmX9Dz3mH0w1/A7
         H2JOgAZrhTbYEE8aeyNQZgKnmBPEodCfU/V1JqEghF9j05m9aGR6Jen8eN4QOiHy2kAj
         hj0A==
X-Gm-Message-State: AO0yUKWYaOwieY0XLOdAHgozZ9qZba2TvcDYkO0dNGiLNObMv6hMsCfO
        rrpbMJIF2QLasKDi4f5hvt+Snw==
X-Google-Smtp-Source: AK7set9Viy6W3uH/z/gbYqjrgi1gVp1ihje8JI5TqGFl4yIwnNVl2yutLYH7E5beN1qh+gMX/raRpg==
X-Received: by 2002:a05:6a20:bb0a:b0:9d:efc0:92 with SMTP id fc10-20020a056a20bb0a00b0009defc00092mr11439154pzb.58.1675446885466;
        Fri, 03 Feb 2023 09:54:45 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9-20020a63a709000000b004b1b9e23790sm1682499pgf.92.2023.02.03.09.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:54:45 -0800 (PST)
Message-ID: <63dd4a65.630a0220.e5739.3450@mx.google.com>
X-Google-Original-Message-ID: <202302031754.@keescook>
Date:   Fri, 3 Feb 2023 17:54:44 +0000
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: mwifiex: Replace one-element arrays with
 flexible-array members
References: <Y9xkECG3uTZ6T1dN@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9xkECG3uTZ6T1dN@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Feb 02, 2023 at 07:32:00PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in multiple structures.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/256
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
