Return-Path: <linux-wireless+bounces-22707-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B1EAAD936
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 09:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C10A7B9879
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 07:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341FF221714;
	Wed,  7 May 2025 07:52:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381A12253B2
	for <linux-wireless@vger.kernel.org>; Wed,  7 May 2025 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604349; cv=none; b=Lsi7DXcxN9FROoFy1Qh8s/lkmsemRWC5xxTFjmLqXzRTKzbGRU1l5DqmvXpDU128KH2XNeCpt5Y4wHVd1HoYBYB3mBhhmbqiNSxgInaD0OI3/U73w1L0wyTYxoKNNxZn9Klx4zTZjtZGlGbIhvkaALpQrpD1AD1zYddc7kAaaa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604349; c=relaxed/simple;
	bh=NV3zShGE9uYbqBF0mH60yPaQ3ZiMdVglbzI3LYuE0hY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=d6JTcDosLK+4yrnjiWeqsIl5v0F2H7RAponMmQ1nPrbPAbm/fyblIEJOjX1mLPNusbfHPPGxM/3M12ZT/frSrDMPc+XT0eNmvHLyIOhGXHrDTigg9jMcTBM3US3BPlfC0mkkrMb4nRno4fT9wDYCAxP2FWMyjnFRLdYwHP4cRBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: XA6ZbCWvR1K2mvsr3Emi8Q==
X-CSE-MsgGUID: rMdCD4FOSiiORLTbyMDWjw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 07 May 2025 16:47:17 +0900
Received: from localhost.localdomain (unknown [10.14.100.35])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E21E04019C77;
	Wed,  7 May 2025 16:47:13 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: johannes@sipsolutions.net
Cc: gal.gur.jx@renesas.com,
	linux-wireless@vger.kernel.org,
	oleksandr.savchenko.dn@bp.renesas.com,
	sergiy.petrov.ue@bp.renesas.com,
	viktor.barna.rj@bp.renesas.com
Subject: Re: [PATCH 00/38] wireless: ra6w driver for Renesas IEEE 802.11ax devices
Date: Wed,  7 May 2025 10:47:12 +0300
Message-Id: <20250507074712.1786013-1-oleksandr.savchenko.dn@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <a34be080dd664a01b94d80150cbb2b6e95034eff.camel@sipsolutions.net>
References: <a34be080dd664a01b94d80150cbb2b6e95034eff.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Hi!

Thanks for answer!

On Fri, 25 Apr 2025 11:39:38 +0200 Johannes Berg <johannes@sipsolutions.net> wrote:

> Hi!

> On Thu, 2025-04-17 at 16:51 +0300, Alexander Savchenko wrote:

>> Renesas Electronics Corporation publishes to the opensource new
>> wireless driver for an own 802.11 chipset family - RA6Wx.

> I guess I'll ask the same questions I just asked the other recent new
> driver submission:

> https://lore.kernel.org/linux-wireless/45b74f9f0831294e783a019cd6a1437fdad4=
> eb6a.camel@sipsolutions.net/


> You're not adding a MAINTAINERS entry, what are your plans to actually
> support this?

Good point, thank you! We were planning firstly get comments in formal similar to RFC,
and then publish polished solution to kernel and became part of it.
I will add myself to MAINTAINERS file in RFCv2.

> Also, how much do you actually plan on being part of the community?
> Reviewing others' code, etc.?

We want share our driver to the world,
and will try to assist the community with review if that would be helpful as well.
Will review other WLAN driver as much as possible
(I am fully allocated for Linux upstream activity in WLAN within Renesas).

> See also
> https://lore.kernel.org/linux-wireless/21896d2788b8bc6c7fcb534cd43e75671a57=
> f494.camel@sipsolutions.net/

>> (including the firmware binaries).

> Those should probably go to linux-firmware.git.

Yep! Apologies, these commits initially were supposed to be RFC,
eventually for PATCH solution we will publish FW as well as required in the guideline.

>> The RFC is divided into separate patches on a per-file basis to simplify
>> the review process.

> The bot reported some issues anyway:
> https://patchwork.kernel.org/project/linux-wireless/patch/20250417135236.52=
> 410-39-oleksandr.savchenko.dn@bp.renesas.com/
> FYI.

Will fix in RFCv2, thanks.

> So dunno what to do with this - I'm not going to review this. I suggest
> you build some street cred first, review other patches, show that you're
> around and care about the infrastructure you're building on.

Of course, I've understand your point.
Noticed! Let us try to increase our involvement and then we will republish it.

> johannes

