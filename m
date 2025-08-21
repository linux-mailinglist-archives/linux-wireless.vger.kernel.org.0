Return-Path: <linux-wireless+bounces-26494-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D20BB2F379
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 11:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EAC21CE05A9
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 09:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41E72E9EBB;
	Thu, 21 Aug 2025 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="NoLftIDx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA28B2D3ED1;
	Thu, 21 Aug 2025 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767522; cv=none; b=VW1hWM+DMrdIzr41dEkhqo5+U4OtgIl8B07eOqNuclAT8eELimMLyR8Qa9VOitzF1CvppiF5YWOD0esWJzHyg+V1Ar6lCtgY8bOodEHFntbXgGhHBTDcRmYkCqPEGjhAeipsbuTzmsk2pnemBriGXE/mGoTGZmRwnsnKBr2Kaxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767522; c=relaxed/simple;
	bh=g59s4/Qwtwv1YpMSQzMuBoZHeETrJWRYPs4pguuzfhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=at7djwTqFIm2Vj7NgFSP0qFztEgSd2kAJicLzLni9TStzQMNjNyqU5OUDWrcD//lqE/DureU/2BnoRNruncqHia/o/wVxQC0VQtE3lGUMi4acbol+guFEdUCGX1cw+oj/OgwNb7TM7Vw5DGGvZzqTsn77Z+G6UZ1ixzYrI3Oy9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=NoLftIDx; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id D91C140D3C55;
	Thu, 21 Aug 2025 09:11:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D91C140D3C55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1755767509;
	bh=sCzSseHm8aXWfxStb92YtXd+xaCSsUO+vJVCCr4NWHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NoLftIDxC/fj9s5CSXp5WL5ycPNK32f7Nuy6sF+8HHelNi1usU9rlnCUktMomw6ak
	 sgU+ks5Popmg2Oc6+n9noaaCwkActjlyUXLKrFl8EsRSrVE+jEQYXd8n+9pPlQoHot
	 QXJixOXEj1YplJICZ8ao+lUxI7D7bwQ7Lp2r74ag=
Date: Thu, 21 Aug 2025 12:11:49 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Bernie Huang <phhuang@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH rtw-next 1/2] wifi: rtw89: fix use-after-free in
 rtw89_core_tx_kick_off_and_wait()
Message-ID: <20250821113341-4d93a84ec8bcd73321acd2b7-pchelkin@ispras>
References: <20250820141441.106156-1-pchelkin@ispras.ru>
 <20250820141441.106156-2-pchelkin@ispras.ru>
 <b4ec58864e544b0295ddb02ed408199b@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4ec58864e544b0295ddb02ed408199b@realtek.com>

Thanks for the feedback, Zong-Zhe!

On Thu, 21. Aug 04:01, Zong-Zhe Yang wrote:
> Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> > Though one solution that _works_ currently is to get rid of 'struct rtw89_tx_wait_info' and
> > replace it with the only field it is used for - 'bool tx_done'.  Then it can be stored at 'struct
> > ieee80211_tx_info::status::status_driver_data' directly without the need for allocating an
> > extra dynamic object and tracking its lifecycle.
> > I didn't post this since then the structure won't be expandable for new fields and that's
> > probably the reason for why it wasn't done in this manner initially.
> 
> With a busy waiting on tx waiting side ?
> If so, it would be unacceptable.

Ohh, I forgot about the need for async completion here. Nevermind that
solution, sorry.

> 
> > 
> >  drivers/net/wireless/realtek/rtw89/core.c | 15 ++++++++---
> > drivers/net/wireless/realtek/rtw89/core.h | 32 ++++++++++++++---------
> > drivers/net/wireless/realtek/rtw89/pci.c  |  6 +++--
> >  3 files changed, 36 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/realtek/rtw89/core.c
> > b/drivers/net/wireless/realtek/rtw89/core.c
> > index 57590f5577a3..826540319027 100644
> > --- a/drivers/net/wireless/realtek/rtw89/core.c
> > +++ b/drivers/net/wireless/realtek/rtw89/core.c
> > @@ -1088,6 +1088,7 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev,
> > struct sk_buff *sk
> >         struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
> >         struct rtw89_tx_wait_info *wait;
> >         unsigned long time_left;
> > +       bool free_wait = true;
> >         int ret = 0;
> > 
> >         wait = kzalloc(sizeof(*wait), GFP_KERNEL); @@ -1097,7 +1098,8 @@ int
> > rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *sk
> >         }
> > 
> >         init_completion(&wait->completion);
> > -       rcu_assign_pointer(skb_data->wait, wait);
> > +       spin_lock_init(&wait->owner_lock);
> > +       skb_data->wait = wait;
> > 
> >         rtw89_core_tx_kick_off(rtwdev, qsel);
> >         time_left = wait_for_completion_timeout(&wait->completion,
> > @@ -1107,8 +1109,15 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev,
> > struct sk_buff *sk
> >         else if (!wait->tx_done)
> >                 ret = -EAGAIN;
> > 
> > -       rcu_assign_pointer(skb_data->wait, NULL);
> > -       kfree_rcu(wait, rcu_head);
> 
> Please consider the following.
> (moving "rcu_assign_pointer(skb_data->wait, NULL)" to be under "if (time_left == 0)")
> 

There is still a tiny race window. Suppose wait_for_completion_timeout()
exits with a timeout, so time_left is 0. If completing side goes on in
parallel just after that, it has a chance to proceed and free skb_data
before the below if (time_left == 0) fragment is executed.

>     if (time_left == 0) {
>         rcu_assign_pointer(skb_data->wait, NULL);
>         ret = -ETIMEDOUT;
>     } else if (!wait->tx_done) {
>         ret = -EAGAIN;
>     }
> 
>     kfree_rcu(wait, rcu_head);
> 
> If completing side does run as expected (potential racing mentioned in this patch),
> there is no real need to assign NULL back.

Actually the race happens regardless of wait_for_completion_timeout() exit
status, it's briefly mentioned in the race diagram inside commit message
(but the diagram can show only one possible concurrency scenario). I agree
this may be improved and described more explicitly though.

As for the patch itself, currently I can't see another way of fixing that
other than introducing locks on both waiting and completing side.

