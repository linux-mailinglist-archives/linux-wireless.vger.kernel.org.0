Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA0C20BBD2
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 23:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgFZVrO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 17:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgFZVrL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 17:47:11 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7BBC03E97B
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2020 14:47:10 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id s18so6269767vsi.6
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2020 14:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BsR9lAG+ZKuy6S8tfE5+62W+cUzuqeg+ojLakVbeNYo=;
        b=aW00ncwVrcFV+2yTbdUmjoHXoVq4ATu+p9+xi+f1wlmnSA3NL8Ks8YkMfmRkVBWGLZ
         02PcNswuAkpSMd44gS8TChs3zBAVbgAFB6uEGkbIUu3+G5AAlccy/7OvRLdg8NSfD9N3
         sC4WFjH+XU40hw38qYpX+hFt0NnxA4nNWRHYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BsR9lAG+ZKuy6S8tfE5+62W+cUzuqeg+ojLakVbeNYo=;
        b=p94IBBaoHsy0dhPWiUCMz7RvGl+tSvIksflIS6mwKqA+fjJcCwgD9RPQonhFlfl75l
         /JmKlCVe4WIAHRuJaL/3VkEs6DqXF5eEfa1cGODYxNw/xo4ZNqsaWubC+109bWVr1xq9
         /pjnKj2xisuq/csHD6EdtS29GtYkWtEQyrGIgEjdP2UxQxjQup01W52DZ4woRLcfOt6+
         HVR6rVfN3ZDgLKkFvZq57+w01ApLWHrNoZx3DVA379pKPcaTTO5fSn2pu2N3Uxex3ERi
         Qf615pHhfIaMZsA+eFGJkMZDeEdG4FA126n73XaYsY+GghR+9O8pJL8EGC4yvTbQxfxg
         5rIw==
X-Gm-Message-State: AOAM533B6997RYAYpmdz+5AFB6jVT7P1oMtluTOwDiKj0L3zjyYbvPbG
        T8TdG0xyEd8YbVluzVeUGYlkgiXn500=
X-Google-Smtp-Source: ABdhPJygIrHqDcMLD6DiLPzobnbLlAaYE0613c77psI3knoKKDLSVRA6BBwuwM9zVU+lK5IISIYEAA==
X-Received: by 2002:a67:62c4:: with SMTP id w187mr4131039vsb.109.1593208029609;
        Fri, 26 Jun 2020 14:47:09 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id z22sm3649180vsi.1.2020.06.26.14.47.08
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 14:47:09 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id q15so3296169uap.4
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2020 14:47:08 -0700 (PDT)
X-Received: by 2002:ab0:29c1:: with SMTP id i1mr4041837uaq.120.1593208028348;
 Fri, 26 Jun 2020 14:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <1593194502-13164-1-git-send-email-pillair@codeaurora.org> <1593194502-13164-2-git-send-email-pillair@codeaurora.org>
In-Reply-To: <1593194502-13164-2-git-send-email-pillair@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 26 Jun 2020 14:46:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X+v1TpZQPBZNV_Azt8J=0ZJw+XGJhLbnBxaZJGCCPwVg@mail.gmail.com>
Message-ID: <CAD=FV=X+v1TpZQPBZNV_Azt8J=0ZJw+XGJhLbnBxaZJGCCPwVg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt: bindings: Add new regulator as optional property
 for WCN3990
To:     Rakesh Pillai <pillair@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Fri, Jun 26, 2020 at 11:02 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
>
> Add an additional regulator supply as an optional
> property for WCN3990.
>
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
>
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Overall though: aren't you missing a whole lot of CCs?  Have you tried
using get_maintainer?


> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> index 65ee68e..b7188d3 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> @@ -65,7 +65,8 @@ Optional properties:
>                                      the length can vary between hw versions.
>  - <supply-name>-supply: handle to the regulator device tree node
>                            optional "supply-name" are "vdd-0.8-cx-mx",
> -                          "vdd-1.8-xo", "vdd-1.3-rfa" and "vdd-3.3-ch0".
> +                          "vdd-1.8-xo", "vdd-1.3-rfa", "vdd-3.3-ch0"
> +                          and "vdd-3.3-ch1".

nit that could probably be fixed by maintainer when applying: missing
comma at the end of "vdd-3.3-ch0"

I will also note that this file is in dire need of being converted to
yaml.  Pretty soon I think people are going to start disallowing
changes to the bindings that haven't been converted to yaml so you
probably want to get a jump start on it so future patches aren't
stalled.

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
