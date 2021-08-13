Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7F53EB2FD
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 10:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbhHMIxn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 04:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239342AbhHMIxm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 04:53:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506C0C061756
        for <linux-wireless@vger.kernel.org>; Fri, 13 Aug 2021 01:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=yEydqY9Xy13lsq8FKdyDyWGqKcxRfkS1FfPdMJ2lE1E=;
        t=1628844796; x=1630054396; b=GsbjOqWzFzHG05exebZdJ9sDNS0p8S/op7J1IdC9PxqD6rS
        aZqZRKbI8zFBqDBx+OugVTDWPjxMolBxy6D6TNUrYnwR8E0ag9VjYDQ7t8hdOtrRTJvZICSfgnhvZ
        TuzO/XPPNV63wkDL71ZwOvSQrOnzsr2B94Y14/xolcygyw7e6pVG7CccDdsJq1xqUFIFFPTxZ0/c5
        RoSm4os8dRfBMmDwGT0jVFI8aMprBA7Tn5g/3WEXoX22zP6u4QaS9VdAwYxeM4zUMITDdMcfWuxmc
        QcuwPgVGm6WTvPys8ztpj+uhz7vuAs2YtNSn259PayBPkF1/09Kav0YVN4kwm6bA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mESwA-00AANQ-Nf; Fri, 13 Aug 2021 10:53:10 +0200
Message-ID: <f61cdc7bae2dd2a645e164ca143b9db402472559.camel@sipsolutions.net>
Subject: Re: [PATCH 9/9] mac80211: save transmit power envelope element and
 power constraint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Fri, 13 Aug 2021 10:53:09 +0200
In-Reply-To: <a056e32d4911400fb0822bf02167e91c@codeaurora.org>
References: <20210517201932.8860-1-wgong@codeaurora.org>
         <20210517201932.8860-10-wgong@codeaurora.org>
         (sfid-20210517_222034_029448_A9A89D57) <d9491db4ece67ac78eb39a1078b91a106770fbb0.camel@sipsolutions.net>
         <1126f8d996e895ae048092b3f8aad19b@codeaurora.org>
         <38e7d9d2eebafa7245a36a0a0396094526eb3efd.camel@sipsolutions.net>
         <1273cc1a399a7457c3d908648a7651c8fe9b93f3.camel@sipsolutions.net>
         <a056e32d4911400fb0822bf02167e91c@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-08-13 at 16:47 +0800, Wen Gong wrote:
> > > > > 2) Should we at least check it again from the protected beacon or such
> > > > > after association, so we don't blindly trust the probe response or
> > > > > beacon (received during scan, not validated) at least when BIGTK is in
> > > > > use?
> > > > 
> > > > May we add support for BIGTK in future with another patch?
> > > 
> > > We already have BIGTK support in mac80211, so if we don't do that now
> > > we're almost certainly not going to do it, so I'd really prefer if you
> > > did it here, or if a separate patch still did it now.
> > 
> > Actually, I should say though - the question was more whether we even
> > need/want that, rather than whether we can do it later or not.
> > 
> > If we should protect this data/information then IMHO we should do it
> > now, but it's not clear to me that we should, given that we also don't
> > have encrypted association response and we still take information from
> > there too, etc.
> > 
> > johannes
> I prefer to add a new enum(not use BSS_CHANGED_TXPOWER),e.g, 
> BSS_CHANGED_PWR_ENV.
> And add check in ieee80211_rx_mgmt_beacon() as well as 
> ieee80211_handle_pwr_constr(),
> when the value of pwr_reduction or content of elems.tx_pwr_env changed,
> save the pwr_reduction and elems.tx_pwr_env to ieee80211_bss_conf, and 
> notify lower
> driver with BSS_CHANGED_PWR_ENV, then lower driver will do next action.
> 
I don't really have any objection to this, but OTOH it feels like
drivers will probably not really listen to this if it can only happen
due to BIGTK?

And if we always defer this until the first beacon, that also feels
wrong and bad?

I'm not sure what the right answer here is, TBH.

Maybe the right answer is to indeed ignore beacon protection for this,
and do exactly what you did here, and say that the TX power envelope
thing is just not meant to be protected, because the protection is meant
to protect the connection etc. and not the performance (and regulatory?)

Do we get this *only* in the beacon, or also in the association
response? If it's also in the association response we could use the data
from *there*, and basically say that the association response might need
some protection (later) anyway?

johannes

