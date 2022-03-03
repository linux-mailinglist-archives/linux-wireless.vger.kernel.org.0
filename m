Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E174CC8B9
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Mar 2022 23:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbiCCWVF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Mar 2022 17:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbiCCWVD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Mar 2022 17:21:03 -0500
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857E610C513
        for <linux-wireless@vger.kernel.org>; Thu,  3 Mar 2022 14:20:14 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.w1.fi (Postfix) with ESMTP id 677C110FB7;
        Thu,  3 Mar 2022 22:20:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VTscEQw5HsWa; Thu,  3 Mar 2022 22:20:11 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Fri, 04 Mar 2022 00:20:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
        t=1646346011; bh=uxflbfWdCa9NbJ8Gck6IHCJYvQLn/GJaaaj6TtsfIOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lDDR9AbZS9JLkiaHB/HcHf1ISFajHnbtHMDpBdDmSFnQcIIRjqkgufK6jgzkxp9KP
         EwsGkhZW+Br+pHHe2xXPjRcCJRkIiWj0QneCI/c6AUUU+bwpj6dfvtSk9+W3hjZejK
         dFwERQp3HGOwtrz0QbR0TRkUsImoZaGOqhjxF7dPwRvmIMD8jNNiCVfI8oeprqTmeP
         UAIh8RQXs2nVoYJmS0//yhR20t6mNtODq+AXzgSZB5KxAPjrXYMX6viF+6pJ1rc5yB
         zycPvKmVxkGR2u1KpiAiXABdwi7+2HLdd/jcJOzDA+JwLtq7eCqQI5RUiTpkhokjrS
         3gC9Rx6GLw0LQ==
Date:   Fri, 4 Mar 2022 00:20:09 +0200
From:   Jouni Malinen <j@w1.fi>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     hostap@lists.infradead.org, linux-wireless@vger.kernel.org,
        nbd@nbd.name, ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH 8/9] DFS: switch to background radar channel if available
Message-ID: <20220303222009.GC33342@w1.fi>
References: <cover.1640014128.git.lorenzo@kernel.org>
 <ec706e090d7e44bcc9afd2f9789802f8c07e3c3f.1640014128.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec706e090d7e44bcc9afd2f9789802f8c07e3c3f.1640014128.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 20, 2021 at 04:48:23PM +0100, Lorenzo Bianconi wrote:
> On radar detection on the main chain switch to the channel monitored
> by the background chain if we have already performed the CAC there.

Is it clear that the channel on the background chain, if one is
available with CAC performed, comply with the ETSI uniform spreading
requirements? The comment below feels a bit misleading, but the way
patch 5/9 picks the channel for background CAC might be sufficient for
this. If so, it would be good to note that in the comment here:

> diff --git a/src/ap/dfs.c b/src/ap/dfs.c
> +hostapd_dfs_background_start_channel_switch(struct hostapd_iface *iface,

> +	/*
> +	 * If background radar detection is supported and radar channel
> +	 * monitored by background chain is available switch to it without
> +	 * waiting for the CAC otherwise let's keep a random channel.

That first part leaves it a bit open whether the random channel part from
the end of the sentence applies in practice for the new operating
channel. It is important to make this clearly describe the functionality
needed to meet uniform spreading requirement.

-- 
Jouni Malinen                                            PGP id EFC895FA
