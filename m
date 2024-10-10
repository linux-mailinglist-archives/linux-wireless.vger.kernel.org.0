Return-Path: <linux-wireless+bounces-13828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D2A9979DF
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 02:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFFC11F23AB6
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 00:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CE9653;
	Thu, 10 Oct 2024 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="j2wFl/fP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63850645
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 00:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728521572; cv=none; b=q+kcdzVZ2z/4fGQ9G02/79I3WON/thHq4bqEI2FoHQ/45I2wm16isnn+jbNJFNniSQNZb/G7slndEMha8cs66axDLLqGAP9OXe0dulnAXJxCiTLuvO19gIVAxbwRgs3IsrqCwT81fpmX9VJ2s/SHgKals14T9l5sCtpb/N/9pXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728521572; c=relaxed/simple;
	bh=0uojjvpdTQPONiB0xViYzY/HESwLJ0wWaeWBosR7rhI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=IHjFA/2W+s4Wneu1FHrayqDxo1bwHvWA3TyG1a2KFMbGPgWFrpgyDXImRKb8HFB1okgVM+s7sneljghqkFY6v216ImSpjH6KNYEF5DXE1mRuv5XrvyBen/uV4YdONH2X/2V9SH4P1YqxBFBcEUopjE/DRHnLyMEvzODGjhNL2AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=j2wFl/fP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49A0qlHmB1576290, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728521567; bh=0uojjvpdTQPONiB0xViYzY/HESwLJ0wWaeWBosR7rhI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=j2wFl/fP1rQVVW8Qzu1H5Ek+1EoxJZUreNCc76jhpQ3gPMD+Hw4WB8EuNdvkFS9Pr
	 WndPAsqrwswS83bXlfYPbwRvBEW8jmQwJOxsJGF52fhFB7TxFwoMGDsqsk93sOywFk
	 16yZmr/fOaj7Bbqmlyhrv49lw5cb8L/wWGLuQpU2f5QZ9Y5U8hD9ZaAxvfcAqLY9tV
	 lMBJO4fc1xjKeFQiwEQQB4P2XjBtI5l5W2nvd3qpYxzPq6IlSjjoaApic+sYfY7+3q
	 W50Hdoosxe/2Ppz/eg0WjkwFvw9JD2mHcN5D0PsOshELVhzBXZ+cqMOQWWUj8ypW4K
	 XT3qlq6VQWWNg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49A0qlHmB1576290
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 08:52:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 08:52:48 +0800
Received: from [127.0.1.1] (172.16.17.99) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 10 Oct
 2024 08:52:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: wow: do not configure CPU IO to receive packets for old firmware
In-Reply-To: <20241004065408.10261-1-pkshih@realtek.com>
References: <20241004065408.10261-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <498325e8-b2e1-41aa-8819-fe13b5bd1ee9@RTEXMBS04.realtek.com.tw>
Date: Thu, 10 Oct 2024 08:52:47 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> The older firmware of 8852A and 8852B can't receive packets via
> CPU IO function and will lead to WoWLAN fail if calling it.
> So use firmware feature to distinguish.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

fc442560016d wifi: rtw89: wow: do not configure CPU IO to receive packets for old firmware

---
https://github.com/pkshih/rtw.git


