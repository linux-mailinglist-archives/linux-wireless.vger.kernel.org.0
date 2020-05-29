Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9A71E78A3
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 10:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgE2Iqd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 04:46:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgE2Iqd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 04:46:33 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE93B2072D;
        Fri, 29 May 2020 08:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590741993;
        bh=Di4VqZgHZxYw6J/QfTw3C2UqCzYNC8As7YmCYVytUqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wlIOlPSE2j4HRlt7MMcJUUqCmsClnRZqJk4COCs+FucQ5QSz8LXy9o2oYn/inTizz
         q+WgBTsvWdISV7kOwXeNDq8prWI5iFcoqIzeGX6i064MF/vn6gwChKHqImoUgW6L6L
         N43fFcI8yZmqIZOFshDXpQ4H5MgIZPD7W3+O15uU=
Received: by pali.im (Postfix)
        id E30E3EB1; Fri, 29 May 2020 10:46:30 +0200 (CEST)
Date:   Fri, 29 May 2020 10:46:30 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ganapathi Bhat <ganapathi.bhat@nxp.com>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] mwifiex: Firmware name for W8997 sdio wifi chip
Message-ID: <20200529084630.j7rpdypt6vycsedh@pali>
References: <20200515132353.vfor7v4buzoddfmb@pali>
 <VI1PR04MB4366625917BB57695BE454448FBA0@VI1PR04MB4366.eurprd04.prod.outlook.com>
 <20200528103432.irmsaaz72x3xophg@pali>
 <VI1PR04MB4366409B8E293A265851DA948F8F0@VI1PR04MB4366.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4366409B8E293A265851DA948F8F0@VI1PR04MB4366.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Friday 29 May 2020 08:43:56 Ganapathi Bhat wrote:
> Hi Pali,
> 
> > According to publicly available information, firmware for these W8xxx
> > Marvell wifi chips is vulnerable to security issue CVE-2019-6496 [1].
> > 
> > Are you able to update firmwares to the last versions and give us some
> > information which (old) firmware versions are affected by that security issue?
> > 
> > So Linux distribution would know if they are distributing older vulnerable
> > firmwares and should push security fixes with new firmware versions.
> > 
> 
> 88W8787, 88W8797, 88W8801, 88W8897, and 88W8997 models are all already updated, with one exception:
> usb8897_uapsta.bin, which we will upstream soon;

Hello Ganapathi! Thank you for information. Can you point me to git tree
or location where are firmware files already updated?
