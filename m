Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B49422E16
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Oct 2021 18:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbhJEQi1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Oct 2021 12:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbhJEQi0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Oct 2021 12:38:26 -0400
X-Greylist: delayed 1686 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Oct 2021 09:36:35 PDT
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3E5C061749;
        Tue,  5 Oct 2021 09:36:35 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1mXmzM-0004zU-Ko; Tue, 05 Oct 2021 18:08:21 +0200
Date:   Tue, 5 Oct 2021 17:08:05 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 2/2] dt: bindings: net: mt76: add eeprom-data property
Message-ID: <YVx4ZaIZsfNQocT+@makrotopia.org>
References: <YSWdv7ZKz7SBtF+v@makrotopia.org>
 <de40bcd3-d730-4d6b-27d0-50492fe18404@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de40bcd3-d730-4d6b-27d0-50492fe18404@nbd.name>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Sep 24, 2021 at 07:14:47PM +0200, Felix Fietkau wrote:
> 
> On 2021-08-25 03:33, Daniel Golle wrote:
> > EEPROM data for mt76 can be embedded into device-tree as an array.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  .../devicetree/bindings/net/wireless/mediatek,mt76.yaml      | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> > index 3e2c2e43175e5..1489d3c1cd6ec 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> > +++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> > @@ -47,6 +47,11 @@ properties:
> >  
> >    ieee80211-freq-limit: true
> >  
> > +  mediatek,eeprom-data:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> Given that the driver patch simply uses memcpy on the data, shouldn't we
> use an uint8-array here?

When using the /incbin/('file.bin'); syntax the result is included as
what appears to be a uint32-array when decompiling again with dtc.
