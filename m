Return-Path: <linux-wireless+bounces-15430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B36369D07B8
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 03:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6811C1F21116
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 02:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB2733E7;
	Mon, 18 Nov 2024 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bSMmgpSY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265A4E55B
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 02:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731895516; cv=none; b=jw4uZgaJbmGE4vdoGLuN45Fq2g3CrzeW/RfDCgVqOuwsldYL5Mb1qd2Equm8AKoP46+I1LdwzWXWpqF1INI0U11jL6UGHAR0F5CWgQ6GsuvuLUWFnaVgI++B+DLfhgOmFgIPzIk7MAcqvV+ShCTusuUIOTDcbmxBySCTsCrISM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731895516; c=relaxed/simple;
	bh=aeXuAmzB6AUbQajgdV/MXb15eHLYtoSA9NyvNAJ4e0Q=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=oPMubDoIVcK09u4pLrshccjFqA2HzSEWRHcL2VZ6TYs4q3mKMdD5odXM6Dmp6VVgw2byAUWo0povMNNA+LYnJmsRwOv0gwkfbVz/0z0JzvCMbQmac0E74Z2qIxVNHknJQ2gwHOCe+kDqOyVS2J8dRaDm8CWHNQ1jshairr61CWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bSMmgpSY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AI25DwK44147692, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731895513; bh=aeXuAmzB6AUbQajgdV/MXb15eHLYtoSA9NyvNAJ4e0Q=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=bSMmgpSYgp04RS25ohCSOmgLkjWJ6ZNTQnMoy1DDfTiOAV9DWRdQ7JrSAsWRpCyBi
	 yA+28gw8sfnbxDECNEd6u2aJDQiLX0R0QNHQY4hx9ruWTDkslFFA4yviZ3JYf5xDuV
	 EQpPjoIV44sQvohWioIJ1FRfmaWiiC1iRAAtn5TzwXqUAGTdpkM0toyrp3MjoKqQHJ
	 gqqunWl/0rnTaJS2jZveU/8jQZKep4MlOSJjP7zcHZaDg/lXNfJdy9EijPZrTc2ijK
	 NIKllESMemFSBRs1j/D8PwZ6gCx6/0kMQg2f3EEqFnDbuXpiMA3iZeZ/Gb8ZdgzPMn
	 NkfWVydTv4UDw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AI25DwK44147692
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 10:05:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 10:05:13 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Nov
 2024 10:05:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: Re: [PATCH 1/6] wifi: rtw89: 8922a: configure AP_LINK_PS if FW supports
In-Reply-To: <20241107084041.20775-2-pkshih@realtek.com>
References: <20241107084041.20775-1-pkshih@realtek.com> <20241107084041.20775-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <5e6a5efc-88c6-4ff0-975b-5e8b27911a19@RTEXMBS04.realtek.com.tw>
Date: Mon, 18 Nov 2024 10:05:12 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> After FW v0.35.46.0, for AP mode, RTL8922A FW supports a new FW feature,
> called NOTIFY_AP_INFO, to notify driver information related to AP mode.
> And, one function of it is to monitor PS states of remote stations. Once
> one of them changes, FW will send a C2H event to tell driver. With this
> FW feature, we can declare AP_LINK_PS.
> 
> For now, driver still needs to determine if a frame is ps-poll or U-APSD
> trigger. So, add the corresponding RX handling in driver, which activates
> only when at least one AP is running.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Applying: wifi: rtw89: register ops of can_activate_links
error: patch failed: drivers/net/wireless/realtek/rtw89/mac80211.c:1609
error: drivers/net/wireless/realtek/rtw89/mac80211.c: patch does not apply

Set patchset state to Changes Requested

[1/6] wifi: rtw89: 8922a: configure AP_LINK_PS if FW supports
[2/6] wifi: rtw89: register ops of can_activate_links
[3/6] wifi: rtw89: implement ops of change vif/sta links
[4/6] wifi: rtw89: apply MLD pairwise key to dynamically active links
[5/6] wifi: rtw89: pass target link_id to ieee80211_gtk_rekey_add()
[6/6] wifi: rtw89: pass target link_id to ieee80211_nullfunc_get()

---
https://github.com/pkshih/rtw.git


