Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40ACA23488F
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jul 2020 17:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGaPiz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jul 2020 11:38:55 -0400
Received: from mail.w1.fi ([212.71.239.96]:60938 "EHLO
        li674-96.members.linode.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726497AbgGaPiy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jul 2020 11:38:54 -0400
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Jul 2020 11:38:54 EDT
Received: from localhost (localhost [127.0.0.1])
        by li674-96.members.linode.com (Postfix) with ESMTP id CE61610F41;
        Fri, 31 Jul 2020 15:30:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from li674-96.members.linode.com ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FuwDwFtFVEec; Fri, 31 Jul 2020 15:30:58 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Fri, 31 Jul 2020 18:28:51 +0300
Date:   Fri, 31 Jul 2020 18:28:51 +0300
From:   Jouni Malinen <j@w1.fi>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     "Vinita S. Maloo" <vmaloo@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] nl80211: Add support to get BIP failure counters
Message-ID: <20200731152702.GA15382@w1.fi>
References: <1593498381-9337-1-git-send-email-vmaloo@codeaurora.org>
 <20d23075fb3437874a311ac18aa94194118a6e2b.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20d23075fb3437874a311ac18aa94194118a6e2b.camel@sipsolutions.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jul 30, 2020 at 01:41:04PM +0200, Johannes Berg wrote:
> On Tue, 2020-06-30 at 11:56 +0530, Vinita S. Maloo wrote:
> > Add support to get number of MIC errors, missing MME incidents and
> > packet replay incidents observed while using IGTK/BIGTK keys when
> > PMF and/or beacon protection features are enabled.
> 
> I can imagine you need this for WFA tests, but why are the debugfs
> counters not enough for that?
> 
> I don't really see much functional reason (wpa_supplicant or so) to have
> this, and thus why expose it in the nl80211 API?

Do we have a policy or some kind of preference on how to address dot11
statistics counters that can be handy at debugging real production use
error cases? For this particular case, is there objection to adding
support for fetching dot11RSNAStatsCMACReplays and
dot11RSNAStatsCMACReplays counter values?

-- 
Jouni Malinen                                            PGP id EFC895FA
