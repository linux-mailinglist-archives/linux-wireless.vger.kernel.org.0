Return-Path: <linux-wireless+bounces-23912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A578AD2BA3
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 03:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2353C16CCAF
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 01:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87FD1714B2;
	Tue, 10 Jun 2025 01:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="WAbrgrd/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D7913790B
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 01:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749520544; cv=none; b=goHUhqaOAuxepPO/shJbtdKGXHzlYXSzr+nrlTMuh9DwfrTxMEkailaNgi9g8tHCYhMIRJvbYKL4MOwEeob11ROBov7CE+uBL/m5+CVp3jsr2Gc2Bbp9JcvnsW8kK8WfEXR0ANfHvgNa9gD4Z7laRp24I2mKgHSCDVdVTDGyl/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749520544; c=relaxed/simple;
	bh=V4k5I1vEf9RDEHiuWKLlSvHBCKmu2ZVznEeWsFv+10s=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=YJEteX6kt5LlqOR4m8WOWMTXSit8d/m7gxY2Vyf6I5BJOj+zwZKWz4xeA6OcRVPQTWjaKhG8jiRJf9sYJgTMomU9VIOn6bWqh1zGt9je2DG+sfPLJ8uXvNR9BAT1hhtz4NNWyt0TR6fyQ98/KfAcNIeOoNN7TNID4sy2FWeB4ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=WAbrgrd/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55A1teUbB2075205, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749520540; bh=QQC+zxVx1igW6x3J9RZhZ2j674PFcc/Dpgjoa6J7xMY=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=WAbrgrd/nfICjQvHcSaAj4Mv5FYmMQyfQGnvhgMttEw4CyfHXjkvKq+seXa8aonGu
	 tea0OVtGGwFGBfCHhM+VthK3c4VtjLz4XUA5UMm0uRvo3aTMSHR52AFpzSl05N+B/2
	 4tJe4ZUqxjZeYKackREDEPcgusfMNa7GgeSGLxn/SHcurvZG2ko3YhLCEmnBomTAOA
	 9iUeSAjjR1Fvy/ZluezLkNLlqpfgdx1dMZHpI1dFKiK/y51kD3MvV5QINtkzEeBvo2
	 BdWLZMNv1uAIpSDSWewN3tA4TfRt0FxHRbMOYH59U3Jmbq2nTudUjdWX+40tyPNQZ0
	 PDkZlwWNaU7Hg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55A1teUbB2075205
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 09:55:40 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 09:55:40 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 09:55:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <damon.chen@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next 1/5] wifi: rtw89: chan: concentrate the logic of setting/clearing chanctx bitmap
In-Reply-To: <20250605114207.12381-2-pkshih@realtek.com>
References: <20250605114207.12381-1-pkshih@realtek.com> <20250605114207.12381-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <4d13193e-df01-43ac-96d5-bfdeacbae6c8@RTEXDAG02.realtek.com.tw>
Date: Tue, 10 Jun 2025 09:55:40 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Originally, the logic for setting bits was wrapped inside the configuring
> function. However, raw clearing bits, clear_bit, was called directly. To be
> more paired and more understandable. Concentrate the logic of them into the
> same function.
> 
> (don't change logic at all)
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patch(es) applied to rtw-next branch of rtw.git, thanks.

6cd93f85af7a wifi: rtw89: chan: concentrate the logic of setting/clearing chanctx bitmap
6c661eec292c wifi: rtw89: chan: re-config default chandef only when none is registered
edba3f107844 wifi: rtw89: implement channel switch support
28bb3d842e8f wifi: rtw89: add EHT physts and adjust init flow accordingly
fe30a8ae853b wifi: rtw89: fix EHT 20MHz TX rate for non-AP STA

---
https://github.com/pkshih/rtw.git


