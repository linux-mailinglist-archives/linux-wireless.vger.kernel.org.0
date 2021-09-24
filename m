Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DD3417986
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 19:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344050AbhIXRQ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 13:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244773AbhIXRQ2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 13:16:28 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEF1C061571;
        Fri, 24 Sep 2021 10:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5ruyZhY+uNqQtF8QASCLFU3+MFMaR3UtIQqWOeM4Yos=; b=t9Zdmp3xAYoNU5cHTE5ni3/dG6
        YsCG07Nce54lV3wKGf/NRHBz43tJsIYm+0d61quRVfSU+Gaaw7QL0/g+rNW4zcd6DY0nAdSiurP6d
        9lMTtmfN4V3PEdPu5zZ3ykspxqFdUgMt4rtsqKTkoVFRAVvozOXATlMTikFlp2fmbnM4=;
Received: from p57a6fa93.dip0.t-ipconnect.de ([87.166.250.147] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mTomd-0003r9-Sa; Fri, 24 Sep 2021 19:14:47 +0200
Subject: Re: [PATCH 2/2] dt: bindings: net: mt76: add eeprom-data property
To:     Daniel Golle <daniel@makrotopia.org>,
        linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <YSWdv7ZKz7SBtF+v@makrotopia.org>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <de40bcd3-d730-4d6b-27d0-50492fe18404@nbd.name>
Date:   Fri, 24 Sep 2021 19:14:47 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YSWdv7ZKz7SBtF+v@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-08-25 03:33, Daniel Golle wrote:
> EEPROM data for mt76 can be embedded into device-tree as an array.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../devicetree/bindings/net/wireless/mediatek,mt76.yaml      | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> index 3e2c2e43175e5..1489d3c1cd6ec 100644
> --- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> @@ -47,6 +47,11 @@ properties:
>  
>    ieee80211-freq-limit: true
>  
> +  mediatek,eeprom-data:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
Given that the driver patch simply uses memcpy on the data, shouldn't we
use an uint8-array here?

- Felix
