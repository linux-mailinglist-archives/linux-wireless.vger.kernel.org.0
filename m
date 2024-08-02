Return-Path: <linux-wireless+bounces-10842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28DF9455E8
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 03:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9301F22F88
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 01:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1982595;
	Fri,  2 Aug 2024 01:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="LmctLI1r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8FBEEBA
	for <linux-wireless@vger.kernel.org>; Fri,  2 Aug 2024 01:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722561454; cv=none; b=m9RBZSqeRZoklP5a+IyM6Rh9/cLFhlXCKo7rDxdCg0Yjy1bIGtlrBNJeekoMj+aSkSquwHk+oZLU+S5AMt1uc85CPV/OOrTOhpVfEu1CRLgdygeDONY+HI6KDvT0FRuFmLGJ5xfksAapZu3coj6ULn28nv6Ha5t80Nfh8S43j30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722561454; c=relaxed/simple;
	bh=nlb0ZDHOVRxT2fLmWCHWEC4Sb/YmTIxRO31/ptggSJ4=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=AyQLJI1LMIrNB38HmHFQmA49AO0bSDx3X9mu5odEq/1OqLAtPebK5wtcck7Jl3iYe+E31AQ+8cCL2OIdxMWqp0UgUMr/xQikp9OMcSO6QaFD+Mo7Lp9pzw7guf12FKMF3gfS+PqfQIXiJVFQSC0AoP4XGj8KzazzWWMlz0Pqvgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=LmctLI1r; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4721HQ8c8063668, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722561446; bh=nlb0ZDHOVRxT2fLmWCHWEC4Sb/YmTIxRO31/ptggSJ4=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=LmctLI1rq0B/RNzd1RBXU3m72V+cxgEEcQH9IqXA/aG2Bj7JBko5wwfkEh2KaJ5VS
	 hA9Bb6oIclQ/NdA09mF2/Ze7R1oMFDtLAhk9Nryu1pw87TsqSz5IBvTmFxbWRhBMIs
	 ks0/xF1YGdm5yQwHJuS6SSvHtoVvQNZX+iMLQrC6GeOJYGoJi6asRjlkey+y63T1Mv
	 EKbj9NoQ0vlwoqT5h98sbItFQ2TQE1txj0yIoKmY7WsQtP/w6fqE/28JE25tTmfj94
	 o0DHtepnJxSABe6U+NpXLlnN1qNCSGudef7+2NlwMBSO8jNVwUVasZ+tJgdf4owt3Z
	 VfF4b3oqKIcNQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4721HQ8c8063668
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 2 Aug 2024 09:17:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 2 Aug 2024 09:17:27 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 2 Aug
 2024 09:17:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>
Subject: Re: [PATCH] wifi: rtw88: 8822c: Parse channel from IE to correct invalid hardware reports
In-Reply-To: <20240724050501.7550-1-pkshih@realtek.com>
References: <20240724050501.7550-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <5591195e-ab44-4e06-b86d-2d55bc839328@RTEXMBS04.realtek.com.tw>
Date: Fri, 2 Aug 2024 09:17:26 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> For CCK packets we could get incorrect reports from hardware.
> And this causes wrong frequencies being reported. Parse the channel
> information from IE if provided by AP to fix this.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

53ed4b25a79a wifi: rtw88: 8822c: Parse channel from IE to correct invalid hardware reports

---
https://github.com/pkshih/rtw.git


