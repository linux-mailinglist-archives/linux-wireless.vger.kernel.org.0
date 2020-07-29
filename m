Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708362327CB
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 01:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgG2XCs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Jul 2020 19:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgG2XCr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Jul 2020 19:02:47 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59234C061794
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jul 2020 16:02:47 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 3so4514083wmi.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jul 2020 16:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=269ylzQjQNctXGMdVnPJDYiFbDKRN0PjrTe8acDJgs0=;
        b=E5StH+ap4/xrZff3pqbJTi/30LHS9PTYvUKRT6FYAYDovy+5+lLq+rKeVbMImCW99P
         /0l3UMqpJzZ0X9X5cuZAe5oURplZFe3ZhN/ZY25LoRo4FCDQ2hq1vSs2VKEpyjYJNcYJ
         P3PoQCe5KISTg48Z2NzDv1aDaJM19vi4TUCBCxwIfP1ZuXCOp9qdEcJYID+BIcLzUhXA
         3UDQbbePU+ZNvA5dUhlsB1Fz+HfZ3V+AFniO75vZz6o5zWkA97f3K+p+hYXoDlvqIZf2
         pbW0ZW0Rz0Oblb5aA1BdLVXWakIF3kNf1issCSFund11vf0l/POolQ7hvFvwuZq/TiFG
         LXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=269ylzQjQNctXGMdVnPJDYiFbDKRN0PjrTe8acDJgs0=;
        b=gbHSJX6FeJ8P9cQTtvtl1VnJFQ7/tO+2grPTTYHU/Qff2+CeVpqt1eoBL7sRAKUAVX
         v+Q43KX6psHx/OV6alBbByLuE57akQVtPQnmvkhQ1uqk+KSe/lGlInvVaPMdZJ2zJGLl
         tOw2VbxoWiRLcRSlDvFkOtxPh+bMke7nN81QkyMV70g9ZS7asSQPth2URNryjQ4q+LVw
         pXLZ0MPBn5UA9iWKfUNBN8PyZWT8klVXxwC+9yZxFyDMqZced3yMQdg+INKq3VyaaVKN
         x0KLIau+o1WEjQiFmhsHc2Spp1Rc/tZWAj/7A5t4E2PDUn28odjvWG0ul7fA0xscdQ4k
         ZXIQ==
X-Gm-Message-State: AOAM533eh3xqBmpGG7fSyoYC3B0FgiGNNzyg4dpzEc+2mnUIgU7aDLH6
        5PiJkBSA2prgVaGM7sQWDJn7iJUqxkE=
X-Google-Smtp-Source: ABdhPJyXGLZ8vWZNGgS6XrKx/PibtLay/VbSa+P8m9cWs4cjgaBFVhgBcQMUvE8OVj+/rp7C31WdyA==
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr11027588wmk.145.1596063765667;
        Wed, 29 Jul 2020 16:02:45 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id c14sm7178553wrw.85.2020.07.29.16.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 16:02:45 -0700 (PDT)
Subject: Re: [PATCH v2 5/6] wcn36xx: Fix software-driven scan
To:     Loic Poulain <loic.poulain@linaro.org>, kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
References: <1595586052-16081-1-git-send-email-loic.poulain@linaro.org>
 <1595586052-16081-6-git-send-email-loic.poulain@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <6bf64d76-b327-bc3b-0b1d-c7d965d31ba9@linaro.org>
Date:   Thu, 30 Jul 2020 00:03:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595586052-16081-6-git-send-email-loic.poulain@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 24/07/2020 11:20, Loic Poulain wrote:
> +		if (wcn->sw_scan_opchannel == ch) {
> +			/* If channel is the initial operating channel, we may
> +			 * want to receive/transmit regular data packets, then
> +			 * simply stop the scan session and exit PS mode.
> +			 */

With a longer burn-in, this is breaking for me.

I have a suggested fix which applies on top since I see Kalle already 
has this in his pending tree.

---
bod
