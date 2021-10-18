Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3496543293B
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 23:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhJRVqi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 17:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbhJRVqh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 17:46:37 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4372FC061745
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 14:44:25 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r10so43800094wra.12
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 14:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wiP9cqmeNhE3SS3r7/ImXkRP5I5mctQ3JZnalKD2HjA=;
        b=nf6FwWRGGPGgWPUsuDdikgD0xgCWW8s3jEPffWWVX18J8s12PBLlY2LXkCSTKOB1xp
         zji7o8MXCls6mkUQfp+6mq58cSn1c/kKKw23D1IjHw1LKDimzoSNXILwqAM6MkxSZIIg
         UKG14qw4looKKFAZhIKJFXvPxAeEJyeQuWoSL7Nse4+qDMOSuHJ9xByHII/Eg2EkVw7y
         2rd5w7tyTBcaAbAUEGiIbjOiQTWPrCX8rT0cfvhLLMmywYMXsxLuVkJpXWEZfIryPhhK
         8D56G+0qTA9KdcDzzfNO32pzP9gFrkXrAMKl+jDPVgffr8yS8mnEm3DpUtwkTj7Gr0tg
         aoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wiP9cqmeNhE3SS3r7/ImXkRP5I5mctQ3JZnalKD2HjA=;
        b=z46OSyPNyuKjBlgbe3ttM4ku3IZH7Z3B9DvW4XIztctvQA7Sn9jacGuJkHBg39dIb2
         9ZQTAYlRuYwk9MuDzGvGkreQhRjo9lkNM5P99soWxCbXstLa9GZ4Fd37hYpMHSYvYXXe
         hhcl7IfFyxNXEUdbKNGECb7VFhgG239EDW3jClXj7qZQPDGu/NMMuguS52KeMaI8x91t
         xufNLXiKHWQd6/M1RilWAfcuCulDJQdvHA2p+e4aEHFfgIlcHbRJRBmdQIMiVobcTO3n
         iOWCp9iVY265K+HGcvkJaiT9BcJEO+Xhx6kP4kVvo4eCWGvFaYV6KtmaoZrNIXlRtWP8
         izJw==
X-Gm-Message-State: AOAM5332fzhGjIqOGqM1LdZpxaBVLmKOZWHYMIF2NF44qA/XQjgSPNZD
        mA7aTuO2L6JH+lSCyExc8VgHiH6OeLqxIw==
X-Google-Smtp-Source: ABdhPJweINqdwDLBIYpWgleW4JBTYsGWJagJbCR9SwgW/lRVZtsZQK/0jB0Ii1reLykzOGYmqgAC2Q==
X-Received: by 2002:a05:6000:168d:: with SMTP id y13mr38864674wrd.172.1634593463853;
        Mon, 18 Oct 2021 14:44:23 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m2sm557941wml.15.2021.10.18.14.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 14:44:23 -0700 (PDT)
Message-ID: <e5ccf59d-54a9-dbaf-1711-ae370879bd9a@linaro.org>
Date:   Mon, 18 Oct 2021 22:46:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] wcn36xx: Add chained transfer support for AMSDU
Content-Language: en-US
To:     Loic Poulain <loic.poulain@linaro.org>, kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
References: <1634557705-11120-1-git-send-email-loic.poulain@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1634557705-11120-1-git-send-email-loic.poulain@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 18/10/2021 12:48, Loic Poulain wrote:
> WCNSS RX DMA transfer support is limited to 3872 bytes, which is
> enough for simple MPDUs (single MSDU), but not enough for cases
> with A-MSDU (depending on max AMSDU size or max MPDU size).
> 
> In that case the MPDU is spread ove multiple transfers, with the
> first transfer containing the MPDU header and (at least) the first
> A-MSDU subframe and additional transfer(s) containing the following
> A-MSDUs. This can be handled with a series of flags to tagging the
> first and last A-MSDU transfers.
> 
> In that case we have to bufferize and re-linearize the A-MSDU buffers
> into a proper MPDU skb before forwarding to mac80211 (in the same way
> as it is done in ath10k).
> 
> This change also includes sanity check of the buffer descriptor to
> prevent skb overflow.

I like this patch and I think it plugs a gap we have but, my question 
is, have we seen this code be triggered at least once ?

I'm a bit reticent about apply it upstream unless/until we have.

---
bod
