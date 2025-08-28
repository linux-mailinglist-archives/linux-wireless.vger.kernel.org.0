Return-Path: <linux-wireless+bounces-26750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CF4B39BAB
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 13:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031C556007C
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 11:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4061930DD04;
	Thu, 28 Aug 2025 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="SUKTdb3c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F1630C62D;
	Thu, 28 Aug 2025 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756380939; cv=none; b=Y9xpJ4Shz0UVn5IofOzHUomjmsKZahot0beejT/4CfojNbr7dUa6WCNBu1QxFwdao0ANkgQEgS5x+ddJ9LVofPVocFbyHvJ3tVNvxgd1Chxi5mHWQxGFvtS6tGahyj0xxObeJW6rvH8ooxqHfWtVddEiJEcPZr1s9Dg40tRW5F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756380939; c=relaxed/simple;
	bh=thDvjNmBzA4MV5p/MCdU6fjMXdLa0+BwlfQm4LBNnRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1FAeNFpnKwwX0Qy7Kzuu9ic881NALBuHgPt5TGvzrGD1K9357FGaxW0JAwOjjaDUMAReyMFBnBwJIBHeJRO4KTm72dOYMt9Oq+ouVZ9NZnTNmPw4IEtXYYFJ60R7V3kt1HlIFZHhE2pvEqqR2fOPBRpYUr4+Jhuy2xdvSiT0aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=SUKTdb3c; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id 7EDBC40643C9;
	Thu, 28 Aug 2025 11:35:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7EDBC40643C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1756380926;
	bh=htruAr9Eay0kERu9Ry9Meq5CGWofFUXQDp6UXGVxBzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SUKTdb3c/rCm+APUfO4mmrt+7zLs8/2Q6pYlnru1/Ba5A/BFBox0E93Y8AdPWhK2L
	 zkQqqnDexyHJ0ET8M+839u/uRhM+Da52MYu3eb5rqL8t5xzpEnF/tqO2Un1k+2jmFa
	 E2IwmbngfW0tS5h+9CtYtF6mKsLInRFuOCwTKXcA=
Date: Thu, 28 Aug 2025 14:35:26 +0300
From: "pchelkin@ispras.ru" <pchelkin@ispras.ru>
To: Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Bernie Huang <phhuang@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH rtw v2 1/4] wifi: rtw89: fix use-after-free in
 rtw89_core_tx_kick_off_and_wait()
Message-ID: <20250828140912-171fa800b314416241936137-pchelkin@ispras>
References: <20250827120603.723548-2-pchelkin@ispras.ru>
 <87693651fe394065b421d8d8fe171f89@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87693651fe394065b421d8d8fe171f89@realtek.com>

Thanks! I agree with all aforementioned comments but wonder about this one:

On Thu, 28. Aug 08:07, Zong-Zhe Yang wrote:
> Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> > --- a/drivers/net/wireless/realtek/rtw89/pci.c
> > +++ b/drivers/net/wireless/realtek/rtw89/pci.c
> > @@ -464,10 +464,7 @@ static void rtw89_pci_tx_status(struct rtw89_dev *rtwdev,
> >  	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
> >  	struct ieee80211_tx_info *info;
> > 
> > -	rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status == RTW89_TX_DONE);
> > -
> >  	info = IEEE80211_SKB_CB(skb);
> > -	ieee80211_tx_info_clear_status(info);
> > 
> >  	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
> >  		info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
> > @@ -494,6 +491,10 @@ static void rtw89_pci_tx_status(struct rtw89_dev *rtwdev,
> >  		}
> >  	}
> > 
> > +	if (rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status == RTW89_TX_DONE))
> > +		return;
> > +
> > +	ieee80211_tx_info_clear_status(info);
> 
> Don't change order of these calls.
> (it's wrong for normal pkt because their tx_info are cleared after filled)
> 

ieee80211_tx_info_clear_status() clears only TX status part of the
ieee80211_tx_info. It doesn't touch 'flags' field - the only one filled
here by rtw89_pci_tx_status(). It shouldn't be wrong for normal packets.

The reason for changing the order of those calls is to have a chance to
update tx_ring statistics before fast return from rtw89_pci_tx_status()
in case of tx_wait packets.

But, ergh, I can't find those stats reported anywhere in the driver so
it looks like just not a real issue currently and I'd rather not change
the order, okay.

> >  	ieee80211_tx_status_ni(rtwdev->hw, skb);  }
> > 

