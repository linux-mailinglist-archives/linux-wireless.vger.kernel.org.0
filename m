Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDDA3EF4BC
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Aug 2021 23:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbhHQVPY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Aug 2021 17:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhHQVPX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Aug 2021 17:15:23 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0693BC061764
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 14:14:49 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so902133pjb.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 14:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=owZMYGru73ewOEwyj3kZpdG85swNx+si4visR9IJsw8=;
        b=RYuNIMAtVr+w1JFOjbdG4Wd4gGgjUH+3YxIojGlb7YZuFd88IpM6Nvc/GXRs8BUOx0
         1jOu7Ikw+3vePLQQ/DHtXJjmYI8TMuhlMKgpXRvsHwi8aofQvg7BUoeytn3lhp2XRmiT
         Rx7VzxWymVq+1TczO/aTa8Q1Q4FA3z9oKdHONhkEHJfun2L+yAuBgVfqRyxE5I7Vs1+x
         M0+/01U3HThsChyIv3CPHn+Df5TnGlEj1fWlXLy5NiDZnvAu1TP0PBpPslYGWDV7YlhN
         7LrQpOARQpGhKbbXOoIFSbPGVRud3ttZHFHlOJsLn3wDz+L8FL+tPJksbSvTH9+GVsqg
         tB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=owZMYGru73ewOEwyj3kZpdG85swNx+si4visR9IJsw8=;
        b=nil2Ux6i+rmqErhi4oPCoMF+N65BEIV28L2I8o7qyszDP4ecLDzpIsIeOINhIcIOKV
         te/mPU3NYdVKUC5m5qDav9J78y9EjCQixBNSX+ZxgkFaq/BLjTHpXVOS9SJcUjtEeR5m
         j7xvABb5gnceB7bKlwOwM+JXI4+v2wc+xSjzHsdsubcB+8OJzieyKUERvv3B0XW69BZ8
         9l6Ao4yBO//jnjzFT46vFjVMt9D3kxG8pULfZVPhfEXLS5NIH+ISux+pvYT8M6mDNpmg
         SIUj5RIqq7X7FU6Q1dwJ2q1BrRfuMU9A2RMkyMAL9KN506HYgrTcjhUPuIzc0HOT5UKg
         8YoQ==
X-Gm-Message-State: AOAM533zAMTIJSIQOEDFNlV1b774+AjEEPeC52oT2C3KaXGCy9hV2TJQ
        joz8ye8uWOB4iNSokJkB4IY=
X-Google-Smtp-Source: ABdhPJyvs7litjAn0YqdRNOg5Fv+qisukd7I8uRkEMIoIK+T2UMDJBEclOerN3OMHEIaC66klcxxBQ==
X-Received: by 2002:a05:6a00:230e:b029:3c4:24ff:969d with SMTP id h14-20020a056a00230eb02903c424ff969dmr5589637pfh.44.1629234888562;
        Tue, 17 Aug 2021 14:14:48 -0700 (PDT)
Received: from [10.230.42.144] ([192.19.152.250])
        by smtp.gmail.com with ESMTPSA id z2sm4631328pgz.43.2021.08.17.14.14.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Aug 2021 14:14:47 -0700 (PDT)
From:   Arend van Spriel <aspriel@gmail.com>
To:     Tejun Heo <tj@kernel.org>, Sean Anderson <sean.anderson@seco.com>
CC:     <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "Chi-hsien Lin" <chi-hsien.lin@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        <SHA-cyfmac-dev-list@infineon.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        <brcm80211-dev-list.pdl@broadcom.com>
Date:   Tue, 17 Aug 2021 23:14:38 +0200
Message-ID: <17b55f75630.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
In-Reply-To: <YRv/xUlC5sIMbCxI@slm.duckdns.org>
References: <20210802170904.3116223-1-sean.anderson@seco.com>
 <e6eb89af-b81e-b96e-70a6-c9498eb681fd@seco.com>
 <17b551dc6e0.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
 <c5bba530-1002-a3fa-322a-1045bf7ee4c2@seco.com>
 <YRv/xUlC5sIMbCxI@slm.duckdns.org>
User-Agent: AquaMail/1.30.1-1828 (build: 103001000)
Subject: Re: [PATCH] brcmfmac: Set SDIO workqueue as WQ_HIGHPRI
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On August 17, 2021 8:28:23 PM Tejun Heo <tj@kernel.org> wrote:

> Hello,
>
> On Tue, Aug 17, 2021 at 02:21:55PM -0400, Sean Anderson wrote:
>>> While I understand the obvious gain it seems like a wrong move to me. What 
>>> if all workqueues in the kernel would start using this flag? I bet the gain 
>>> above would be negated and all are equal in the eyes of .. the kernel
>>
>> Is there an official policy on what counts as high-priority? Using some
>> very-scientific methodology [1], it seems like most high-priority
>> workqueues are in drivers/net and fs. Making these queues high-priority
>> seems to be commonplace. For example, in fe101716c7c9 ("rtw88: replace
>> tx tasklet with work queue"), Po-Hao Huang remarks:
>
> I think this is actually a good candidate for HIGHPRI. As you noted, stuff
> which interacts with hardware in latency sensitive manner with impact on
> observable performance is one of the common use cases. The alternatives
> would be doing it from hard/softirqs which are higher priorities anyway.

Hi, Tejun

Thanks for the explanation.

Regards,
Arend


