Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8659376F6DC
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Aug 2023 03:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjHDBVN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 21:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjHDBVL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 21:21:11 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04154204
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 18:21:10 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686f8614ce5so1455037b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 03 Aug 2023 18:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691112070; x=1691716870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ypBwOVIzjGVKMtpMOqEnNVCRx9mqI7yfpCvSX9uD1zc=;
        b=CoCTu0k05NCxhTrWpO2gGYn9FY/B30MkO/QOlPHQzdKPOnYk5Bk4DRNPmCmZQvs9V/
         5cais6NVAAc23978nBrhcacaARfe/m58Ad+6N1Ls7Xn5vEGE2udGKSVc9FJVcJBxK7FD
         9kzvinYzWFtU4Q8RtvWxJ5LkBI9TSht0IdDm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691112070; x=1691716870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypBwOVIzjGVKMtpMOqEnNVCRx9mqI7yfpCvSX9uD1zc=;
        b=EDvw8IACYBSMVEObE3AVIFgD9+IKPIq8YIVV+lCLoeiV83or76se5mv53RR8kcxJpX
         cKvIT7j8TZJSpPoN2tARQhQtpWZQDx1o1jFsTDoYgSq8l9Mv8SwSPdkXl8/RQmfGu7uE
         xO5bT6e1qWyRiBJ5IWMgZCa4wxYMdHAJwRONpKWBdF9Lsao7NukMaDN//5ZLkkVgeFLk
         YGkrUJkZ5YofI/5D6rtm/QPOk+TAH58QGxJT3sGATOmOAPmZ7Hjomlxps19KBsCdr0V3
         puJOjbgHrjYOTekm3R/uMGJ0vqfQpBMNHvwtHNpEaRuvU6nt9lExdp92p7ZMEx6Mcjgo
         U1uA==
X-Gm-Message-State: AOJu0YwRFdhhSAHobjamT/SN25Kn8f5EqvBPY4qu4eYA6D7GX4lNIqDu
        vTrwfHpi8q0EhDUlXlg26o0BQQ==
X-Google-Smtp-Source: AGHT+IEq/r3gvwil/W/WZOL42jslh7WMQlcxhhQnAq7eqgLRxoNU2DEQN6hRyk75sOQDVQux4f29Bg==
X-Received: by 2002:a05:6a21:3384:b0:134:1ef9:8c17 with SMTP id yy4-20020a056a21338400b001341ef98c17mr430494pzb.20.1691112070360;
        Thu, 03 Aug 2023 18:21:10 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:8572:f31f:f867:9438])
        by smtp.gmail.com with ESMTPSA id j13-20020aa78d0d000000b006829b27f252sm446026pfe.93.2023.08.03.18.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 18:21:09 -0700 (PDT)
Date:   Thu, 3 Aug 2023 18:21:07 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Kevin Lund <kglund@google.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/2] wifi: mwifiex: Stop rejecting connection attempts
 while connected
Message-ID: <ZMxSg1SmALzTSyGD@google.com>
References: <20230602225751.164525-1-kglund@google.com>
 <20230602225751.164525-2-kglund@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602225751.164525-2-kglund@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 02, 2023 at 04:57:51PM -0600, Kevin Lund wrote:
> Currently, the Marvell WiFi driver rejects any connection attmept while
> we are currently connected. This is poor logic, since there are several
> legitimate use-cases for initiating a connection attempt while
> connected, including re-association and BSS Transitioning. This logic
> means that it's impossible for userspace to request the driver to
> connect to a different BSS on the same ESS without explicitly requesting
> a disconnect first.
> 
> Remove the check from the driver so that we can complete BSS transitions
> on the first attempt.
> 
> Testing on Chrome OS has shown that this change resolves some issues
> with failed BSS transitions.
> 
> Signed-off-by: Kevin Lund <kglund@google.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/cfg80211.c | 6 ------
>  1 file changed, 6 deletions(-)

I've been told this one might need an extra look, but first off, it's
marked Rejected, likely due to feedback on patch 1, so probably needs a
resubmit if it needs consideration:

https://patchwork.kernel.org/project/linux-wireless/patch/20230602225751.164525-2-kglund@google.com/

But, did you attempt any background work on this, to determine why it
exists, or what other mitigations are in place? For example, I see that
sme.c's cfg80211_connect() makes a similar check, but only rejects
things if the SSID is different. So with that understanding, it's a
reasonable guess to say that mwifiex would be OK with just relying on
the existing cfg80211 checks instead.

In other words, I think this patch may be OK, but probably could use a
bit more explanation.

Also, how does "BSS Transitioning" (in your description) fit in here?
IIUC, cfg80211_connect() doesn't support that, as it only allows
reassociation to the same BSSID.
(Or, I might be confused here.)

Brian
