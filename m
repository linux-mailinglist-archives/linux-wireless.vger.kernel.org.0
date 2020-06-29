Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4368020E524
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2020 00:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgF2VdI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 17:33:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728638AbgF2SlD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:03 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32DDC23D6A;
        Mon, 29 Jun 2020 13:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593437175;
        bh=hOJIPbJXPvorQtrhgyqOIr37k404XP7JJGNJCE8s+Y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MAX6lR6wO0zARsIgVfVNexIL/S+5tt+gFwta5XG+JfKdCl2/tbJ4ltJxUO2OPNrKa
         GixHl/5xiVLA0/rMJNNFIA3gXA3qacdPqgt4MG48tHiIWMumQBXzIHFPtRCObTrojs
         IE9fAP73j8zkayeTR3FtmWStj0DR0SLZ9TEq4/3I=
Received: by pali.im (Postfix)
        id EE3E381F; Mon, 29 Jun 2020 15:26:12 +0200 (CEST)
Date:   Mon, 29 Jun 2020 15:26:12 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ajay.Kathat@microchip.com
Cc:     linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, johannes@sipsolutions.net,
        Nicolas.Ferre@microchip.com, Claudiu.Beznea@microchip.com,
        Sripad.Balwadgi@microchip.com, Venkateswara.Kaja@microchip.com
Subject: Re: [PATCH v7 00/17] wilc1000: move out of staging
Message-ID: <20200629132612.nl6rfpihzlii6ilh@pali>
References: <20200623110000.31559-1-ajay.kathat@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623110000.31559-1-ajay.kathat@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tuesday 23 June 2020 11:00:04 Ajay.Kathat@microchip.com wrote:
> This patch series is to review and move wilc1000 driver out of staging.
> Most of the review comments received in [1] & [2] are addressed in the
> latest code.
> Please review and provide your inputs.

Hello Ajay! Could you please move SDIO vendor/device ID definitions from
driver code wilc1000/sdio.c to common file include/linux/mmc/sdio_ids.h?

Similar cleanup was recently finished for all existing non-staging drivers:
https://lore.kernel.org/linux-mmc/20200522144412.19712-1-pali@kernel.org/
