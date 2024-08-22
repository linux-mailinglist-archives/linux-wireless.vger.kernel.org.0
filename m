Return-Path: <linux-wireless+bounces-11775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706A895AAF4
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 04:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC931C22175
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 02:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AB733EA;
	Thu, 22 Aug 2024 02:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZzP32S2p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95FB2C9A
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 02:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724293917; cv=none; b=ZW4tcExtHy0bKUxZ/5K+zG1GKcNpkRlcLpcUpAB7boMgY/Nf33/IZOK/tgW4j62H3TUm0DU7tAJmnT8P7fg7MIc6UB7ELSywSeeK3/qpiNNyba6VkT6d4ukc4BDTcJKYfO6aT2L++oK7CWXV/8RbcTL0y0wcfF3KVAyNg9WnXCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724293917; c=relaxed/simple;
	bh=UgSkXmIv9tNHk6YdJj8Mcvw/USGK/ker/xtgXkI/4/4=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=h3VY+SVdWlNC0a0okbwONo+E+Le5GzuotyuCI4EgaXgHXXlucZVeUttMm0R1nPhQ79L7JQW5uq9g/Xp5HikrUR6vUZuOSOoYapMbXVZp2LIvZpArO4fbx59ZWnkmI1R4SJ+czpdqFsgfPho0UwdHriqm1w5rDaKDi+L/6ahzCss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZzP32S2p; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47M2VqnoE3461838, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724293912; bh=UgSkXmIv9tNHk6YdJj8Mcvw/USGK/ker/xtgXkI/4/4=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=ZzP32S2pYxHoFInCc1cVmn1MnXBGXLqG30vI1owKaNIBmPJ+5mWzgicQG3tN4TEZ+
	 me72ehhlCLCKQNqRkytwFE9cYMOOvx2LvIWBih+JJ0wlznrmavBh0PSrvPkk9ya8wN
	 mIHbV0IQYum0aoedXKG1S/lLgkgMMJ+PMVYj8d9dOAV2Rrw6HtgjYV297BjRItgMFK
	 NXzv0sjJFjWBAr7atgWSvENsM16g9HYI5jULYa0T/W+1XUAx2/9eRe6dksRELlx3TQ
	 srZOxzAUsYTQkaQRm9w6YlDyNPhsKXSnuF0DxhiEZtuMVpPtquyrNk8cbKsW59Lq20
	 ib8GUzVZy9L4A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47M2VqnoE3461838
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 10:31:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 10:31:52 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 22 Aug
 2024 10:31:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: limit the PPDU length for VHT rate to 0x40000
In-Reply-To: <20240815134054.44649-1-pkshih@realtek.com>
References: <20240815134054.44649-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <1b1a0e5b-7c37-4120-beec-9502824a5e48@RTEXMBS04.realtek.com.tw>
Date: Thu, 22 Aug 2024 10:31:51 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chia-Yuan Li <leo.li@realtek.com>
> 
> If the PPDU length for VHT rate exceeds 0x40000, calculating the PSDU
> length will overflow. TMAC will determine the length to be too small and
> as a result, all packets will be sent as ZLD (Zero Length Delimiter).
> 
> Fixes: 5f7e92c59b8e ("wifi: rtw89: 8852b: set AMSDU limit to 5000")
> Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

124410976bf8 wifi: rtw89: limit the PPDU length for VHT rate to 0x40000

---
https://github.com/pkshih/rtw.git


