Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3FE439A99
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 17:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhJYPj3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 11:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbhJYPj3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 11:39:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB28C061745
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 08:37:06 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id y78so5846763wmc.0
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UabaFjJbIc5knMtgoSzbReSVzjHUJNdVrXW6X2vdSlQ=;
        b=RegJa8sIQ4iEImoME8YghlKdm6+8c7LHvRfUL65kPvbWoW0VOWyflkv+S8F+zOhjU4
         G1EOJqldfJqJWfFkT+gIy66sqpk5epugWeIn8OQ0tQvWh2QSWjwiARYF++PKLlJ9WAqP
         M9Uhp1NzVwuEG7GuJaiGDW7o9RzeJ5yETJ+vs+tESbFOC9x2gxgqUZs5mMzZkmS0pN0H
         GlL4W07M+sR/B1Q3XNHTzB6CYBsq87cyQjiPIqYv0X4TNtAhJ5ENHmfvTFKHQr0pPUuq
         Ppwt8VdP7NexRJ4ioBAvQ95dLuZCagMMc3ZWRinaRYjkWjTMd6zDzkTI7A9990yNIphn
         M5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UabaFjJbIc5knMtgoSzbReSVzjHUJNdVrXW6X2vdSlQ=;
        b=a7KFRKCz2J5+n163gFiK0ei25V+6wNIRn6l5a2HvqnXMG3SPLeynaMZC6SVeLflLit
         WoPcW3Et5gwp7Efn4QEeGrL2I8XN+EtCqX2TPh1ctVu4eiIg82qxojRyZq/Ba0aKBXm0
         lyBQE3bYTwTRsmEmYwwm0BS5s+rJep/YWpgkAwAck9aiOG3VQoE85ldgZ+LxTVnxT8BO
         fHyJg2AypiHJJ0xZa5HXQhNDzHpja7+eYKz27SDVH+yEdiUj+gl2dE2pYY1u3br5ondC
         X033WiPXpxb8ansqiSwYdgotbysybFnEcDcQ/ERdO0/6Pf+YuctVgLlvmZ2H2qKZF+By
         b5qQ==
X-Gm-Message-State: AOAM532ppGFekZH8/KHZL6IAE1GDfVEBvBoU6Jkl/ULcjdESDL/IdAu9
        ybrvyh08i98RD688woI4DFmVXTbliKBBuA==
X-Google-Smtp-Source: ABdhPJwIAJ6LdpA83jcZYtaMUjBmSnUxGALe/Zl0TVjguWX5gtSA8i414/ChXOSghkaTKf4vohKSXg==
X-Received: by 2002:a7b:c359:: with SMTP id l25mr49929477wmj.84.1635176225220;
        Mon, 25 Oct 2021 08:37:05 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s11sm3549274wru.16.2021.10.25.08.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 08:37:04 -0700 (PDT)
Message-ID: <3e226886-ab82-82f5-65bc-e0fb10fad46c@linaro.org>
Date:   Mon, 25 Oct 2021 16:39:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] wcn36xx: Add chained transfer support for AMSDU
Content-Language: en-US
To:     Loic Poulain <loic.poulain@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
References: <1634557705-11120-1-git-send-email-loic.poulain@linaro.org>
 <163516812328.10163.3396652728924346112.kvalo@codeaurora.org>
 <CAMZdPi9uUXiQZjLLu_ccG6PZgdvdgEKtZQDspEoM1=tXdS0ggg@mail.gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CAMZdPi9uUXiQZjLLu_ccG6PZgdvdgEKtZQDspEoM1=tXdS0ggg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 25/10/2021 16:46, Loic Poulain wrote:
> But it's better than the previous situation IMHO, since we check the
> buffer descriptor to prevent skb breakage.

Let's apply it and see how we go..

---
bod
