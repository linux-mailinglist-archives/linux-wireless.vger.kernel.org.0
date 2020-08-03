Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F23F23A298
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 12:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgHCKMr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 06:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgHCKMq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 06:12:46 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAE0C06174A
        for <linux-wireless@vger.kernel.org>; Mon,  3 Aug 2020 03:12:46 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k2XSX-00Fcd8-09; Mon, 03 Aug 2020 12:12:45 +0200
Message-ID: <78592978a8f3abab0130afc31e8d1fd210cd7d6f.camel@sipsolutions.net>
Subject: Re: [PATCH V5 1/3] nl80211: add support for setting fixed HE
 rate/gi/ltf
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Miles Hu <milehu@codeaurora.org>
Date:   Mon, 03 Aug 2020 12:12:44 +0200
In-Reply-To: <90e2d09f1d175e858964517b7365919c5d2b46f2.camel@sipsolutions.net> (sfid-20200803_111204_131961_556F5939)
References: <20200803085127.180550-1-john@phrozen.org>
         <90e2d09f1d175e858964517b7365919c5d2b46f2.camel@sipsolutions.net>
         (sfid-20200803_111204_131961_556F5939)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-08-03 at 11:11 +0200, Johannes Berg wrote:
> On Mon, 2020-08-03 at 10:51 +0200, John Crispin wrote:
> > From: Miles Hu <milehu@codeaurora.org>
> > 
> > This patch adds the nl80211 structs, definitions, policies and parsing
> > code required to pass fixed HE rate, gi and ltf settings.
> 
> Would be nice to capitalize acronyms like 'GI' and 'LTF' in free text
> ... :)
> 
> >  	[NL80211_TXRATE_VHT] = NLA_POLICY_EXACT_LEN_WARN(sizeof(struct nl80211_txrate_vht)),
> >  	[NL80211_TXRATE_GI] = { .type = NLA_U8 },
> > +	[NL80211_TXRATE_HE] = NLA_POLICY_EXACT_LEN_WARN(sizeof(struct nl80211_txrate_he)),
> 
> _WARN is for backward compatibility, don't use it for new stuff.
> 
> 
> But fixed those and applied.

I take that back, it causes tests that hit the set rate code to crash.

johannes

