Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA321437800
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 15:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhJVNcV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 09:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhJVNcU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 09:32:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C3FC061764
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 06:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=z30IKZGWWfA5CPoRtU28VazMVrjKYnEr/SB3kukIQig=;
        t=1634909403; x=1636119003; b=XJVt5rlUGR3XE0W7cBvdFq9NyGuzJUaJmXjRQRhWN43FJeq
        e2kbUEXv1lM3tXvy+0EsYTwy7h5oL/yMWZVfqvVsq+R+lY5+CiRAdW6F8Q8Sg6r3bcW6XcoW40bGP
        RHyERHYr1vZaVNTW6sNizCCQsB1UlyNsfhKHuyOdcHyxMiSWFKKh8TcHc1KmyKDcJRt3nTxUajbmR
        i0CDHMFor5JJf4GAQOy1PJ2nng3wR8hitkvC6FTvl3Dw7Ku6mNTv83357eZCs8i2r0calEmjFSVr7
        8/nhoW9rHp1E57xuVxN0abktGeEEhnlLxuzhxWt3PXKZ82UU7byH2GWFtk7Zq4Cw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mducS-005ftE-Ow;
        Fri, 22 Oct 2021 15:30:00 +0200
Message-ID: <69995d6c767edcea15ef7645fabc0e39c0dc7960.camel@sipsolutions.net>
Subject: Re: [PATCH] nl80211: Indicate SA Query procedures offload for AP
 SME device
From:   Johannes Berg <johannes@sipsolutions.net>
To:     vjakkam@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 22 Oct 2021 15:29:59 +0200
In-Reply-To: <5a1f654e3406e99c816afbc762519fea@codeaurora.org>
References: <1634210331-9001-1-git-send-email-vjakkam@codeaurora.org>
         <612e80125878bae6fccbb72701381832a8a6029c.camel@sipsolutions.net>
         <5a1f654e3406e99c816afbc762519fea@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-10-22 at 18:56 +0530, vjakkam@codeaurora.org wrote:
> > 
> > So how's that going to work with older hostapd? It'll be offloaded, and
> > then hostapd doesn't know, so it's still going to disconnect them?
> > 
> > So should be that hostapd also opts in to this driver behaviour?
> 
> yes, we have to update hostapd also with new implementation based on the
> feature flag.

That wasn't my question. My question was what happens if you have a
hostapd that's *not* updated?>

johannes

