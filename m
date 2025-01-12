Return-Path: <linux-wireless+bounces-17357-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F87A0A6D2
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 02:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09921888706
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 01:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37424A35;
	Sun, 12 Jan 2025 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="UshRGw4z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424A72F5B
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736645433; cv=none; b=IX77h1v+IsrzeLANrk07kw+r7ZTVAYD8xoa35uy/3Yv2QAbSCnqoKT12PSC7WN0/3tVBblZpNalIxUJ/W1Sh/L2uybJHcCgxABmTpnSl7NEZTlstCJnFRIIfwtRaPwIgCC859sPLPY1Qo0CC/XI2SS4HHmZuJpq1LJezM03Z3Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736645433; c=relaxed/simple;
	bh=I4TlVQi151UXvXqEZ9PuMA0CFEeRVRgCuEux07Lk7iQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=HxLiiYFfDWXz3pM4+WHuWue4f02jgCfrQIZ95zkoLf1FWNljgRuzEYQwc8RQmvZvx5tef67wmNKSpwFl+lXFtkveqn4cf1GhhpPoOuF4e6Mr4PHe92o5l9RQ8CPmpdpeRHvnsiotlSpbis1o8w5t26280oN8qn7VSVvU1l1z/QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=UshRGw4z; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50C1US2901565372, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736645428; bh=I4TlVQi151UXvXqEZ9PuMA0CFEeRVRgCuEux07Lk7iQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=UshRGw4zhKbixjwa3vv3S4rOwzkViKZyycrc57QlDpMabDo6BMTYHOTy+4NDBEXFt
	 XwsuPqWyzin0BeCdM0ePVltB0Ty1bINu5d6b0GzxMhf6tS9jOXos0xfpvQPGEG+XQZ
	 61iVzVPr0jb2a0pJUI6an18rYVe80zKr0JQNCkn+yCo415NGDCc2aHQmKBnzy4u76Y
	 eGrB87lbSfR9DBQfu5paSThtPnlfnxpOzsLglDqfxkIpch6nkxYKDS58RwsZS0vM3x
	 Dx1GBYjHES7RBip7Zyp8H3TxIWxxqiwnbIUNWwPcbDH7Cpl0JSUEJIDznaTi9AVfZp
	 f6AzbpRd1khfg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50C1US2901565372
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 09:30:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 12 Jan 2025 09:30:29 +0800
Received: from [127.0.1.1] (172.16.16.103) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 12 Jan
 2025 09:30:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: mcc: consider time limits not divisible by 1024
In-Reply-To: <20250103074412.124066-1-pkshih@realtek.com>
References: <20250103074412.124066-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <7cd8fe5c-a8ab-467a-8c61-cc21807b802a@RTEXMBS04.realtek.com.tw>
Date: Sun, 12 Jan 2025 09:30:28 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> For each MCC role, time limits, including max_tob_us, max_toa_us, and
> mac_dur_us, are calculated if there are NoA attributes. The relation
> between these time limits is "max_dur_us = max_tob_us + max_toa_us".
> Then, the unit is converted from us to TU. However, originally, each
> time limit was divided by 1024 independently. It missed to consider
> the cases that max_tob_us or max_toa_us is not divisible by 1024. It
> causes the result breaks "max_dur (TU) = max_tob (TU) + max_toa (TU)".
> Finally, when MCC calculates pattern parameters based on these kinds
> of time limits, it might not perform well.
> 
> Fixes: b09df09b55fb ("wifi: rtw89: mcc: initialize start flow")
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

35642ba31dc4 wifi: rtw89: mcc: consider time limits not divisible by 1024

---
https://github.com/pkshih/rtw.git


