Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEB241706F
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 12:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244924AbhIXKtc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 06:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhIXKtc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 06:49:32 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B7BC061574
        for <linux-wireless@vger.kernel.org>; Fri, 24 Sep 2021 03:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=UwM4aAzBj6rN1BXyl4YIBsxqe561TcfDXv5VBrcAq6U=;
        t=1632480479; x=1633690079; b=sosqpIdYw+HelE1KwbYm9tfHGR4L/liT2Lkd/e9xy8GNyBE
        xIrKPgfdnlX6ak+CbFuZtWA+RD27ehiMEY3kqhNgd6mw2ZFRVw25AAQyXpmx+o4/AuDBs4vxGXvLn
        n8btHpl39RYezvo8012O6dbvLMniaDK8MwPOqnZqAiXcf8lXpnuYIyXbeEwElXI+mnSeCdDTci+qr
        J/g75AOjSXSymQthRu3bJ0F6w3+3sZ14T8X7Gy7ZtKfHImkgg1ToAb4kZk+Ncq+E+nEZf4wWhUE6I
        +NHrNVE8/PZepGAmrpdeLfAe7wsnm79dtvxAP31zJxJ6X/aA7vuYvJ5IaGUFezhQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mTikE-00B9pG-4u;
        Fri, 24 Sep 2021 12:47:54 +0200
Message-ID: <19473132ad2e3bab492c001402e0b08886a5493c.camel@sipsolutions.net>
Subject: Re: [PATCH v4 5/6] mac80211: use ieee802_11_parse_elems() to find
 ies instead of ieee80211_bss_get_ie()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Sep 2021 12:47:53 +0200
In-Reply-To: <b02735cc844c9ba2222d23a7e6ad112a82a36891.camel@sipsolutions.net>
References: <20210924100052.32029-1-wgong@codeaurora.org>
         <20210924100052.32029-6-wgong@codeaurora.org>
         <b02735cc844c9ba2222d23a7e6ad112a82a36891.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-09-24 at 12:13 +0200, Johannes Berg wrote:
> Taking a brief look before lunch,
> 
> >  	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT) && !is_6ghz) {
> >  		const u8 *ht_oper_ie, *ht_cap_ie;
> >  
> > 
> > 
> > 
> > -		ht_oper_ie = ieee80211_bss_get_ie(cbss, WLAN_EID_HT_OPERATION);
> > +		ht_oper_ie = elems->ht_operation ?
> > +			((const u8 *)elems->ht_operation) - 2 :
> > +			NULL;
> >  		if (ht_oper_ie && ht_oper_ie[1] >= sizeof(*ht_oper))
> >  			ht_oper = (void *)(ht_oper_ie + 2);
> 
> Can't we drop these checks, and simply do
> 
> ht_oper = elems->ht_operation?

I checked, yes, we can do that. Since I just did it anyway, no need to
resend.

johannes

