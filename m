Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1427D45E125
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Nov 2021 20:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350491AbhKYTu1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Nov 2021 14:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356742AbhKYTs1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Nov 2021 14:48:27 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACD0C061574
        for <linux-wireless@vger.kernel.org>; Thu, 25 Nov 2021 11:43:28 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1mqKeP-0002Mm-Pj; Thu, 25 Nov 2021 20:43:21 +0100
Date:   Thu, 25 Nov 2021 19:43:13 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH] mt76: eeprom: tolerate corrected bit-flips
Message-ID: <YZ/nUd3pil+DQTjI@makrotopia.org>
References: <YZ/XvfwzqUyjmBCm@makrotopia.org>
 <8ed35f3f-b0a2-dd93-e78c-33233bc6497a@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ed35f3f-b0a2-dd93-e78c-33233bc6497a@nbd.name>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 25, 2021 at 07:44:26PM +0100, Felix Fietkau wrote:
> 
> On 2021-11-25 19:36, Daniel Golle wrote:
> > mtd_read() returns -EUCLEAN in case of corrected bit-flips.
> > As data was read, don't error out in this case.
> > 
> > Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >   drivers/net/wireless/mediatek/mt76/eeprom.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
> > index 2d58aa31db934..0eb98f7ff7ec0 100644
> > --- a/drivers/net/wireless/mediatek/mt76/eeprom.c
> > +++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
> > @@ -65,7 +65,7 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
> >   	offset = be32_to_cpup(list);
> >   	ret = mtd_read(mtd, offset, len, &retlen, eep);
> >   	put_mtd_device(mtd);
> > -	if (ret) {
> > +	if (ret && !mtd_is_bitflip(err)) {
> I don't think this will even compile (err vs ret)

Oops, that has sneaked in when making use of the macro last minute.
I'll send v2.
