Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50E02195649
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2020 12:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgC0LZP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Mar 2020 07:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbgC0LZP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Mar 2020 07:25:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EDC5206F8;
        Fri, 27 Mar 2020 11:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585308314;
        bh=nYLHHHRgW7KyhXgGAfcT0pygfJkAcJNPNdQChIW8IzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=18dP0C8Mb7gJckrnRxRLPL+nbNHpzhZUFKEJGWDnCbTz27iZ61uQ1UzoML5cqpwjZ
         OnMES3/9QvzfhK6otlnz7npww5X9/VLU5sDKzxloN3NhcbnzffEaCd8pBwM/aSppbp
         q/SogzJO2Od4oA1on+He3NN2cgG9I3jI1cN7hBEc=
Date:   Fri, 27 Mar 2020 12:25:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Ajay.Kathat@microchip.com, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, Venkateswara.Kaja@microchip.com,
        linux-wireless@vger.kernel.org, Nicolas.Ferre@microchip.com,
        Adham.Abozaeid@microchip.com, johannes@sipsolutions.net
Subject: Re: [PATCH v6 00/17] wilc1000: move out of staging
Message-ID: <20200327112511.GA1708276@kroah.com>
References: <20200327063302.20511-1-ajay.kathat@microchip.com>
 <87ftduoxou.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftduoxou.fsf@tynnyri.adurom.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Mar 27, 2020 at 01:16:01PM +0200, Kalle Valo wrote:
> <Ajay.Kathat@microchip.com> writes:
> 
> > From: Ajay Singh <ajay.kathat@microchip.com>
> >
> > This patch series is to review and move wilc1000 driver out of staging.
> > Most of the review comments received in [1] & [2] are addressed in the
> > latest code. Please review and provide your inputs.
> >
> > [1]. https://lore.kernel.org/linux-wireless/1537957525-11467-1-git-send-email-ajay.kathat@microchip.com/
> > [2]. https://lore.kernel.org/linux-wireless/1562896697-8002-1-git-send-email-ajay.kathat@microchip.com/
> >
> > Changes since v5:
> >  - handle DT binding review comments suggested in below link:
> >   * https://lore.kernel.org/driverdev-devel/20200320175920.GA31641@bogus
> >  - merged latest driver from staging which contains few cleanup patches
> >    and changes to use crc7 from existing library instead of having
> >    private implementation.
> 
> This is already the third version this month, please avoid spamming the
> list unnecessarily. What you can do to speed up the acceptance is to get
> Reviewed-by tags from people, the more I see those the more confident I
> get about the driver. I will also review this again once I find some
> free time, but don't know when that will happen.
> 
> But it would be good to document in the cover letter what commit id are
> you using as the baseline. That way it's easy to review rest of the
> changes Greg has applied separately and you don't need to resend the
> whole driver everytime.

Using the --base= flag in git format-patch is helpful in automating that
:)

thanks,

greg k-h
