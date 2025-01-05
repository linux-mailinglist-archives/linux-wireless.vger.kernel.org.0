Return-Path: <linux-wireless+bounces-17091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08609A01BFA
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2025 22:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D7D1884840
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2025 21:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706BD80027;
	Sun,  5 Jan 2025 21:21:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2619EB658;
	Sun,  5 Jan 2025 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736112078; cv=none; b=rmZSb62f5UFVtk3L4FYHoqCrxpiCa0sOa/+uKf8/X7VpzJ8vZ2C7bJIWU7pk3mAmjJYnuCl+MiqCZxKH4UNB8hs6sgMcmdlpsOXnjpwKWjIXgtWE6hnVLMeD7A6lQrP3PIkSVHL0QNMQqfv9/MfPoBt9hrMOKbZ+2IzQ4IvGkOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736112078; c=relaxed/simple;
	bh=UOv6KGKi+F68hGpR1/6VE6ISisLVHZWtxb3hDTOk3Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLpW+bXu1Izc0LQUmiZXNfvdAoM8YQAgv1MoTooAVBXPCvMMWeD4Dm3Mcn2tMGInj6DhRXY/0Lmk4/5Y7CGLhvUz79bgAYefrl+2j0qUUZCymR6tjmp6Ff0NkDSYBq8y9Jq4SRoObsoZyxLwIf8zYIIUoW4CC3SLhs95Tzh0314=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tUY3W-000000002z5-3YyZ;
	Sun, 05 Jan 2025 21:21:06 +0000
Date: Sun, 5 Jan 2025 21:21:03 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Ariel Otilibili-Anieli <Ariel.Otilibili-Anieli@eurecom.fr>
Cc: Shiji Yang <yangshiji66@outlook.com>, Stanislaw Gruszka <stf_xl@wp.pl>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>,
	Tomislav =?utf-8?Q?Po=C5=BEega?= <pozega.tomislav@gmail.com>,
	Linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rt2x00: Remove unusued value
Message-ID: <Z3r3vxy8cRRH6w1m@pidgin.makrotopia.org>
References: <20241221124445.1094460-1-ariel.otilibili-anieli@eurecom.fr>
 <20241221124445.1094460-2-ariel.otilibili-anieli@eurecom.fr>
 <20250103085540.GA94204@wp.pl>
 <Z3fMxD2mAVsVl58h@pidgin.makrotopia.org>
 <20250103131002.GA100011@wp.pl>
 <2f7a83-6777e880-a451-5cf12280@99910178>
 <20250104103753.GA2228@wp.pl>
 <2f7a8b-67792f00-52db-be99fc0@193911177>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f7a8b-67792f00-52db-be99fc0@193911177>

H again,


On Sat, Jan 04, 2025 at 01:51:25PM +0100, Ariel Otilibili-Anieli wrote:
> Great, then; thanks for having acked the patch as such.

I just noticed that Shiji Yang had posted a series of patches for
OpenWrt which also addresses the same issue, however, instead of
removing the augmented assignment, it fixes it to the supposedly
originally intended way.

See
https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=package/kernel/mac80211/patches/rt2x00/621-04-rt2x00-fix-register-operation-on-RXIQ-calibration.patch;h=aa6f9c437c6447831490588b2cead6919accda58;hb=5d583901657bdfbbf9fad77d9247872427aa5c99

I suppose this was tested together with the other changes of the same
series, so we may want to pick that instead.


Cheers


Daniel


