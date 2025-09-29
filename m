Return-Path: <linux-wireless+bounces-27695-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6082BA8B88
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 11:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3103B6A23
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED272D0C95;
	Mon, 29 Sep 2025 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="ScLp0n5E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B47D27E06D;
	Mon, 29 Sep 2025 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759139187; cv=none; b=t9uHiwKFmBEf6OrQuZdidf2EZasCAXv0Eum9BrtCSz01aoY8kEp4EGPctPCPaztY4y7ACLRVZvlT/O3YUitickYpYz3OTzmeMsOzKx1BVPk2H+g7Z/Qv5iJlr+JHm59FRIMzsbW+phd1fpZPFyhsmhZwqFXyMR/y2bv879Oivfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759139187; c=relaxed/simple;
	bh=tAQ0z88IVH9cwoTS3/hEi0QtFi9WWrwFP5+oS9kp2EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riV7bpmirGeff2TFV8R/bIjYQU5A4tsbjcIobTkD+G6zuLGO4f9xfjC4wq+rcqsScMfOHx4ijn6yyQlT3rMMOKNaWFCaHrW7qs9o8UOswh9G4HLx5Q/SaXG3QyC8qauZDsbLZENgavEZLQw/oUJcz8FTSkCpAYA5mWgB1pAy/1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=ScLp0n5E; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.17])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id B07B74028387;
	Mon, 29 Sep 2025 09:46:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B07B74028387
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1759139180;
	bh=KBkfj0Ry6JPnYVze3a/9swiipK9iA83UU8fx5Xmmhc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ScLp0n5ElKTMAiPv0bYlYvA7HyLVv2+z+WDNColfFgOCpkBny+9tMBLzdb89cAROf
	 36nXAJyDL6w4JKtRjSW4QltDay8YLjRecfzWZjVDvexH2Q0/klQfQWHm6wQkghEtES
	 VZwdt+Q3HA0W/ICsthKOZ1fBWG/r55CU5bS3k1jg=
Date: Mon, 29 Sep 2025 12:46:20 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, 
	Zong-Zhe Yang <kevin_yang@realtek.com>, Po-Hao Huang <phhuang@realtek.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH rtw-next 3/6] wifi: rtw89: implement C2H TX report handler
Message-ID: <20250929121400-91aaec5c84b4868757ce3384-pchelkin@ispras>
References: <20250920132614.277719-1-pchelkin@ispras.ru>
 <20250920132614.277719-4-pchelkin@ispras.ru>
 <5316222e-5d9d-4cb8-b161-06ba311bdc2d@gmail.com>
 <07ee4e8c-bcb8-4349-afd3-59bc58899116@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07ee4e8c-bcb8-4349-afd3-59bc58899116@gmail.com>

On Wed, 24. Sep 22:16, Bitterblue Smith wrote:
> On 24/09/2025 01:12, Bitterblue Smith wrote:
> > On 20/09/2025 16:26, Fedor Pchelkin wrote:
> >> diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
> >> index ddebf7972068..f196088a8316 100644
> >> --- a/drivers/net/wireless/realtek/rtw89/fw.h
> >> +++ b/drivers/net/wireless/realtek/rtw89/fw.h
> >> @@ -3747,6 +3747,11 @@ struct rtw89_c2h_scanofld {
> >>  #define RTW89_GET_MAC_C2H_MCC_REQ_ACK_H2C_FUNC(c2h) \
> >>  	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(15, 8))
> >>  
> >> +#define RTW89_GET_MAC_C2H_TX_RPT_TX_STATE(c2h) \
> >> +	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(7, 6))
> >> +#define RTW89_GET_MAC_C2H_TX_RPT_SW_DEFINE(c2h) \
> >> +	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(12, 8))
> > 
> > This is only 4 bits:
> > 

Right, will be fixed.

> > #define TXCCXRPT_SW_DEFINE_SH		8
> > #define TXCCXRPT_SW_DEFINE_MSK		0xf
> > 
> > 
> > The rest of the series looks good to me. (I don't know much about
> > the RCU stuff.) I will test this tomorrow.
> > 
> 
> Actually, I found this in my notes:
> 
> "how to get just one tx report for each request? currently it seems
> to provide a report for each transmission attempt. how is the vendor
> driver coping with that?"
> 
> I think your code doesn't account for this.
> 
> Sorry I forgot about this detail. This behaviour is new in rtw89.
> The chips supported by rtw88 provide only one report for each request.

I think this part is also controlled with a couple of extra bits in TX
descriptor.

The vendor driver specifies a retry limit of 8 times.  It's probably the
default one followed by the firmware anyway because multiple retries on
failure status are seen via debug output of rtw89_mac_c2h_tx_rpt().
https://github.com/fofajardo/rtl8851bu/blob/1f1a14492fdac757c64a7efb7846be6374984d09/core/rtw_xmit.c#L7438

When there is a failed TX status reported by the firmware, the report is
ignored until the limit is reached or success status appears.
https://github.com/fofajardo/rtl8851bu/blob/1f1a14492fdac757c64a7efb7846be6374984d09/phl/hal_g6/hal_api_mac.c#L9547

The only concern is what happens if the sequence number of transmitted
frames wraps (4 bits is not a big range) when the previous frames with the
same sequence number were not processed yet - probability of the situation
increases with high retry limit being set.  I imagine the firmware has
some sort of handling for this but your reply suggests constraining retry
limit in the driver, are there maybe some other reasons we should set the
retry limit to one TX report?

