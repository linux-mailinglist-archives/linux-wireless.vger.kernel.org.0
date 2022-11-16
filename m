Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1946562C58B
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 17:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbiKPQ4K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 11:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiKPQzj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 11:55:39 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA3AB3E;
        Wed, 16 Nov 2022 08:55:27 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id q186so19131756oia.9;
        Wed, 16 Nov 2022 08:55:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kiEBJO/YjcMAZi1EqUusiIE2D8QfFJq7eZwFhwMPZso=;
        b=XUhd1YZINCqUB9+lROHYSr+aR4vQtsGz9YdpG0pjowKyb8r4RcNe13HUxe0q/9E34p
         kWJY9YLy4JO5fbk7VYMBZohgKhb9oTXOcNKH4HSpfXWTb3Z7wmpWqUnuaPrWWIxwWga+
         o/+3+VNM2rYqU1HoYen4IuNca3+H4gMW0SlJRVnLk8bajQm+iqjbRaChf7E0LTbxWdp4
         CkjkivKlZ90PtxWS2olXw7TodOHAuzYjr7ZFk09wKCzH0NxlJDXsirGSxj0dihFPzx/0
         Zxar/1QF8VyBVKnID3qDjwVV8H+3UZo67IyPrQmgzAyy31GJ9ki0VC4w30ZKVUSTmeXO
         eAnQ==
X-Gm-Message-State: ANoB5plir3BqjLx4WAp13yijubhaDGmqzBBYKC+MQ9ehNYzYWJfegn9w
        N53zbSGjAWrzO1kwu4CZ/g==
X-Google-Smtp-Source: AA0mqf64Fje3bdOgJ5mS0w+P3LsDO8E8DUlCW+fnA4tU3JbGCGhrmcJnW4mo3simdTwRehr0cYgx7Q==
X-Received: by 2002:a05:6808:688:b0:354:e358:ad2c with SMTP id k8-20020a056808068800b00354e358ad2cmr2056255oig.130.1668617725518;
        Wed, 16 Nov 2022 08:55:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bg2-20020a056808178200b0034fd36e95bfsm6367551oib.31.2022.11.16.08.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 08:55:25 -0800 (PST)
Received: (nullmailer pid 231353 invoked by uid 1000);
        Wed, 16 Nov 2022 16:55:27 -0000
Date:   Wed, 16 Nov 2022 10:55:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, linux-bluetooth@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: leds: Document Bluetooth and WLAN triggers
Message-ID: <166861772609.231295.14812410099261417331.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On Wed, 09 Nov 2022 15:46:06 +0100, Geert Uytterhoeven wrote:
> Add the missing trigger patterns for Bluetooth and WLAN activity, which
> are already in active use.
> 
> While at it, move the mmc pattern comment where it belongs, and restore
> alphabetical sort order.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dtb: leds: bt_active_led:linux,default-trigger: 'oneOf' conditional failed, one must be fixed:
> 	'hci0-power' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
> 	'hci0-power' does not match '^mmc[0-9]+$'
> 	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
> arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dtb: leds: wlan_active_led:linux,default-trigger: 'oneOf' conditional failed, one must be fixed:
> 	'phy0tx' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
> 	'phy0tx' does not match '^mmc[0-9]+$'
> 	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
> ---
>  Documentation/devicetree/bindings/leds/common.yaml | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
