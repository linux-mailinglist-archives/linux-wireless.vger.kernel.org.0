Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADAC1E78D4
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 10:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgE2Izj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 04:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgE2Izj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 04:55:39 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEE13205CB;
        Fri, 29 May 2020 08:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590742539;
        bh=zDPyiYau/GuyIfR6tLiVFlkacXVXkEPMUpHP5Uo7uVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IdZ3e21EQo+aM5HIBDDyV/UNWn85XBHr7JlaFyae37yhkvWY+wxu1dOyE4U6APbYV
         8IGV+27eJhkWJ6sikxmO58s6n0CK8uaWRkr9DozDAB1fpaYplMsqEazM6r+YLXMhLP
         CbKztxTuGXeosRLOKWuK7ue3KxfoGBl5vW5Q2g6I=
Received: by pali.im (Postfix)
        id 09713EB1; Fri, 29 May 2020 10:55:36 +0200 (CEST)
Date:   Fri, 29 May 2020 10:55:36 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ganapathi Bhat <ganapathi.bhat@nxp.com>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] mwifiex: Firmware name for W8997 sdio wifi chip
Message-ID: <20200529085536.zivf36mn2d6zx5ii@pali>
References: <20200515132353.vfor7v4buzoddfmb@pali>
 <VI1PR04MB4366625917BB57695BE454448FBA0@VI1PR04MB4366.eurprd04.prod.outlook.com>
 <20200528103432.irmsaaz72x3xophg@pali>
 <VI1PR04MB4366409B8E293A265851DA948F8F0@VI1PR04MB4366.eurprd04.prod.outlook.com>
 <20200529084630.j7rpdypt6vycsedh@pali>
 <VI1PR04MB4366DECFA1EB5C3D6AADB0818F8F0@VI1PR04MB4366.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4366DECFA1EB5C3D6AADB0818F8F0@VI1PR04MB4366.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Friday 29 May 2020 08:49:18 Ganapathi Bhat wrote:
> Hi Pali,
>  
> > Hello Ganapathi! Thank you for information. Can you point me to git tree or
> > location where are firmware files already updated?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
> 
> or
> 
> https://github.com/NXP/mwifiex-firmware

Hello Ganapathi! Seems that on both locations is older version of
sdsd8997_combo_v4.bin firmware, not the latest one. On both location is
available just version 16.68.1.p179. But we have newer version
16.68.1.p197. Could you please recheck it?
