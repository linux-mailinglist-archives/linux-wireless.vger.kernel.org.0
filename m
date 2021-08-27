Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698B63F947E
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 08:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbhH0GrH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Aug 2021 02:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhH0GrH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Aug 2021 02:47:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7DBC061757
        for <linux-wireless@vger.kernel.org>; Thu, 26 Aug 2021 23:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ZRTYD6eP/gs8e0gFb1UkAZUbs3ZjYkft6D2Zi+/Ha+8=;
        t=1630046778; x=1631256378; b=EWJpGmLBjyYlXrztdFgHx3poRjx85doNqHjZlz9TGZWJg4t
        JEZRfXWd+2lMjP5k/8Iwd7px4/4HEogROA/1x62Gj9mBEMFVHWoxlgKjlDvv1STww9K2o3cpGNlPa
        DKfca05RKL07xavLj6qpSD3lijh9dfhqcZPPzmMNtJ8luKTG0t2lAZQh2/D+VtCXhaICuWws5jXTo
        bnY2PuAVI8r7QA44GCOJuWW5x/gC3NsC4P8i2pn1AX+OO0ADY+vx8w4mwpso/0dtpR6uWnjWUveM6
        XLuMM0vZj0bAQOCRSkU50g3ORxZSUWh0wWI3ZH0hY6Vv/iNwWgfrbYEvD8lF1aZQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mJVcy-00GVUD-Ay; Fri, 27 Aug 2021 08:46:12 +0200
Message-ID: <48ad47869e703cbef437378c508d6a5b64c160ae.camel@sipsolutions.net>
Subject: Re: [PATCH v2 8/8] mac80211: save transmit power envelope element
 and power constraint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Fri, 27 Aug 2021 08:46:11 +0200
In-Reply-To: <25fcede26b99604a03d0b321b7120db4@codeaurora.org>
References: <20210820122041.12157-1-wgong@codeaurora.org>
         <20210820122041.12157-9-wgong@codeaurora.org>
         <dfe27f657b4615369cf751d394f5cba75f5fdcc1.camel@sipsolutions.net>
         <25fcede26b99604a03d0b321b7120db4@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-08-27 at 10:11 +0800, Wen Gong wrote:
> > Also, if we're doing this anyway, then we can change
> > the code above (perhaps as a separate patch) to not do
> > cfg80211_find_ext_ie() but rather take it out of the parsed.
> do you mean NOT use cfg80211_find_ext_ie()/cfg80211_find_ie() and still 
> use "struct ieee802_11_elems elems" here and
> move this code to a separate function/patch?

Well, there's an existing place in this function that uses
cfg80211_find_ext_ie(), and various uses of ieee80211_bss_get_ie(), so
it feels like if we're going to do the full parsing, we should switch
all the existing "look up an element" to also use the parsed data
instead.

Not the other way around :)

johannes

