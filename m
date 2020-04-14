Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E34F1A8F09
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 01:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbgDNXTv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 19:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731159AbgDNXTq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 19:19:46 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53A6C061A0E;
        Tue, 14 Apr 2020 16:12:11 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id e20so1570145otl.2;
        Tue, 14 Apr 2020 16:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3LvyUE2GUTR0pHYEnmT2tUO1UdeQFGwAkp9xm1vgbDE=;
        b=r7KnoE1Rf0QB6fpyKgG1zNAtU62O5MI8aVvjcVSHWL09B+7LTqa9uSItn7s/TC8aSw
         KogZXmBpftxyvLGDLWwleZITx9MGqvghol0yYRRiuOf1yNe49/VmosnldvFbZrTSCY2a
         vThVGqtqJax2MZEnCS3LsnXhMqSeC9lxGMk8G4Uf/3iMzQx3nac6SRGiAFw0BGM7ZO0u
         y5nQWtzw23+GyuNHpHu02Xx/sGTcszMtZa6kt/E3h+y54f9ixkouBorScxcRsgekFM2W
         PpcbMQ/OwWgN1ibdYXNgojQm8HMoNK6nghQHJiKBVdrQrIQ0JozWVI0Cdy3WlIU4B5A8
         sFlw==
X-Gm-Message-State: AGi0PuZnKo4ZSXoqhCubfVZkC/6rzsTee3MnMkJcPn9i0fvaFJop5+yJ
        KuffyQvXSogL5Fbk/Ro6liY4oFc=
X-Google-Smtp-Source: APiQypLk3qLcQHFn2yII+iHdQeLwDivd6L18ckP1XjH5hhG+LHdjUeIJ5HA6/l0lOU/TzU6subtL1Q==
X-Received: by 2002:a9d:5381:: with SMTP id w1mr10846785otg.288.1586905930992;
        Tue, 14 Apr 2020 16:12:10 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n184sm5538526oih.58.2020.04.14.16.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 16:12:10 -0700 (PDT)
Received: (nullmailer pid 7707 invoked by uid 1000);
        Tue, 14 Apr 2020 23:12:09 -0000
Date:   Tue, 14 Apr 2020 18:12:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: net: wireless: mt76: document
 mediatek,eeprom-merge-otp property
Message-ID: <20200414231209.GA7642@bogus>
References: <20200406102203.54450-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406102203.54450-1-nbd@nbd.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon,  6 Apr 2020 12:22:00 +0200, Felix Fietkau wrote:
> It is used to enable merging of Flash EEPROM data with OTP ROM calibration.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  .../devicetree/bindings/net/wireless/mediatek,mt76.txt         | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
