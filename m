Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF9167C55F
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 09:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbjAZIBr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 03:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjAZIBq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 03:01:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FB566EC8;
        Thu, 26 Jan 2023 00:01:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9A71B81D09;
        Thu, 26 Jan 2023 08:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36EFC433EF;
        Thu, 26 Jan 2023 08:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674720103;
        bh=O8fH/gQ/PhcTjJUDDmcX68F+GoyfX/eoRR1/IyK3BjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJfTpRO3iqXgT2NzbKELI4qTgFLoubeg2PwkBau6E/no6yK3CDjBL3U2QWETuOR7H
         zNfeDciS2gzuoZUBdn7tsfyCNndixKtfLM9ocZ0ctbdKjiliG6cincJQot5LEFgUII
         NycMnBdVw1IutpDz1ALoA8KmL8rMR8DKydDgCt/hUf0Jdech4d3/imNxoRgbEzjsMU
         BaMWmEFPnOW2Z/hJYfKUhhp5P9MAkbVd/K6yzxztKQcBTKE8ddl2TiKJZR+Gu+cYdU
         tZL7yTjdy7OjDCM1uNCE0E5j99yOrWJoxhfqESoso0CZetGo3puU9nB5qw2etUa446
         sc17HJ+soWTfw==
Date:   Thu, 26 Jan 2023 08:01:37 +0000
From:   Lee Jones <lee@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: leds: Document Bluetooth and WLAN
 triggers
Message-ID: <Y9IzYdO64NXJc09o@google.com>
References: <0d0de1bc949d24e08174205c13c0b59bd73c1ea8.1674384302.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d0de1bc949d24e08174205c13c0b59bd73c1ea8.1674384302.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 22 Jan 2023, Geert Uytterhoeven wrote:

> Add the missing trigger patterns for Bluetooth and WLAN activity, which
> are already in active use.
> 
> While at it, move the mmc pattern comment where it belongs, and restore
> alphabetical sort order.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dtb: leds: bt_active_led:linux,default-trigger: 'oneOf' conditional failed, one must be fixed:
> 	'hci0-power' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
> 	'hci0-power' does not match '^mmc[0-9]+$'
> 	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
> arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dtb: leds: wlan_active_led:linux,default-trigger: 'oneOf' conditional failed, one must be fixed:
> 	'phy0tx' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
> 	'phy0tx' does not match '^mmc[0-9]+$'
> 	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
> 
> v2:
>   - Add Reviewed-by.
> ---
>  Documentation/devicetree/bindings/leds/common.yaml | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
