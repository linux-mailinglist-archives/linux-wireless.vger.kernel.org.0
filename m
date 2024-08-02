Return-Path: <linux-wireless+bounces-10845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B1F945613
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 03:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE961F23459
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 01:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036CB79F0;
	Fri,  2 Aug 2024 01:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="SqK0jNRV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7601F2572
	for <linux-wireless@vger.kernel.org>; Fri,  2 Aug 2024 01:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722563288; cv=none; b=KilZbxwM5KtqPOHRXId6g7BDzovlXpMTlHlnFNztXn/kHcynvFyb5CQRNbVDdtt+utnfPAZ8kkx713IIqTgOSc0wRt9zDLC3J9i1naLgLfSxmsJP2VO1gxxFicJaclo3o2WN7pCrz9ATKhXa726OkyFbh7Pn83rdEleQiQ+QG4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722563288; c=relaxed/simple;
	bh=dwJSgLReIo01InPHi8sqOiRJvjsUthgdboRiRoX70aQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=UhMetrPxpETNnhdIoI8o9BahqOGj9kAfLIq3Z2PBu43S7BhXv6A2rKhG+56DeX2mkznLNrTvUTWQSqDjrjI8HgfqH5Erg7/NTJyDkkKzL0Gmy/ifzpAohvhVx95kuag3s4uKW47SEuEaSzpvaZokoWL9Bepb6Eajp4J68/4GVjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=SqK0jNRV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4721m48h9114273, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722563284; bh=dwJSgLReIo01InPHi8sqOiRJvjsUthgdboRiRoX70aQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=SqK0jNRVaw7izBeAew8WBKdyy6R9hvYx1R4BxoWq4hrc3fHRm76Orsho2Q59teEBe
	 VthMZ3+376N7JmceyqMmnvhzD5wMFW+vQQE/xKQWJ+rOPvNWzqe3fLrBTFZf+Fdvsl
	 DslcIbbyupd/I+giXqencrpOUd1wicxXTPX62dYcoAwtb44Sz+k8LKaJCZUdLYh/ua
	 CglcLlNTt/3UIOKQeXLTkKN1W4rAnpkUrYd/M3GKyJSjjPSa/iACrNhMBO3BrqeS+b
	 spPaqQBNqhmjRrt+RmnyUmJI3jgL1BBHKHXy9SkcPquT4fCPbHa4+DFJ+pCf8cUeqB
	 R41f7uyYraWhA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4721m48h9114273
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 2 Aug 2024 09:48:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 2 Aug 2024 09:48:03 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 2 Aug
 2024 09:48:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: Re: [PATCH 1/7] wifi: rtw89: chan: refine MCC re-plan flow when unassign chanctx
In-Reply-To: <20240727080650.12195-2-pkshih@realtek.com>
References: <20240727080650.12195-1-pkshih@realtek.com> <20240727080650.12195-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <2308393a-bbc7-4389-986f-d6ed40ac3a3a@RTEXMBS04.realtek.com.tw>
Date: Fri, 2 Aug 2024 09:48:03 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Originally during unassign-chanctx, MCC (multi-channel concurrency) is
> re-planed before set-channel if need. But, we might calculate MCC stuffs
> based on old channel info. And, the following set-channel might be racing
> with FW MCC state mechanism. So, we refine this flow. Now, if MCC re-plan
> is needed here, it will be done after set-channel.
> 
> Besides, to be more rigorous, we now ensure entity isn't paused before we
> deal with MCC things here.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patch(es) applied to rtw-next branch of rtw.git, thanks.

62c5a91b25f0 wifi: rtw89: chan: refine MCC re-plan flow when unassign chanctx
39b9271095b2 wifi: rtw89: mcc: stop at a role holding chanctx
583e998e2024 wifi: rtw89: rename sub_entity to chanctx
75d853d4ae45 wifi: rtw89: pass rtwvif to RFK channel
ed5f66a28120 wifi: rtw89: pass rtwvif to RFK scan
db0dbe26f48a wifi: rtw89: fw: correct chan access in assoc_cmac_tbl_g7 and update_beacon_be
11b227901ffa wifi: rtw89: pass chanctx_idx to rtw89_btc_{path_}phymap()

---
https://github.com/pkshih/rtw.git


