Return-Path: <linux-wireless+bounces-25552-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B755FB07D11
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 20:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A06B1C284A1
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 18:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E1329AAFE;
	Wed, 16 Jul 2025 18:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFD4xQkY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F2E188A3A;
	Wed, 16 Jul 2025 18:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752691348; cv=none; b=claSzw0U+YEVXTEQircebjPiv7MTxJPsWUxUMD7ALxUmFK0egraLY5YxdQTrqf81InL/vjDAYAKaLUj3jQaKAHG4JsaHioHs3/AJ9tS+MxF5VfSS1HHu93wkNDQdUvYviX0WGdLq7aIMKzSxCVd9hMNT9tVIIa4I86PI/uM2bbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752691348; c=relaxed/simple;
	bh=W625jyLEePQHh2CT/ALJ43Tm8kzCxebLpRONVH5s3Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fIFSO8PcWbAQPrXP0fdDna3LOTCSMZ4L0fxj1U0uOy0Y1RjUODz8lXLQjFbafEDgW/PmvZV4SlLUuF1xrPfdtMJyy5MdejOpUdf7+3TWSsBAGwQ4Obx+U8t5jHHgZ1rjKanjitsRwI4sS/Wv1nIjnZs4yDdZhlGx+gwz102ZTXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFD4xQkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5DAC4CEE7;
	Wed, 16 Jul 2025 18:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752691347;
	bh=W625jyLEePQHh2CT/ALJ43Tm8kzCxebLpRONVH5s3Zo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CFD4xQkYY0cD+c5dZyADrlMOrUgLCQsNflRIFnFa3Zn53XLU6CeJT1yX+g/b/+oOE
	 l418YMNoW2D8jfu4gaJ3KR86eA9Rpv2/naido0+oUCddWCUO8HLME3eoqc77bw3ztg
	 hm4ySQ/e6ntztM5Iz6cQQutreJsLTIBvnabRcxGnKi6KdU/mqOqjs2g2+wPNWLWmd7
	 CWE+WSvM9zIMhQSBXkZwxuSEC0Yq5cPzy+SewO7iDRm3JfXx2GJk6ygda4L30YUrrE
	 Jw3JX7B3j82RBcIM7ClsKmPY2a96xVH6VCF0Q3ODy/V5uxmRZ0JKKY55kwNRpkZ33R
	 lVE6ZayRg00uA==
Date: Wed, 16 Jul 2025 13:42:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] iwlwifi: probe with driver iwlwifi failed with
 error -22
Message-ID: <20250716184226.GA2547862@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-XvFvGigpY7JYFn@debian.local>

On Fri, Mar 28, 2025 at 12:36:38AM +0000, Chris Bainbridge wrote:
> Hi,
> 
> Laptop: Lenovo Legion 7 16ACHg6.
> Wifi: Killer(R) Wi-Fi 6 AX1650x 160MHz Wireless Network Adapter (200NGW)
> 04:00.0 Network controller [0280]: Intel Corporation Wi-Fi 6 AX200 [8086:2723] (rev 1a)
> 
> Wifi stopped working in recent kernel builds:
> 
> [   20.907824] Intel(R) Wireless WiFi driver for Linux
> [   20.907955] iwlwifi 0000:04:00.0: enabling device (0000 -> 0002)
> [   20.912024] ee1004 2-0050: 512 byte EE1004-compliant SPD EEPROM, read-only
> [   20.913666] NET: Registered PF_BLUETOOTH protocol family
> [   20.913670] Bluetooth: HCI device and connection manager initialized
> [   20.913806] Bluetooth: HCI socket layer initialized
> [   20.913810] Bluetooth: L2CAP socket layer initialized
> [   20.913828] Bluetooth: SCO socket layer initialized
> [   20.917455] iwlwifi 0000:04:00.0: Detected crf-id 0x3617, cnv-id 0x100530 wfpm id 0x80000000
> [   20.917674] iwlwifi 0000:04:00.0: PCI dev 2723/1654, rev=0x340, rfid=0x10a100
> [   20.917679] iwlwifi: No config found for PCI dev 2723/1654, rev=0x340, rfid=0x10a100
> [   20.920126] iwlwifi 0000:04:00.0: probe with driver iwlwifi failed with error -22
> 
> Bisect led to:
> 
> commit 75a3313f52b7e08e7e73746f69a68c2b7c28bb2b (HEAD)
> Author: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Date:   Wed Feb 5 14:55:42 2025 +0200
> 
>     wifi: iwlwifi: make no_160 more generic

https://git.kernel.org/linus/64dc5d5e341d ("Revert "wifi: iwlwifi:
make no_160 more generic"") appeared in v6.15-rc5 and reverts
75a3313f52b7 ("wifi: iwlwifi: make no_160 more generic"), so it
*looks* like this regression should be fixed, but it still appears in
the tracker at https://linux-regtracking.leemhuis.info/regzbot/mainline/

If it is resolved, can somebody send the appropriate regzbot fix
command?  (See https://linux-regtracking.leemhuis.info/about/#tldr)

