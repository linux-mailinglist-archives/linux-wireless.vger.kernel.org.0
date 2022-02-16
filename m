Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF3E4B9277
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Feb 2022 21:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiBPUfc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Feb 2022 15:35:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiBPUfb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Feb 2022 15:35:31 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5769A2A39F0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Feb 2022 12:35:17 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id y5so3116727pfe.4
        for <linux-wireless@vger.kernel.org>; Wed, 16 Feb 2022 12:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KtRcf8spwupfWXx3ppHGUao3iJAoVb7Xdyi2Swh8EQg=;
        b=QRbl0vlrkn+en8seDm6Fp7XKxcRlzQrFbbDLDGp7jPj9U+ZaXloFtJ9mNDe2ngzggR
         ZmjoG4A1HmJX1NLSMOkwsZ++Rl342st+uklMLse0z2L7j6XCBx39yCBlSNjSQGJOLEjL
         mDeMAo7zcUsGgHCZEg11xdguXIu8HBF9fP+QY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KtRcf8spwupfWXx3ppHGUao3iJAoVb7Xdyi2Swh8EQg=;
        b=T2TzVpgwXryvgfMHQqkR0jlccgjBVuuyZe0R0mmdfXENaRmtPTzcXuZVH4XTAqC2Av
         TjgU64DWfLbAcyy7s3Yr/rGQGd1Rv2RIKEmhuc544C7KgVPzjDAXgxLgAHQD7wZJQ6Hc
         sbvq2EIVojwDiy1lJz4dW7pt0flLPTZLE+Hy8UqRreQpiEWDlXR4KDdwqZYTYEp4c4Dv
         E3MFhQP5fugyuQ70O/i2w22gYvWGesYOKMPOkAy0bssqCKh/GaABDTTXARR9f5gBVBPs
         dwBaJeWhmEqx+Uc5bBLt24Foaft6W7Q8Noed5+mw9ov8gHQQuQ1mMBm7FQjnv3Nv+3o0
         u5Pg==
X-Gm-Message-State: AOAM533vKAyFC1WrmzQf8QK9rIsaXMqMZlW0NVH6NP+FMzmyEaCl434v
        OxVPz8sZEk7fAX8HaAGR7LjY0A==
X-Google-Smtp-Source: ABdhPJzpUqye00ePhdV10IGfo3yDMvRuXibACTdpct9tBS2QY1o/hcdO5DvGhO1nkGq1iwWh41N3Ag==
X-Received: by 2002:a05:6a00:1a04:b0:4e1:786c:cce3 with SMTP id g4-20020a056a001a0400b004e1786ccce3mr4876730pfv.81.1645043716908;
        Wed, 16 Feb 2022 12:35:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x5sm20603941pjr.37.2022.02.16.12.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:35:15 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:35:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iwlwifi: fw: Replace zero-length arrays with
 flexible-array members
Message-ID: <202202161235.2FB20E6A5@keescook>
References: <20220216195015.GA904148@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216195015.GA904148@embeddedor>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Feb 16, 2022 at 01:50:15PM -0600, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
