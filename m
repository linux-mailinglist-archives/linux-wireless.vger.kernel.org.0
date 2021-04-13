Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4971335DDCE
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 13:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbhDMLcw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 07:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhDMLcu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 07:32:50 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5EAC061574;
        Tue, 13 Apr 2021 04:32:26 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lWHHG-00B7NO-B5; Tue, 13 Apr 2021 13:32:18 +0200
Message-ID: <a058901aa4baf5fa858a83f35c59a9b874c2d964.camel@sipsolutions.net>
Subject: Re: linux-next: build warning after merge of the mac80211-next tree
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Tue, 13 Apr 2021 13:32:17 +0200
In-Reply-To: <SA0PR11MB4752827232FAEB27E2EBEEB6F24F9@SA0PR11MB4752.namprd11.prod.outlook.com>
References: <20210413203349.43d3451e@canb.auug.org.au>
         <SA0PR11MB4752827232FAEB27E2EBEEB6F24F9@SA0PR11MB4752.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-04-13 at 10:39 +0000, Grumbach, Emmanuel wrote:
> Hi,
> 
> > 
> > Hi all,
> > 
> > After merging the mac80211-next tree, today's linux-next build (htmldocs)
> > produced this warning:
> > 
> > include/net/cfg80211.h:6643: warning: expecting prototype for
> > wiphy_rfkill_set_hw_state(). Prototype was for
> > wiphy_rfkill_set_hw_state_reason() instead
> > include/net/cfg80211.h:6643: warning: expecting prototype for
> 
> Ouch
> 
> Johannes, this is the fix:
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 3b296f2b7a2c..c6134220dd8f 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -6634,7 +6634,7 @@ void cfg80211_notify_new_peer_candidate(struct net_device *dev,
>   */
>  
> 
>  /**
> - * wiphy_rfkill_set_hw_state - notify cfg80211 about hw block state
> + * wiphy_rfkill_set_hw_state_reason - notify cfg80211 about hw block state
>   * @wiphy: the wiphy
>   * @blocked: block status
>   * @reason: one of reasons in &enum rfkill_hard_block_reasons
> 
> Do you want a patch or you amend the original commit?
> It is not in net-next yet.

Please send a separate fix anyway, I've pushed it out publicly after all
and try not to rebase unless absolutely necessary.

johannes

