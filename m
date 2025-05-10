Return-Path: <linux-wireless+bounces-22807-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFA6AB20AA
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 03:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A34A074A9
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 01:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191D61D7989;
	Sat, 10 May 2025 01:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="wZvW+iR8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E34512E7E
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 01:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746839225; cv=none; b=JXihzBXTAKbcF2tHhgwKRIuGiRGDZDXrHiemkQuQ2sIC/TRsa4BKgvsz06+wcYTmlvYTOh8Wrzc1b1bjOWydXvNTxo9LAUy/lqrfxFz2kCIvuIVqFKcbcNrOs8cuHkOwZhWS4iW/zwC/P9VfvLTeOqIdGVidtpDZmCKnXurR6J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746839225; c=relaxed/simple;
	bh=lOe7dcSrAtdAG3lV/8tCSNA6AjwyD7mwhaTlANHSzmE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=Uyg5mnelWqph1I+rvc0iU+/1qu3WkxVAU9RJQVVlrY7rEa+xbn1tqjDkJW+gd69R9hvC+s029Ocu6BAqR6o6R81LQrFTxi4y9bcBV3QVdfRHqSRsomLkwQMS7LVCTyOfrn8skKjeKrvueUh1DlePLPdKQWgHpsqiNW+HO6aMChM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=wZvW+iR8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 54A16qYfA1336767, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746839212; bh=lOe7dcSrAtdAG3lV/8tCSNA6AjwyD7mwhaTlANHSzmE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=wZvW+iR8c43bY9idke0WKRv9AWOgv3GcszRW5vs7MqOD8SvYzWG2CnmKUuSfmGwTM
	 TcnE1zlxB30M0USpK4Gnafy/ArhoZX1aqiKRvLcQ3kk3gy0wu3mfdXqY5Jo5b5mCCK
	 VXqvtKC9/SfchCY47Ap0H+peHIHixHLLM/ugjqvZmvCcomWtmUL+8L1WM2lmy79fh8
	 XHB/Mlu0G7GqG9hVGfiTlpHEusdlRQn6I8N+37iQ45qaf4MgH69rXOGBGO2MQFoY9g
	 IhGtTsUsPe2xQnAPUsUMNAcCX6nfovK89vRdvoYyYKZPeXyMOzcYXLeLjLRyaw9d5Y
	 nx3UPaBp8TWbQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 54A16qYfA1336767
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 09:06:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 10 May 2025 09:06:53 +0800
Received: from [127.0.1.1] (10.22.225.79) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 10 May
 2025 09:06:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next 01/11] wifi: rtw89: extract link part from core tx write function
In-Reply-To: <20250505072440.45113-2-pkshih@realtek.com>
References: <20250505072440.45113-1-pkshih@realtek.com> <20250505072440.45113-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <22ce90ed-62af-40a5-8560-119c2c4de88d@RTEXMBS04.realtek.com.tw>
Date: Sat, 10 May 2025 09:06:51 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Extract core_tx_write_link from core_tx_write to accept given links as
> parameters. To make the follow-up changes of TX description more clear,
> tweak SW functions to split things ahead.
> 
> (don't change logic at all)
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

11 patch(es) applied to rtw-next branch of rtw.git, thanks.

0f34fbd274b8 wifi: rtw89: extract link part from core tx write function
829bd3599ae2 wifi: rtw89: allow driver to do specific band TX for MLO
a8ba4acab7db wifi: rtw89: send nullfunc based on the given link
5b6247de57d7 wifi: rtw89: chan: re-calculate MLO DBCC mode during setting channel
c3dba0653b1b wifi: rtw89: add handling of mlo_link_cfg H2C command and C2H event
e264a4d1c75f wifi: rtw89: add MLO track for MLSR switch decision
23a5c37ffb1a wifi: rtw89: debug: extend dbgfs for MLO
0c400c0a687d wifi: rtw89: debug: add MLD table dump
18dab90f5653 wifi: rtw89: debug: add FW log component for MLO
9dd85e739ce0 wifi: rtw89: debug: add mlo_mode dbgfs
52d2f6857c33 wifi: rtw89: declare MLO support if prerequisites are met

---
https://github.com/pkshih/rtw.git


