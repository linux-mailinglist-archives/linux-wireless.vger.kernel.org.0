Return-Path: <linux-wireless+bounces-27978-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05174BDD342
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 09:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D0F84F0390
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 07:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B01A313E39;
	Wed, 15 Oct 2025 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="iy6tBtuD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3764D313E06;
	Wed, 15 Oct 2025 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760514689; cv=none; b=d6/XZvIEV1jI90+5skusmSxXJMn4Ii/2f+yBc5ebKQV1OC/Pu/Rop7ruNZFi+cmec5zptRTuBjI/8IwWjFuWCej8i60lCOOYt0ezd18iGOnvyst00Xt3HinuE0r2tFZ/ODyVMD1scLjF0xfLl9ihOPtcNZ0XpFMdw7uFx4+bw4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760514689; c=relaxed/simple;
	bh=CBFfHRsFYIsZiQ4tsE1nkWROuQ1xtj+GhJNGHDenFUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvHbjZYV5EGgQ4U1jFZijhaiT1rf8CxlhhyzF9TKPHcgUTO3yDobYo7mHBitHM992tTY0tiCZmsdT1KzCeWaBIrY0grW5I1znT/ZLWMC7A5sxDJ8pzQY4PO4SMs/krT8Q9TjyVxonpV//702yAY/1Qiu4O/GPqUBVDi37EMeXS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=iy6tBtuD; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.16])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id F301E4076180;
	Wed, 15 Oct 2025 07:51:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru F301E4076180
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1760514682;
	bh=LbD9Rhy15FFxgoIf78gzFlJLro5Fvl9lKWQtefRbzBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iy6tBtuDEUr0yJzcKPgs/rSTWcw9bQrvvzlCrRBCspZ+e/6Qej9m8aYwoI7BSXG4j
	 PT0r1Nx5D50RIEPCt0yPX9XngK1ZLpknd2Gf1qWYqfDF+ZNsGQymdt8h5Fn500aqz7
	 PCzrJT4DaKSqPQsz3GPPX2sdwE0zaPfK8YXi/JwE=
Date: Wed, 15 Oct 2025 10:51:21 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
	Zong-Zhe Yang <kevin_yang@realtek.com>, Bernie Huang <phhuang@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH rtw-next v2 6/7] wifi: rtw89: handle
 IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Message-ID: <20251015103403-08f19f981c70546d56ebd07a-pchelkin@ispras>
References: <20251002200857.657747-1-pchelkin@ispras.ru>
 <20251002200857.657747-7-pchelkin@ispras.ru>
 <b1725b36caba476ba9ee4916910d8232@realtek.com>
 <20251014234211-4f763e2dab18fe04fbe4d95c-pchelkin@ispras>
 <bbaaabd1631d43fdaa24b818b7ac7929@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bbaaabd1631d43fdaa24b818b7ac7929@realtek.com>

On Wed, 15. Oct 01:43, Ping-Ke Shih wrote:
> > > > +
> > > > +               if (sw_define != skb_data->tx_rpt_sn)
> > > > +                       continue;
> > > > +               if (tx_status != RTW89_TX_DONE &&
> > > > +                   data_txcnt != skb_data->tx_pkt_cnt_lmt)
> > >
> > > As commit message of previous patch, "When there is a failed
> > > TX status reported by the firmware, the report is ignored until the limit
> > > is reached or success status appears."
> > >
> > > Do you still need to check data_txcnt for failed cases?
> > 
> > The question also concerns
> > 
> >   tx_req->desc_info.tx_cnt_lmt = 8;
> > 
> > line in rtw89_tx_rpt_enable().  'tx_cnt_lmt' is written to TX descriptor
> > and processed by firmware.  The value defines how many times the firmware
> > will retry transmission attempts, it will not retry more times than that.
> > 
> > 'data_txcnt' C2H field determines the retry attempt counter for the frame
> > returned by the firmware.  If it reaches the limit, this means we got
> > the last report from the firmware and there would be no other firmware
> > reports for the sent frame.  So a final tx_status should be taken
> > uncondionally in this case.
> > 
> > E.g. if 'tx_cnt_lmt' is set to 1, the firmware will try only once,
> > 'data_txcnt' will be 1, too.  The limit is reached and we should take
> > tx_status immediately as is.  So there's a higher chance of getting a
> > failed status eventually.
> > 
> > I set it currently to 8 as the vendor driver does.  In local testing it
> > looks more than enough.  I've seen maximum of 5 retry attempts for the
> > same frame (usually there are no retries at all) though my network radio
> > environment is quite noisy.
> > 
> > I'll add the tx_cnt_lmt related info to commit message for clarity.
> > 
> 
> Thanks for the detail. 
> 
>     1 2 3 4 5 6 7 8
> (a) x x x x x x x x  ==> retry 8 times, but all failure. Report at 8th C2H.
> (b) x x x o          ==> retry 3 times, and 4th done. Report at 4th C2H.
> (c) o                ==> just done at first one. Report at first C2H.
> 
> For every attempt, firmware reports a C2H with tx_status, right?

Yes.

> Can I say (a) case is why we should check data_txcnt? 
> For cases (b)/(c), they rely on 'tx_status == RTW89_TX_DONE'.

We should somehow determine in case (a) when those 8 attempts for the
frame have passed and then promptly give the report with a failed status
up to the wireless stack.  To my mind, without checking data_txcnt
rtw89_mac_c2h_tx_rpt() can't determine the time when to do an actual
report if every retry attempt has failed.

Otherwise skb would remain in the queue being unreported until HCI reset
takes place, though we already had a chance to report it as failed.

