Return-Path: <linux-wireless+bounces-27939-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29029BCF821
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Oct 2025 18:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A3A14E3F73
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Oct 2025 16:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBE82737FB;
	Sat, 11 Oct 2025 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="DABueoF/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2D827E1D5;
	Sat, 11 Oct 2025 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760198791; cv=none; b=XZ5Cn4jfZSL7pg0hK/2GsGEmoSNkEFcZNoIr6QTZ1SVH7TKAki4mAAy/UpGnwrqDyuyY3VEleBbRLPNTIQ7tJ7jn+7boazgwGanrIYvfDZm0U6nos4JaBB+05ntDMv+ZaUUXFT78aqK9xOuxCK0J1h3b16DwXEo0O5pgZeaLoBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760198791; c=relaxed/simple;
	bh=11/PwvFWENUZGA6oedt5FAn2vny1Kx9O/VDKt64Jci8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bY2fDba77ho1Gv93IbEjm9AgJ7XfCJp3lw17iqK1CoVSNoT2slm9IXzFNc0LrPADQrihmDNTUp2SG5REzCiozAXEYywB1W/NQ0o6k+j/LWJQ3QvwHixSSQnUgVlfJJYKvMAR3SpJ6fnGBm8avWHIWMoQgY3bBg6knhOOwXbzPFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=DABueoF/; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id 633954028388;
	Sat, 11 Oct 2025 16:06:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 633954028388
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1760198785;
	bh=ywUIBktJyHmVN90pQn9FxCWxBT1mchKax2mgiw5i030=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DABueoF/ozklmo460hN4ESU9OWL4C59HRzf0aB4m3DH/WGYLApSawEVovLrkDCCXl
	 G8aPIsySlvQ6u1GB/qKzH5TOtFFEYXlVStSnWfUdeaqvaHkhdj5EnO77DBsduw2ll0
	 G5gepmg+zwA55sM7UvL0Eq1bXu7FN1XpwLnyE4CU=
Date: Sat, 11 Oct 2025 19:06:25 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
	Zong-Zhe Yang <kevin_yang@realtek.com>, Bernie Huang <phhuang@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH rtw-next v2 7/7] wifi: rtw89: process TX wait skbs for
 USB via C2H handler
Message-ID: <20251011175758-9e1b3340d51ac93a2663a800-pchelkin@ispras>
References: <20251002200857.657747-1-pchelkin@ispras.ru>
 <20251002200857.657747-8-pchelkin@ispras.ru>
 <d72c6bf8618b4245939fd73cd9e24acd@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d72c6bf8618b4245939fd73cd9e24acd@realtek.com>

On Tue, 07. Oct 08:07, Ping-Ke Shih wrote:
> Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> > @@ -1173,7 +1173,8 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *sk
> > 
> >         if (time_left == 0) {
> >                 ret = -ETIMEDOUT;
> > -               list_add_tail(&wait->list, &rtwdev->tx_waits);
> > +               if (!rtwdev->hci.tx_rpt_enable)
> > +                       list_add_tail(&wait->list, &rtwdev->tx_waits);
> 
> Oh. You avoid using rtwdev->tx_waits for USB. But I'd like to have the same
> behavior as PCIE.

I may be confused but doesn't it conflict with the comment [1] you've
posted to the previous version?  I've treated that as we should use
rtwdev->tx_rpt_queue for both TX wait and IEEE80211_TX_CTL_REQ_TX_STATUS
frames...

I'm all for following the PCIe-style as possible, too, but then initial
comment [1] becomes irrelevant, right?

[1]: https://lore.kernel.org/linux-wireless/c2c40bed311c4f05948cf2541c64ea30@realtek.com/

