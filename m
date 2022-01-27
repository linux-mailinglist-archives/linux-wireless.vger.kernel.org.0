Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA68E49DF77
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 11:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239101AbiA0KbI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 05:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbiA0KbI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 05:31:08 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11D9C061714
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jan 2022 02:31:07 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id g2so1891426pgo.9
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jan 2022 02:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1kX37wQENXCWiPhriKT3HkFTk3hHEFf0yachEDOMgyE=;
        b=IVEbehBHnLkjoa+wODHbrfw/goFNnGQbBe9eyVGvS4awJkvFnrBscLwMmt5oNQpyBq
         PfNeBK4V8VWWE4W+Phx7ixK8KoSZ10l+t7gxrKkkZEZawiloJHk/MjYtW2LzlhW9gPXs
         oqf9+cHqeXTsbq45zfbIqfEncQ7DAKAv2THqC2uiuWEL9TeFU0F/YBYaELqeDszCrfJF
         JsRyHpZ7ZlCmtOsLweq7uS5BqDqNjUoJ0YA6UdK2pKOs0YR+ppricGPJ6gyJwcwigh2W
         nx7x1agGsE0t6xmWr+kZtzeP+g4J13rqeVS9vkMCvekl/uFV0iYfRSXTBAm9VYcHwtlD
         nFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1kX37wQENXCWiPhriKT3HkFTk3hHEFf0yachEDOMgyE=;
        b=2T9OORz6/GxRKSXm7sqeWXcjdVfx39b30GVfuf6WjdKofQMyXvh9TH7vdBSLZ5eyO1
         8kRwGy3U9BvrddXXJal5Kg2UnRk+Eylznk+UImFTGKXySTzFfjnp3GYBZ9RW6tJQ3o3/
         eEtBsQ1EKT6cnIIo+fhI3V5622qAFcOZC4BdrwNwAuGqDhM7I/mA2BgrkVx8x/fcXMpu
         XKYIUmrMJ9uZ0DUnZ1pFRK0Zu+WcrW7f86QCcLzpZ5OCrzzO/gMPg9VQX4Qv1vi/+US/
         5dfiNNhL/ohyeGpdK/HrbrDuRAuZsM9UrkaHxva4CWP3fOwMdDGZExVihtxYFRTX9krF
         K8OQ==
X-Gm-Message-State: AOAM530vweVkT8dzbrJlHPvffhacKfZMOyvYKiHjQCANBNwl1/YHbm3i
        bi/tjS6W73QNiy4G1I9YVT39aIUHl8W46Lh37js4YXrvioQy5g==
X-Google-Smtp-Source: ABdhPJyrs5iEVqx6fxrYavsoQOVvtavOGWUxbMLMdAohLqYXZos3DkxexFhMiRql+EVoORCP94yrQanMVbnFs56sepo=
X-Received: by 2002:a05:6a00:22c9:: with SMTP id f9mr2437853pfj.79.1643279467078;
 Thu, 27 Jan 2022 02:31:07 -0800 (PST)
MIME-Version: 1.0
References: <20220127092709.5203-1-kvalo@kernel.org> <20220127092709.5203-2-kvalo@kernel.org>
In-Reply-To: <20220127092709.5203-2-kvalo@kernel.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 27 Jan 2022 11:42:40 +0100
Message-ID: <CAMZdPi_o=NOVivz9a_zRDfGRrPS7N70zmY3Tt2o1FC0bJGMZgg@mail.gmail.com>
Subject: Re: [PATCH 2/4] MAINTAINERS: change Loic as wcn36xx maintainer
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, toke@toke.dk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 27 Jan 2022 at 10:27, Kalle Valo <kvalo@kernel.org> wrote:
>
> I don't have time for being wcn36xx maintainer but Loic is willing to step up.
> Thanks Loic!
>
> Also remove Eugene's old tree, it has not been used for a long time.
>
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

Acked-by: Loic Poulain <loic.poulain@linaro.org>

> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e250736e380e..2bf3b1f7442e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16082,11 +16082,10 @@ F:    Documentation/devicetree/bindings/media/*venus*
>  F:     drivers/media/platform/qcom/venus/
>
>  QUALCOMM WCN36XX WIRELESS DRIVER
> -M:     Kalle Valo <kvalo@kernel.org>
> +M:     Loic Poulain <loic.poulain@linaro.org>
>  L:     wcn36xx@lists.infradead.org
>  S:     Supported
>  W:     https://wireless.wiki.kernel.org/en/users/Drivers/wcn36xx
> -T:     git git://github.com/KrasnikovEugene/wcn36xx.git
>  F:     drivers/net/wireless/ath/wcn36xx/
>
>  QUANTENNA QTNFMAC WIRELESS DRIVER
> --
> 2.20.1
>
