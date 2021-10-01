Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25CD41E7D9
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 09:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352032AbhJAHDf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 03:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352394AbhJAHCz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 03:02:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC48C061776
        for <linux-wireless@vger.kernel.org>; Fri,  1 Oct 2021 00:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=NJr5xpW7MZSkW7xFINyqHqDBDFCpW/nUdFRJKEADvuc=;
        t=1633071670; x=1634281270; b=Uu7zYnJ3z2nsj7CKAa237RvdF5bQ9CAvT5bABwkita1J23X
        mQiRAXKoaZUOYRaIHDrDJZCG3Ticq56j+y4IPTYWw2IGUabZ1K4EYdKybV8RelHYjn6LcC7yFsooC
        OuGopY+DoDc03dbfm9JRIBNEHfyIjmRYe25h1pMatNsX1JxWWNDhyNti8A8hXjeSZjvm6bjtIcpGQ
        d7hMzreIKv+pgld/sgfV0B0lJ09C2u9pKRd3NJdigLWKW7mkpyb5auQaXXuLJ7Q0On6qjnFA5a+c6
        GOdE4N3b+AxVI0OPY9Mrh/RBt6A/F4MHlQIJgL/wXD8sunS/aQ/Hv9+/RqnnPi/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mWCXX-00E6g7-PG;
        Fri, 01 Oct 2021 09:01:03 +0200
Message-ID: <93c99a81d89aafed21e8e22157b3bf21526be716.camel@sipsolutions.net>
Subject: Re: [PATCH v3 2/2] mac80211: do intersection with he mcs and nss
 set of peer and own
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@codeaurora.org>, Wen Gong <wgong@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Fri, 01 Oct 2021 09:01:02 +0200
In-Reply-To: <87bl49mf02.fsf@codeaurora.org>
References: <1609816120-9411-1-git-send-email-wgong@codeaurora.org>
         <1609816120-9411-3-git-send-email-wgong@codeaurora.org>
         <b6c96c4ecdf9ec175d7f89e8600fb53768287cc2.camel@sipsolutions.net>
         <facd18458a7ecfc0afbfd06c8a57d849@codeaurora.org>
         <87bl49mf02.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-10-01 at 09:32 +0300, Kalle Valo wrote:
> > 
> > Add "__packed" before the "__le16 *" should solve this warning by my
> > understand like this:

[snip]
> > 
> > -static void ieee80211_he_mcs_disable(__le16 *he_mcs)
> > +static void ieee80211_he_mcs_disable(__packed __le16 *he_mcs)
> > 

[snip]

> I don't know what Johannes thinks, but to me that looks like an ugly
> hack. Wouldn't use get_unaligned() or similar be cleaner?
> 
Well, then we've have to pass an untyped pointer (void *), which I guess
is fine? Since we do all kinds of le16_to_cpu() with it anyway, that'd
just become get_unaligned_le16().

That's probably the better choice.

But regardless, would the __packed even *work*? __attribute__((packed))
is documented as:

   This attribute, attached to a struct, union, or C++ class type
   definition, specifies that each of its members (other than zero-width
   bit-fields) is placed to minimize the memory required. This is
   equivalent to specifying the packed attribute on each of the members.
   
   When attached to an enum definition, the packed attribute indicates that
   the smallest integral type should be used. Specifying the -fshort-enums
   flag on the command line is equivalent to specifying the packed
   attribute on all enum definitions. 
   
   [snip example]
   
   You may only specify the packed attribute on the definition of an enum,
   struct, union, or class, not on a typedef that does not also define the
   enumerated type, structure, union, or class. 

So I'm not convinced it would actually *do* anything here at all, in the
proposed context?

johannes

