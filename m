Return-Path: <linux-wireless+bounces-8307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECFA8D46EF
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 10:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D811C21E58
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 08:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A655E14B084;
	Thu, 30 May 2024 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DI90/Pa2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDC314387F;
	Thu, 30 May 2024 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717057240; cv=none; b=Gno7RMyJpqw91sx9y+F0ikofyHsIK15BxMs19wMyRvJF8PmvGrn0jOaY+WYFyrqxn/b9z/OD3hUTluk8vNegSUu1JD4E5/xTpWFQ2LTrHWJwSdeShSf9kEFPiuQDLYmB3R6Y8e9jApqzTqanWcCIr6l8VsKQ17PFIeyEm4T0c/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717057240; c=relaxed/simple;
	bh=uwAz9qN23oK/OJuve8KxoRRpV5x0vLAL4/ykKXpRrPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SM/uElo1kKWvi/wHK5T5LMpaeXiBvyW26BuPbYGq+Cd2/3CUxWT2qqQtOInQvrkAzzJxH+MPqtt2YtBztb6N+543Rybpq+Ek/jvGzUE6izd1EkyS+HlOoppfrAy/AaLbNuLyJ3n6XMiJZB9L1snOTrBfu5UIFLO2nZO/Q/XgDR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DI90/Pa2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bYZIpqrQtzaQ8xIM1w25+g3wQxbpxFEBPyGhVKMCX+U=; b=DI90/Pa2/mK1x3SUUOArogPrUM
	dp5/8NgdELrTAo7BpeljhBPpniaFtG1h1s+BjONSc/PcKe9W8Ycd+GLgqdwM+jmJkaozyEevoLJDE
	58nktpsStoHpXLQ5O2wjEj+9BwE1nZlG3nxCEukyxwd9So3LuwsxM1s6Z72vVBYtd5fnR4kxsHkLQ
	8Q3GqjIPzcEYP3YdhMzyKL6Ris2VlQJOUByvqtUBJb/R+NuRpl1S8rOhFNW8N+4hCHNDjbKWwMS2t
	XKvQcTgk0wSL1138p/8IrGIlwFzx4jNk+1il4AYmCCSsJ079zFWw2XieoFPPSPX5U6kFfN08+fZjJ
	wR0+3R0Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56108)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sCb1Q-000752-0x;
	Thu, 30 May 2024 09:20:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sCb1Q-00050Q-OI; Thu, 30 May 2024 09:20:28 +0100
Date: Thu, 30 May 2024 09:20:28 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Nemanov, Michael" <michael.nemanov@ti.com>
Cc: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [EXTERNAL] [PATCH wireless-next 6/8] wifi: wlcore: add pn16
 support
Message-ID: <Zlg2zGb7s7zu6jb+@shell.armlinux.org.uk>
References: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
 <E1sBsy7-00E8vu-Nc@rmk-PC.armlinux.org.uk>
 <e6ae6dfa-6554-4e88-abb0-31dbbd8df03f@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6ae6dfa-6554-4e88-abb0-31dbbd8df03f@ti.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, May 30, 2024 at 11:06:40AM +0300, Nemanov, Michael wrote:
> 
> On 5/28/2024 12:18 PM, Russell King (Oracle) wrote:
> 
> [...]
> 
> >    static int wlcore_fw_status(struct wl1271 *wl, struct wl_fw_status *status)
> >    {
> > +	struct wl12xx_vif *wlvifsta;
> > +	struct wl12xx_vif *wlvifap;
> >    	struct wl12xx_vif *wlvif;
> >    	u32 old_tx_blk_count = wl->tx_blocks_available;
> >    	int avail, freed_blocks;
> > @@ -410,23 +412,100 @@ static int wlcore_fw_status(struct wl1271 *wl, struct wl_fw_status *status)
> >    		wl->tx_pkts_freed[i] = status->counters.tx_released_pkts[i];
> >    	}
> [...]
> >    	for_each_set_bit(i, wl->links_map, wl->num_links) {
> > +		u16 diff16, sec_pn16;
> >    		u8 diff, tx_lnk_free_pkts;
> > +
> >    		lnk = &wl->links[i];
> >    		/* prevent wrap-around in freed-packets counter */
> >    		tx_lnk_free_pkts = status->counters.tx_lnk_free_pkts[i];
> >    		diff = (tx_lnk_free_pkts - lnk->prev_freed_pkts) & 0xff;
> > -		if (diff == 0)
> > +		if (diff) {
> > +			lnk->allocated_pkts -= diff;
> > +			lnk->prev_freed_pkts = tx_lnk_free_pkts;
> > +		}
> > +
> > +		/* Get the current sec_pn16 value if present */
> > +		if (status->counters.tx_lnk_sec_pn16)
> > +			sec_pn16 = __le16_to_cpu(status->counters.tx_lnk_sec_pn16[i]);
> > +		else
> > +			sec_pn16 = 0;
> > +		/* prevent wrap-around in pn16 counter */
> > +		diff16 = (sec_pn16 - lnk->prev_sec_pn16) & 0xffff;
> > +
> > +		/* FIXME: since free_pkts is a 8-bit counter of packets that
> > +		 * rolls over, it can become zero. If it is zero, then we
> > +		 * omit processing below. Is that really correct?
> > +		 */
> > +		if (tx_lnk_free_pkts <= 0)
> >    			continue;
> The original code was
>         tx_lnk_free_pkts = status->counters.tx_lnk_free_pkts[i];
>         diff = (tx_lnk_free_pkts - lnk->prev_freed_pkts) & 0xff;
> 
>         if (diff == 0)
>             continue;
> 
> I wonder if comparing tx_lnk_free_pkts to 0 was added intentionally? This is
> monotonously incremented counter so 0 is not significant, unlike the diff.
> Have I missed something?

You are... While you're correct about the original code, your quote is
somewhat incomplete.

+		if ( (isSta == true) && (i == wlvifSta->sta.hlid) && (test_bit(WLVIF_FLAG_STA_AUTHORIZED, &wlvifSta->flags)) && (status->counters.tx_lnk_free_pkts[i] > 0) )
...
+		}
 
+		if ( (isAp == true) && (test_bit(i, &wlvifAp->ap.sta_hlid_map[0])) && (test_bit(WLVIF_FLAG_AP_STARTED, &wlvifAp->flags)) && (wlvifAp->inconn_count == 0) && (status->counters.tx_lnk_free_pkts[i] > 0) )
...
+		}
 	}

Note that both of these if() conditions can only be executed if the final
condition in each is true. Both check for the same thing, which is:

		status->counters.tx_lnk_free_pkts[i] > 0

In my patch, tx_lnk_free_pkts is status->counters.tx_lnk_free_pkts.

Therefore, there is no point in evaluating either of these excessively
long if() conditions in the original code when tx_lnk_free_pkts is
less than zero or zero - and thus the logic between TI's original patch
and my change is preserved.

Whether that condition in the original patch is correct or not is the
subject of that FIXME comment - I believe TI's code is incorrect, since
it is possible that tx_lnk_free_pkts, which is a u8 that is incremented
by the number of free packets, will hit zero at some point just as a
matter of one extra packet being freed when the counter was 255.

Moving it out of those two if() statements makes the issue very
obvious. It would be nice to get a view from TI on whether the original
patch is actually correct in this regard. I believe TI's original patch
is buggy.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

