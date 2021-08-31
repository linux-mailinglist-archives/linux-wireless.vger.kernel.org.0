Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151B53FCCEE
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Aug 2021 20:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhHaSWx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Aug 2021 14:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbhHaSWx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Aug 2021 14:22:53 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74063C061575
        for <linux-wireless@vger.kernel.org>; Tue, 31 Aug 2021 11:21:57 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id m4so251619ljq.8
        for <linux-wireless@vger.kernel.org>; Tue, 31 Aug 2021 11:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KsNRskN10uGdBS+FAhPOIQh/5DxFwy8MHfzSDSxX5Uw=;
        b=HIZJbD1ZWTB3ivppNQo6KKvLKNJBkZB+gB6ECFKBKCdp2BQMTOL8XIFSnwtuvbiwmG
         O8glyNjDNLhlM2Q4kXKPB8mPT+qVL8C7+vEo81+qGz1cY7E9A0QC3zhE0Hiv9dZjiNf0
         mQdFN0OQF2VZwuoAvvKDHbsSPx5Zuhaedt7cFTjAWncmVpvESSv2DD7QzMrkBf2L5d/F
         0na7mJ1dpycu27ttIkjZRsECQ14Lb8CKr6sPjYha9+LYhDARhI7fGzYjl7iBq8C1AEPz
         sCnFxhUni7bHJn2yj0TF/ksTTfLvx1d5OUmoJD47NNKnzq9rFpXYe1j9zm6K/fQEyuAJ
         lLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KsNRskN10uGdBS+FAhPOIQh/5DxFwy8MHfzSDSxX5Uw=;
        b=FNcH4IWD4qLCWEY1myMVYuxmp2IqP6+hSxcXliNPitYxmW6yL62mjqmRhhKkyvvDTd
         NkUlgINDbnyuYUpCZsOFNztN3Jw+md/DWL3fUHnOaJvYhgnnjeXLi/fwgJ/inDkBzEwM
         fRp3qB+wvLh0rJ1jfX0MW5AoZDmGzXObv706FBR1ZWWLQ2N2vn7FC/odISi/K7NSm7+L
         8jdB/hsMpMgf2mqh97cXsHow4feCC8mChYuZzMDIsJVzyN/qQhCUYuOC1Xdj5LIbfdmZ
         YB5xKr5wAC4whHGf9RHhz5iyjzmMQOfLbPlj683wz9SNKf4Vh31SSSsO4Sh0HPqWw+p+
         Y90A==
X-Gm-Message-State: AOAM530PpgLUCh1c16UYn2MCjlM5qse7mwvbb9MZCPOkrijKnzBjSZ8n
        Y4Jv5Hw1l8Mlbhsr/MZL5wm68ZaKbAhexFKy8cc=
X-Google-Smtp-Source: ABdhPJxL1IAF36zhJIY0JnAWPwhELmGCoNSgButeIYRUVeDMKk0MaHJtpBax9vrnDkmDUw4+cJmIsh9Udy1ud2Fk7zk=
X-Received: by 2002:a2e:8e8f:: with SMTP id z15mr25480012ljk.121.1630434115728;
 Tue, 31 Aug 2021 11:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210824144339.2796122-1-festevam@denx.de>
In-Reply-To: <20210824144339.2796122-1-festevam@denx.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 31 Aug 2021 15:21:44 -0300
Message-ID: <CAOMZO5De71QvbvAsddCzAmGRULTie3hPqBJgo6ytVV6pEkisXw@mail.gmail.com>
Subject: Re: [PATCH] ath10k: sdio: Add missing BH locking around napi_schdule()
To:     Fabio Estevam <festevam@denx.de>, Kalle Valo <kvalo@codeaurora.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marek Vasut <marex@denx.de>, wgong@codeaurora.org,
        alagusankar@silex-india.com, erik.stromdahl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On Tue, Aug 24, 2021 at 11:46 AM Fabio Estevam <festevam@denx.de> wrote:
>
> On a i.MX-based board with a QCA9377 Wifi chip, the following errors
> are seen after launching the 'hostapd' application:
>
> hostapd /etc/wifi.conf
> Configuration file: /etc/wifi.conf
> wlan0: interface state UNINITIALIZED->COUNTRY_UPDATE
> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
> Using interface wlan0 with hwaddr 00:1f:7b:31:04:a0 and ssid "thessid"
> IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> wlan0: interface state COUNTRY_UPDATE->ENABLED
> wlan0: AP-ENABLED
> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
> ...
>
> Fix this problem by adding the BH locking around napi-schedule(),
> in the same way it was done in commit e63052a5dd3c ("mlx5e: add
> add missing BH locking around napi_schdule()").
>
> Its commit log provides the following explanation:
>
> "It's not correct to call napi_schedule() in pure process
> context. Because we use __raise_softirq_irqoff() we require
> callers to be in a context which will eventually lead to
> softirq handling (hardirq, bh disabled, etc.).
>
> With code as is users will see:
>
> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
> "
>
> Fixes: cfee8793a74d ("ath10k: enable napi on RX path for sdio")
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Gentle ping on this one.
