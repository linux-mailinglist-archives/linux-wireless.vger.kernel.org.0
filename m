Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF1B2DCE82
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 10:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgLQJgV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 04:36:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:41084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgLQJgU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 04:36:20 -0500
Date:   Thu, 17 Dec 2020 10:35:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608197740;
        bh=5kWZ0QEwHk5zG6G+jZNPusICr/3y0G9zUD7KzfJxWTM=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=f08QVvu7hQs+JlUXIdl/nFBQaU3l27xv7Ugf6voXjI3265ElPL8tcFPk7KhnGTD13
         0V1BW8onjULJaFe0zCGsUMjFAnOxfzQfvIn8k0+of9IY38zSVVE6/5Wrgq100Ls/PF
         H38PuGHa5zl3CKyCYigR+OvCyURRd7FtFwjMCB4uogl6l8TjpIeqLIsM21nWrTlr4u
         kuA6+TzQ7aqWgzATe8fY8a6WAaxdzCHmVIosqouco1k/0q/BGa3s+v/Jc9b8CvyPeG
         k2vLHmD4I35HcSbbgSiMsbaopyInPtY7ETI4PlycONsCb/L6iTCXedJfdxg4RaN68P
         TitD5z9O2xQNA==
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jouni Malinen <j@w1.fi>
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        ath10k@lists.infradead.org, ath9k-devel@qca.qualcomm.com,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: CVE-2020-3702: Firmware updates for ath9k and ath10k chips
Message-ID: <20201217093537.w22c7a2jeivt763e@pali>
References: <20200810090126.mtu3uocpcjg5se5e@pali>
 <20200812083600.6zxdf5pfktdzggd6@pali>
 <87lfik1av8.fsf@toke.dk>
 <20200812092334.GA17878@w1.fi>
 <20201007082502.3da6rw2bkudilqaq@pali>
 <20201207140438.as2i7kwquhdxqn53@pali>
 <20201214174149.GA18899@w1.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201214174149.GA18899@w1.fi>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Monday 14 December 2020 19:41:49 Jouni Malinen wrote:
> On Mon, Dec 07, 2020 at 03:04:38PM +0100, Pali Rohár wrote:
> > Hello! Has somebody fixes this security issue in ath9k driver? About
> > 4 months passed and if this issue is not fixed, could you please share
> > at least incomplete / WIP patches? I would like to look at it and have
> > this issue finally fixed.
> 
> https://patchwork.kernel.org/project/linux-wireless/list/?series=401685

Thank you! I will look at it.
