Return-Path: <linux-wireless+bounces-4390-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3768725DB
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 18:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D20CB22C28
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 17:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A74917555;
	Tue,  5 Mar 2024 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQhMvmem"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2DC171A7
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660676; cv=none; b=mwdZBjeH+nW6AF5hYrz84HRmhPmPjPTmmqGq3SYDKerfA6JXtzrl2W6x/c7PX3N+z0DKnSH7Qtd3zpmIAYHq3pid1bLwVFkPuykQ4pBuQKGWoZl+zDq2jWowkx9PYra7bItwqhhCHahHkVjfjTGuxp4n5WeAJOB4z9/SR57mToQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660676; c=relaxed/simple;
	bh=oHSZ0G4oxwj88r+yIh5oS1t3YVffBNY0r0XjVs2okSI=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=YO2zysHU/gD6fMAF+fkmroUaNFOouLs6NpILWUMpCLRRz/D8wsYLIgEzmQ+92o+OVdMF1e/qOadCbb21HmYuwGpHmU/Kmn5ciTKabLOiuY8FsZY7/6z9cNYTMUyGF5tdCpUXi18adQLvoSSYc8jyiQO/4mEAWjFBWu6ykvWv7qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQhMvmem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F5CC433C7;
	Tue,  5 Mar 2024 17:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709660676;
	bh=oHSZ0G4oxwj88r+yIh5oS1t3YVffBNY0r0XjVs2okSI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=mQhMvmem+uWTmhgyZDtw3WSaiZVuS+zbTsBArxGv3omtGSTebmohU1ZPIcXPjDa+f
	 i4Sg+ES+TCZpuRWUsvfSjNLcQhV+q9YvCNtfwDUXVS1mIS5TcyPTc30E9IJPLupohx
	 Zto80Cl8BlTYuEnTH2fl8fqwblLcoYcEh5jTK63q0EoeScna5BCjJp71dtOPacUYi9
	 H3MKObhKIH3q8KhuJE8Rd8wvThd+7plgMenHX7L64tsysHKVwjHXnmqPj2CAYBAtoq
	 lIUpYZCsEWHb7e26RPWCwpgX0tkfEYQjD8pf+aKeoygCpj4pnaRbqvbK1jQEQC7pA9
	 SL3MsC8k2Dv6A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] wifi: rtw88: 8821cu: Fix firmware upload fail
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <f12ed39d-28e8-4b8b-8d22-447bcf295afc@gmail.com>
References: <f12ed39d-28e8-4b8b-8d22-447bcf295afc@gmail.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>,
 Sean Mollet <sean@malmoset.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170966067347.365498.17993816555428778650.kvalo@kernel.org>
Date: Tue,  5 Mar 2024 17:44:35 +0000 (UTC)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> RTL8822CU, RTL8822BU, and RTL8821CU need an extra register write after
> reading and writing certain addresses.
> 
> Without this, the firmware upload fails approximately more than 50% of
> the time.
> 
> Tested with RTL8811CU (Tenda U9 V2.0) which is the same as RTL8821CU
> but without Bluetooth.
> 
> Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-next.git, thanks.

41a7acb7dde8 wifi: rtw88: 8821cu: Fix firmware upload fail
605d7c0b05ee wifi: rtw88: 8821cu: Fix connection failure
e1dfa21427ba wifi: rtw88: 8821c: Fix beacon loss and disconnect
c238adbc578e wifi: rtw88: 8821c: Fix false alarm count

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/f12ed39d-28e8-4b8b-8d22-447bcf295afc@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


