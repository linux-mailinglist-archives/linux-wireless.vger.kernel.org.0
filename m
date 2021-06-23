Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89793B1824
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jun 2021 12:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhFWKfX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Jun 2021 06:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWKfW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Jun 2021 06:35:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF64C061574
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jun 2021 03:33:05 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lw0Bn-00AWiA-NL; Wed, 23 Jun 2021 12:32:59 +0200
Message-ID: <05835527eb79d7bad22b20247b351b82cc0776d3.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: Fix sw connection monitor and sw scan when
 STA is connected HE
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Pkshih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Wed, 23 Jun 2021 12:32:58 +0200
In-Reply-To: <072bfd8473ac4054a43818009e66a914@realtek.com> (sfid-20210611_052347_394259_CA96FBDB)
References: <20210611030422.9608-1-pkshih@realtek.com>
         <072bfd8473ac4054a43818009e66a914@realtek.com>
         (sfid-20210611_052347_394259_CA96FBDB)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Hi mac80211 team,
> 
> We are working on Realtek 11ax driver, rtw89, not being merged yet.
> This driver uses software connection monitor and software scan, like
> our 11ac driver rtw88,
> but we found these two functions don't work properly due to mac80211
> doesn't send
> null data frame when STA is connected HE.
> 
> We search for the reason why it can't send null frame, but we don't
> get the answer.
> Possibly, it is because existing HE hardware supports hardware
> connection monitor
> and scan, or supports TWT to avoid sending null data frame to tell AP
> its PS mode.
> Could anyone enlighten me the reason?

It was just a workaround for an iwlwifi specific issue that got left in.
I just merged a patch from Felix to resolve that.

johannes

