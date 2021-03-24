Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BCA347FC2
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Mar 2021 18:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbhCXRsF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Mar 2021 13:48:05 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:37880 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237051AbhCXRrm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Mar 2021 13:47:42 -0400
Received: by mail-il1-f169.google.com with SMTP id z9so22140620ilb.4;
        Wed, 24 Mar 2021 10:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6sFpKFDAR45P8qdi3OXzURHMKJVWv82SmLUCIRQWPIM=;
        b=tEUSalxjzLbJRqlkvRF/242P0N4t1rAcOV2uussJQGKuj1xX4JGERmuVPtva3qvWFv
         KX3u6D6xnXW2dGY+SMNgbTT0N1pPoNtp0NvJhhg/wyNe38yVYSsA5q2ijQO0Zhs0uBm6
         //gwe4syjZf1TJY8tHXNswJxS+se2RlUT3KVUrNmklFwo6rmjDmSOfiIcH76Pvlb/inE
         JytSJOLhihD4qhQqmDGQW6BcDvH06tg2+yV21h6ZxzCUozcbywaWf0fCYALssCVY/SKY
         L7nuNYet57NZZibiX0eV9aAN+5UmKKe6M4kW+eA0FC4WUJkjbYqjRPQ8znd+/HP0SPf8
         Ig9A==
X-Gm-Message-State: AOAM531dQ6lP35OWvGyschT9ipX+BHo3r+cgORY7neymIHFWJtoXUjEG
        /GeCIkzVw768LXIASXfnlw==
X-Google-Smtp-Source: ABdhPJyqrL3BcB/i265I4XT5qqsYGCd20UIfjpbAzrPNcmR+MMZccTtSqfNzzFe8IkqMWqfZzrbLyA==
X-Received: by 2002:a05:6e02:1a68:: with SMTP id w8mr3731496ilv.129.1616608062252;
        Wed, 24 Mar 2021 10:47:42 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id c18sm1429263ild.37.2021.03.24.10.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:47:40 -0700 (PDT)
Received: (nullmailer pid 3319752 invoked by uid 1000);
        Wed, 24 Mar 2021 17:47:37 -0000
Date:   Wed, 24 Mar 2021 11:47:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org,
        Wright Feng <wright.feng@infineon.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Julian Calaby <julian.calaby@gmail.com>,
        SHA-cyfmac-dev-list@infineon.com,
        Arend van Spriel <aspriel@gmail.com>,
        devicetree@vger.kernel.org,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        Franky Lin <franky.lin@broadcom.com>
Subject: Re: [PATCH v2] dt-bindings: Convert the BCM4329 bindings to YAML and
 extend
Message-ID: <20210324174737.GA3319687@robh.at.kernel.org>
References: <20210315105911.138553-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315105911.138553-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 15 Mar 2021 11:59:11 +0100, Linus Walleij wrote:
> This converts the BCM4329 family bindings to YAML schema, and
> extends and fixes the bindings like this:
> 
> - Name the bindings after the first chip (BCM4329) since
>   wildcards like 43xx are nowadays frowned upon by the DT
>   binding reviewers. We call this the "BCM4329 family"
> - Add compatible strings for all the variants that seem to
>   exist in the wild. (Derived from firmware listings.)
> - Support specific-to-generic compatible strings (as already
>   in use in DTS files).
> - Add required reg property (SDIO function number)
> - Add reset-gpios property (some systems wire this to a GPIO
>   line).
> - I have only listed Arend as maintainer for now, volunteers
>   can be added.
> 
> Cc: Arend van Spriel <aspriel@gmail.com>
> Cc: Franky Lin <franky.lin@broadcom.com>
> Cc: Hante Meuleman <hante.meuleman@broadcom.com>
> Cc: Chi-hsien Lin <chi-hsien.lin@infineon.com>
> Cc: Wright Feng <wright.feng@infineon.com>
> Cc: Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
> Cc: Julian Calaby <julian.calaby@gmail.com>
> Cc: brcm80211-dev-list.pdl@broadcom.com
> Cc: SHA-cyfmac-dev-list@infineon.com
> Cc: linux-mmc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Specify specific-to-generic compatible strings such as
>   "brcm,bcm4334-fmac", "brcm,bcm4329-fmac"
> - Also allow just "brcm,bcm4329-fmac" for legacy platforms.
> - Use this scheme in the example.
> ---
>  .../net/wireless/brcm,bcm4329-fmac.yaml       | 101 ++++++++++++++++++
>  .../net/wireless/brcm,bcm43xx-fmac.txt        |  38 -------
>  2 files changed, 101 insertions(+), 38 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
> 

Applied, thanks!
