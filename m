Return-Path: <linux-wireless+bounces-28373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5A9C1C8B9
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 18:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E843407CFB
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 17:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E8133B6DA;
	Wed, 29 Oct 2025 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="q5o/zIAT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CB537A3BB;
	Wed, 29 Oct 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757776; cv=none; b=BACdqU9LgrzGxUY1Sdxcr15Nou2dOMvYKZmGHu3clFnLYI4SectLRCL4NpgdFqsGvetImvfouQ1dAjyhSC7efhxRzupIdgrn94Uh+xin1rms4mXBZXY0IpQZeSe+frBYVkCXGO8zv1Hg3YjdkNh+yd8A8MZveoGXdZ78tgfFI2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757776; c=relaxed/simple;
	bh=dpOUu+29Nwt1e5gOLYEcqNd7N1sSJPkCNvHRDp41KkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Atc15TBuS8hRsyv1J1H+LbZXJAxxXIzf5vkh8+OutGIpu8amXMUoNP1NFB9+f6Ceb8GAwnhv8ExoIInnOknUlBpete2nqO6+OP0b5LkUITZZYGPCeln+mAWTnfNdZd7xfKOmxW0F7PHIvQ2RCD4ZC7l/h5Owe3aHIfILV4/zUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=q5o/zIAT; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id CE50C4076721;
	Wed, 29 Oct 2025 17:09:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru CE50C4076721
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1761757763;
	bh=wZkFRA+EsCk1NJwdV/5eyBiB+QnDfWLsLSc/LqmQXco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5o/zIATsFjU/F1zHdzWFeyewIEIyDvp85RoRICzoXEz3psiyqtRLNzLBFiLOsCbQ
	 EASKB+b5FJlrSe0CCt/NzevRk6wwDdizRu74BjtcvxWg3JCs6IHvl/XaNJKv4sl8tT
	 FiItovNFnCeGf+yEdBTyrOWVrjtoJp09GE10RQK4=
Date: Wed, 29 Oct 2025 20:09:23 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
	Zong-Zhe Yang <kevin_yang@realtek.com>, Bernie Huang <phhuang@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH rtw-next v3 7/9] wifi: rtw89: handle
 IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Message-ID: <20251029200210-5906e044da5941522130c159-pchelkin@ispras>
References: <20251017100658.66581-1-pchelkin@ispras.ru>
 <20251017100658.66581-8-pchelkin@ispras.ru>
 <f013f65b97a447e2b744a4f3d6aff269@realtek.com>
 <20251025131637-d3a03888f5c753e6b213e204-pchelkin@ispras>
 <71b89748d72d42c28696c9ba1ee3addf@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71b89748d72d42c28696c9ba1ee3addf@realtek.com>

On Mon, 27. Oct 01:14, Ping-Ke Shih wrote:
> Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> > On Wed, 22. Oct 07:16, Ping-Ke Shih wrote:
> > > Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> > > > @@ -5849,6 +5852,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
> > > >         wiphy_work_init(&rtwdev->cancel_6ghz_probe_work, rtw89_cancel_6ghz_probe_work);
> > > >         INIT_WORK(&rtwdev->load_firmware_work, rtw89_load_firmware_work);
> > > >
> > > > +       skb_queue_head_init(&rtwdev->tx_rpt.queue);
> > >
> > > not sure if it's worth to initialize tx_rpt.sn to zero?
> > 
> > That shouldn't be needed because rtwdev is zero initialized in
> > rtw89_alloc_ieee80211_hw().  ieee80211_alloc_hw() fills the private
> > driver part with zeroes.
> 
> Ah. I mentioned this in wrong place. I meant that we can initialize tx_rpt.sn
> in rtw89_core_start() or do it right after downloading firmware in
> __rtw89_fw_download() like ' fw_info->h2c_seq = 0;'.

To my mind, it's not worth adding extra code to initialize tx_rpt.sn to
zero at some point as it's just a sequential number in [0x0, 0xF] range,
which is replayed to firmware and used to synchronize with it.  Actually
we can start counting from 0x1 or 0xA, it doesn't really matter to care
about counter initialization.

