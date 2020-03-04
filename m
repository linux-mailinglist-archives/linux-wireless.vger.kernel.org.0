Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE01D178AED
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2020 07:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgCDGvF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Mar 2020 01:51:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:57310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725271AbgCDGvF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Mar 2020 01:51:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71BF72146E;
        Wed,  4 Mar 2020 06:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583304664;
        bh=rpXCbKBh+vkhu4LbxUhgsvfrgYX9A2Td2iWADRYckww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ad49lQTddtod21WVnwNAtbRcaubnjHb7ywOUcCLGELj0/J9F/cHoMl5pgpF7Cjfq8
         rKs5a1jIPJ0hLQ/OcSYBfmIY8wegBOSoFsDQK2LW1ff4OXd0aIh+bX+R4nU3q4gYbY
         0yJ9bMlmikVXidhO09oWCIA3omblTrGuwF5G7OkA=
Date:   Wed, 4 Mar 2020 07:51:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-wireless@vger.kernel.org, ajay.kathat@microchip.com,
        adham.abozaeid@microchip.com
Subject: Re: [PATCH] staging: wilc1000: spi: Use new structure for SPI
 transfer delays
Message-ID: <20200304065102.GA1232845@kroah.com>
References: <20200227145054.24567-1-sergiu.cuciurean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227145054.24567-1-sergiu.cuciurean@analog.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Feb 27, 2020 at 04:50:54PM +0200, Sergiu Cuciurean wrote:
> In a recent change to the SPI subsystem [1], a new `delay` struct was added
> to replace the `delay_usecs`. This change replaces the current
> `delay_usecs` with `delay` for this driver.

Please also fix this one up based on the comments Dan provided for your
other "Use new structure..." patch.

thanks,

greg k-h
