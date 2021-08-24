Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396743F634E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Aug 2021 18:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhHXQv5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Aug 2021 12:51:57 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:39519 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbhHXQv4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Aug 2021 12:51:56 -0400
Received: by mail-ot1-f47.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so47775840otf.6;
        Tue, 24 Aug 2021 09:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vxzzMrhaCDrO9Bdv7oOrHtYo0kuV1Q1/mc8vb+GtZzw=;
        b=iQbJMyDQZvPiCjGZ+u3JZ8OPaQizApgDN5+bEDjmT2JIPTYdKoMAmzAObT/KDDYTy3
         lpVE0EqfZPXa+w9eOYI2QudyW3SRDU8dEJQ4UvFlvZQmROxmUminWiIvwK3e8AEfIb7G
         /t525p1gBn2Ne7iXcWj/evcWp3U1u3i8/qj3spMnpN+cOfz1wjE27+pAb27iRkiDARAC
         bYfcIjGFomksckwWxdjYaGRe7KxN8mLnuZEs8h78u5dJJiX6otgf4TO0yAc2x5ygUxNT
         J2QtkXwGH93dC0nj/P9UCqLnLvi7njRPwH+oyzVYrxQOfk4Z1mI1KdTDcmfUnifxHM61
         jvEw==
X-Gm-Message-State: AOAM531rXtKM2FjKJeY9ynh3YNT/I981DUixSZeODC5w5AKHPEeWzpKw
        7ITZWCzoL46gehrUohJ2GQ==
X-Google-Smtp-Source: ABdhPJweL9A8+TGB7MRX/sxi13E2NkqsN3WiNwlBA2BdzDeWrAUXDrege0wUIesAbi5i2L16+n+VPg==
X-Received: by 2002:a05:6830:1d8c:: with SMTP id y12mr32698037oti.362.1629823871903;
        Tue, 24 Aug 2021 09:51:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e2sm4674475otk.14.2021.08.24.09.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:51:11 -0700 (PDT)
Received: (nullmailer pid 613644 invoked by uid 1000);
        Tue, 24 Aug 2021 16:51:10 -0000
Date:   Tue, 24 Aug 2021 11:51:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/3] dt-bindings:net:wireless:qca,ath9k: add
 nvmem-cells for calibration data
Message-ID: <YSUjfiU0Fx6Ut8kq@robh.at.kernel.org>
References: <91e68ca7f65bee7197ed5829ef91bc526df16e8a.1629508039.git.chunkeey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91e68ca7f65bee7197ed5829ef91bc526df16e8a.1629508039.git.chunkeey@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 21 Aug 2021 03:09:13 +0200, Christian Lamparter wrote:
> On most embedded ath9k devices (like range extenders,
> routers, accesspoints, ...) the calibration data for
> the RF/PHY is simply stored in a MTD partition named
> "ART", "caldata"/"calibration", etc.
> 
> Any mtd partition is automatically registered in the
> nvmem subsystem. This makes is possible to fetch the
> necessary calibration directly from there at the low
> cost of adding nvmem cell information via the
> device-tree or via similar means.
> 
> This speeds up the driver's initialization a lot,
> because the driver doesn't have to wait for userspace
> to provide the data via helpers.
> 
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> ---
>  .../devicetree/bindings/net/wireless/qca,ath9k.txt     | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
