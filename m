Return-Path: <linux-wireless+bounces-19575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0911A49944
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 13:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B8D7AA9C1
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 12:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A7426B95A;
	Fri, 28 Feb 2025 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRpXfb9t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0D526B949;
	Fri, 28 Feb 2025 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745706; cv=none; b=rrYIwyTUyRR4dBgyp++xFbi6GKcBNEM1k7lM2Xr5t4EAOBz3ZJlsh7XcaFZ2nFAwzpgk5P2I6k7RbyYPjfX/UgUHXy2zg8k2w3T5Pc2d0NrebiWWM+kwyTThpMsaCr61MCRP0VTnxJcPka1HosuWW2cH4QwxdyTuUg6QBiqApUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745706; c=relaxed/simple;
	bh=1KhkYt4yF0gE6rueJYBwI3PIyKx9a9jUDZzdIh9Onzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjLlOpUkUeGUI2qsKE7h0w2zeZh4bWNRU1hQoe3sZG0Z4XaI1Oj7Zj96CCNljNM6qoAn4OFLJs89jVrl50xOCB+TEuXtW+OeQx63B+tanMXb4rB3M3gLoL2nlT3wLOLjZzPTZ8drp7PX4lgsh6Xgo8h8WXOiX3tcSqBmfUjnCBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRpXfb9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D28C4CEE7;
	Fri, 28 Feb 2025 12:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740745706;
	bh=1KhkYt4yF0gE6rueJYBwI3PIyKx9a9jUDZzdIh9Onzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GRpXfb9tr3J8U6boxisV61tke6CkDG3i6rUPt5Tof0k4JkaHI++Cjq/5H0Z9Aek9c
	 VQpkXfAqta5TXdY9vSf4tq762cGsy+X1+1a3raUa13h3tU091BcFlCdY30Gn4mD8jC
	 gET7u1NOdsxMw7Mn33E8EfAAwSyg8SJqDFwWUfEVyGmhNX1Ey6BFwZXWtnovRTnHG1
	 FluajsEwUsJEPJLdpH48Ljf33acFeHl+/VaTjwyOYi8rB8nMyEmBeGCB2OoEmmxvR2
	 oBTAoBTrMVdLRPj+l+zViYhni1cg0MmSlDv/YgydtUJIb0zp+oLOoc5pEvMYRW7tUg
	 otViz9fKAaHIw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tnzTs-000000004ys-0xFE;
	Fri, 28 Feb 2025 13:28:40 +0100
Date: Fri, 28 Feb 2025 13:28:40 +0100
From: Johan Hovold <johan@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: Re: ath11k: WCN6855: possible ring buffer corruption
Message-ID: <Z8Gr-IMD-UZTU-X5@hovoldconsulting.com>
References: <Zh6b-38tGGXo-ee7@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh6b-38tGGXo-ee7@hovoldconsulting.com>

Hi Jeff,

The ath11k ring-buffer corruption issue is hurting some users of the
Lenovo ThinkPad X13s quite bad so I promised to try to escalate this
with you and Qualcomm.

The chance of hitting the bug seems to depend on the AP/network, and it
also seems my hypothesis that enabling the GIC ITS, which increases
parallelism by spreading interrupt handling over all cores, do indeed
make it easier to hit this.

The latter could indicate a driver bug, even this could very well be a
firmware issue.

Have you had a chance to look into this yet? Can you tell from the logs
and reported symptoms whether this is a firmware bug or not?

On Tue, Apr 16, 2024 at 05:40:43PM +0200, Johan Hovold wrote:

> Over the past year I've received occasional reports from users of the
> Lenovo ThinkPad X13s (aarch64) that the wifi sometimes stops working.
> When this happens the kernel log is filled with errors like:
> 
> [ 1164.962227] ath11k_warn: 222 callbacks suppressed
> [ 1164.962238] ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1484, expected 1492
> [ 1164.962309] ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1484
> [ 1164.962994] ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1476, expected 1484
> [ 1164.963405] ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1484, expected 1488
> [ 1164.963701] ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1480, expected 1484
> [ 1164.963852] ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1468, expected 1480
> [ 1164.964491] ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1484, expected 1492
> [ 1164.964733] ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1488, expected 1492
> [ 1165.198329] ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1488
> [ 1165.198470] ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1476
> [ 1166.266513] ath11k_pci 0006:01:00.0: wmi tlv parse failure of tag 2699 at byte 348 (1132 bytes left, 64788 expected)
> [ 1166.542803] ath11k_pci 0006:01:00.0: wmi tlv parse failure of tag 4270 at byte 348 (1128 bytes left, 63772 expected)
> [ 1166.768238] ath11k_pci 0006:01:00.0: wmi tlv parse failure of tag 0 at byte 376 (1112 bytes left, 11730 expected)
> [ 1166.900152] ath11k_pci 0006:01:00.0: wmi tlv parse failure of tag 3 at byte 790 (694 bytes left, 16256 expected)
> [ 1168.499073] ath11k_pci 0006:01:00.0: wmi tlv parse failure of tag 1 at byte 62 (1426 bytes left, 3089 expected)
> [ 1168.818086] ath11k_pci 0006:01:00.0: wmi tlv parse failure of tag 63063 at byte 1466 (10 bytes left, 50467 expected)
> [ 1169.032885] ath11k_pci 0006:01:00.0: wmi tlv parse failure of tag 0 at byte 364 (1120 bytes left, 12483 expected)
> [ 1169.308546] ath11k_pci 0006:01:00.0: wmi tlv parse failure of tag 3092 at byte 348 (1128 bytes left, 64780 expected)
> [ 1169.563928] ath11k_pci 0006:01:00.0: wmi tlv parse failure of tag 1 at byte 348 (1124 bytes left, 44062 expected)
> 
> which after a quick look at the driver seems to suggest that we may be
> hitting some kind of ring buffer corruption.
> 
> Rebinding the driver supposedly sometimes make things work again, but
> not always.
> 
> The issue has been confirmed with the 6.8 kernel and the latest firmware
> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37.
> 
> I've triggered this issue twice myself with 6.6 and .23 firmware, but
> the reports date back to at least 6.2 and likely when using even older
> firmware.
> 
> An unconfirmed hypothesis is that we may be hitting this more often when
> enabling the GIC ITS so that the interrupt processing is spread out over
> all cores (unlike when using the DWC controller's internal MSI
> implementation). This change is now merged for 6.10.
> 
> Do you have any immediate theories about what could be causing this?
> Does it look like a firmware or driver issue to you, for example? Is it
> something you've seen before?
> 
> Note that I've previously reported this here:
> 
> 	https://bugzilla.kernel.org/show_bug.cgi?id=218623
 
Johan

