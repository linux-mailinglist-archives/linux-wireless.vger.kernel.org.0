Return-Path: <linux-wireless+bounces-19237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE80A3EA27
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 02:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24D1420CE9
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 01:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C205E2AE84;
	Fri, 21 Feb 2025 01:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="SrvHFL3z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC4192B74
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 01:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101827; cv=none; b=VX8USsNiB/1ytVCvAmS7VrOiI12o7+MUZ5SDYQpmbuJah33stdbWhpA1xnByYWAP490snjtitn73z3RGByV5hpk/pIdjEdly/hiHNSHo4+K/uRmeFur0J4mtsux/Jnr22Y4LUG65DLFIMKucaeqBTLcAYflXfrahBLYDr/8p3SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101827; c=relaxed/simple;
	bh=bMq6k3MPvS+/RAx1wDbBnd4wkLmYOVaKjjBkaUSU/i4=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=qT0obG7ETghaLA2LurULSPdYZHLnu3xeVdQfk4/qEBX3ROVbtx/bukKNUGfxkweV3E2PQT0dDf+PtU3WhpKSsTfWNL/mkO8WZzDa6HFsL1hahLqrVmuQjovCwberQvxW8ZmB2Xi7/lv6dztGz9tY7zx/WEvRSYL7BhHas140OoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=SrvHFL3z; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51L1auPS3791890, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740101817; bh=bMq6k3MPvS+/RAx1wDbBnd4wkLmYOVaKjjBkaUSU/i4=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=SrvHFL3zk445YJBOtgBnujWqIaNttCwWecjb8J44DlVWrN9llUWeozkeK2zSTi7f1
	 LWlqaIwraIFMAc9Xy51tHKoDaDoK1uo/ib12+H0BGdVXrAVdlE6HGzIjcZhOlbEg77
	 E90AxyACoMuaJEcUgGPtJkZCdt14CvJCtBbuXrXp4hGZeLEnwCE5Sqd+ck+vLJFRGz
	 80ucHBvi7MKEqrGQFwI+43Hmv9e1jgpxN1VJguApCEmga2nTVw2LSsS7VAUZzDfmw0
	 yagaG9nw+otc3nMv2Ktrz5Hr+m+6/fYntgL/p6bQTC7P0co2a2wp95C/jzyJxpgWGV
	 Mj3g4Zc+QIKDg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51L1auPS3791890
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 09:36:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Feb 2025 09:36:57 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 21 Feb
 2025 09:36:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dmitry Antipov <dmantipov@yandex.ru>, Ping-Ke Shih <pkshih@realtek.com>
CC: Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
        "Dmitry
 Antipov" <dmantipov@yandex.ru>
Subject: Re: [PATCH v4] wifi: rtw89: rtw8852b{t}: fix TSSI debug timestamps
In-Reply-To: <20250213095006.1308810-1-dmantipov@yandex.ru>
References: <8c7cc2e680cf43379734aa86f22f8d49@realtek.com> <20250213095006.1308810-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <897b9f66-71d2-43fc-b323-c6242605fbfe@RTEXMBS04.realtek.com.tw>
Date: Fri, 21 Feb 2025 09:36:56 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Since the vendor driver is claimed to measure 'tssi_alimk_time' of
> 'struct rtw89_tssi_info' in microseconds, adjust rtw8852b{t}-specific
> '_tssi_alimentk()' to not mess the former with nanoseconds and print
> both per-call and accumulated times. Compile tested only.
> 
> Fixes: 7f18a70d7b4d ("wifi: rtw89: 8852b: rfk: add TSSI")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

bfc8e71ef6b7 wifi: rtw89: rtw8852b{t}: fix TSSI debug timestamps

---
https://github.com/pkshih/rtw.git


