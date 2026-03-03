Return-Path: <linux-wireless+bounces-32367-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIAtLqZGpmlyNQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32367-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 03:25:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E641E7FB8
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 03:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5819306CEC5
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 02:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C323750BC;
	Tue,  3 Mar 2026 02:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="vMhBgEiV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C548F30C34A
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 02:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772504736; cv=none; b=m+P7eSNnbaGCjlNKKGdaZvqo80t6pVyJnmZ8Da2FjYf3psOue3qsIGO7vIPeXs6sv3R5i21uCSnSkHlVYHd9jcBtfGBotulEuFsd3TVy3AO88YfZd+IyeaZsJNpAWJbLEmUYssvOntv/XCZfeKyHB6NGFC7pBs9IzNWPdlOUDnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772504736; c=relaxed/simple;
	bh=BL4/4mTTaYQ87HuhXxMVeodrFBJVpM4WYc8p+HVSeE0=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=UWL9cFX12Ih0uzz2l5tgnf5FVwpSGYokY3/EblVRRG7dEOe1mn8TBsaJh/CxTZMRKJi8SUStuxWHoozaDb3rR8vWjlIODa49kE2CoBjyW76swIM0mXmPkxK5F3YisTkyQjkNVfmtcdPP19h+87hKeExRW9j5IN6m75VupVfbZcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=vMhBgEiV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6232PWMY0212798, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1772504732; bh=2jL5VT2OiqeiglUcJzqGvw9xpiwyOwfd+wUH2cXPyKI=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=vMhBgEiVjpXZIFg3oZEUvn8B79ReELx3ve5XyTJOcSmU0Wm+nmwAx0nuEwSHaUQ96
	 D/Rh9p3N1wMm2ShvUlucPLnQpiyDcKOxZy588PaGVe4ne1BokPU/JYyewnf+3HA6e4
	 VLbtAuOByQO00gzjI9rI5pNSeHx77Buqx/YkGCaGEDAZ42aDkejgTe5mB7y2OrVrrm
	 zzqmTH048V+Q0xLPo/PKHaiVNN/zngD8X/R2pgOv7ARqotsZPAoLSPdzIyWjufK54y
	 jka9sf8SpfuEmWsq/a6UJvlAAegLbxpEiAJoLUtR7sv6AOONJp29KR4tuaFtVXiNat
	 bQYuxqN8J+jOg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6232PWMY0212798
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 3 Mar 2026 10:25:32 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 3 Mar 2026 10:25:32 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Mar 2026 10:25:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: Re: [PATCH rtw-next] wifi: rtw88: coex: Solve LE-HID lag & update coex version to 26020420
In-Reply-To: <20260213053445.19384-1-pkshih@realtek.com>
References: <20260213053445.19384-1-pkshih@realtek.com>
Message-ID: <c77c9210-be5d-4739-a3d1-23a06c0eeabe@RTKEXHMBS06.realtek.com.tw>
Date: Tue, 3 Mar 2026 10:25:32 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: C7E641E7FB8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32367-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email]
X-Rspamd-Action: no action

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> When Wi-Fi enters power save, the register value can not be read
> correctly. If mechanism take the wrong information to make decision,
> it will run with wrong parameters. It leads Bluetooth low-energy
> HID lag. Add logic to isolate the wrong register state.
> 
> BTCOEX Version: 26020420-2020
> Desired_BT_Coex_Ver: 0x20
> Desired_WL_FW_Ver: 9.9.X
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

c95323ea9dfb wifi: rtw88: coex: Solve LE-HID lag & update coex version to 26020420

---
https://github.com/pkshih/rtw.git


