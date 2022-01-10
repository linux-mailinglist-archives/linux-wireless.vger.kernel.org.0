Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD0748A12D
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jan 2022 21:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343620AbiAJUx4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jan 2022 15:53:56 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:45624 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243927AbiAJUx4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jan 2022 15:53:56 -0500
Received: by mail-ot1-f41.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso16353042otf.12;
        Mon, 10 Jan 2022 12:53:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5jViEVNaH5ssihtRUb66g7EwfG1jcOv2MY8O9pmmorg=;
        b=jr1y3+cvYiz38kI6D8xwntQ2GZx5zT5oxD2hwInrp7ZsxhrtOWP1BVyZpxkzu8jMHC
         z3FE1X3jmvE3Zp1vBlDs+bWZYsOzPaOggu3dEFlkjjzUpj5oMpQh8RKeJS3XuO874oy1
         4oSVZMXvTWShSQ0jSIrwvxg8wDkrFUWCwG6zCXmrvo+681nIanJM0m0Nt8q11TMFJJbh
         1va90ozhCRdhao/cmZr4Ff85Xg9RPpJ9Fql3a6nhM7GLS83ybtHn2mVX1AegFX4AxObl
         mbK4u3NV5Sn74aIjd4lJqvblIOt7Ps0y1wyw+45v7QLv+LJVFCwUaJQqHdbSQfxmWtip
         0FYg==
X-Gm-Message-State: AOAM5327reslkrOuqZydBKI9wD4PG1PEv+srzdJFZ4vv+GRB+y2KKHNr
        PFYmJeJ3Jmy1FVqhEMbx3g==
X-Google-Smtp-Source: ABdhPJxjZ2jynEBItpLqt9NCVitbIruGA6hhf1Cn4rtASR80GBQRgNzOVwIYNjaQXtPgE6AnPKlWyg==
X-Received: by 2002:a05:6830:314b:: with SMTP id c11mr1192713ots.145.1641848035368;
        Mon, 10 Jan 2022 12:53:55 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bc10sm1337791oib.44.2022.01.10.12.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 12:53:54 -0800 (PST)
Received: (nullmailer pid 1489114 invoked by uid 1000);
        Mon, 10 Jan 2022 20:53:52 -0000
Date:   Mon, 10 Jan 2022 14:53:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Arend van Spriel <aspriel@gmail.com>, soc@kernel.org,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Franky Lin <franky.lin@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        linux-wireless@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Ray Jui <rjui@broadcom.com>,
        Wright Feng <wright.feng@infineon.com>,
        linux-rpi-kernel@lists.infradead.org,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        brcm80211-dev-list.pdl@broadcom.com,
        Hante Meuleman <hante.meuleman@broadcom.com>
Subject: Re: [PATCH RFC 2/4] dt-bindings: arm: bcm2835: Add Raspberry Pi Zero
 2 W
Message-ID: <Ydyc4IwORMPNep4z@robh.at.kernel.org>
References: <1641068812-5851-1-git-send-email-stefan.wahren@i2se.com>
 <1641068812-5851-3-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641068812-5851-3-git-send-email-stefan.wahren@i2se.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 01 Jan 2022 21:26:50 +0100, Stefan Wahren wrote:
> Add the Raspberry Pi Zero 2 W to DT schema.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
