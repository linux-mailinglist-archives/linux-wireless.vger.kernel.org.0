Return-Path: <linux-wireless+bounces-2266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544E0832E32
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 18:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADCD287CBD
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 17:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E190D55C27;
	Fri, 19 Jan 2024 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaYfnNA5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD0D55C05
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685463; cv=none; b=cOEgseg68d0bd7E2vlMLR+1UEnNSWqS3lT412eYTk2ghdteomEyL6VFysOTw5amBFHvRROG7kLsC7Bs7s5yP8T7bB6thMZjSSTypjKoS8Y9MfWwnOChT5uySmGjAdwFWbeXwiTI0V5WcZx3JND0wzIXzRGGO57hQFPjtT/vxqoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685463; c=relaxed/simple;
	bh=Wzh+WYgb2DaWS26PmauCXyieV/ZXABIUrPqr6fuPXb8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=BAhVHBmXlXHzEYtvdA/Vrwg86TcUQCSoov8bjwssM8TR41eLamh5xqrleQIY9vs/BzDJEdc0WlvLZoJBQbep4hkASZjrtua/yl24mBzZRUQtuMH3srF58lyoe0qU7qM7F50Zgo3q6XRCCgn2TAcL2AvvBxkf6w1WU+iIm5F57FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaYfnNA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F362EC433F1;
	Fri, 19 Jan 2024 17:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705685463;
	bh=Wzh+WYgb2DaWS26PmauCXyieV/ZXABIUrPqr6fuPXb8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=uaYfnNA5cVdIF0pUqYTL06HrlFm87+LzZfRSmGVzWpVdb0j2eHaCKpbCNV5RTyGpR
	 X96ZrTC56wM5ngDfStzFhYmshwrq1wDrqTRxuGAW9UgsDsMfjreGQplK/si3RbsVLu
	 vaQFteZO/zMgXYWl3BPWPjHXacawFPb8OPtQw6w7jvHy72x/6LKLrgymAuUCX0HKBa
	 HaKRSIb59pu6Qam8t6zgDn1EgEADvEqvFjJMK4wpJuII+Y9PVA2h/Z94uKFqUoZWsG
	 yDiymkb64P1/xLvQ5ZDy41KsLlb4N8jC26+E+ukOYGrz6qmTH6cX6NVQkjXoVAM1on
	 lhxEAqr2vSZ4g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: rtl8xxxu: add missing number of sec cam entries for all
 variants
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240116095001.399500-1-martin.kaistra@linutronix.de>
References: <20240116095001.399500-1-martin.kaistra@linutronix.de>
To: Martin Kaistra <martin.kaistra@linutronix.de>
Cc: linux-wireless@vger.kernel.org, Jes Sorensen <Jes.Sorensen@gmail.com>,
 Ping-Ke Shih <pkshih@realtek.com>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170568546015.3153793.1103690824595965170.kvalo@kernel.org>
Date: Fri, 19 Jan 2024 17:31:01 +0000 (UTC)

Martin Kaistra <martin.kaistra@linutronix.de> wrote:

> Commit b837f78fbffa ("wifi: rtl8xxxu: add hw crypto support for AP
> mode") introduced max_sec_cam_num as a member of rtl8xxxu_fileops.
> It was missed to set this number for all variants except 8188f, which
> caused rtl8xxxu_get_free_sec_cam() to always return 0 and therefore breaking
> encrypted traffic.
> 
> Fix it by adding the numbers for all variants. The values are taken from
> the vendor drivers and rtlwifi.
> 
> Link: https://lore.kernel.org/linux-wireless/20240111163603.2325-1-zenmchen@gmail.com/
> Fixes: b837f78fbffa ("wifi: rtl8xxxu: add hw crypto support for AP mode")
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>

Patch applied to wireless-next.git, thanks.

563d5025cf3b wifi: rtl8xxxu: add missing number of sec cam entries for all variants

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240116095001.399500-1-martin.kaistra@linutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


