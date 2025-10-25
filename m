Return-Path: <linux-wireless+bounces-28242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5F6C08EDE
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 12:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62811899A70
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 10:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29BB29E101;
	Sat, 25 Oct 2025 10:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="A8FMeEFg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5A827E7F0;
	Sat, 25 Oct 2025 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761387164; cv=none; b=ItqtiAk/4GdqBbUJNaovvc2Xbq4pkmgAYdLdvq0vDlSfhHfnInQlTpenv8Irp3j4q7908LAYzvKel7rkelrYg0bcdwM43MdbDm34t1O/qqpFJcf5KCHu5f385DjDXIJTVR0wSDIO6jgpsbJfm7qK4epXr11VoHqDhVweTV76X9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761387164; c=relaxed/simple;
	bh=xYAgceLspemRBMQ+mkC0zd2Skjqs0JX7be4SWBc08mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxZHTQUYV5gtNChOs+/TowJY8bjlSh4EQzIu4gyiURsxw17HKm+TW5f4qKq0w7nYukAT+JiIVZ4Y5sPNAgkgGxvS0iwHs0Iqu5kVxXJa4CAfuKD1uAZ4knPuYLnLLkiWYr0567AZDktZ8g4CxZ4+dCPLR5nVmMm98sTCd0/c1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=A8FMeEFg; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id 86E8B407674D;
	Sat, 25 Oct 2025 10:12:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 86E8B407674D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1761387151;
	bh=k+qxlMOpsdoySMMJQyou7/5VUprV+TN2uaIvjNBJC+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A8FMeEFg13jLtvFiL4eXye2eSbdwsbkTQb9Gk4wQykr/cc98JmH6zHwNYfihRRjYK
	 pCW0tJLZrVNNij3/EfDICQ3YeHN2wSGT5FlNF3HOQED67KJ+orKuXKgFgjkA0nbbnK
	 /slwHH8a3ZJAHFuKyWDk1idByKuzbVz04uc6GtgE=
Date: Sat, 25 Oct 2025 13:12:31 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
	Zong-Zhe Yang <kevin_yang@realtek.com>, Bernie Huang <phhuang@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH rtw-next v3 5/9] wifi: rtw89: implement C2H TX report
 handler
Message-ID: <20251025125848-1a66489b56a61c3e63193431-pchelkin@ispras>
References: <20251017100658.66581-1-pchelkin@ispras.ru>
 <20251017100658.66581-6-pchelkin@ispras.ru>
 <6dc0740a095f4a38ae2427169b1d100c@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6dc0740a095f4a38ae2427169b1d100c@realtek.com>

On Wed, 22. Oct 06:21, Ping-Ke Shih wrote:
> Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> > @@ -5457,6 +5457,35 @@ rtw89_mac_c2h_mcc_status_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32
> >         rtw89_complete_cond(&rtwdev->mcc.wait, cond, &data);
> >  }
> > 
> > +static void
> > +rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
> > +{
> > +       u8 sw_define, tx_status, data_txcnt;
> > +
> > +       if (rtwdev->chip->chip_id == RTL8922A) {
> 
> Add a chip_ops c2h_tx_rpt? Then, no need chip_id checking, and reduce line
> length (normally we prefer shorter than 80 or 90 characters; over 100 characters
> isn't a good idea).
> 
> Maybe this is because you want to store the status into local variables.
> With a chip_ops, you should define another struct to store them.
> 
> Or, you just keep it as was, but wrap lines to be shorter, and give shorter
> naming. For example,
>   - rpt_v2 -> v2
> 
>   - data_txcnt -> txcnt
> 
> 		if (rtwdev->chip->chip_id == RTL8852C)
> 			txcnt = le32_get_bits(rpt->w5,
> 					              RTW89_C2H_MAC_TX_RPT_W5_DATA_TX_CNT_V1);
> 		else
> 			txcnt = le32_get_bits(rpt->w5,
> 					              RTW89_C2H_MAC_TX_RPT_W5_DATA_TX_CNT);
> 

The chip_ops variant is more abstract (and good in such a way) but I don't
think it's worth mangling with modifying struct chip_ops of each chip and
adding new structs as we probably won't need to scale or expand
rtw89_mac_c2h_tx_rpt() further unless some another V3 format is supported.
Also other mac C2H functions tend to check chip_id in place if they need.

I'll try to make the lines shorter - the longest one will be 86 symbols.

> 
> > +               const struct rtw89_c2h_mac_tx_rpt_v2 *rpt_v2;
> > +
> > +               rpt_v2 = (const struct rtw89_c2h_mac_tx_rpt_v2 *)c2h->data;
> > +               sw_define = le32_get_bits(rpt_v2->w12, RTW89_C2H_MAC_TX_RPT_W12_SW_DEFINE_V2);
> > +               tx_status = le32_get_bits(rpt_v2->w12, RTW89_C2H_MAC_TX_RPT_W12_TX_STATE_V2);
> > +               data_txcnt = le32_get_bits(rpt_v2->w14, RTW89_C2H_MAC_TX_RPT_W14_DATA_TX_CNT_V2);
> > +       } else {
> > +               const struct rtw89_c2h_mac_tx_rpt *rpt;
> > +
> > +               rpt = (const struct rtw89_c2h_mac_tx_rpt *)c2h->data;
> > +               sw_define = le32_get_bits(rpt->w2, RTW89_C2H_MAC_TX_RPT_W2_SW_DEFINE);
> > +               tx_status = le32_get_bits(rpt->w2, RTW89_C2H_MAC_TX_RPT_W2_TX_STATE);
> > +               if (rtwdev->chip->chip_id == RTL8852C)
> > +                       data_txcnt = le32_get_bits(rpt->w5, RTW89_C2H_MAC_TX_RPT_W5_DATA_TX_CNT_V1);
> > +               else
> > +                       data_txcnt = le32_get_bits(rpt->w5, RTW89_C2H_MAC_TX_RPT_W5_DATA_TX_CNT);
> > +       }
> > +
> > +       rtw89_debug(rtwdev, RTW89_DBG_TXRX,
> > +                   "C2H TX RPT: sn %d, tx_status %d, data_txcnt %d\n",
> > +                   sw_define, tx_status, data_txcnt);
> > +}
> > +
> >  static void
> >  rtw89_mac_c2h_mrc_tsf_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
> >  {
> 
> [...]
> 

