Return-Path: <linux-wireless+bounces-29222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F3887C77641
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 06:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC9DC4E1108
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 05:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E51E20102B;
	Fri, 21 Nov 2025 05:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="wbdX+MBR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1E11C5D59
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 05:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703373; cv=none; b=lkjCZuUoXP3sMr9BbhMdQxnWEg6cYadhcZZPkg+mWcfRqZbNGtSgIVMk9vs9DK8kg2giM8QqvaKMOtLU+3ewfMF+uvozFbHtHGwm4AmGlccXGUu9+gzB5mRCPbO/cedke8A24jnYL/6l59SlvVrI9sxuH0cmXOK/4jvQwNT/HZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703373; c=relaxed/simple;
	bh=BDOJVV0x4mAZhP+tu444eNkX9WP6R73IMVmLMRHgPTM=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=TZwHXI0RUurNCOK4zajhyzOQb5d9WlH7MzxuuBZIY5WyXEkqzl0UTEiWDQzy/FpCmTQCXWqXUwO3Y276OasgM19WrRyti9W33cZ7ZA4X2SwO3D4hvCBpao+0M66cRXUkIM2bXIH7JUIdwS2C1zqf5y+Dm8DX2R0jVvbtyB5923M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=wbdX+MBR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AL5a6Tk92986956, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763703366; bh=mKliGlpOiSczLI3VxR9kGuP7lsyCnwi3ORaz33SPfAk=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=wbdX+MBRt9A4MGSZT+fxsgb45I94ZSQdzI4oKtR+m4sKtuBAk2rJNOhNddeIHS3B9
	 mh4H5muIAtTrBsXMwbLMKEh/QThK9NmD/McJZFo0dzDdZKT56OQBpqDi46OYLExf6o
	 NfmaCwWuQ29JMJPMb3v8+vMc8f+W7dDDTmBndLEoRHwMrnXAV9DiH2uLKVQqdVEgPw
	 wNsWaZYQ36tGuxk1phleAetj6tH9XJuBe3cCn8yRlX6b4uEBFJx2B5MKeSWXigxR4X
	 qchiLAkf2g91MYQA/BUn31hmgGPL4XNxGMrHLT9TxxZI34+aeidtvjholwZxMUOvQQ
	 Y6l50laNJ2IiQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AL5a6Tk92986956
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 13:36:06 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 21 Nov 2025 13:36:06 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 21 Nov 2025 13:36:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH rtw-next v2 1/5] wifi: rtl8xxxu: Fix HT40 channel config for RTL8192CU, RTL8723AU
In-Reply-To: <1f46571d-855b-43e1-8bfc-abacceb96043@gmail.com>
References: <c54a69c8-9c7a-4249-ac9c-8d6544483ae9@gmail.com> <1f46571d-855b-43e1-8bfc-abacceb96043@gmail.com>
Message-ID: <8b23bcfd-9331-4f91-8ebb-c9bb278e9e54@RTKEXHMBS03.realtek.com.tw>
Date: Fri, 21 Nov 2025 13:36:06 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Flip the response rate subchannel. It was backwards, causing low
> speeds when using 40 MHz channel width. "iw dev ... station dump"
> showed a low RX rate, 11M or less.
> 
> Also fix the channel width field of RF6052_REG_MODE_AG.
> 
> Tested only with RTL8192CU, but these settings are identical for
> RTL8723AU.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

5 patch(es) applied to rtw-next branch of rtw.git, thanks.

5511ba3de434 wifi: rtl8xxxu: Fix HT40 channel config for RTL8192CU, RTL8723AU
bdb4c850c368 wifi: rtl8xxxu: Make RTL8192CU, RTL8723AU TX with 40 MHz width
fc44314a377a wifi: rtl8xxxu: Fix the 40 MHz subchannel for RTL8192EU, RTL8723BU
41a21d0ff3a0 wifi: rtl8xxxu: Fix RX channel width reported by RTL8192FU
dbf9b7bb0edf wifi: rtl8xxxu: Enable 40 MHz width by default

---
https://github.com/pkshih/rtw.git


