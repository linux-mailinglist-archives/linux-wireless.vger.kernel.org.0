Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA0E742DCC
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jun 2023 21:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjF2TxB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 15:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjF2Tw7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 15:52:59 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44431FC0
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jun 2023 12:52:58 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3457cba78f3so4967465ab.3
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jun 2023 12:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688068378; x=1690660378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q+OV1bbKxg/qKN6kdBFMoxPXZzLIbrPPPO3Omw1xni4=;
        b=FS/l9gahimbl0J09Gixz9uiu3Z7aMpDQP2/LStGjjfsQ44vpOqsN9dOOPcgn1i81Zx
         uydzRSYsCAUsCLnl4SvIFtY3mWQ05YBwRFLtSoNUTllgN+Im4O92sRi6btEG8+jLqAzn
         RY7Fm87Q8dx/3jE8hXJTcCafjR6Tos9bFhyTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688068378; x=1690660378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+OV1bbKxg/qKN6kdBFMoxPXZzLIbrPPPO3Omw1xni4=;
        b=Wp3JQwTu0t+DGj7F4y/oZKVDKzE31K2269Czxspvy7M7HcLumwGEKS+FbABkCVba0w
         i9e+UR9EbQ/wbq+nk57gkTwEE4SBCLCDbxil7ss0em7C5UPhQ0rph+ZT385WiIYuEVmM
         2YjhRi5cER0GMbymnhIHE4hQq5Yohu89TJzFXcG8MgdsGX50oYIM5+KCqDuOL46MZyjF
         JI3jjaNdei01FXs5Sf2auoHDT3o+L6+RnEXEqcK+yN9vFq4zhkcbNSiskcw46kSUYs04
         uUpwE83AtdXOdRuF7bUiSmD+KbOSDOqkP3pySwx9zkGGpwEtufsFtxHbREGZnLUtESXF
         ZMYA==
X-Gm-Message-State: ABy/qLaec+unYAsbulsjBNLwdZGGvOsqn0NciKZ9xplcNmEuYUpddIPn
        7prmh52EtT6a7I4Juo5PVwCgiQ==
X-Google-Smtp-Source: APBJJlFgQSILukDVPI86cuF+TjImymhuaOloZ40+/0Sq93WevSmmmMUZIiKoebImyMe7EEvq3q51Tw==
X-Received: by 2002:a92:c848:0:b0:345:84ea:ace7 with SMTP id b8-20020a92c848000000b0034584eaace7mr138045ilq.30.1688068378211;
        Thu, 29 Jun 2023 12:52:58 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:3c2b:cbff:22ae:80d6])
        by smtp.gmail.com with ESMTPSA id 14-20020a630b0e000000b0054fb537ca5dsm8983674pgl.92.2023.06.29.12.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 12:52:57 -0700 (PDT)
Date:   Thu, 29 Jun 2023 12:52:55 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/3] [v4] wifi: mwifiex: fix fortify warning
Message-ID: <ZJ3hF53JG3CtA0KZ@google.com>
References: <20230629085115.180499-1-dmantipov@yandex.ru>
 <20230629085115.180499-2-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629085115.180499-2-dmantipov@yandex.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jun 29, 2023 at 11:51:01AM +0300, Dmitry Antipov wrote:
[...]
> This also fixes an improper usage of 'sizeof()'. Since 'skb' is
> extended with 'sizeof(mgmt->u.action.u.tdls_discover_resp) + 1'
> bytes (where 1 is actually 'sizeof(mgmt->u.action.category)'),
> I assume that the same number of bytes should be copied.
> 
> Suggested-by: Brian Norris <briannorris@chromium.org>

I don't believe I actually *suggested* the change; I just highlighted
that the size looked sketchy in the original code. :)

But your change does look correct, and I don't see how we could possibly
*want* to be off by 1 here, so:

Reviewed-by: Brian Norris <briannorris@chromium.org>

> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v4: fix memmove() size calculation (Brian Norris)
> ---
>  drivers/net/wireless/marvell/mwifiex/tdls.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
