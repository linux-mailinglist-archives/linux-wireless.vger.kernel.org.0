Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2123C3EB3DA
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 12:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239954AbhHMKM3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 06:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239867AbhHMKM2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 06:12:28 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD56C061756
        for <linux-wireless@vger.kernel.org>; Fri, 13 Aug 2021 03:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=yxqGznKpFcy90u/i72TSHu+ZUzJFayVrCEeLw+E0YvY=;
        t=1628849522; x=1630059122; b=o/XXEgZHNcUG8SIDnHWD/dSwyVxwQRczpKVAY1sD/JOJQLd
        4WY+u/3fMdHHVnZ2wCSQuir3e1b4Z7ywz64OAY32g7DFg/KJNE7wlUte7LuEqxWubjDmaabgbO8W8
        2SyfZUsKdEscLrkVnBh9FHh+UG44+i3RmQqvypQjKNowIE5TZgvvctxvPMm05uSfduBGjAgvf7Pif
        wMD5daC+zv1oDwbmy21OxaMrNzMYFImKRotKdZWL0dQ91BhsM301U1muSj/CmBpxBuH+6WFF7/dpm
        zhja7blpN+TjRAljkHryngf7IYYJ9r8oMAG9ZDJGfFIOomMIlJBVTkhmy3Cc3aWA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mEUAK-00ABs5-Rs; Fri, 13 Aug 2021 12:11:52 +0200
Message-ID: <569d85aec8fecc836b5a6f9d40b53dff6e41c1b1.camel@sipsolutions.net>
Subject: Re: [PATCH 9/9] mac80211: save transmit power envelope element and
 power constraint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Fri, 13 Aug 2021 12:11:52 +0200
In-Reply-To: <465b6b8535fc17ae51ee2f3116af87bb@codeaurora.org>
References: <20210517201932.8860-1-wgong@codeaurora.org>
         <20210517201932.8860-10-wgong@codeaurora.org>
         (sfid-20210517_222034_029448_A9A89D57) <d9491db4ece67ac78eb39a1078b91a106770fbb0.camel@sipsolutions.net>
         <1126f8d996e895ae048092b3f8aad19b@codeaurora.org>
         <38e7d9d2eebafa7245a36a0a0396094526eb3efd.camel@sipsolutions.net>
         <1273cc1a399a7457c3d908648a7651c8fe9b93f3.camel@sipsolutions.net>
         <a056e32d4911400fb0822bf02167e91c@codeaurora.org>
         <f61cdc7bae2dd2a645e164ca143b9db402472559.camel@sipsolutions.net>
         <465b6b8535fc17ae51ee2f3116af87bb@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-08-13 at 17:16 +0800, Wen Gong wrote:
> 
> yes, it should have some flag/logic to check whether it is BIGTK.
> If you know it, you can tell me. :)

Uh, actually, we don't have a secure indication of BIGTK getting used
until after the 4-way-HS.

> > 
> Yes, the lower driver also have the max power limit itself. If power 
> calulated
> from the fake beacon is bigger than the max power limit, then it will be
> ignored.

Right.

> > 
> The Transmit Power Envelope is not existed in the assoc response, it is 
> existed
> in beacon. So it can not use assoc response.

Right.


Given this discussion, I think we should just leave it as is, and simply
not assume that the TPE is protected by beacon protection or such. There
are a number of other similar parameters, and doing some real protection
at this level would likely require further spec changes.

johannes

