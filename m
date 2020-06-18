Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643191FF1FB
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2020 14:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgFRMgv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jun 2020 08:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbgFRMgu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jun 2020 08:36:50 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C526E2070A;
        Thu, 18 Jun 2020 12:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592483809;
        bh=b3WSJ0JAtVfTd98/g8GA2SmVjw5DbbasFwVMJskruSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qNg/23UxRyx9h0EMSrojDoYVBTmp4sf/NZoOY2FUgMjvEtmuh32BvdUpIE1eiqUfx
         RD5nh183tv62X3TszdvDdA4rNgKOmAzTgksevMi09HhEbuoTsqIGZzNJGvdIaf8Xwy
         HT1Qq8ftvSQp83X6hZPS2oifPWR/dElHkGoF2wVA=
Received: by pali.im (Postfix)
        id 5A787791; Thu, 18 Jun 2020 14:36:47 +0200 (CEST)
Date:   Thu, 18 Jun 2020 14:36:47 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ganapathi Bhat <ganapathi.bhat@nxp.com>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] mwifiex: Firmware name for W8997 sdio wifi chip
Message-ID: <20200618123647.axx7wtlclgs333k5@pali>
References: <20200515132353.vfor7v4buzoddfmb@pali>
 <VI1PR04MB4366625917BB57695BE454448FBA0@VI1PR04MB4366.eurprd04.prod.outlook.com>
 <20200528103432.irmsaaz72x3xophg@pali>
 <VI1PR04MB4366409B8E293A265851DA948F8F0@VI1PR04MB4366.eurprd04.prod.outlook.com>
 <20200529084630.j7rpdypt6vycsedh@pali>
 <VI1PR04MB4366DECFA1EB5C3D6AADB0818F8F0@VI1PR04MB4366.eurprd04.prod.outlook.com>
 <20200529085536.zivf36mn2d6zx5ii@pali>
 <VI1PR04MB43663ACEAADB7ADD1EB7572D8F8F0@VI1PR04MB4366.eurprd04.prod.outlook.com>
 <20200529091211.vx2godj5zirsptam@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200529091211.vx2godj5zirsptam@pali>
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Friday 29 May 2020 11:12:11 Pali Rohár wrote:
> On Friday 29 May 2020 09:11:08 Ganapathi Bhat wrote:
> > Hi Pali,
> >  
> > > Hello Ganapathi! Seems that on both locations is older version of
> > > sdsd8997_combo_v4.bin firmware, not the latest one. On both location is
> > > available just version 16.68.1.p179. But we have newer version 16.68.1.p197.
> > > Could you please recheck it?
> > 
> > p179 do have the fix but we will try to upstream p197 also soon.
> 
> Thank you!

Hello Ganapathi! Do you have any updates about upstreaming new firmware version?
