Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC34D3CC3AC
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jul 2021 15:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbhGQN4J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Jul 2021 09:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232893AbhGQN4J (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Jul 2021 09:56:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58FD8613D3;
        Sat, 17 Jul 2021 13:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626529992;
        bh=of/pKXLKFxJmN3+Ff+6VfGIUW58pTtfTzsowBhAel9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kow34QJccqKPPNNr0EYjcB+5MALMRKlvDQjV6VVozOsVOn29me370gGoO/LIa1OzQ
         79D6h8yn9w03QPALlU3sifXFDrSA7iKqDmqeZVRyNI2cHpA92ldhf+eZfF1gjnCDXQ
         pmOeTnzKC8/OyGi8rEjZcwJerwKsmAvcm8B4f0bxjke1rg29tKzpUneZJmR3xSptuV
         jk0wFA7HWMW9pLaoNBpPpO8j1CwquE5yD1rCWh22Zdi34veinJBPh6hfB33FIqNfbX
         LOMBa73Bl0S08L20bRoE6SRp3Hb5lX7JKFzRKcwNJ6y6YjU1EW20ari8/oy6X7Hkc/
         Q0qr1123EYDKQ==
Received: by pali.im (Postfix)
        id 26C5095D; Sat, 17 Jul 2021 15:53:10 +0200 (CEST)
Date:   Sat, 17 Jul 2021 15:53:09 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Sharvari Harisangam <sharvari.harisangam@nxp.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Jonas =?utf-8?Q?Dre=C3=9Fler?= <verdre@v0yd.nl>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>
Subject: Re: mwifiex: Maximal number of AP interfaces
Message-ID: <20210717135309.lwntxwwil6cz7cz4@pali>
References: <20200611113009.v7cpybecc55vtni2@pali>
 <20210217121841.zqkesoy56bmzhwjf@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210217121841.zqkesoy56bmzhwjf@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[+cc: Maximilian and Jonas]

Hello Sharvari! Could you look also at this issue which disallows
88W8xxx cards to create more that 3 AP instances, even when HW supports
it?

I think it is a big limitation if HW supports more AP SSIDs, but mwifiex
driver refuse to create more than 3.

On Wednesday 17 February 2021 13:18:41 Pali Rohár wrote:
> Hello! I would like to remind this my email...
> 
> On Thursday 11 June 2020 13:30:09 Pali Rohár wrote:
> > Hello!
> > 
> > mwifiex kernel driver has currently hardcoded maximal number of AP
> > interfaces to 3. It is defined by MWIFIEX_MAX_UAP_NUM constant and
> > '.max' member in 'mwifiex_ap_sta_limits' structure.
> > 
> > I tried to increase this limit and figured out that SD8997 card can
> > create four independent BSSIDs in AP mode. Not only 3. Scanning for wifi
> > networks on another device proved that SD8997 was really broadcasting 4
> > SSIDs.
> > 
> > When I tried to create fifth AP interface/SSID then mwifiex received
> > error "mwifiex_cmd_timeout_func: Timeout cmd id = 0x4d, act = 0x1" and
> > then card firmware crashed. SDIO card was then unregistered from bus.
> > 
> > I would like to increase maximal number of AP interface to 4 as it is
> > supported by SD8997 card. But it cannot be done easily as for other
> > cards managed by mwifiex driver which do not support more then 3 ap
> > interfaces, it can cause problems...
> > 
> > Looks like that maximal number of AP interfaces is firmware dependent
> > number. Do you know if it is possible to retrieve this maximal count
> > from card firmware via some special command?
> > 
> > Or do you know how to determinate maximal number of AP interfaces?
> 
> Is there any firmware command which returns maximal number of AP
> interfaces which kernel can create?
> 
> If not then I would suggest to create per-card constant for maximal
> number of AP interfaces in mwifiex driver and hardcode it to 4 on 8997
> card. Any objections?
