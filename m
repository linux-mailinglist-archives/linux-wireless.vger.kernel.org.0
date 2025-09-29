Return-Path: <linux-wireless+bounces-27694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE741BA88B1
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 11:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC3E189D72E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 09:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165DB28314B;
	Mon, 29 Sep 2025 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="li8ioU6F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725232820B7;
	Mon, 29 Sep 2025 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137184; cv=none; b=gjNTUCAmK4MlCkkKT/ojFhQ3cbrcYVD/goxrcJbYCEHgr7eovm4VXwHQvtKETWtAqGLBTdqyb+JbV2nXzlhC/ccK4982oFbQ4nUwjvffkQl73M3HGduVj5h6zQ4QxaHnL1Yzn5/BurA3cZul5F5PKKlQd6jJ62x9xINBmUqc2GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137184; c=relaxed/simple;
	bh=MDWkLK1dGijjG8v507lu0ysDW3LIvasoxZgZGYZ3a5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leGuBOI8gb3euzc8c5FrmqQ3LtGsSsc9eBWynKBjcb4lNm1ZHFymcLTt2qy0n+du+1HVpkHx+UuqJ6pIWX6/DraSD/KuIWIU++yUCndLWpttE2cvn3dZPqrj8P5CwijtLXU0yGn9ojB2nZt4BECWDJqbFeuQcGM5xkZNsnjdvQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=li8ioU6F; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.17])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id E211A4028387;
	Mon, 29 Sep 2025 09:12:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru E211A4028387
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1759137172;
	bh=M5/86L2ysekbvzlLNJYDPTANUtIXEb03F86NeC3bLus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=li8ioU6F086CyKOUTO/mcGQMYgoJPIctnJj3/58MoGuj0Jy7ipl5t0QCT+nPJ/gOT
	 3aDwmUfnICUxzl7t4XJYXMIIsiknfErr6xXiw+FIP6qz7IiyVod1eSvrhSqqhrm6xP
	 UC/gU3gutdXkHF+b7VpK8xib8x8k2TeONwGUgaxU=
Date: Mon, 29 Sep 2025 12:12:52 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
	Zong-Zhe Yang <kevin_yang@realtek.com>, Bernie Huang <phhuang@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH rtw-next 2/6] wifi: rtw89: usb: fix leak in
 rtw89_usb_write_port()
Message-ID: <20250929120454-04af8f947a628885bf00db71-pchelkin@ispras>
References: <20250920132614.277719-1-pchelkin@ispras.ru>
 <20250920132614.277719-3-pchelkin@ispras.ru>
 <fbd7e4192bb8422980a2916489d4961d@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fbd7e4192bb8422980a2916489d4961d@realtek.com>

On Wed, 24. Sep 09:03, Ping-Ke Shih wrote:
> Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> > @@ -305,8 +305,9 @@ static void rtw89_usb_ops_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)
> >                 ret = rtw89_usb_write_port(rtwdev, txch, skb->data, skb->len,
> >                                            txcb);
> >                 if (ret) {
> > -                       rtw89_err(rtwdev, "write port txch %d failed: %d\n",
> > -                                 txch, ret);
> > +                       if (ret != -ENODEV)
> > +                               rtw89_err(rtwdev, "write port txch %d failed: %d\n",
> > +                                         txch, ret);
> > 
> >                         skb_dequeue(&txcb->tx_ack_queue);

Hi, thanks for reviews!  I'm in process of addressing the provided
comments.

> 
> By the way, during I review this function, txcb->tx_ack_queue is a
> struct sk_buff_head, how about just struct sk_buff *skb? 
> (I might ask Bitterblue Smith about this).

tx_ack_queue is implemented like in rtw88, but there is no TX aggregation
in rtw89 yet I guess.

> 
> More, since skb here is from mac80211, so ieee80211_free_txskb() would be 
> more suitable rather than dev_kfree_skb_any()?

Agree, will do this in a separate patch.

> 
> >                         kfree(txcb);
> > --
> > 2.51.0
> > 
> 

