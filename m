Return-Path: <linux-wireless+bounces-30054-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FE1CD67B5
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 16:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68B8A3019BD1
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 15:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594922F3C34;
	Mon, 22 Dec 2025 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mNa0Mt0E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD3B320CBB
	for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416179; cv=none; b=BiQrSvvwFfrykijFBocJIVwvOBL8B/w97xBr//Uj4LfCeQ3fA8BYBLjZ0tpb0Lvjx0hHkZCeiu3930xdK32/IH9LQJ6y8VM8H3+6AU5WbXE7KjOBQ2QQr5KisFKEC/QW1sB7JjZeMwDd8/Z9l2jMjLLnVx0q9fiduYcvR4c9IQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416179; c=relaxed/simple;
	bh=Xg38P0BVhbVJz83FhLp61aLuiD+2bWYhUjdYODAgS/w=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qqEWYUFCtvuIyq5322fCTgiTR89ccKUH2G9+Cr3QigS0x+XA+c8+ubdpm/ZWydMLtMGxLXYyktVcLii58LepnaU8SUdFNcMmSiFbN2ZIJqIJoATpAYE8RYdndClePVrSFF0TT28jSm8zFhoNgyYZTOJ6HrcCGg6LosyJ4bao8S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mNa0Mt0E; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766416178; x=1797952178;
  h=from:to:subject:in-reply-to:references:date:message-id:
   mime-version;
  bh=Xg38P0BVhbVJz83FhLp61aLuiD+2bWYhUjdYODAgS/w=;
  b=mNa0Mt0EBp5oTFT/NrauIC7HaihpxKIKE5FFDb7nYCTxkX7w7Qw1LTyt
   Eu2JGTUW7WYlihXUCMhdYDt0FhKGjJev2RnPV5Wws6OQagD9RJKmcHaAX
   66h3ELTUjvaWlI8I6FxTt45Op2Fz2OE+xoHpwGFpiCbrgWK1HhOk3Rhs1
   iLcEf1FVRzh0/HsTG+zIjNnIRMPFAuq/GM7UuZbUUASpnt0EJkw2zy+Sg
   mvOVOyFW6fQrH8vaDonIh4Wl2Z8EckqCkzLqbYCQ2mLX0GDueUZ0dtAva
   d81ZuXxnywBiF/4iYL+coxt3c9r25J7QJYD3f0hSSmFegMPeCR7C3en4j
   Q==;
X-CSE-ConnectionGUID: jseUd/LISHyk1nCQxCZTWQ==
X-CSE-MsgGUID: az/eQWZqQx+usKLxhIktUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="72119178"
X-IronPort-AV: E=Sophos;i="6.21,168,1763452800"; 
   d="scan'208";a="72119178"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 07:09:37 -0800
X-CSE-ConnectionGUID: N9zTcWAwTES3qoqeIUumBg==
X-CSE-MsgGUID: mzPsjL4sTwKa3xKLAU1SOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,168,1763452800"; 
   d="scan'208";a="223029816"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.79])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 07:09:34 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Chris Russomanno <russomch@aol.com>, intel-xe@lists.freedesktop.org,
 linux-wireless@vger.kernel.org
Subject: Re: [BUG] Intel B580 (e20b) HDMI Flicker & Realtek RTL8922AE 6GHz
 missing - Mint 22.3
In-Reply-To: <AB8446D8-708B-4971-8852-87353112E60F@aol.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <AB8446D8-708B-4971-8852-87353112E60F.ref@aol.com>
 <AB8446D8-708B-4971-8852-87353112E60F@aol.com>
Date: Mon, 22 Dec 2025 17:09:31 +0200
Message-ID: <8dc0f5755ac815c1e828f4a9a62b311925179780@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, 20 Dec 2025, Chris Russomanno <russomch@aol.com> wrote:
> Hello,
>
> I am reporting two issues encountered on brand-new hardware using Linux Mint 22.3 with Kernel 6.14.0-generic.
>
> Hardware Environment:
> - GPU: Intel Arc B580 (Battlemage), PCI ID: [8086:e20b]
> - WiFi: Realtek RTL8922AE (rtw89), Firmware: rtw8922a_fw-3.bin
> - Display: Samsung 4K Monitor connected via HDMI (No DisplayPort available)
>
> Issue 1: Intel Xe HDMI Flickering
> The Samsung monitor experiences intermittent black-screen flickering (1-2 seconds) at both 4K and 1080p resolutions. This behavior is not present on Windows 11.
> Troubleshooting attempted:
> - Added kernel parameters: quiet splash i915.enable_psr=0 xe.force_probe=e20b i915.enable_dc=0 intel_iommu=igfx_off intel_idle.max_cstate=2
> - Forced "TearFree" and "TripleBuffer" in xorg.conf.
> - Frequency remains at 60Hz.

See [1] on how to report i915 and xe bugs.

BR,
Jani.


[1] https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html


-- 
Jani Nikula, Intel

