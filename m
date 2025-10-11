Return-Path: <linux-wireless+bounces-27938-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 799DFBCF7AC
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Oct 2025 16:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3475C3BAE0B
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Oct 2025 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F8025D536;
	Sat, 11 Oct 2025 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="hOOMkz/N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C732F29;
	Sat, 11 Oct 2025 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760194648; cv=none; b=FOybSi7s06ysBDARsLNol0Iy9XrjfZAREthAb7ofhD4xNyXuHo0C49+nfFH2cUu3nwZmhq1GblS4UEEhH6ozLZEZFldowlI4dzBy1CfrVj+5xUyqPUNS13wCG8V9BqCRvZ/r5nFvtBjkuMZLYBibN8RE9HT2YdYn3ihW/WS8Jsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760194648; c=relaxed/simple;
	bh=/kmmVCY+6fLWjnNRslBr1xg2f4CGGA+58gQPdY5F8EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3LCXEynNX71KEPy9vCdxeKUcSWDMTBl9b91X0yn0FttK+CAU7rj0FWSqCM61Bk8Qcuh/yVlE/JU4ycJxjQsezhLHN76THKheQKprJnznHTIi/PIaODlI5NrH31hf8BcAjvl1CBwMTsFmXdHCWzNpe5Lk9NboHvA4BBYBboJ7Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=hOOMkz/N; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id D18AB40762F5;
	Sat, 11 Oct 2025 14:57:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D18AB40762F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1760194642;
	bh=ymA85Q5gcbWAp8GP4xroF8s5mtp2IUluyFeJzNchXjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hOOMkz/NzBYgBDp9qSND/pFuthT+8dLNTZSPAvBHSEehUlbH/c4qK+tKIpk5hMe8j
	 VNs79qyGzDVTms9x1DHNkcJrHdkM8XSqbxjwgiuddj4J0r2A9FB6wsInop9Y8elnIu
	 jXxtR5lPybXAjd//gTGTPUyCZ+jT4BPkvcOw4sJw=
Date: Sat, 11 Oct 2025 17:57:22 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, 
	Zong-Zhe Yang <kevin_yang@realtek.com>, Po-Hao Huang <phhuang@realtek.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH rtw-next v2 0/7] wifi: rtw89: improvements for USB part
Message-ID: <20251011171303-6e37619c4071ee0bae4f9675-pchelkin@ispras>
References: <20251002200857.657747-1-pchelkin@ispras.ru>
 <88f30433-98fa-4f9a-bbe3-9d630b72c2e4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88f30433-98fa-4f9a-bbe3-9d630b72c2e4@gmail.com>

On Sat, 04. Oct 20:37, Bitterblue Smith wrote:
> I tested these patches with RTL8851BU, RTL8832AU, RTL8832BU, RTL8832CU, and
> RTL8912AU. They all work, with a few additions.
> 
> Before these patches RTL8851BU and RTL8832AU would remain "connected" when
> I power off the router. That's because they don't have beacon filtering in
> the firmware and the null frames sent by mac80211 were always marked with
> IEEE80211_TX_STAT_ACK. With these patches they disconnect immediately when
> I power off the router. So that works nicely.
> 

Glad to hear, thanks for the insight.

> What doesn't work is TX reports for management frames. Currently rtw89
> doesn't configure the firmware to provide TX reports for the management
> queue. That can be enabled with SET_CMC_TBL_MGQ_RPT_EN for the wifi 6 chips
> and with CCTLINFO_G7_W0_MGQ_RPT_EN for RTL8922AU.

I'll investigate. Looks like the enabling of the management part should go
to rtw89_fw_h2c_default_cmac_tbl().

Btw, could you give a quick hint please on how I can check during testing
that the reporting facility works properly for all cases needed?  By far
I've dealt with iw utility and debugging printks incorporated into rtw89
but it doesn't look sufficient anymore..

> 
> The other thing that doesn't work is the TX reports are different for
> RTL8852CU and RTL8922AU. It's only a small difference for RTL8852CU:
> 
> #define RTW89_C2H_MAC_TX_RPT_W5_DATA_TX_CNT_V1 GENMASK(15, 10)
> 
> RTL8922AU is more strange. It needs something like this:
> 
> #define RTW89_C2H_MAC_TX_RPT_W12_TX_STATE_V2 GENMASK(9, 8)
> #define RTW89_C2H_MAC_TX_RPT_W12_SW_DEFINE_V2 GENMASK(15, 12)
> #define RTW89_C2H_MAC_TX_RPT_W14_DATA_TX_CNT_V2 GENMASK(15, 10)
> 
> The C2H is 80 bytes here (header included).

rtw89_mac_c2h_tx_rpt() needs to account for different types of C2H report
formats, bah.  Will add this missing part.

