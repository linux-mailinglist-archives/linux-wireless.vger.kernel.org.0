Return-Path: <linux-wireless+bounces-12405-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FA696A6AC
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19FB1F23CA0
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 18:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B27F18E027;
	Tue,  3 Sep 2024 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nshpBPcL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F8515574F
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388600; cv=none; b=sTSeOvjjyIO8E6Xi3Vi2Osa23mug27YOTpjhU+5GcO4LhDcpqxRBwPlB+3uquxJyNJThvmI6LCIxMIe7H5zzRgMj9wU0Uvgu5JJra9oPVk31dI1shplfZ34bo5+y314utP6l6G8Ln6kwfF9WJAt7v+Xh+ZRSfOmIbQOwVuWtGBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388600; c=relaxed/simple;
	bh=FPrcA8nDk6gVfe+97z/m5+8h3R1dQnSJH8cwh7vg+W0=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Kq6362xa4mtD8ieNdNO8L3/yI/XSIxwuvf5vPwbvuGN3em3z/QY7k4N/zTfuovpQXjBZeg5Zy0C2dRcM7djAVBLFpTZbGEXM7EQpRJY34G3WGWA7xEpi4uOP69+ClnqLRaElpazmLWmdfCbrxsGeksMqgkH7o+gjKV9MLvlEQH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nshpBPcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2893BC4CEC4;
	Tue,  3 Sep 2024 18:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725388599;
	bh=FPrcA8nDk6gVfe+97z/m5+8h3R1dQnSJH8cwh7vg+W0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=nshpBPcLVswYwRdB82lgT9VA98YWEkJs4kjO6D3kI3MyJVMoFCXIur/e2Co4ifmwe
	 Zyr8qKXGx1ZwbXWBj+iD4riZsSC6tfT47i46jJiWKt+WKrr3Hqmv4L1SmN9UayspIW
	 GR+1kR4xP4KatzsA9widlcc9ZWAb0qNmn3IdFKrQC2h8okSmqAXZiQvZ7ieJti/DXr
	 wDJSSjg/Jukeu1cJQOLbyL1Z9PcD6/pUOXcR2cfJXKlgIQ01Jf1dnul/uxlMY+Drw/
	 K65cCti6j5drynRx99iAgaLktgtE0t8cmkhbOPIeLE5m1iYTTTIIK9l3jutv3hNZK0
	 0orKfDeMbmS6g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] MAINTAINERS: wifi: cw1200: add net-cw1200.h
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240902-wifi-mnt-v2-1-f5ad1f36e993@kernel.org>
References: <20240902-wifi-mnt-v2-1-f5ad1f36e993@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172538859711.1112769.11778270496906460790.kvalo@kernel.org>
Date: Tue,  3 Sep 2024 18:36:38 +0000 (UTC)

Simon Horman <horms@kernel.org> wrote:

> This is part of an effort [1] to assign a section in MAINTAINERS to header
> files that relate to Networking. In this case the files with "net" in
> their name.
> 
> [1] https://lore.kernel.org/netdev/20240821-net-mnt-v2-0-59a5af38e69d@kernel.org/
> 
> It seems that net-cw1200.h is part of the CW1200 WLAN driver and
> this it is appropriate to add it to the section for that driver.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

Patch applied to wireless.git, thanks.

5872b47ce18e MAINTAINERS: wifi: cw1200: add net-cw1200.h

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240902-wifi-mnt-v2-1-f5ad1f36e993@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


