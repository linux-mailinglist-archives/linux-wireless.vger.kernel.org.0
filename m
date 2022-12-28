Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB526586FF
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Dec 2022 22:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiL1VWS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Dec 2022 16:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiL1VWQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Dec 2022 16:22:16 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822F513E9F
        for <linux-wireless@vger.kernel.org>; Wed, 28 Dec 2022 13:22:15 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 36so11241190pgp.10
        for <linux-wireless@vger.kernel.org>; Wed, 28 Dec 2022 13:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xx3EP6ODYC48OXDEIcqjUBuNhmOgyXFl+VG+rCLYnqU=;
        b=m6aSduj7fW4JNEnSmIxkkz7pBaOO/mRMhCGZ4AXTLHjHisrVejpvGTTE64SnXJKeJt
         gPDkAiNQBOHwm2Maoq8jLZXFrcibn9dKJLUZ+teWK5nHSFXO+o1vADLFeM+ZwvFKuNk4
         KC5h1IKliojQFqlIvg7RO/Jo5qgS4AZTK0b9BAAPA62ccI0QDIOoGUtay6M2jzie7tmu
         c/JuLkZ0fE5HT8Nyni2MFhC3HULIkEYUsus2EAgtQhxfvtWZEDL1jq2tDOdm5cPSYmIH
         TE2qjjhedgbg9aFmSDWKT+JU54Q2dLYMeLrkD5ItmiRRdi7NXxBAFyuk5zfqUduicOIZ
         HKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xx3EP6ODYC48OXDEIcqjUBuNhmOgyXFl+VG+rCLYnqU=;
        b=yVELV27l6Ic9+/teTZR0SdWtaAvIeRKKfN7cwqJmBG1LVTwrHfOE795naapEbbr6un
         LWlbEfkDVAXdX6fJ63OpOk84QE64kBpaLNzTxoedx5FLJK/XEkC2lFmubKf6xQnWCsd2
         B8ibfRFoaGnTDanNvR2/RWAlBbqVsHAIYlEwmkgzeNlpNXX/CSDvmi0JK0k3XwVwMT3G
         iXEyY/YF4do6TcwnYAXhuzLO/X0oBwntVaVq5T5cDkUsOhl4H3Oeh3i479ewctWy7/Ob
         nlk//5qscX6xSM2SJirzEI8q+rgn6PyDwTq6QPQ6Liz0AHFbOAeF3GerCtheHSsakq31
         tAsg==
X-Gm-Message-State: AFqh2koWF0JndLOkNHsVXfYNX4QDK4vRbBtWFwYQTX23Nbbu9SN6olVH
        nhCQQqn6q9gyStQHM1vXqTBrJmh/sfg=
X-Google-Smtp-Source: AMrXdXtYOgHQvLrDx2+vQ91DWrdV0XMnfyR70ZTHkZudkWh3UaCcZyw+oWDaK0v3YRqNrQJqHMeZCg==
X-Received: by 2002:a05:6a00:1a01:b0:580:8d40:cb9d with SMTP id g1-20020a056a001a0100b005808d40cb9dmr29010338pfv.27.1672262534958;
        Wed, 28 Dec 2022 13:22:14 -0800 (PST)
Received: from [192.168.254.20] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id c23-20020aa79537000000b005747b59fc54sm361718pfp.172.2022.12.28.13.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 13:22:14 -0800 (PST)
Message-ID: <378a1d63b3752ace7384c44d6f5184753fa7795d.camel@gmail.com>
Subject: Re: [PATCH] wifi: ath11k: Optimize 6 GHz scan time
From:   James Prestwood <prestwoj@gmail.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Wed, 28 Dec 2022 13:22:14 -0800
In-Reply-To: <2861463e-a097-7efe-bc75-f13c8faf9547@quicinc.com>
References: <20221220043823.20382-1-quic_mpubbise@quicinc.com>
         <5DAEA8B2-2B44-4A91-9E57-12B6C6B6C1FC@holtmann.org>
         <2861463e-a097-7efe-bc75-f13c8faf9547@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Manikanta,
> By the way, userspace itself selects the frequencies to scan, not the
> driver.
> 
> If we see the split scan implementation in cfg80211, this is the how
> it 
> is implemented. If NL80211_SCAN_FLAG_COLOCATED_6GHZ is set, it
> selects 
> all PSC channels and those non-PSC channels where RNR IE information
> is 
> found in the legacy scan results. If this flag is not set, all
> channels 
> in 6 GHz are included in the scan freq list. It is upto userspace to 
> decide what it wants.


This isn't your problem, but it needs to be said:

The nl80211 docs need and update to reflect this behavior (or remove
the PSC logic). IMO this is really weird that the kernel selects PSC's
based on the co-located flag. The docs don't describe this behavior and
the flag's name is misleading (its not
SCAN_FLAG_COLOCATED_AND_PSC_6GHZ) :)

If userspace doesn't specify a channel list then the kernel can do
whatever it wants, but otherwise it should stick to the requested
channels and scan only for co-located APs if the flag was set, not
PSC's too.

This basically adds ~3x the time to IWD's quick scan's for 6GHz capable
cards regardless if there are any co-located AP's. ugh.


