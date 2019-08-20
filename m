Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 320B396AE6
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 22:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbfHTUux (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 16:50:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36648 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfHTUuw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 16:50:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 72F3B6090F; Tue, 20 Aug 2019 20:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566334251;
        bh=MLFFmzz1hYrHIylehvgf66H6iwkG3XqcWkKEw0qB+90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ge99vDVomyskTyxzlAMAkF3XvDbw0rKE79d1t1jFuQrmZCN8Bxv9svfg2i/ijbCdL
         fPMkboCCpyDTZdJ9Bv3EgKyyML/MFFYM31xmgs0BU3rMn1XVZxJ0S4qO/ggx3+914V
         rmdWEHzv83OGsqYRpfBNlR7s7p6Wofs5BUqOxVLE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from jouni.codeaurora.org (87-93-55-163.bb.dnainternet.fi [87.93.55.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jouni@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1014D608FC;
        Tue, 20 Aug 2019 20:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566334250;
        bh=MLFFmzz1hYrHIylehvgf66H6iwkG3XqcWkKEw0qB+90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y4BdAmHttSIpKLwmF605xDobVJb4Zkzx4Bx+UuQRCa/l5dSVQdZZSG8xIrVXKrLiZ
         oPhHIwAQFTRVsgb/ctblvmLPrndPZ0ahxsKa5UvoLkFIE1ipf2GG6LX7cochYzPBQ2
         d3s/FkFlwP3uXKjpa7mBfdW+jVFFIcEQSKZ6X0oE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1014D608FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jouni@codeaurora.org
Received: by jouni.codeaurora.org (sSMTP sendmail emulation); Tue, 20 Aug 2019 23:50:46 +0300
Date:   Tue, 20 Aug 2019 23:50:46 +0300
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Gurumoorthi Gnanasambandhan <gguru@codeaurora.org>
Subject: Re: [PATCH] cfg80211: VLAN offload support for set_key and
 set_sta_vlan
Message-ID: <20190820205046.GA9860@jouni.qca.qualcomm.com>
References: <20190815133825.8131-1-jouni@codeaurora.org>
 <3a8edc6691a03ed3c253d95811d5fd6cae453a03.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a8edc6691a03ed3c253d95811d5fd6cae453a03.camel@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 19, 2019 at 12:16:03PM +0200, Johannes Berg wrote:
> On Thu, 2019-08-15 at 16:38 +0300, Jouni Malinen wrote:
> > From: Gurumoorthi Gnanasambandhan <gguru@codeaurora.org>
> > 
> > This provides an alternative mechanism for AP VLAN support where a
> > single netdev is used with VLAN tagged frames instead of separate
> > netdevs for each VLAN without tagged frames from the WLAN driver.
> > 
> > By setting NL80211_EXT_FEATURE_VLAN_OFFLOAD flag the driver indicates
> > support for a single netdev with VLAN tagged frames. Separate
> > VLAN-specific netdevs are added using vcongig similar to Ethernet.
> > NL80211_CMD_NEW_KEY and NL80211_CMD_SET_STATION will optionally specify
> > vlan_id using NL80211_ATTR_VLAN_ID.
> 
> Without really looking at the specifics, it might be relatively simple
> to support this in mac80211?

Yes, that is something that I was thinking about when going through
this.. I don't remember why exactly mac80211 ended up with its current
design for per-AP_VLAN netdevs without tags, but it could indeed be
quite convenient to have this alternative approach available. I guess
both of them have some benefits, so this would likely be left with two
different mechanisms left to maintain, but the needed implementation in
mac80211 for this would seem to be pretty minimal (also without looking
at the exact details..).

-- 
Jouni Malinen                                            PGP id EFC895FA
