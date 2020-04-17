Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C381AE7F7
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2020 00:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgDQWIQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 18:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726284AbgDQWIP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 18:08:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B12C061A0C
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2020 15:08:15 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t14so4697181wrw.12
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2020 15:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=7UMBTTxqddn7dk5hxGVt8ENAgHrrOZUMGFunYXqysqA=;
        b=MP1LrdCb8ddufiI+W8M1tv1/uPxewY8by4mSYewFcQJqAvV5hX3wyXw293pOaIqVeL
         BjDyZYmONlwW1d7uXSVFHzv4k4UvAOo9nEKqxyonEUC1nTPwL6EBRmu0ISzYNr4+27Z5
         nkVSCDVzCFK74fSUa8/SVLwF53TOxuy6FQUEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=7UMBTTxqddn7dk5hxGVt8ENAgHrrOZUMGFunYXqysqA=;
        b=guDhzdW1nhxa16YTpc85frg50fLBdPxgXNlAiqCnQION08Wki6m8u2iHkqf3cwDqn1
         G/GE2nkkoljWmRZnaklcCaE5hXDG0uN2Pz6/+UT1VhF234Yy6S2Ay4dxlUd7Z7WxP/+9
         lWQ1EihSbAZFWrGLDJ40zbZ/7rdmAZWlhyTGswoLiF59I6J98RLQKB2/RJywC2U5lQmv
         JYUekGFH76MoQ/BeELryBpKF66Ic8BPUOMdomUNsegpyCQ3LEhepGUa0ctWUf+8fME5s
         /nG9PPl+HMSjq2z+5KZ7bWTD2Tl2cekeHArMkM2eauh1Uze3oryudSbGWS03/nqkR40W
         5FxA==
X-Gm-Message-State: AGi0PuYP2Py46wzyWtFMKLqp8EduAt3i9mu5DerUTFzC1f3GqYYkAAlh
        0PvG0aFbd6nWclG8IpylgCdkvA==
X-Google-Smtp-Source: APiQypIj/WT3JWM5bVnJVs3h7ULG3VvlGHoYiUtZjnRzxuWsEoVi2bFbJ0Y3WwSrWGaQST7OONUzBw==
X-Received: by 2002:adf:bb94:: with SMTP id q20mr6581496wrg.105.1587161293712;
        Fri, 17 Apr 2020 15:08:13 -0700 (PDT)
Received: from [192.168.178.38] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id n131sm9394168wmf.35.2020.04.17.15.08.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2020 15:08:12 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "Chi-Hsien Lin" <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <brcm80211-dev-list@cypress.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Igor Mitsyanko <imitsyanko@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>,
        Johannes Berg <johannes.berg@intel.com>
Date:   Sat, 18 Apr 2020 00:08:12 +0200
Message-ID: <1718a2f5ce0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20200417124300.f47f3828afc8.I7f81ef59c2c5a340d7075fb3c6d0e08e8aeffe07@changeid>
References: <20200417124300.f47f3828afc8.I7f81ef59c2c5a340d7075fb3c6d0e08e8aeffe07@changeid>
User-Agent: AquaMail/1.23.0-1556 (build: 102300002)
Subject: Re: [PATCH v2] cfg80211: change internal management frame registration API
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On April 17, 2020 12:43:09 PM Johannes Berg <johannes@sipsolutions.net> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
>
> Almost all drivers below cfg80211 get the API wrong (except for
> cfg80211) and are unable to cope with multiple registrations for
> the same frame type, which is valid due to the match filter.
> This seems to indicate the API is wrong, and we should maintain
> the full information in cfg80211 instead of the drivers.
>
> Change the API to no longer inform the driver about individual
> registrations and unregistrations, but rather every time about
> the entire state of the entire wiphy and single wdev, whenever
> it may have changed. This also simplifies the code in cfg80211
> as it no longer has to track exactly what was unregistered and
> can free things immediately.

For brcmfmac...

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> drivers/net/wireless/ath/ath6kl/cfg80211.c    | 26 +++---
> .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 19 ++---



