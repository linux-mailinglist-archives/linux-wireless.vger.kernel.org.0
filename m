Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3418F40DEE2
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 18:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240339AbhIPQDn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 12:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240135AbhIPQDm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 12:03:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20181C061574
        for <linux-wireless@vger.kernel.org>; Thu, 16 Sep 2021 09:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=fSVySNBHzy+tCJVdmsFE9bKP/0IBbKfnrmCay+KMMFI=;
        t=1631808142; x=1633017742; b=IwLEX24brNBHrP2VzsJ1659Xu+w4dVtu32MiaEJVfNEJGBC
        s1q3u2mi3pUnsUfgZH5UlXw2tZZGTaTdCsNEliIy3mp5qNOCiEgdAZmow0H0+YyfnLTmuCp4YIvzQ
        sdA6EOuOhJ0FT4IvW1DRUZRPH5pYxwhILf4z1fXht5+2v9Z9HNj8lbsggdNeWCD+ojoGK5yZcFu43
        EB5bjE3Zf1W3p+zwNVYnfCrAeCMhYaat/G0wmIKydGTHY4S96xLFUaE5GA0/2xrXN4ULdbD4AhykU
        1aQJbqYEpLEhQLjqveSOXgaiiySuG1IorfeBv0u7+DAymD5YY2PaKU2GFVXk2G5A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mQtq3-007nkC-Mt;
        Thu, 16 Sep 2021 18:02:15 +0200
Message-ID: <a3df1f072600e79bac0a247b905fec8b946f0729.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] ieee80211: Add new A-MPDU factor macro for HE 6 GHz
 peer caps
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Date:   Thu, 16 Sep 2021 18:02:14 +0200
In-Reply-To: <87wnngy2ro.fsf@codeaurora.org>
References: <20210913175510.193005-1-jouni@codeaurora.org>
         <87wnngy2ro.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-09-16 at 18:10 +0300, Kalle Valo wrote:
> Jouni Malinen <jouni@codeaurora.org> writes:
> 
> > From: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
> > 
> > Add IEEE80211_HE_6GHZ_MAX_AMPDU_FACTOR as per IEEE Std 802.11ax-2021,
> > 9.4.2.263 to use for peer max A-MPDU factor in 6 GHz band.
> > 
> > Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
> > Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> > ---
> >  include/linux/ieee80211.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
> > index 694264503119..a1a7eda35cb5 100644
> > --- a/include/linux/ieee80211.h
> > +++ b/include/linux/ieee80211.h
> > @@ -2084,6 +2084,7 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
> >  
> > 
> > 
> > 
> >  #define IEEE80211_HE_VHT_MAX_AMPDU_FACTOR	20
> >  #define IEEE80211_HE_HT_MAX_AMPDU_FACTOR	16
> > +#define IEEE80211_HE_6GHZ_MAX_AMPDU_FACTOR	13
> 
> Johannes, can I take this via my ath tree? I think that's the easiest as
> the ath11k patches depend on this.
> 
Sure, looks fine.

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes

