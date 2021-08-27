Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255203F95E2
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 10:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244494AbhH0IVk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Aug 2021 04:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbhH0IVj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Aug 2021 04:21:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027A3C061757
        for <linux-wireless@vger.kernel.org>; Fri, 27 Aug 2021 01:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=HHrMeXbykUDL/YEPXeS3l+FmwS0oZlKQaJGFstXR11Q=;
        t=1630052451; x=1631262051; b=oBTA6nQFhM90nLD6qZyq0wEd8TDuRswX/RrMyOFVFGjGL1K
        k7r0ocQu1HVq3/el3jvY+mrZpnERtZXMEwKH/tA123yUvZnulBBSKDVsdP/el+Qs35TVciSzALrsZ
        BLe00Y9+pdxFGmVvBr7livR/C/6SIvhnOxjg+yHj4CXnQdSr1vGWGrdqxF1/7CZ55sOBFGVHr+zdp
        Hk02IWXWthhEbZZITuGHoVeAANoY9RsSNoqxL7yrYA7fpv+oFirN5oS/vfXtIzlVc/awVtwbQHyfw
        yhklAPqkA930bv/9XlLagGWx5lO5KIuV+Wqq/9OUrRJhxPTuO+Xk0CQuPQqBOPgg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mJX6Q-00GX75-Fy; Fri, 27 Aug 2021 10:20:42 +0200
Message-ID: <3483aeb87a81dea538af3a2640cd49831274320f.camel@sipsolutions.net>
Subject: Re: [PATCH v2 8/8] mac80211: save transmit power envelope element
 and power constraint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Fri, 27 Aug 2021 10:20:41 +0200
In-Reply-To: <01d9e4eadbb0d87edbc026fc719858a3@codeaurora.org>
References: <20210820122041.12157-1-wgong@codeaurora.org>
         <20210820122041.12157-9-wgong@codeaurora.org>
         <dfe27f657b4615369cf751d394f5cba75f5fdcc1.camel@sipsolutions.net>
         <25fcede26b99604a03d0b321b7120db4@codeaurora.org>
         <48ad47869e703cbef437378c508d6a5b64c160ae.camel@sipsolutions.net>
         <db22a4cb9a07e3845a50f436c7052feb@codeaurora.org>
         <0680b508a7864e02f55d763851f7460baa73b53f.camel@sipsolutions.net>
         <110489059796b17849d0f32fb5189828@codeaurora.org>
         <27680423e824dd67217cc6f1e62f9ac0a1af78f2.camel@sipsolutions.net>
         <01d9e4eadbb0d87edbc026fc719858a3@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-08-27 at 16:18 +0800, Wen Gong wrote:
> 
> then should I use "struct ieee802_11_elems elems = {0}" or "struct 
> ieee802_11_elems *elems = kzalloc(sizeof(*elems))"
> in the parsing patch?

Yeah, it's a good question ...

We keep adding stuff here, so it'll be safer to alloc it.

I get a fair number of stack size warnings on the build now (possibly
due to the addition of the TPE fields?), and while they're probably fine
for now (we get there from nl80211, so no deep stack), it's only going
to increase - we have EHT patches already now, for example.

johannes

