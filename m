Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421E125171C
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Aug 2020 13:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgHYLI5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Aug 2020 07:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729954AbgHYLIv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Aug 2020 07:08:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C42C061574
        for <linux-wireless@vger.kernel.org>; Tue, 25 Aug 2020 04:08:50 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so12275037wrl.4
        for <linux-wireless@vger.kernel.org>; Tue, 25 Aug 2020 04:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kbko0XWxjDqeFleDNdg+dX1lFVAULaz0Q9p/eEZFJyM=;
        b=yOxWgF+ZmIeBXs8vrGzRIVlwBYS1Ndz6bnHj9y0baK9W1ouUaps0xNj3XW1JXPVS9Y
         AQBy69caekVW2FJqE9pfo+XnZe1v9zW7J9QL2OzEvPk2De9hUrTUpMoitB4ydaxGS1o2
         jwdAeeJv4IAQSz+S5ErR6ovRUC27PZAGaPfduNvw/o/qKQRkGkxfUqltf/MJqLoW1JC3
         K4QWDHmM3hlG+1oNChOZuGcCJercAXWMd0/UbcVwKaMyQBhMbAGIKlncgYiookVzyVlC
         PnhfMTE6FyG1I2rNDyX4HKge0gv+zkh6GaO3NzzRggq8MBhSWxEyuhMomkcaWVqrC/MZ
         e7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kbko0XWxjDqeFleDNdg+dX1lFVAULaz0Q9p/eEZFJyM=;
        b=Xz0qk8sYhI0jLa70qfUKQFGVxfox2iq80aQu6+CAe5EsUpEMj5oPbb5lJK1Jbfniqp
         2fanio+esQ1zcmJWsK7CYYF66gz456VsCEu6x/zHPP4jx5OlXzhWpzOtosR0Wl7RVlnS
         9ZTSodyKWp59oNuZtZGLhN1VR3Xh1qLg5seZrOLV1gI/zQTsgewXm5PaiGC7RnwLXpKZ
         b4LMv5exW6JBYT0XDGkF9QDeKdBCqTL1qxSUKRGnlQxC65QmyutVXR2tdE2W9kNjRfVF
         7DGy10orpPERGjtnlotKoowBRHV0yhNj0/JSVWSUOzpoxXKkaTcH0/gvzWb+IJneH7MX
         li1Q==
X-Gm-Message-State: AOAM530J1qfnhyzJnh66U79rWOkbv3ty/Yx+bpwAQnu9SZO92gC/yEts
        sVTEprOwhZJwwutH5um7Bmew5j5dx52KDivd
X-Google-Smtp-Source: ABdhPJyaJ6K4g1ZxGxNru/cT2yHuIR/S5EUWEkiy0TXlYiGXQDJV8oVUw+Me8ESoXMTNelZMmN4LMA==
X-Received: by 2002:a5d:5352:: with SMTP id t18mr9931531wrv.407.1598353729204;
        Tue, 25 Aug 2020 04:08:49 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id j8sm9889883wrs.22.2020.08.25.04.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 04:08:48 -0700 (PDT)
Subject: Re: [PATCH v3] wcn36xx: Fix software-driven scan
To:     Loic Poulain <loic.poulain@linaro.org>, kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
References: <1598288035-19790-1-git-send-email-loic.poulain@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <e32a5ad0-321f-adb5-405e-4d8277be0713@linaro.org>
Date:   Tue, 25 Aug 2020 12:09:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1598288035-19790-1-git-send-email-loic.poulain@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 24/08/2020 17:53, Loic Poulain wrote:
> For software-driven scan, rely on mac80211 software scan instead
> of internal driver implementation. The internal implementation
> cause connection trouble since it keep the antenna busy during
> the entire scan duration, moreover it's only a passive scanning
> (no probe request). Therefore, let mac80211 manages sw scan.
> 
> Note: we fallback to software scan if firmware does not report
> scan offload support or if we need to scan the 5Ghz band (currently
> not supported by the offload scan...).
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   v2: rebased on ath master and squashed with Bryan's fix:
>       wcn36xx: Set sw-scan chan to 0 when not associated
>   v3: finish_scan(): Always restore channel to operating chan

lgtm

