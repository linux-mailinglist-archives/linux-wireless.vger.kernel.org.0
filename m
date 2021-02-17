Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6F631D94D
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Feb 2021 13:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhBQMT0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Feb 2021 07:19:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:51712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231593AbhBQMTZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Feb 2021 07:19:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B45364E0F;
        Wed, 17 Feb 2021 12:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613564324;
        bh=ksrh/sIu1x2EC30xDgDUMb4gs3SDjmk1c0sLNF2u7rU=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=m0vv2qIOsudtdZZ2ugZ+DKnhnttxfzelvE6/9IOhTSFEVV6Nuu5NIUYudPr/97i0t
         +1HhnFAEIt+5PTj1hA1z2kEqEulX5Fw5ESjv+GZP7njX50NcQecR91Kcyv9iEmQsaQ
         uhgRPkUnEqs03+9i9VLsfFnP6cRaE75Y+rGEwBmnLhzv5PfjJA/9ljnvCO8YjBcr9M
         TKuDkBFhqWeIdICUUxsl4VLse8ZELT2uGs/50wnEJLKu/cNtIj69q2TWTx1Fc6OVBD
         7aRi8nkKk7un70h8H3St4o1QGc+ORRwbN8Px7a7hBRqQOr7Z8fgXBUiphpHgg4WwlM
         uKFfRXwmo6Jng==
Received: by pali.im (Postfix)
        id 1FE0A828; Wed, 17 Feb 2021 13:18:42 +0100 (CET)
Date:   Wed, 17 Feb 2021 13:18:41 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>
Subject: Re: mwifiex: Maximal number of AP interfaces
Message-ID: <20210217121841.zqkesoy56bmzhwjf@pali>
References: <20200611113009.v7cpybecc55vtni2@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200611113009.v7cpybecc55vtni2@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello! I would like to remind this my email...

On Thursday 11 June 2020 13:30:09 Pali Rohár wrote:
> Hello!
> 
> mwifiex kernel driver has currently hardcoded maximal number of AP
> interfaces to 3. It is defined by MWIFIEX_MAX_UAP_NUM constant and
> '.max' member in 'mwifiex_ap_sta_limits' structure.
> 
> I tried to increase this limit and figured out that SD8997 card can
> create four independent BSSIDs in AP mode. Not only 3. Scanning for wifi
> networks on another device proved that SD8997 was really broadcasting 4
> SSIDs.
> 
> When I tried to create fifth AP interface/SSID then mwifiex received
> error "mwifiex_cmd_timeout_func: Timeout cmd id = 0x4d, act = 0x1" and
> then card firmware crashed. SDIO card was then unregistered from bus.
> 
> I would like to increase maximal number of AP interface to 4 as it is
> supported by SD8997 card. But it cannot be done easily as for other
> cards managed by mwifiex driver which do not support more then 3 ap
> interfaces, it can cause problems...
> 
> Looks like that maximal number of AP interfaces is firmware dependent
> number. Do you know if it is possible to retrieve this maximal count
> from card firmware via some special command?
> 
> Or do you know how to determinate maximal number of AP interfaces?

Is there any firmware command which returns maximal number of AP
interfaces which kernel can create?

If not then I would suggest to create per-card constant for maximal
number of AP interfaces in mwifiex driver and hardcode it to 4 on 8997
card. Any objections?
