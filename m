Return-Path: <linux-wireless+bounces-28032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E026ABE802E
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 12:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A63C6E3568
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 10:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593D131282E;
	Fri, 17 Oct 2025 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="IKmBqaGk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D323126AD;
	Fri, 17 Oct 2025 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695972; cv=none; b=m48OtN8bScs8P86nDmQdGWHNNaIgzozZIQMUVD6e79HPd/DT8wO4WinCMSk91csejbX+vA28JaJXeM00+nq1EgX0Gno4qtXPrt71nLpJVyeMxsrBLahGjK6G5h8gmdiaJ/21ZlZPih5aI36ykoMnCmRbjGuj4Yo2dFgn99noOmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695972; c=relaxed/simple;
	bh=hgbsJy1K+T2wbnGopkLA+vQvJBX4xoRD1yQWh/+hF2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHn28hZCPqlU/zi4VB4gFOX7JDIwxg5376KOyawAkauQ3XHf+dqio6IjGfHuyeyOqnL9ByLdsoTvD/gmnMh4CfEJk60kGoeGRdO9K13jG7CpYlWg/H7xYtw1MS1Yi1f40I9Men6bPWCTrbDRQfavh5biYY+R7tELhmBE94pAe9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=IKmBqaGk; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id 74C064076724;
	Fri, 17 Oct 2025 10:06:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 74C064076724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1760695564;
	bh=M9lvUvTg+/KqvyjKYOU58LQnoOIwLtxSnLae4bXKyJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKmBqaGkn/3p+fQGT2F2iPZ40a8eGUUVnJRV33kciVtUcHM5acusv8535va6YtWrO
	 E6mmoDPKBrSTCeCIki6no+0dDAIY7w76Z7y/yhod5XXUmWsD7CBEk0WF9n2JbrxLzt
	 23wJQ3MRD/0ivxBJAiY5q/l5hKZ26iPpGfwJ8DUg=
Date: Fri, 17 Oct 2025 13:06:04 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
	Zong-Zhe Yang <kevin_yang@realtek.com>, Bernie Huang <phhuang@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH rtw-next v2 6/7] wifi: rtw89: handle
 IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Message-ID: <20251017130331-8e1cb072432535fbedf0d931-pchelkin@ispras>
References: <20251002200857.657747-1-pchelkin@ispras.ru>
 <20251002200857.657747-7-pchelkin@ispras.ru>
 <b1725b36caba476ba9ee4916910d8232@realtek.com>
 <20251014234211-4f763e2dab18fe04fbe4d95c-pchelkin@ispras>
 <bbaaabd1631d43fdaa24b818b7ac7929@realtek.com>
 <20251015103403-08f19f981c70546d56ebd07a-pchelkin@ispras>
 <164d3319d29e4a9aa3658726ee098092@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <164d3319d29e4a9aa3658726ee098092@realtek.com>

On Thu, 16. Oct 00:54, Ping-Ke Shih wrote:
> Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> > On Wed, 15. Oct 01:43, Ping-Ke Shih wrote:
> > > > > > +
> > > > > > +               if (sw_define != skb_data->tx_rpt_sn)
> > > > > > +                       continue;
> > > > > > +               if (tx_status != RTW89_TX_DONE &&
> > > > > > +                   data_txcnt != skb_data->tx_pkt_cnt_lmt)
> > > > >
> > > > > As commit message of previous patch, "When there is a failed
> > > > > TX status reported by the firmware, the report is ignored until the limit
> > > > > is reached or success status appears."
> > > > >
> > > > > Do you still need to check data_txcnt for failed cases?
> > > >
> > > > The question also concerns
> > > >
> > > >   tx_req->desc_info.tx_cnt_lmt = 8;
> > > >
> > > > line in rtw89_tx_rpt_enable().  'tx_cnt_lmt' is written to TX descriptor
> > > > and processed by firmware.  The value defines how many times the firmware
> > > > will retry transmission attempts, it will not retry more times than that.
> > > >
> > > > 'data_txcnt' C2H field determines the retry attempt counter for the frame
> > > > returned by the firmware.  If it reaches the limit, this means we got
> > > > the last report from the firmware and there would be no other firmware
> > > > reports for the sent frame.  So a final tx_status should be taken
> > > > uncondionally in this case.
> > > >
> > > > E.g. if 'tx_cnt_lmt' is set to 1, the firmware will try only once,
> > > > 'data_txcnt' will be 1, too.  The limit is reached and we should take
> > > > tx_status immediately as is.  So there's a higher chance of getting a
> > > > failed status eventually.
> > > >
> > > > I set it currently to 8 as the vendor driver does.  In local testing it
> > > > looks more than enough.  I've seen maximum of 5 retry attempts for the
> > > > same frame (usually there are no retries at all) though my network radio
> > > > environment is quite noisy.
> > > >
> > > > I'll add the tx_cnt_lmt related info to commit message for clarity.
> > > >
> > >
> > > Thanks for the detail.
> > >
> > >     1 2 3 4 5 6 7 8
> > > (a) x x x x x x x x  ==> retry 8 times, but all failure. Report at 8th C2H.
> > > (b) x x x o          ==> retry 3 times, and 4th done. Report at 4th C2H.
> > > (c) o                ==> just done at first one. Report at first C2H.
> > >
> > > For every attempt, firmware reports a C2H with tx_status, right?
> > 
> > Yes.
> > 
> > > Can I say (a) case is why we should check data_txcnt?
> > > For cases (b)/(c), they rely on 'tx_status == RTW89_TX_DONE'.
> > 
> > We should somehow determine in case (a) when those 8 attempts for the
> > frame have passed and then promptly give the report with a failed status
> > up to the wireless stack.  To my mind, without checking data_txcnt
> > rtw89_mac_c2h_tx_rpt() can't determine the time when to do an actual
> > report if every retry attempt has failed.
> > 
> > Otherwise skb would remain in the queue being unreported until HCI reset
> > takes place, though we already had a chance to report it as failed.
> 
> Got it.
> 
> By the way, I'd list case (d) which TX done at 8th retry and can be handled
> properly as well. 
> 
>     1 2 3 4 5 6 7 8
> (d) x x x x x x x o  ==> retry 8 times, and finally done. Report at 8th C2H.

This is covered by `tx_status != RTW89_TX_DONE` check that's the first
half of the && expression.

