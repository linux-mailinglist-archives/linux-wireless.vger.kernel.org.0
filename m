Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049FF32C145
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 01:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245688AbhCCVRt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Mar 2021 16:17:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:43458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241393AbhCCTUy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Mar 2021 14:20:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABDCA64EF3;
        Wed,  3 Mar 2021 19:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614799177;
        bh=foliZiz3rI2vyKLIHWNgT7LIMdi0MA4Hbv+MqoW7wR0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=petoCf703nrmUXLuxW+FbHQpB4MLYYSf85UQvamRzAs5gkulHW/6iIeiGZ+pAdnJk
         +QjhfFawL7p9U1FL+Z3lPZ46Jx7BzEZeWQD3Uwcogl0zGmlEiukicpwQBjsNXTwJMZ
         lsuP1P7EcG7/ddHpwmZoRfiinFyXnOypinWjomf5d3PfLMzL63xW6HSHySsfz2KQpp
         q/hMpUFn+TtID2YeAM8b3F7GKhPqr3M19V0FKAX30QPlMdzkdwK3jw1lL0HazT6z+o
         YZjYXebeSb1dhB4l4RGQGCIF15QlayyAQ3gAvfjEXdeSAyS3EFY2p3Mbj6T855mHXK
         CYzFQQ2V4xwIg==
Date:   Wed, 3 Mar 2021 20:19:33 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
cc:     Johannes Berg <johannes@sipsolutions.net>,
        Luca Coelho <luciano.coelho@intel.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iwlwifi: don't call netif_napi_add() with rxq->lock
 held (was Re: Lockdep warning in iwl_pcie_rx_handle())
In-Reply-To: <87y2f46qai.fsf@codeaurora.org>
Message-ID: <nycvar.YFH.7.76.2103032018080.12405@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2103021134060.12405@cbobk.fhfr.pm> <20210303155941.25521C43463@smtp.codeaurora.org> <nycvar.YFH.7.76.2103031901140.12405@cbobk.fhfr.pm> <87y2f46qai.fsf@codeaurora.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 3 Mar 2021, Kalle Valo wrote:

> > ... i believe you want to drop the "(was ...") part from the patch 
> > subject.
> 
> Too late now, it's already applied and pull request sent. Why was it
> there in the first place?

Yeah, it was, but I don't think it's a big issue :) So let it be.

BTW, how about the other fix I sent? It's also fixing a real functional 
issue, so it IMHO is a -rc material

	https://lore.kernel.org/linux-wireless/nycvar.YFH.7.76.2103021125430.12405@cbobk.fhfr.pm/

Thanks,

-- 
Jiri Kosina
SUSE Labs

