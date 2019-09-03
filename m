Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F877A72FA
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 20:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfICS70 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 14:59:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33980 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfICS70 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 14:59:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id y135so709578wmc.1
        for <linux-wireless@vger.kernel.org>; Tue, 03 Sep 2019 11:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cCiLi9G0JnKfIu6Oqo9KsIMKr5FffxQ/wE79TYJXYJ8=;
        b=PW43JY3GLYffNhYGwvG4PmrwwJynONIOML3Dg/XLnMNqG5v8g4uPnCKzL6Cg9+R4pf
         6X7ekYkgqNwbEAOsuaC55pR/RExBwRLcs5iDXbKqjInnhuf8JO18i8b1GOCEkkcb1FWk
         SaLSolck+6YhG4ktS9tRIONHr9iiRW257xz4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cCiLi9G0JnKfIu6Oqo9KsIMKr5FffxQ/wE79TYJXYJ8=;
        b=qfwDTMGVLyHhweopSJVzczapANtAB6dCh4ZTRBa9F6YOsD7DFhKe/GCpvUcHwU9As+
         SZQMLDcz6JCJf7jd1tAzvXBkZ9yjjGMJfDnX2bKHZcOMnqkmPyI9kpHRR1VSHbK6EQEh
         IK3WcN9hu7KYn5tKGAJhiRNjENCOBjVfLxb0YmCTM6YO/ebhpa6Th9eJWTUsIROT4fp9
         dCadtYdP8y7GE9Egt06txM8LDA52uCLoS3c/Z9nmQTU/NvtS5ppaYzA3WF+FQPJJsmgl
         fHxKOV36gDfM08abETvWgr0/OP7qKZRxfZetKjdYtnjcj/PIlLqg7SRjchQ8v93EpR9T
         P5Yg==
X-Gm-Message-State: APjAAAXQyWMy67wVz3LlJMYz9KDCdi4ZTq//qSa1nxdZRIPDowB0RCmf
        GsCyyUCC2+oFBygQkU6hhn9vrQ==
X-Google-Smtp-Source: APXvYqzCgEaq7mSDYcP4jQvw/l4Mj3ogsX95tQ4YPTp6uNy21cpb64iibkzPMkhxPIZ39mBWOKW2lg==
X-Received: by 2002:a05:600c:259:: with SMTP id 25mr981158wmj.158.1567537163797;
        Tue, 03 Sep 2019 11:59:23 -0700 (PDT)
Received: from [10.230.33.15] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id b194sm291318wmg.46.2019.09.03.11.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 11:59:23 -0700 (PDT)
Subject: Re: [PATCH 1/3] brcmfmac: move "cfg80211_ops" pointer to another
 struct
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Winnie Chang <winnie.chang@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20190903042928.18621-1-zajec5@gmail.com>
 <20190903042928.18621-2-zajec5@gmail.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <527c6f46-bad4-58ac-afce-ca62ddda7c5b@broadcom.com>
Date:   Tue, 3 Sep 2019 20:59:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903042928.18621-2-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/3/2019 6:29 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This moves "ops" pointer from "struct brcmf_cfg80211_info" to the
> "struct brcmf_pub". This movement makes it possible to allocate wiphy
> without attaching cfg80211 (brcmf_cfg80211_attach()). It's required for
> later separation of wiphy allocation and driver initialization.
> 
> While at it fix also an unlikely memory leak in the brcmf_attach().

Always good ;-)

I recall there is some fiddling with the callback ops in cfg80211.c. Is 
that broken by this reorg. Need to look into that.

Regards,
Arend
