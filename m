Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4C8325544
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 19:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhBYSLz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Feb 2021 13:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbhBYSK6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Feb 2021 13:10:58 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C63C061574
        for <linux-wireless@vger.kernel.org>; Thu, 25 Feb 2021 10:10:18 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id p16so6867687ioj.4
        for <linux-wireless@vger.kernel.org>; Thu, 25 Feb 2021 10:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=cp2kY8C+D5s6UKa/zc6D53lHNbaENlHeW8EVg2V6of4=;
        b=iAOzBH7wG1ujFtJWEWvTZdx4CLWWrxZ8bO+Z4nEGKOV8F/RvtnjJCbzLLiA1lEQuyC
         HYRPpvnGQ0sue2N7CWfVTF5eUse2k3tcE4KKAFsQ/t2rga3llrr7DKk3zPM/9wYnTrwa
         r50OSFwwkR2dkLcuHV86FlbK/y/OUQQO5oIsQYMbRD7uFXTTKwWggFTXsPOX5bT4nq/F
         zpZR6sW7NcT+F1R9AvRm+qfeSW1p2XnJC3v9oZXuhDQsH0MBq+58G7Zji7kNY/510Nx5
         Spq1XYI75zJWT5Dzs4kcJ3Ac1Jy9/QP3RNUIAmnRWnlO0CkVlHh4EpiLWP4p1np/Nfxs
         4rWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=cp2kY8C+D5s6UKa/zc6D53lHNbaENlHeW8EVg2V6of4=;
        b=mCsLJr7qqu5I65tAFFSx68W7yiHemxBrMYUBfJHg0B00rG97FC2tiago1U812TkcAh
         YRxuO9GYFAxxwfula9VSeKNYRnZo0sW6gpOg7vHfGaKZg/q6odOuasOiEeDLM2fJXGEK
         JOxrpfAZTcm73Qhbsd2v/KtV+vhST94tb5ij4Nf2rtCcLCNiLxZZtB1X/TSvZx8bVtbG
         ANeRTOkSlM3XSEfhUL/x0hAi0ZgwCebZdDeU3jiw6xT2IAQ/pHv9iA4Y8xIgyNaknzVM
         +1o0sHL09y1w9I4vLpAKvZRoaCEgWR2aMPpZviFxRP1BFywNX60fN10eiw4OVvqcPC9n
         mw8w==
X-Gm-Message-State: AOAM531M8Z6VieU0+mpbtK/lVcpgqWvHOgBkNVPjhKc5DqjDmAi6b7Rn
        2BP6IJ6G7fU4m3YYlLF6iGUR
X-Google-Smtp-Source: ABdhPJzLu9qKnPMRGkXh8yG36O9Ewvn395JlhJFYMosxg2qzx6ebRYUvx1PZmEsEaZXEjVmIHucnbA==
X-Received: by 2002:a05:6638:512:: with SMTP id i18mr4556766jar.126.1614276617626;
        Thu, 25 Feb 2021 10:10:17 -0800 (PST)
Received: from bixby ([2601:281:8280:3560:dc4c:ffc8:6468:4a5b])
        by smtp.gmail.com with ESMTPSA id x7sm3837110ioa.48.2021.02.25.10.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 10:10:16 -0800 (PST)
Message-ID: <0dc801dd40ccb8bd8197cf117c0b73c63fdcf6f2.camel@egauge.net>
Subject: Re: [PATCH 3/4] wilc1000: Check for errors at end of DMA write
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Date:   Thu, 25 Feb 2021 11:10:15 -0700
In-Reply-To: <87eeh4eelz.fsf@tynnyri.adurom.net>
References: <20210224055135.1509200-1-davidm@egauge.net>
         <20210224055135.1509200-3-davidm@egauge.net>
         <87eeh4eelz.fsf@tynnyri.adurom.net>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-02-25 at 10:27 +0200, Kalle Valo wrote:
> David Mosberger-Tang <davidm@egauge.net> writes:
> > +	for (i = sizeof(rsp) - 2; i >= 0; --i)
> > +		if ((rsp[i] & 0xf0) == 0xc0)
> > +			break;
> 
> No magic numbers. Please create proper defines for these.]
>
> +	if (rsp[i] != 0xc3 || rsp[i + 1] != 0x00) {
> 
> Same here.

Good points.  I'll change those, thanks.

  --david

