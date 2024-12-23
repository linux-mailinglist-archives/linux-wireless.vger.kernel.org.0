Return-Path: <linux-wireless+bounces-16729-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 770B69FAB5B
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 09:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE68D1659C4
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 08:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA9D1917E3;
	Mon, 23 Dec 2024 08:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="qR6S+kn9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAF618FC83
	for <linux-wireless@vger.kernel.org>; Mon, 23 Dec 2024 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734940804; cv=none; b=kI9PBMVhKxFMjwG+OkD7pUdtokE+Nb9DwCfVR2uzcdKUxAKhAct1yBc3vC9G/wc4CCdiz5SGOjgPHczbA6AENPwlJnfZSn+DqsiccXkmsv0ZToYViQvunp43aS6ARZXtLUbW/sTQhANyGom3tZJUEOgoYqqzKyAJ6aGUQ0zLMaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734940804; c=relaxed/simple;
	bh=xwc/7gYd42pij0B84W6I7g6f4s9jzWC7iIYWyE0xEJA=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=OMtkQr9OVr2+IWV1E92hC4zDcF90QudGWGlbZCc2PKnkvvgRSt180IC3H3C4A6FMpk2hC7BRQWJzChPnaZxAwDiL8HgJEf28fnR54j2fqOUFPThS3jXmp/d+C+4uvDXTOLjoCWjEZRaqwShKB+4xX48VCqP74MHEpNXsQKxxxgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=qR6S+kn9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BN7xxepF1478101, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1734940799; bh=xwc/7gYd42pij0B84W6I7g6f4s9jzWC7iIYWyE0xEJA=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=qR6S+kn9nyR01lt75zky8ehRBv6vhoSECjCXPqUCFZ8RZYTnMa2wip4Z3rtsDmKEP
	 ILQ09a10kZgT/Vg6/Yb/io/tILrYhpYt7DWiCkDvIr6iKMitDU5AFFEOJq4I/O9wYV
	 OpTjZN6MDAJff/PEpJ9FzfhyEGnXZcHGDKewIGFCBrnnRPFs2ZHJzdA7tkAjDREA8H
	 CKUddA52/RPENFbSpIUKKuNr6TEWLwvaPkGhWfS+ngrWCjAAIhoBk1/yrUISyoiaMx
	 FfnlkaAbuxc26guwspzmiCXdN3ut08ehEZrUasC9F03CsJMFZUhB/lvBLF3MMi3J2g
	 0zAYfcVW6y7Xw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BN7xxepF1478101
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 15:59:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Dec 2024 15:59:59 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 23 Dec
 2024 15:59:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH 1/2] wifi: rtw88: 8812a: Support RFE type 2
In-Reply-To: <2917c7fc-6d88-4007-b6a6-9130bd1991e5@gmail.com>
References: <2917c7fc-6d88-4007-b6a6-9130bd1991e5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <5f71e94e-1f21-4afa-804e-496a1fabb29a@RTEXMBS04.realtek.com.tw>
Date: Mon, 23 Dec 2024 15:59:58 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> RF front end type 2 exists in the wild and can be treated like types
> 0 and 1.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

59ab27a9f20f wifi: rtw88: 8812a: Support RFE type 2
74a72c367573 wifi: rtw88: 8821a/8812a: Set ptct_efuse_size to 0

---
https://github.com/pkshih/rtw.git


