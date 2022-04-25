Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E72650EC76
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Apr 2022 01:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbiDYXQT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Apr 2022 19:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbiDYXQR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Apr 2022 19:16:17 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D244614D
        for <linux-wireless@vger.kernel.org>; Mon, 25 Apr 2022 16:13:12 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so843877pjf.0
        for <linux-wireless@vger.kernel.org>; Mon, 25 Apr 2022 16:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2DJhIYTqXYplW9lP9uJQwqXKSCnTlNmW0Zo9c3Kv29k=;
        b=epgKtVTNynOyu/7OZFsmHnChXekgv57ciJlvl0aIbH/M+t0fuW4gnBFAv2SPOU/7oI
         lOwY1o5RP7sRPX4OvCPP47Jw2e6kzACR8pgMEW7Ia8M6D+UwuFy1P4WGdE9aXyy69FpB
         l5hLGufQ0xogXf1k0QakrqnU+LccdI2/aOYQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2DJhIYTqXYplW9lP9uJQwqXKSCnTlNmW0Zo9c3Kv29k=;
        b=V98J0QLzDcnu9zVV17rezm2hdh+O3iN+0F02BOvN/uhHVtAlT93yfBMmIPbs62KJK4
         zbpbnMK1JE5BjCtFaEyw4ta4510VwOd3XYopSWmufF2V19AQcyTgAsACGx3MAC3ptT6N
         Rvy6dpNaSvGWYZ0a6C3hVehkSdWD9t2lle2bNNkJO2aZjmWNXkT7xA8oZYaJNNzAWGs3
         qDeOGE5PLY9J8roC+Oqj4UHprAZqNYpw2fpRknOxoWqX5/G5FfToZCOBwXDyS0ajrsvL
         2u3GdanV+ibLtYzm5uQpFGCgx68jetCHK997o2bb9GgJzka1trX1HLGqkltU+bVKVMB/
         koVw==
X-Gm-Message-State: AOAM531n0zfqbIc7DmXbhJ4l6OZtGefmR2YSFz/azpu0E/An8j3LWVqI
        E0x0raiz2e8Y9RXtFDn3GqHq4Q==
X-Google-Smtp-Source: ABdhPJx1ULMWttNhMQ0Qvlkb27kuiPfgh7vujfY1m6axCjNVRaz5FzsGwvA+45wmAAUpUKZG8wN4Dw==
X-Received: by 2002:a17:902:b906:b0:14f:76a0:ad48 with SMTP id bf6-20020a170902b90600b0014f76a0ad48mr20675811plb.79.1650928391477;
        Mon, 25 Apr 2022 16:13:11 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:84c6:2d6d:c16:1a1b])
        by smtp.gmail.com with ESMTPSA id z16-20020a17090abd9000b001d2edf4b513sm347375pjr.56.2022.04.25.16.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 16:13:10 -0700 (PDT)
Date:   Mon, 25 Apr 2022 16:13:08 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Abhishek Kumar <kuabhs@chromium.org>
Cc:     kvalo@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        netdev@vger.kernel.org, Wen Gong <quic_wgong@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] ath10k: skip ath10k_halt during suspend for driver state
 RESTARTING
Message-ID: <YmcrBFZ0CB/7abzW@google.com>
References: <20220425021442.1.I650b809482e1af8d0156ed88b5dc2677a0711d46@changeid>
 <YmcqsFyCMqcWAEMM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmcqsFyCMqcWAEMM@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Apr 25, 2022 at 04:11:44PM -0700, Brian Norris wrote:
> On Mon, Apr 25, 2022 at 02:15:20AM +0000, Abhishek Kumar wrote:
> > --- a/drivers/net/wireless/ath/ath10k/mac.c
> > +++ b/drivers/net/wireless/ath/ath10k/mac.c
> > @@ -5345,8 +5345,22 @@ static void ath10k_stop(struct ieee80211_hw *hw)
...
> > +			/* If the current driver state is RESTARTING but not yet
> > +			 * fully RESTARTED because of incoming suspend event,
> > +			 * then ath11k_halt is already called via
> 
> s/ath11k/ath10k/
> 
> I know ath11k is the hot new thing, but this is ath10k ;)
> 
> > +			 * ath10k_core_restart and should not be called here.
> 
> s/ath10k/ath11k/

Oh boy, I got *that* backwards! Should be this, obviously:

s/ath11k/ath10k/

> > +			 */
> > +			if (ar->state != ATH10K_STATE_RESTARTING)
> > +				ath10k_halt(ar);
> > +			else
> > +				/* Suspending here, because when in RESTARTING
> > +				 * state, ath11k_core_stop skips
> 
> s/ath10k/ath11k/

Same.

Brian
