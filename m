Return-Path: <linux-wireless+bounces-27974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53300BDB6BE
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 23:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CF03BAC4A
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 21:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ECC1E3DED;
	Tue, 14 Oct 2025 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Ah0cqhlj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C4F2E5B04;
	Tue, 14 Oct 2025 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760477606; cv=none; b=rx1LEYoTFFXiulo1dAxUwdLUiBSZQelvi47ciZpxVd5r6PMAlh+7OZY3xk/SFzsmEXCadLzK9U/E+z88QydLPTccki+TPVLF1DD2kq/+X8LARcSWzfxvcadl3zmd4+MshNn4hcpahktfPmOIyRBlNXukpl9nTTZGw4JM2BrrssE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760477606; c=relaxed/simple;
	bh=1DCUVDZpyWQTBBul6DGESOlwwIOGrVMWSnAzw3ukEiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZh+YyvtpV9g8G2995YB7FFOhXkkvxlDBZMSs14JMOAHBNdROYHr3Vl5ViiVWWqSa5R6WKYMCicUlxw2dqU0twHOPxYjdkjmL1NvWhuZ7lisZvPbYxejAjG253ZWOgI7VbTZz6TvTv7NWExm+yIpivEuGHPQwgmqKnhdnUTtovM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Ah0cqhlj; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.11])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id 9A62D40762D8;
	Tue, 14 Oct 2025 21:33:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9A62D40762D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1760477598;
	bh=8GHrMlIJ3c1jbQO+ueMF/7DoMnihTflIws4U/FDUWTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ah0cqhljQInnoflnv+w/tnyY1c3rqnBsiq1ucR+wCPkdK63E0YyTz7vVkWnycVR+g
	 KKGzfdLczEU88WHULtuyRMYapOeG84pCFFMtcqvZsnzzQnUAw+tc1Aqf+efJpGOpC2
	 61SZ65I21etiGf/KldSiAJ789FNcbEh9N0qBnkgI=
Date: Wed, 15 Oct 2025 00:33:18 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, 
	Zong-Zhe Yang <kevin_yang@realtek.com>, Po-Hao Huang <phhuang@realtek.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH rtw-next v2 0/7] wifi: rtw89: improvements for USB part
Message-ID: <20251015002601-e7a307b2e8320369124054bc-pchelkin@ispras>
References: <20251002200857.657747-1-pchelkin@ispras.ru>
 <88f30433-98fa-4f9a-bbe3-9d630b72c2e4@gmail.com>
 <20251011171303-6e37619c4071ee0bae4f9675-pchelkin@ispras>
 <ebc5ede8-cf00-47a3-8a78-d9475f42cf97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ebc5ede8-cf00-47a3-8a78-d9475f42cf97@gmail.com>

On Sun, 12. Oct 01:49, Bitterblue Smith wrote:
> On 11/10/2025 17:57, Fedor Pchelkin wrote:
> > On Sat, 04. Oct 20:37, Bitterblue Smith wrote:
> >> I tested these patches with RTL8851BU, RTL8832AU, RTL8832BU, RTL8832CU, and
> >> RTL8912AU. They all work, with a few additions.
> >>
> >> Before these patches RTL8851BU and RTL8832AU would remain "connected" when
> >> I power off the router. That's because they don't have beacon filtering in
> >> the firmware and the null frames sent by mac80211 were always marked with
> >> IEEE80211_TX_STAT_ACK. With these patches they disconnect immediately when
> >> I power off the router. So that works nicely.
> >>
> > 
> > Glad to hear, thanks for the insight.
> > 
> >> What doesn't work is TX reports for management frames. Currently rtw89
> >> doesn't configure the firmware to provide TX reports for the management
> >> queue. That can be enabled with SET_CMC_TBL_MGQ_RPT_EN for the wifi 6 chips
> >> and with CCTLINFO_G7_W0_MGQ_RPT_EN for RTL8922AU.
> > 
> > I'll investigate. Looks like the enabling of the management part should go
> > to rtw89_fw_h2c_default_cmac_tbl().
> > 
> 
> Yes, and rtw89_fw_h2c_default_cmac_tbl_g7().
> 
> > Btw, could you give a quick hint please on how I can check during testing
> > that the reporting facility works properly for all cases needed?  By far
> > I've dealt with iw utility and debugging printks incorporated into rtw89
> > but it doesn't look sufficient anymore..
> > 
> 
> I enabled RTW89_DBG_TXRX, which let me see that no TX reports appeared
> during authentication and association. I also added a printk where the
> IEEE80211_TX_CTL_REQ_TX_STATUS flag is checked. Then I just use the
> driver normally, with wpa_supplicant and NetworkManager.

Thanks, Bitterblue!

By the way, do you see lots of "parse phy sts failed\n" messages printed
when RTW89_DBG_TXRX is enabled?  (it's with RTL8851BU in my case)

I wonder whether this is kind of a normal failure case or an indicator of
a firmware bug.

Just to point out, I've activated your workarounds from [1], otherwise
the device is unusable due to firmware unresponding during scan and
crashing eventually.

[1]: https://lore.kernel.org/linux-wireless/0abbda91-c5c2-4007-84c8-215679e652e1@gmail.com/

> 
> >>
> >> The other thing that doesn't work is the TX reports are different for
> >> RTL8852CU and RTL8922AU. It's only a small difference for RTL8852CU:
> >>
> >> #define RTW89_C2H_MAC_TX_RPT_W5_DATA_TX_CNT_V1 GENMASK(15, 10)
> >>
> >> RTL8922AU is more strange. It needs something like this:
> >>
> >> #define RTW89_C2H_MAC_TX_RPT_W12_TX_STATE_V2 GENMASK(9, 8)
> >> #define RTW89_C2H_MAC_TX_RPT_W12_SW_DEFINE_V2 GENMASK(15, 12)
> >> #define RTW89_C2H_MAC_TX_RPT_W14_DATA_TX_CNT_V2 GENMASK(15, 10)
> >>
> >> The C2H is 80 bytes here (header included).
> > 
> > rtw89_mac_c2h_tx_rpt() needs to account for different types of C2H report
> > formats, bah.  Will add this missing part.
> 

