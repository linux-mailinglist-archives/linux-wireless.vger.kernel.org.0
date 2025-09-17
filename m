Return-Path: <linux-wireless+bounces-27441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7995DB7D55B
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202511889621
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 12:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FFE2C1786;
	Wed, 17 Sep 2025 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="jS+H3dWX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF0F2FBE1E
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111502; cv=none; b=VgJTKTrS2O6uvqAjA90Bhb2uAibvzLp8cOmCn1LfYFPFQacaIVolRGOFFeld8VHp4/JnvoBinfu4PBRBq9pgRoNJTtnMrur8Vx3HniddY8Uam36TZTrQ+OA1Lf2pKE0Bu8bzuwHwv6HLnL0+FpPKdFQildXQoH3r7J42S2v4BEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111502; c=relaxed/simple;
	bh=BIQHgAVp4wA7EXVdQrsBZCfRo+oAWc7uxSvLO1YKl4k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvvP9w0s5AnabFiQfVC8AMZ9lrRL7mP6MoGnEEnYPGGjM8mOtdQISjP9FjlSVG2vxZUmnHRu5VFfiNLVtbxaJYVwRQZAsE1JClOxd5wMcqSoRga1iFwbxy6ZNBZ9+9e8gyG0XDd4mYBnCBMqcSDi3QLWnvsUZdXawPEm1tLxUI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=jS+H3dWX; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758111501; x=1789647501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BIQHgAVp4wA7EXVdQrsBZCfRo+oAWc7uxSvLO1YKl4k=;
  b=jS+H3dWXeC51E188yBUSij9QIaXPcvxM8Hi/CjWFs5aEbcv60w4VRs88
   zzV8YbeFApkk4isml9eAuv8NkmZRJm7HERpPonfoh/r5PwUCU1CASKxQA
   wytYwMaTIBqwM984dax5ez5LF2zMmr7oMB9+OYY4O+xqBjd/Gcs7Fu5bw
   8=;
X-CSE-ConnectionGUID: pxKSHuk+T0CtfPHrBnEtZA==
X-CSE-MsgGUID: TVakaC9tRFSwiXnB+ZMukw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="111028742"
X-IronPort-AV: E=Sophos;i="6.18,272,1751234400"; 
   d="scan'208";a="111028742"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 14:18:18 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 14:18:17 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 14:18:13 +0200
Date: Wed, 17 Sep 2025 17:48:02 +0530
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <wlan-kernel-dev-list@infineon.com>,
	Carter Chen <Carter.Chen@infineon.com>, Owen Huang <Owen.Huang@infineon.com>,
	Ian Lin <Ian.Lin@infineon.com>, JasonHuang <Jason.Huang2@infineon.com>,
	Shelley Yang <Shelley.Yang@infineon.com>, avishad verma
	<avishad.verma@infineon.com>
Subject: Re: [PATCH wireless-next 00/57] wifi: inffmac: introducing a driver
 for Infineon's new generation chipsets
Message-ID: <aMqm-soAc5tzHQFf@ISCN5CG14747PP.infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
 <4d46dfb13927a878f5684e9e8cfc51673e8df4b8.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d46dfb13927a878f5684e9e8cfc51673e8df4b8.camel@sipsolutions.net>
X-ClientProxiedBy: MUCSE801.infineon.com (172.23.29.27) To
 MUCSE827.infineon.com (172.23.29.20)

On 09/17, Johannes Berg wrote:
> On Wed, 2025-09-17 at 03:47 +0530, Gokul Sivakumar wrote:
> >
> > We have split the driver into smaller commits to make the review easier,
> 
> Now I guess you should also split it into a smaller driver that doesn't
> try to be the kitchen sink from the get-go ...
 
We acknowledge that the number of patches are more and the review bandwidth
is limited. We had modified our internal WLAN driver source code as per the
linux kernel guidelines and submitted it for upstream community review in
the v1 patchset, based on references from earlier instances of how new
vendor WLAN drivers (Ex: ath drivers) gets submitted for community review.

Could you kindly clarify whether you are suggesting to shrink the INFFMAC
driver source by having limited functionality, as part of the v2 patchset ?
I guess, that could help ease the review process and the other files can be
submitted as incremental commits later for further review.

> >     This driver also introduces a new wdev interface (non netdev) type
> >     “WLAN_SENSE” in the Linux nl80211/cfg80211 layer to allow 802.11
> >     frame transmissions with a specific MAC address, which would be used
> >     by the device during solicited WLAN sensing measurement.
> 
> And this _really_ isn't how things work.

Ok, this probably needs modification, we will come back on this topic for
further discussion in the future. For now, we will prioritize other driver
functionalities. Thanks.

Gokul

