Return-Path: <linux-wireless+bounces-30720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBE8D165B8
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 03:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66ABA30206AD
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 02:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA08D1E5205;
	Tue, 13 Jan 2026 02:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="LGRZfLnz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3832717B50F
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 02:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768272499; cv=none; b=CLGQgYsw9dIGmvVIABGRaZVPLNpbB80i0f2SlCiUYmu9E9IP4C+e8Qa5ArLzE7GLHJzpBjnwXYfJncaJASufek8/FlT5YnDQX4JHlTv/FPjIPVMX130AG0bBRIkAUozhPYf4Rp74yWfSLYpEoB3NLlA1IoSkfmNdBCtNj4SFQx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768272499; c=relaxed/simple;
	bh=HGqp1vmnQnHAxExf6pYq0ly1WTjYSg2Xk0JiIXrpNUk=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=vFgrVuSec1mWGquUTNEtarTgkICkm84B6mGEisKXmhfuP1JTVFiq5x9MuF/S9mRTo5MMLbrf+firKXB8E/37cw4syOqZ55aYo7C6uG/XqGe4uw583hTeM2070Wb9N3edJhVGJTRuqPSTttBrUl5OHHtN61+g04urnBhye87pge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=LGRZfLnz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60D2mEeaD2162353, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768272494; bh=E4bjfNOTr3ctsazCRWx6nuv96aLIIe1HbsllrAfFjRo=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=LGRZfLnz6xhBhb73cVvb/0Mmxyfb2AA/EYwOn8b36SK0knCzxd0rzQahdViPtKMUC
	 r4vrwDsbw1UWrRfxyVSpc+CLerp+hVhBhhsD+dKapdd+Eq1Woo20Z7k34N8XUc2uaM
	 2aKy49KBE6a08U8TMmce7Tyo/ckfgzCB15M8+LMka1/dFWCWXNKsJGhH3miBIFT1nm
	 3vb1K/mDGDKOwixwLdXu9LJsbwgx00zdxkWPzPVax5r0B9zBEaH3CPiCEYrng2XPiB
	 gHmDGSOvyvELtnLbckiAg+V965SaZXdsKtc8twLjVg40QJHrGwnKo5zhebUBtf8sMD
	 ZcQ7ELWY3L4Fg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60D2mEeaD2162353
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 10:48:14 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 13 Jan 2026 10:48:14 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 13 Jan 2026 10:48:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>, <linux-wireless@vger.kernel.org>,
        <pkshih@realtek.com>, <rtl8821cerfe2@gmail.com>
CC: <usbwifi2024@gmail.com>, <zenmchen@gmail.com>
Subject: Re: [PATCH rtw-next] wifi: rtw89: Add support for MSI AX1800 Nano (GUAX18N)
In-Reply-To: <20260112004358.5516-1-zenmchen@gmail.com>
References: <20260112004358.5516-1-zenmchen@gmail.com>
Message-ID: <dc843cf4-c2d0-43a0-943b-4db6cbd52dd2@RTKEXHMBS03.realtek.com.tw>
Date: Tue, 13 Jan 2026 10:48:09 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zenm Chen <zenmchen@gmail.com> wrote:

> Add the ID 0db0:f0c8 to the table to support an additional RTL8832BU
> adapter: MSI AX1800 Nano (GUAX18N).
> 
> Compile tested only.
> 
> Link: https://github.com/morrownr/rtl8852bu-20250826/pull/2
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

3116f287b81f wifi: rtw89: Add support for MSI AX1800 Nano (GUAX18N)

---
https://github.com/pkshih/rtw.git


