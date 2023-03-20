Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48C56C1E5B
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 18:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjCTRmq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 13:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjCTRmS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 13:42:18 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008492884E
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 10:38:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x15so2603935pjk.2
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 10:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679333893;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KbjxRufEz2LRrJW5lGjgyHekWzY5fcxyXvPFpUnVw9U=;
        b=h6VQAW+VydvCHDcrlm9qbC2teFPwAXJGdBR71S5TRV0XMVkU4FFCtMPT73/vbtNkt5
         rram+YA7R9vQOjPpFOWt9zCgBZ1lyCT8Y8qwu4u8QXmDZWmK7j54OXgHsG5PqgYHuavA
         HMXaUh1nVwo5XnFdrvSTbtWpGv6tGO8knNad8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679333893;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbjxRufEz2LRrJW5lGjgyHekWzY5fcxyXvPFpUnVw9U=;
        b=VjWNxOFHdboUZHp3mthPPkLWeRD1YZzCJiS3AJcxtM5asjiWg2pDAUDuALxC/EuP3q
         txfyS0urE62moreGykNWNqH2sYFZskOLepWgsdQEVOzJItotVB522rIvVpMKACSYAVM7
         jPgmf8VPOlwBabhHVZf1V22UbdHQsxuRQr4/d+Pagux4Hmj8ZcoeOQ7LSFZGge+oKx91
         nwXs454IhS+MlsSC49gtdpgrJITUec1IDWGVFVnpyrD7dAVykkxK658OS/IboyLudwdI
         jrCC7wF9LtzJIjc1iWJwGnjr+l9c/0z1u618FGoPQvrc4nPsHG5wepRjnZFDhRap/UHh
         L5Dw==
X-Gm-Message-State: AO0yUKWoQ032dkEkOPgHrl7oQA2vMcHsSeDMLxq3+OWPKr/+ZRT0b0jt
        wTZHazoGCMGqQCodX/TNBjx7iA==
X-Google-Smtp-Source: AK7set+ReMGhR+wH/rByvb/2sDKb3mL+AiPgYJ8uCaW6k92swRifv4RM1h9KANVm749WNJ0AutMauA==
X-Received: by 2002:a17:902:facd:b0:1a0:768a:e648 with SMTP id ld13-20020a170902facd00b001a0768ae648mr15988776plb.9.1679333893296;
        Mon, 20 Mar 2023 10:38:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709026b4600b001a19cf1b37esm6995903plt.40.2023.03.20.10.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 10:38:12 -0700 (PDT)
Message-ID: <64189a04.170a0220.a3692.c0bd@mx.google.com>
X-Google-Original-Message-ID: <202303201037.@keescook>
Date:   Mon, 20 Mar 2023 10:38:12 -0700
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
Subject: Re: [PATCH][next] wifi: carl9170: Replace fake flex-array with
 flexible-array member
References: <ZBSl2M+aGIO1fnuG@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBSl2M+aGIO1fnuG@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Mar 17, 2023 at 11:39:36AM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays as fake flexible arrays are deprecated and we are
> moving towards adopting C99 flexible-array members instead.
> 
> Address the following warnings found with GCC-13 and
> -fstrict-flex-arrays=3 enabled:
> drivers/net/wireless/ath/carl9170/tx.c:702:61: warning: array subscript i is outside array bounds of ‘const struct _carl9170_tx_status[0]’ [-Warray-bounds=]
> drivers/net/wireless/ath/carl9170/tx.c:701:65: warning: array subscript i is outside array bounds of ‘const struct _carl9170_tx_status[0]’ [-Warray-bounds=]
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/21
> Link: https://github.com/KSPP/linux/issues/267
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

This one threw me for a moment, but then realized the patch context
couldn't see the union that wrapped them. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
