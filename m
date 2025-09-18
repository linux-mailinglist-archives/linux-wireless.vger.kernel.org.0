Return-Path: <linux-wireless+bounces-27483-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E40B85891
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 17:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14C216372F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F202C2359;
	Thu, 18 Sep 2025 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="D7NJlpsz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599A41D5CE8;
	Thu, 18 Sep 2025 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208782; cv=none; b=fcp5Pmd5bywqXleRDvs5Fifkna3W5Quxr1bUGn52BRYpaJp5vo6E0+/4nqqQ0MSiupE+VfZx7+wfylJPOtu05PA8LGL2xPC+sKvi3zZGwjriSoskH4V4r/w3G3bm8SAN9NDpqVW1+rot3nGX47K5Pn/24Qm9qRD6R/a8gLjp1yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208782; c=relaxed/simple;
	bh=jqgoKHvx0zTVG09+rXLAG6Rcf+ag/snJNbF43eYrUg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQ6s+j/t70d7SYKEv5GWPmxYv3gdEfmSg0h4LTa1Zm7Fl95q9Bzcy+6T4QYENDtgVSlu+Qvm7PZtAgMo6zICHG647umyDxQyiZAxDXqb6Qf5BEN31KUOE9NadT+Jpfbl4VkmdgOS3/UGIeks27f7hkYaAocF6/kLmd0Ginc7puE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=D7NJlpsz; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.2])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id 9EEA44076720;
	Thu, 18 Sep 2025 15:19:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9EEA44076720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1758208774;
	bh=U8rnZo4l2S01JfBPhRX4AJkDuBZd7vACjSkCZ45pc2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D7NJlpszfuSedKsapC9sCM3UiIc0mwHcGPZexDFTwc0RQY67+692vpxic+XUrvzzq
	 xyXvKXEhPznaFZLIkmTdthb9lhcN7LwdkrSf9d2pTlD4hpy5sdZxiEJAAu+5vpL6OF
	 7klsTHcIg1PYikwKjRpYxIg9zgjobtquOJGYcDFw=
Date: Thu, 18 Sep 2025 18:19:34 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>, 
	Bitterblue Smith <rtl8821cerfe2@gmail.com>, Bernie Huang <phhuang@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH rtw v4 2/4] wifi: rtw89: fix tx_wait initialization race
Message-ID: <20250918173522-07abe99566c12fa46a096fc5-pchelkin@ispras>
References: <20250917095302.2908617-1-pchelkin@ispras.ru>
 <20250917095302.2908617-3-pchelkin@ispras.ru>
 <08b25263c6874a089e4a271cb95a9cb7@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08b25263c6874a089e4a271cb95a9cb7@realtek.com>

On Thu, 18. Sep 05:47, Ping-Ke Shih wrote:
> Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> > @@ -1094,22 +1094,13 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *sk
> >                                     int qsel, unsigned int timeout)
> >  {
> >         struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
> > -       struct rtw89_tx_wait_info *wait;
> > +       struct rtw89_tx_wait_info *wait = wiphy_dereference(rtwdev->hw->wiphy,
> > +                                                           skb_data->wait);
> 
> Can't we just pass 'wait' by function argument?

Yep.

> 
> >         unsigned long time_left;
> >         int ret = 0;
> > 
> >         lockdep_assert_wiphy(rtwdev->hw->wiphy);
> > 
> > -       wait = kzalloc(sizeof(*wait), GFP_KERNEL);
> > -       if (!wait) {
> > -               rtw89_core_tx_kick_off(rtwdev, qsel);
> > -               return 0;
> > -       }
> > -
> > -       init_completion(&wait->completion);
> > -       wait->skb = skb;
> > -       rcu_assign_pointer(skb_data->wait, wait);
> > -
> 
> Here, original code prepares completion before TX kick off. How it could
> be a problem? Do I miss something?

That's a good question and it made me rethink the cause of the race
scenario.  I didn't initially take TX kick off into consideration when
it actually matters.

The thing is: there might have been another thread initiating TX kick off
for the same queue in parallel.  But no such thread exists because a taken
wiphy lock generally protects from such situations. rtw89_core_txq_schedule()
worker looks like a good candidate but it doesn't operate on the needed
management queues.

So I may conclude this patch doesn't fix any real bug though I'd prefer to
keep it (with description rewritten of course) because it helps to avoid
potential issues in future.

