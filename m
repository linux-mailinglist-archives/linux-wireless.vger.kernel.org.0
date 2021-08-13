Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56773EB160
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 09:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239397AbhHMH0V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 03:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbhHMH0T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 03:26:19 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C842EC061756
        for <linux-wireless@vger.kernel.org>; Fri, 13 Aug 2021 00:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=v9Wtwd/8aUIfamFoxP6ozH8U5WAvgh7jxdCw2WZN0Aw=;
        t=1628839552; x=1630049152; b=WMpJ4WrwC0/4jGCZT6A/NMg7dRmm8FeYMWK2pSGijhixvBB
        IWZFnkCTXVgNDdHpVU/Jt8nXv+xbJPuVV/uId4TsAS/uxaOmGn3W7MY5qOIgFsxDZHWIqKEBYL2vO
        9l7BdLHMPje5VgtyhjeFhubYZoq5hN/0jQb4mDpjb0jIfiati5bhrzpcNcklIrZ5OikObcuDqiRPg
        lagtjZeViUKtbfKHb+iVz0e2VNfbwFAfcXrqIiqy5ur/3g6/2lPGgxTxwQbEw2tnmWO46iKCrMT0o
        x7dy9pXADpBORxdbdq+RM57yZPD2ikvo0uDSpRtuxT5Eb2M8p8v/RH9JfNkk5G+Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mERZa-00A8ib-5n; Fri, 13 Aug 2021 09:25:46 +0200
Message-ID: <1273cc1a399a7457c3d908648a7651c8fe9b93f3.camel@sipsolutions.net>
Subject: Re: [PATCH 9/9] mac80211: save transmit power envelope element and
 power constraint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Fri, 13 Aug 2021 09:25:45 +0200
In-Reply-To: <38e7d9d2eebafa7245a36a0a0396094526eb3efd.camel@sipsolutions.net>
References: <20210517201932.8860-1-wgong@codeaurora.org>
         <20210517201932.8860-10-wgong@codeaurora.org>
         (sfid-20210517_222034_029448_A9A89D57) <d9491db4ece67ac78eb39a1078b91a106770fbb0.camel@sipsolutions.net>
         <1126f8d996e895ae048092b3f8aad19b@codeaurora.org>
         <38e7d9d2eebafa7245a36a0a0396094526eb3efd.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-08-13 at 09:19 +0200, Johannes Berg wrote:
> 
> > > 2) Should we at least check it again from the protected beacon or such
> > > after association, so we don't blindly trust the probe response or
> > > beacon (received during scan, not validated) at least when BIGTK is in
> > > use?
> > 
> > May we add support for BIGTK in future with another patch?
> 
> We already have BIGTK support in mac80211, so if we don't do that now
> we're almost certainly not going to do it, so I'd really prefer if you
> did it here, or if a separate patch still did it now.

Actually, I should say though - the question was more whether we even
need/want that, rather than whether we can do it later or not.

If we should protect this data/information then IMHO we should do it
now, but it's not clear to me that we should, given that we also don't
have encrypted association response and we still take information from
there too, etc.

johannes

