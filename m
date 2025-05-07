Return-Path: <linux-wireless+bounces-22706-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB714AAD8E1
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 09:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4548C4C6715
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 07:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B022139DB;
	Wed,  7 May 2025 07:49:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE94221552
	for <linux-wireless@vger.kernel.org>; Wed,  7 May 2025 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604170; cv=none; b=gzgIUvDnu9ZjEou5RvhOTjJ4oQvx8MYbqQdrGa93rjXEdV4ZUPM5SyrBHqEs++fLzpad3NdWi04IsKyENWHRyMqP/ZnSr/NgXQETur28g4e132LxU2pnKjxbfjfBXP9wKDrbStzTousRw3Q9fqlYc1iW4tQ+GHGe2erL/HKyJ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604170; c=relaxed/simple;
	bh=UWLzjNC8B6a0um+chI+jDh1H0QIOIolTRErfLo/KwqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=evEMQM3GBwHqrKrS5qULygcp7/3pLJfaR8gtlLf1VHMsrkWkXEiRIOIrxaBVbjKHZ82TDqjN6IEUmJxOo7PHmSxyE4pA4RRGJyya13slyoCSQpGjRy4Kx/z+81/i4PddCm1a3e+4ffp32/8M6P5EYT1iStVUpjOj9OHDVStg5UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: CddAZDs9R2qH+kVmaePcWA==
X-CSE-MsgGUID: TlRIUl/HSOOlOhveXApPHg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 May 2025 16:49:25 +0900
Received: from localhost.localdomain (unknown [10.14.100.35])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EDFA441F8473;
	Wed,  7 May 2025 16:49:21 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: johannes@sipsolutions.net
Cc: gal.gur.jx@renesas.com,
	linux-wireless@vger.kernel.org,
	oleksandr.savchenko.dn@bp.renesas.com,
	sergiy.petrov.ue@bp.renesas.com,
	viktor.barna.rj@bp.renesas.com
Subject: Re: [PATCH 00/38] wireless: ra6w driver for Renesas IEEE 802.11ax devices
Date: Wed,  7 May 2025 10:49:20 +0300
Message-Id: <20250507074920.1786253-1-oleksandr.savchenko.dn@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <6d4e921e0c656260ef6f56119591bbaee6c14634.camel@sipsolutions.net>
References: <6d4e921e0c656260ef6f56119591bbaee6c14634.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

On Fri, 25 Apr 2025 11:40:43 +0200 Johannes Berg <johannes@sipsolutions.net> wrote:

> On Thu, 2025-04-17 at 16:51 +0300, Alexander Savchenko wrote:

>> Renesas Electronics Corporation publishes to the opensource new
>> wireless driver for an own 802.11 chipset family - RA6Wx.

> Oh, and out of curiosity - and maybe you can't say this - is this IP
> coming out of the apparent Celeno acquisition? I had some meetings with
> Celeno more than a decade ago :-)

Not exactly, this IP came from different company which have been acquired by Renesas.

> johannes

