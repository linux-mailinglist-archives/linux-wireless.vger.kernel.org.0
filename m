Return-Path: <linux-wireless+bounces-19798-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BA3A4FE01
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 12:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51FC1892374
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 11:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBAB23496F;
	Wed,  5 Mar 2025 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="mSGj+l0S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEAB235BE4
	for <linux-wireless@vger.kernel.org>; Wed,  5 Mar 2025 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175470; cv=none; b=S0uQajXH4YoIFEhbnejIzUIZcihrzs0czDgDUdf9TgkGDgf1Ln3Jo+SvE+yTJCqK3YUcgQxucqSqgFyfh6HF0tBUHT4it6TWKiJ6dJUaIMLoDwthb87YB8v4+1XAr+nK//7/Zf7wJDRtB8Gt4oFOTRTZYxEfhhL2jYeddiv+hlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175470; c=relaxed/simple;
	bh=OA4woIe61jRNgmXGnxWnv++fidm4uQ9SDK1HPUmIGZQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=AUH+MjQ3K/O6MXRefBWX6CMfUXOGeL/SDEppDL1oKmfwFlZEJLJsfaAegkWsogKFrH/3fMlb1KV8Vuz1phILPDyxuZGgaa8FFlak2Xf0nqNPHQ17LWgVWUS5tj0vZk97dgzUEeG5fYvUbMm5fEs+cjjnxfv2Rvtow1QtUnaHxBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=mSGj+l0S; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 525Bp4Oc91414979, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741175464; bh=OA4woIe61jRNgmXGnxWnv++fidm4uQ9SDK1HPUmIGZQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=mSGj+l0SlwBY4NtCmerqvJXrPFFsu5oc5PLgBWX9e+Vaue/ORNkYjQnUWFtajZWJN
	 5RM7qTzucs3Mp3IQ1NYV3m8VJ7yKNRz5QaBHm2HDh4nHjlkiXq2Ji2g/BYjP75tXNJ
	 +xeb7I7e6LrDLFayMnJlbeCP7AReRKUknxVmytsCSXc02LMd28ObKaJFvugzPbyDHk
	 9vVMv4iSwsJBNdoLZWqfq/XiymC1eLbHltO87zm00pDJnOjo50TOnX2AQK6iZR4XTt
	 IbOkd4ilDJweO2WnrowApw/MUTJ/wSNP9VCy73WD0bMrzIMiYrjjeTu7Z2cG8J+VNP
	 7iSViu4LTsnPw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 525Bp4Oc91414979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 5 Mar 2025 19:51:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 19:51:04 +0800
Received: from [127.0.1.1] (172.16.23.73) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 5 Mar
 2025 19:51:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>
Subject: Re: [PATCH rtw-next v2 1/4] wifi: rtw89: fw: use struct to fill role_maintain H2C command
In-Reply-To: <20250227131228.8457-2-pkshih@realtek.com>
References: <20250227131228.8457-1-pkshih@realtek.com> <20250227131228.8457-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <42a8972d-51ff-413a-8f91-3b9f0794b6a8@RTEXMBS04.realtek.com.tw>
Date: Wed, 5 Mar 2025 19:51:03 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> The role_maintain H2C command is to align operating mode of WiFi role,
> such as STA or AP modes, between driver and firmware.
> 
> Use a struct to fill fields of this H2C command.
> 
> Don't change logic at all.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patch(es) applied to rtw-next branch of rtw.git, thanks.

385eff211ee0 wifi: rtw89: fw: use struct to fill role_maintain H2C command
b521af1dcdc3 wifi: rtw89: fw: update role_maintain H2C command for roles operating on band 1
88b46320fc9d wifi: rtw89: fw: correct debug message format in rtw89_build_txpwr_trk_tbl_from_elm()
ad26d0dcb3bd wifi: rtw89: fw: don't reject firmware in blacklist to prevent breaking users

---
https://github.com/pkshih/rtw.git


