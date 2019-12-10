Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C13F9118384
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2019 10:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfLJJ1u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Dec 2019 04:27:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfLJJ1u (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Dec 2019 04:27:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17D1920726;
        Tue, 10 Dec 2019 09:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575970069;
        bh=FXwGmlP7i/ZGQ9Iif2A4jfF4n1WNZuzQofHTptkaPcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aeeBMHyr1E204MPUijGvJJF2bDOP+Hw74l6LisLPKzrGhOtXGPUEKSXhJPRlXxnRz
         K33VP4P7cLH/Ve4QdevGNa3mBLb1ZeNX4VMHRYe2GXUf7xO4q0+ld96OBoIgNkXev5
         fQrAvwyRmZKBbliWrRP8oUk+zH8wmxM9k82DmYt8=
Date:   Tue, 10 Dec 2019 10:27:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Adham.Abozaeid@microchip.com
Cc:     julian.calaby@gmail.com, devel@driverdev.osuosl.org,
        johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        Ajay.Kathat@microchip.com
Subject: Re: [PATCH 1/4] staging: wilc1000: use runtime configuration for
 sdio oob interrupt
Message-ID: <20191210092747.GA3548978@kroah.com>
References: <20191122205153.30723-1-adham.abozaeid@microchip.com>
 <CAGRGNgV=zW8xpgHfj99m9LHN=dtUBH_36_kQSnnBOrd_6WpDoA@mail.gmail.com>
 <a174f958-ddda-b57f-060b-ca4ed7c36ea1@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a174f958-ddda-b57f-060b-ca4ed7c36ea1@microchip.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Dec 03, 2019 at 07:10:26PM +0000, Adham.Abozaeid@microchip.com wrote:
> 
> 
> On 11/25/19 2:26 AM, Julian Calaby wrote:
> > Hi Adham,
> >
> > The OOB interrupt is a GPIO and this is an SDIO card, so why not just
> > set the relevant pin in the devicetree and detect it based on that?
> >
> > I'm pretty sure that the Broadcom fmac driver does something like this.
> Thanks Julian and Dan for your feedback. We will go through the fmac driver to see how to improve OOB selection based on that, and send v2 of this patch.
> Greg, will it be possible to ignore this patch for now and merge the rest of the patch series?

Now ignored!
