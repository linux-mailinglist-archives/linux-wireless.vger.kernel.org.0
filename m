Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D3634B7F4
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Mar 2021 16:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhC0PUo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Mar 2021 11:20:44 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:44820 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhC0PU2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Mar 2021 11:20:28 -0400
Received: by mail-ot1-f47.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso8054527oti.11;
        Sat, 27 Mar 2021 08:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y2nDl8Qp49K1yQrpV7e9/juhNchofsPL7Vdk+I1KTL0=;
        b=YybwlyVcdt4tNVxaoxx2e91CArPwQSZhAoAdkLjclUxXuu0/x6sWEKLEjIO1fTxN1r
         IdPna0TrsquH00tK/xHAZbVmEdHlr/ZTMAIBsXkpvQCZxWoaBUa5pOeaaFpwKHXVMgfN
         +l23By99hTPuJVgNWxxxNCf45i+HoUfnsav0W4gvhDfo1Bwypq84q03NA3UttvDt/huQ
         jcOASxHuugBZJXwYVz/P3DKzU08sDE7myQEEIjRfHQDELUDgCK/RDUCedOCO1elnX93H
         ih/jvH3z0ZE4wq2Wd3bNASXTedF8eAv26zD3ZmGihVhI00IP4L401t+JWZwForJIrBV4
         KzqQ==
X-Gm-Message-State: AOAM533ex0JQjwpZw4NVaD2K+j/35oAMHRtEs+75AzEokraHjS+6hci2
        wi/q8HHTHgeLUwmB8EH+Yg==
X-Google-Smtp-Source: ABdhPJxdgNgpaoriB+w1PpB8N9T/oN78d8GoVYt97ZwEAMknW5UaOX07BVMK8zHhRiYw87X2laTSwQ==
X-Received: by 2002:a05:6830:4001:: with SMTP id h1mr15454061ots.159.1616858427606;
        Sat, 27 Mar 2021 08:20:27 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.102.185])
        by smtp.gmail.com with ESMTPSA id y11sm3013487ots.80.2021.03.27.08.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 08:20:26 -0700 (PDT)
Received: (nullmailer pid 139887 invoked by uid 1000);
        Sat, 27 Mar 2021 15:20:23 -0000
Date:   Sat, 27 Mar 2021 09:20:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        devicetree@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: Re: [PATCH v3 1/2] dt-bindings:net:wireless:ieee80211: txt to yaml
 conversion
Message-ID: <20210327152023.GA139828@robh.at.kernel.org>
References: <cover.1616621229.git.lorenzo@kernel.org>
 <248bcf217858a827849758e5af48b02376bca28f.1616621229.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <248bcf217858a827849758e5af48b02376bca28f.1616621229.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 24 Mar 2021 22:49:59 +0100, Lorenzo Bianconi wrote:
> Convert generic ieee80211 dts bindings from .txt to .yaml
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/net/wireless/ieee80211.txt       | 24 ----------
>  .../bindings/net/wireless/ieee80211.yaml      | 45 +++++++++++++++++++
>  2 files changed, 45 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/wireless/ieee80211.txt
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
