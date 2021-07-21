Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0423F3D1157
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 16:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbhGUNsb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 09:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238614AbhGUNsb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 09:48:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD7DD6120C;
        Wed, 21 Jul 2021 14:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626877747;
        bh=IegnqJKU0dxppcRpT+kLJBNKmAxlPjTzOn7xsqafSa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SJAxCU/qUtUx07jtTXRjXnYZ7l7OjYRRvkGHpwFU/g4BZUQ38mAvOAnVlXb4HtkdJ
         Rbtl6tdhglsI+W6XGcdWGPjXdHt382+1ZnPGmgYZ6zxEQdfBu/0A97ZPl/IR3+pBTR
         TveW5wanJBKYQMQuBUC0I2+bXUKhvSwCcuSRCYz2BqVWCoJR+KZhMA3SvlG9gcFCMj
         ppR8gNBN+wdgEkEgfUqHfyGb+x988I9GlfjaX3WcoLx/udRCdtq+0BmoTiSPq9JbRV
         LLw+gAQvTk55tNwmIydrFwBHcFl/BtAMt3EtRLMNB5UCy6hgVqjSIJ52u85jr336uM
         K+FoL1ZYddynA==
Date:   Wed, 21 Jul 2021 09:29:06 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Timo Witte <timo.witte@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: wireless-regdb: Update regulatory rules for Germany (DE) on 6GHz
Message-ID: <YPgvMph+3vRbrol3@ubuntu-x1>
References: <CANB4YXTf0DhJfL6kPa26ZCzj8FRwwdw_enGROzL-zXuWGyrwOQ@mail.gmail.com>
 <CANB4YXRtyvgu946rL=gxaRqhXja1qfBQ+DSYfiMvYcax7o45EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANB4YXRtyvgu946rL=gxaRqhXja1qfBQ+DSYfiMvYcax7o45EQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jul 19, 2021 at 02:20:34AM +0200, Timo Witte wrote:
> The bundesnetzagentur has assigned WiFi 6E frequencies for germany you
> this is the
> publication of that change:
> https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Telekommunikation/Unternehmen_Institutionen/Frequenzen/Allgemeinzuteilungen/MobilfunkDectWlanCBFunk/vfg552021WLAN6GHz.pdf?__blob=publicationFile&v=3
> 
> Following frequencies have been assigned for general use:
> 5945 - 6425 Mhz
> maximum (200 mW)
> No outdoor usage is allowed for 200mW
> 
> For "very low power devices" outdoor usage
> is allowed, but only with (25 mW)
> same frequency range 5945 - 6425
> 
> There is no DFS requirement.

This all matches with my reading of a translated version of the
document. Do you plan to send a patch to add this range? If not, I can
send one.

Thanks,
Seth
