Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403E2405A34
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Sep 2021 17:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbhIIPaq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Sep 2021 11:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbhIIPap (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Sep 2021 11:30:45 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED67C061574
        for <linux-wireless@vger.kernel.org>; Thu,  9 Sep 2021 08:29:36 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m21-20020a17090a859500b00197688449c4so1738617pjn.0
        for <linux-wireless@vger.kernel.org>; Thu, 09 Sep 2021 08:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9mh1yFONu1+KVZ1hcIpEXDWxwA0zNLhb3EzEa4tpuY=;
        b=VAjl3a2NIx0JFixcvIf4Eum9SOuxOmtmTgG/94E0bZlG+P5lHYMmwD5lIptQRTZFVJ
         3svcL23YIuCy+JgGVhnScgMacB/xADWhajHZ4pnzgByeRX73KwdA2df8YJodzC26z7ln
         ZzZyTnvm91b/o2IeI0SkDULEpzI3iDMhSJmksni9Hw8x6+p4OrR3GX0QeM53d64UG2/j
         LklJT4GOQFnBpz71BZ53j7vGwKl7XctAPTcfJml7bbMD6KMyox5znrntjJRi+rJcX2wr
         691qdJtmwyLakOGpfYE1TcbxKgLxWb3Lkov60q0SygbHoLYG3pko72Fzz7YAInuO7mgq
         pm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9mh1yFONu1+KVZ1hcIpEXDWxwA0zNLhb3EzEa4tpuY=;
        b=sWaNp4VMRlmN2laovqOKTz66NL9pwsxU0/0UVOUGQkuubCjhSqR4Cv9svR2AJZwgRw
         VjaZPwCJ0MTGKu/X82Lk7F3FPaFaByOjtagJgnNvK+UCsVKZ1ODh/34kFyayt3UAPx6i
         V9gjeewPJUSAx4A+WH8V3zOLp1IAZW2glUBWM9Q9mnv4Ozbdzzh1APgJ+OiOz+KIYjEN
         kpA2TbxjxCQcj2wwJ+h+AvPbftKJfBrB1wLKvteXKgHduGSu+qvYikWDzOTi7bnV8UDs
         OptFoa90pMcgjGXL7l2WOg+DK+gSHxvEVnj9QeSbA4FzLPqZRN4GDQl3oT/tLkpU2jMr
         xvjw==
X-Gm-Message-State: AOAM530Xcl18R/Hk5vnATcHpBLKddaeSMDSMAHqbnZnQngM6Mnxjtg8x
        7+IaKH0PDL2Opws0j2GW4bsGetRzxnO/4gLD8ImrVw==
X-Google-Smtp-Source: ABdhPJya+DpVgaQ+PERUyrEVe+QAI+E+TE/jMqsqhFTEslsDS0txJhrGhgmCej3O8a7wKnqakHlnrpWlk4OTvnYcc9U=
X-Received: by 2002:a17:90a:ab86:: with SMTP id n6mr4120227pjq.159.1631201375443;
 Thu, 09 Sep 2021 08:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210909144428.2564650-1-bryan.odonoghue@linaro.org> <20210909144428.2564650-3-bryan.odonoghue@linaro.org>
In-Reply-To: <20210909144428.2564650-3-bryan.odonoghue@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 9 Sep 2021 17:39:54 +0200
Message-ID: <CAMZdPi9+yH05edfPKHHJd=34X3YF1es2hZH+2=H+=tTWD9xfLQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] wcn36xx: Add ability for wcn36xx_smd_dump_cmd_req
 to pass two's complement
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, Benjamin Li <benl@squareup.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 9 Sept 2021 at 16:42, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> Qcom documents suggest passing of negative values to the dump command,
> however currently we convert from string to u32 not s32, so we cannot pass
> a two's complement value to the firmware in this way.
>
> There is in fact only one parameter which takes a two's complement value
> <tigger threshold> in the antenna diversity switch command.
>
> Downstream:
> iwpriv wlan0 dump 71 3 <schedule period> <trigger threshold> <hysteresis value>
>
> Upstream:
> echo "71 3 <schedule period> <trigger threshold> <hysteresis value>" > /sys/kernel/debug/ieee80211/phy0/wcn36xx/dump
>
> Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
