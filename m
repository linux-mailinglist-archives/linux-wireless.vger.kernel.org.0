Return-Path: <linux-wireless+bounces-12303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A59B967D11
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 02:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E90F1F214D6
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 00:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B372C9D;
	Mon,  2 Sep 2024 00:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="P0ctTPjb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58738A47
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 00:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725238148; cv=none; b=V+5wvrSyRmQnBULp5G/it+GOPctWLJHxhA9uOy/G5IGS9nzPkbe5pA/cX4iS4ZbANPzro128jNgsFBPAJ5J1WT6hvqbOkLuKiBobp3ufOqn7C/pcVcY0Tzp9xOUCGl3B69d4YX1TFcqzJ8NJ7AfFGZhIaUNYcu7j03iXWCfNDxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725238148; c=relaxed/simple;
	bh=ZSNJa7qDCFnJXgf2t+8JS4tF1bKYdR7XIgdK2zxFnEI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=FCSVz/3RQkh38uNR8zWM71HK5gdrwJ5Mwwo3OV2ONhwjo1lW8wdp2JJSeh+gS6rITvy7vn7rmXp0asemyD2GhM2RaaMEV0/+/Vdp6mIbFGDR1Mtltk6LaVE/g4qPifb21WQ0bW6JSXG42E8dORf3XrR9z2zDIRqIXtv8XIBCBj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=P0ctTPjb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4820n05K13443117, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1725238141; bh=ZSNJa7qDCFnJXgf2t+8JS4tF1bKYdR7XIgdK2zxFnEI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=P0ctTPjbOm9mfUXyuC6VDQd8nsEPeFn3l+bjJ+dnuPh/h8IXQmNmEJuSMs2mVLU+i
	 rLS8+HfqGxf2G+xqdweES62FPK9nsljefH+hdQEHAXvrzpJNMOhSICwVc/B5yu5qhT
	 rmvsXh+d2GwUuu2pUYSNIIk2wDUSoFr2g+546QHrtXVqpcQ+Z2LVe/A4ZoILcH3bVr
	 X9rtPx9x8q2ekUN1MYg1C8+PfIBga05Me+KqsX260T4rzjto3IiMiy66rTA80E+ocK
	 LEDeIyHJ6UmdAXV+PpTFguAAZFDGVZUuzdzEU/OV8XGcwQw4QEr8w0EjrvadbA5AHG
	 jX4+GfRasytkg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4820n05K13443117
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Sep 2024 08:49:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Sep 2024 08:49:01 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 2 Sep
 2024 08:49:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH] wifi: rtw88: assign mac_id for vif/sta and update to TX desc
In-Reply-To: <20240819025248.17939-1-pkshih@realtek.com>
References: <20240819025248.17939-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <8ed39c77-6751-45b2-8ded-7abcdd8fecbb@RTEXMBS04.realtek.com.tw>
Date: Mon, 2 Sep 2024 08:49:01 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> A mac_id as an instance in firmware has to be assigned for each station
> including AP and connected stations. Firmware will use the mac_id to
> control TX rate and do statistics.
> 
> Assignment rule is to assign mac_id to each vif when adding vif.
> For station mode, sta->mac_id will reuse vif->mac_id. For AP mode,
> dynamically allocate an sta->mac_id to a station, and vif->mac_id is
> used to send broadcast/multicast packets which are not belong to
> a station. For example,
> 
>                   vif->mac_id      sta->mac_id
> vif0 (STA mode)        0               0
> vif1 (AP mode)         1               2...
> 
> By the way, remove unused RTW_BC_MC_MACID, which was planed to send
> broadcast/multicast packets on fixed mac_id.
> 
> Tested-on RTL8822CE with STA + AP SCC mode.
> 
> Link: https://lore.kernel.org/linux-wireless/e4be0a75-43b2-4ae5-9aab-5c4a88e78097@gmail.com/
> Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

902cb7b11f9a wifi: rtw88: assign mac_id for vif/sta and update to TX desc

---
https://github.com/pkshih/rtw.git


