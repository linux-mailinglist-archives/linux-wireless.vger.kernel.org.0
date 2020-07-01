Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB1321058B
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2020 09:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgGAH4H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jul 2020 03:56:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbgGAH4G (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jul 2020 03:56:06 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6D422073E;
        Wed,  1 Jul 2020 07:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593590166;
        bh=8AVY+EOC1zIp5rtauW5ZfJDYFkhYsE0IK0VPZmhucc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zvIGS5xWsCSlh2c6XlBKR+4PGeNpV3IF1G7KQ9mud+WTa7UHAwSIp0SzOJru1Qpe5
         1dsSiAPmiDs0UWONeSkz2lz7vqk83dyRYwALcL3A3TbaISAFj/ZG3rKx2dMQILuG3X
         eXBpK/HTdB58Ae2Fxzi2Rr7Kin4iQOihjFcH5yTQ=
Received: by pali.im (Postfix)
        id 30880102D; Wed,  1 Jul 2020 09:56:04 +0200 (CEST)
Date:   Wed, 1 Jul 2020 09:56:04 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ajay.Kathat@microchip.com, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, johannes@sipsolutions.net,
        Nicolas.Ferre@microchip.com, Claudiu.Beznea@microchip.com,
        Sripad.Balwadgi@microchip.com, Venkateswara.Kaja@microchip.com
Subject: Re: [PATCH v7 00/17] wilc1000: move out of staging
Message-ID: <20200701075604.7pyik6jkptl37yld@pali>
References: <20200623110000.31559-1-ajay.kathat@microchip.com>
 <20200629132612.nl6rfpihzlii6ilh@pali>
 <c23ca5da-b9db-5e98-94e4-edc84ded9611@microchip.com>
 <20200701075515.zypusfh4xazqu2fl@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701075515.zypusfh4xazqu2fl@pali>
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(adding Ulf)

On Wednesday 01 July 2020 09:55:15 Pali Rohár wrote:
> On Tuesday 30 June 2020 03:17:01 Ajay.Kathat@microchip.com wrote:
> > On 29/06/20 6:56 pm, Pali Rohár wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > > 
> > > On Tuesday 23 June 2020 11:00:04 Ajay.Kathat@microchip.com wrote:
> > >> This patch series is to review and move wilc1000 driver out of staging.
> > >> Most of the review comments received in [1] & [2] are addressed in the
> > >> latest code.
> > >> Please review and provide your inputs.
> > > 
> > > Hello Ajay! Could you please move SDIO vendor/device ID definitions from
> > > driver code wilc1000/sdio.c to common file include/linux/mmc/sdio_ids.h?
> > > 
> > 
> > Currently, the wilc1000 driver movement changes are present in topic
> > branch and yet to be merged to master branch. Would it be okay to submit
> > the new patch once driver is merged to 'wireless-driver-next' master and
> > branch is pulled into Greg's staging repo.
> 
> I think it should be OK. But maybe Ulf as maintainer of mmc subsystem
> could have opinion or react on this.
> 
> > Regards,
> > Ajay
> > 
> > > Similar cleanup was recently finished for all existing non-staging drivers:
> > > https://lore.kernel.org/linux-mmc/20200522144412.19712-1-pali@kernel.org/
> > > 
