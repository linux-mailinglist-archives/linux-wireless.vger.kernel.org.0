Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9649962E96B
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Nov 2022 00:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239691AbiKQXR1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Nov 2022 18:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239640AbiKQXQ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Nov 2022 18:16:57 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7CD742CF
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 15:16:56 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so6751885pjc.3
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 15:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oFHM35UNmfkldWlBK35cn48oG6HZgrQ/KKBOkaB7rqU=;
        b=ATU3KjrZtjnHaTJObubyH+A7KNgBJz/4UaptmzMu4aSuS9NdqlPG0tYK4xIrw4V0NB
         4RU5QBMu8DWiBXX1/TktUDKtbUKAnZx48Xhzr5n3cj0tYPXPgg6lNQQwF68TEdbEM6dh
         1Bx+Y3+kimUVDCJga+7SSlvRvh7BS7Opi4JuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFHM35UNmfkldWlBK35cn48oG6HZgrQ/KKBOkaB7rqU=;
        b=sH9R5zKaU9JfFjPlaVEH6UG3mMfTaI2H/dm6/vrKFfa+AlUtiqcieqCUgML5WLW6S7
         WjEpHzugt1YWIS+VTrbnAbzyzoBtELcxy5j4ljTHOCJF4VIpaL4XSLR0aDFK0C6v94zP
         x3HvsNTZ5ReUMMd2gtq0z8/96XIm7YgxDW5lro3sT4K6XsFNq9L3b6Da4dpSHdHM6uYS
         FBo0NrNaM3ENHdW2w6aSTwclfc03y14/hT/mm7Sg99Dg8ReCVsq3K5zoS+CTOEiXjPuk
         EPRnmSA0MIOIJn99+XpqkALQOg/zK73MieQuBnL1lmGOQ6K1p9UCvZs9nNl60HxUbuzZ
         x1rQ==
X-Gm-Message-State: ANoB5pn/B2MeL8sbeEkLXGu5F7sVWeOILCP+r4NCnMIhX6kFZDSUjceA
        3eI02H65SO2sp/laO7ikPAF+Jw==
X-Google-Smtp-Source: AA0mqf4Z52LhYoKCKnrcJ/sZ0XNkqqlzxYRePSfLz9EXsNXDAWUPh3OJgEchOas5UoNkbsmIaRRXqA==
X-Received: by 2002:a17:90a:6e47:b0:205:a550:e529 with SMTP id s7-20020a17090a6e4700b00205a550e529mr5065529pjm.25.1668727016281;
        Thu, 17 Nov 2022 15:16:56 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ls5-20020a17090b350500b00205f013f275sm4149719pjb.22.2022.11.17.15.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 15:16:55 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:16:55 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] wifi: brcmfmac: Use struct_size() and
 array_size() in code ralated to struct brcmf_gscan_config
Message-ID: <202211171516.19C8EB37@keescook>
References: <cover.1668466470.git.gustavoars@kernel.org>
 <de0226a549c8d000d8974e207ede786220a3df1a.1668466470.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de0226a549c8d000d8974e207ede786220a3df1a.1668466470.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 14, 2022 at 05:02:06PM -0600, Gustavo A. R. Silva wrote:
> Prefer struct_size() over open-coded versions of idiom:
> 
> sizeof(struct-with-flex-array) + sizeof(typeof-flex-array-elements) * count
> 
> where count is the max number of items the flexible array is supposed to
> contain.
> 
> Also, use array_size() in call to memcpy().
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
