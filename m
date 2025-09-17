Return-Path: <linux-wireless+bounces-27434-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C03B80053
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 16:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F7B37A42C7
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 09:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D67225390;
	Wed, 17 Sep 2025 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="ofa7FySs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754483074BA;
	Wed, 17 Sep 2025 09:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101559; cv=none; b=ISoOB3KHqf/nZyy+WvQXOzPjmOLCT0OZzaQ+8YxZ6/Dd7HZrMdBt1GSr0Pdl4Gk+IWOMc65kCyV6V8R4Eu1s46DWtFrGuR1tk6xEJ4qr5LP8aY9j/3vl9pQL4E4ZZWP5VMZO3IT1YTSr/25M44PlZfrrFNCW2F2BP4GqBqKOlSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101559; c=relaxed/simple;
	bh=tl0TsG2e6GDs5NmAO38DZ+18yVqnIjSBVq1pvWcs22I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KH/0ojJXv3DX77iuOckwRjwAcyYmbKFmlWtfJE9hr326aegdyDBjeeAidKmtZehhgumPsEcvkPRb039AdA6D1NbA9FHoVF3/1QOklqSKZnu4pLBDd82C8mV8DPgpZ0lsFlgZLhBpuh3ubkEGHCU3yNVSlS8rHOp+KseK2RAKgLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=ofa7FySs; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id 0E6A540762F3;
	Wed, 17 Sep 2025 09:25:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0E6A540762F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1758101109;
	bh=n3b2nPejUENpVHaajjMk59jl6pFrmTsX4tUpLwh41X4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ofa7FySs0IMCHADNxPsVY66DhgV2JAToobyCUX5TAPgXyy0rmxfotOe/Idzb33e2E
	 01KXKdhLbEJKYqn7AZRID7julNHqmhxSrB8eYy91WOu0DgYv78yDb0sGgeFMC8Ygu7
	 Y4GWZT3s1HnLNIKZrNcUxMUyvtCAljEBhzAsPKZw=
Date: Wed, 17 Sep 2025 12:25:08 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, 
	Zong-Zhe Yang <kevin_yang@realtek.com>, Po-Hao Huang <phhuang@realtek.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH rtw v3 3/5] wifi: rtw89: perform tx_wait completions for
 USB part
Message-ID: <20250917104047-82a166f58532dffcb0a8d1a3-pchelkin@ispras>
References: <20250828211245.178843-1-pchelkin@ispras.ru>
 <20250828211245.178843-4-pchelkin@ispras.ru>
 <bc1857a0-86d9-40aa-a1ab-f4bc83adf6fa@gmail.com>
 <20250901194743-62fc282f96aeeb9804c34e2f-pchelkin@ispras>
 <0cb4d19b-94c7-450e-ac56-8b0d4a1d889f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0cb4d19b-94c7-450e-ac56-8b0d4a1d889f@gmail.com>

On Mon, 01. Sep 21:46, Bitterblue Smith wrote:
> On 01/09/2025 20:45, Fedor Pchelkin wrote:
> > On Fri, 29. Aug 22:57, Bitterblue Smith wrote:
> >> The USB side doesn't have real TX ACK status reporting yet. I only
> >> learned recently how to do that. It looks like it will work about the
> >> same as in rtw88.
> > 
> > Do you mean similar pattern already exists in rtw88?  Could you give a
> > hint on how USB side TX ACK status reporting works there?  At a quick
> > glance, I don't see how those TX URB complete callbacks differ from what
> > rtw89 has.
> 
> Well, I assume we are talking about ACK status reporting. For example,
> when mac80211 detects beacon loss it sends a null frame, or a probe
> request (I'm not sure which is used when). It flags the frame with
> IEEE80211_TX_CTL_REQ_TX_STATUS, which means the driver has to report
> whether the AP sent ACK for the null frame/probe request or not. If
> the AP doesn't reply for a while, the connection is considered lost.
> 
> A URB status of 0 only means that the URB was submitted successfully.
> It doesn't mean the chip actually transmitted anything, and it doesn't
> mean the chip received ACK from the AP.
> 
> In order to receive these ACK status reports rtw89 will have to set
> a bit in the TX descriptor and place the skb in a queue to wait for
> a message from the firmware. ieee80211_tx_status_irqsafe() can be
> called when the firmware sends the message. 
> 
> This is for USB. It seems to work differently for PCIE in rtw89
> (rtw89_pci_release_rpp()). In rtw88 it's one mechanism for PCIE, USB,
> and SDIO.
> 
> These are some functions to look at in rtw88:
> 
> rtw_tx_report_enable()
> rtw_usb_write_port_tx_complete()
> rtw_tx_report_enqueue()
> 
> rtw_usb_rx_handler()
> rtw_fw_c2h_cmd_rx_irqsafe()
> rtw_fw_c2h_cmd_handle() / rtw_fw_c2h_cmd_handle_ext()
> rtw_tx_report_handle()

Thanks for the detailed explanation of the above!

Apologies for the delay. So I've got the RTL8851BU chip in the meantime.

As rtw89-usb part is designated for not yet released v6.17 and is rather
a thing on its own, I'd better address it in a separate series.

With RTL8851BU there appears a possible firmware bug related to hardware
scan channel list, already reported at [1].  Eventually after some time of
hardware unresponsiveness it leads to the splat [2] and the device has to
be replugged.  So I had to apply your proposed workaround to avoid
experiencing these failures.  It happens with the first available firmware
version, too (0.29.41.0 (e210be8a)).

[1]: https://lore.kernel.org/linux-wireless/0abbda91-c5c2-4007-84c8-215679e652e1@gmail.com/

[2]:
rtw89_8851bu 2-1:1.2: rtw89_hw_scan_offload failed ret -110
rtw89_8851bu 2-1:1.2: c2h reg timeout
rtw89_8851bu 2-1:1.2: FW does not process h2c registers
rtw89_8851bu 2-1:1.2: HW scan failed: -110
rtw89_8851bu 2-1:1.2: Update probe request failed
rtw89_8851bu 2-1:1.2: Update probe request failed
rtw89_8851bu 2-1:1.2: timed out to flush queues
rtw89_8851bu 2-1:1.2: timed out to flush queues
rtw89_8851bu 2-1:1.2: FW does not process h2c registers
rtw89_8851bu 2-1:1.2: FW does not process h2c registers
rtw89_8851bu 2-1:1.2: [ERR]FWDL path ready
rtw89_8851bu 2-1:1.2: [ERR]fwdl 0x1E0 = 0x23
rtw89_8851bu 2-1:1.2: [ERR]fwdl 0x83F0 = 0x70000
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb890cce3
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb8900a77
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb8900a55
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb8900a53
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb890cce3
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb890cce3
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb8900a6f
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb890cce3
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb890cce3
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb8900a73
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb8900a59
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb8900a67
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb8900a57
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb890cce3
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb8900a67
rtw89_8851bu 2-1:1.2: [ERR]FWDL path ready
rtw89_8851bu 2-1:1.2: [ERR]fwdl 0x1E0 = 0x23
rtw89_8851bu 2-1:1.2: [ERR]fwdl 0x83F0 = 0x70000
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb890cce3
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb890cce3
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb890cce3
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb8900a75
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb8900a55
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb890cce3
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb890cce3
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb8900a69
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb890cce5
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb8900a51
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb890cce3
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb890cce3
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb890cce3
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb890cce3
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0xb890cce3
rtw89_8851bu 2-1:1.2: [ERR]FWDL path ready
rtw89_8851bu 2-1:1.2: [ERR]fwdl 0x1E0 = 0x23
rtw89_8851bu 2-1:1.2: usb read32 0x83f0 fail ret=-110 value=0x0 attempt=0
rtw89_8851bu 2-1:1.2: usb read32 0x83f0 fail ret=-110 value=0x0 attempt=1
rtw89_8851bu 2-1:1.2: usb read32 0x83f0 fail ret=-110 value=0x0 attempt=2
rtw89_8851bu 2-1:1.2: usb read32 0x83f0 fail ret=-110 value=0x0 attempt=3
rtw89_8851bu 2-1:1.2: usb read32 0x83f0 fail ret=-110 value=0x0 attempt=4
rtw89_8851bu 2-1:1.2: [ERR]fwdl 0x83F0 = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]H2C path ready
rtw89_8851bu 2-1:1.2: [ERR]fwdl 0x1E0 = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fwdl 0x83F0 = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]H2C path ready
rtw89_8851bu 2-1:1.2: [ERR]fwdl 0x1E0 = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fwdl 0x83F0 = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: [ERR]fw PC = 0x0
rtw89_8851bu 2-1:1.2: mac init fail, ret:-110
rtw89_8851bu 2-1:1.2: failed to leave idle state
rtw89_8851bu 2-1:1.2: Update probe request failed
rtw89_8851bu 2-1:1.2: rfkill hardware state changed to disable


