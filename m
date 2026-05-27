Return-Path: <linux-wireless+bounces-36989-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNxVJYyuFmpHoQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36989-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 10:42:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7405E141C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 10:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77C643005ABD
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 08:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798C43DDDB4;
	Wed, 27 May 2026 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="j7j4FF7S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722CE377009
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871369; cv=none; b=HADA7sN+XCg/4pIg1cWw0geBJqsbZ1YyIzxCP9SzSG+P1kLKh51vKaXVbWCqYCVowtWKXpYBXhnirUg7L6oxRd1ZXvOOCugsu+J2Epj3f+92iqk3DlUWmZEmkOwjFePE1nNN3K9LnfKSdWG38+4JZf94bB9RfRbia31TIPgyw90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871369; c=relaxed/simple;
	bh=lMDiVgf8SvYgqZNRXkEmSHTAzApnpJnoWjORk68lEIc=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=CBhEuFZb2CwUlwGBiI1HF/HLcayhHKv/gIjz+8gk/HV76+J/WVPNaeFjw7TwPKtscmjVzEAyCZj1aRB15lgkAHpPNMN/91O8p7u/qV2uqUllov1lvsJYFtDEDVXgYzqILGNSWgPwy/UDfviXqaQfVLMiO+CKCP2bnAm4gxTcVDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=j7j4FF7S; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64R8gidK72301470, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779871365; bh=/0nkl9RXAyLx3nHY57tX+z9Pv1/aB/TSVpER3u+CSfQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=j7j4FF7ShN/RtMb2WDbOiV1LDDbaiCUxADD/6fBw+5zicW/YqWFeI+b7blYxfFUZF
	 Onp797JG9epSvAQlbs2uVmOVkyss47y/1a4EN2LoHjgvLv/jSKqB0+neZTRGUjIX8k
	 PHkg8qiEAlReVZECe/p/6ZNxp/4NFojRprJlBPlqonW2zZ5bMikPY+C32tJfw00A0s
	 hd5Nlt7TLcCisPImEwrmpiwX6z4PqWw2ueEDN/OrOHBqnZr99hconDw5lN5Pflf9On
	 usBf5s7q5XzNrRqQ1VdpAH9CawBjiXE4XLcKfVIVCLaqziKhF66ZWFk1oL2/RdR525
	 fnm9CaRcax+Uw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64R8gidK72301470
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 16:42:44 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 May 2026 16:42:43 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 27 May 2026 16:42:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next 1/7] wifi: rtw89: fw: load TX power track element according to AID
In-Reply-To: <20260520123823.1792954-2-pkshih@realtek.com>
References: <20260520123823.1792954-1-pkshih@realtek.com> <20260520123823.1792954-2-pkshih@realtek.com>
Message-ID: <18293035-af4c-4b87-abf6-10bd462dd4d0@RTKEXHMBS05.realtek.com.tw>
Date: Wed, 27 May 2026 16:42:43 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36989-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5E7405E141C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> RF parameters has different TX power track table for different AID.
> FW elements may include multiple TX power track tables for different
> AID. So, load the corresponding one.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patch(es) applied to rtw-next branch of rtw.git, thanks.

f50cf5f5d6a3 wifi: rtw89: fw: load TX power track element according to AID
57efc7b096a6 wifi: rtw89: 8922d: refactor digital power compensation to support new format
c77a155c96d7 wifi: rtw89: 8922d: support new digital power compensation format
89ab7535e428 wifi: rtw89: fw: load TX compensation element by RFE type
ed438b312d07 wifi: rtw89: Wi-Fi 7 configure TX power limit for large MRU
a153f9ce94e6 wifi: rtw89: debug: show large MRU in txpwr_table dbgfs
756abe2ebe3e wifi: rtw89: 8922d: configure TX shape settings

---
https://github.com/pkshih/rtw.git


