Return-Path: <linux-wireless+bounces-34295-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8/yMBmbYzWmliQYAu9opvQ
	(envelope-from <linux-wireless+bounces-34295-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 04:45:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 382A9382CDD
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 04:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64EFB30034B4
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2026 02:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945C51DC985;
	Thu,  2 Apr 2026 02:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="R1nFMyUC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC05D3B7A8
	for <linux-wireless@vger.kernel.org>; Thu,  2 Apr 2026 02:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775097885; cv=none; b=EERyIvPlN57Mt7/snF1TTyMM80Z5PzMaVoE4sjNtPD6+YgnHYb/K74cNofCS3S/ozP6ZbAQKyir8wLGAq8t5EI97Pf3aSjs4jXXYj+xKYqNw11dockLv+1KX03CuhVdfSQ5myTaBwarhFUuVpkwVluosNckkNRH9ES8MGk9CnQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775097885; c=relaxed/simple;
	bh=x+GjPkBpNnxHAj/6PPrdSHmrS+IMay9okaSO+EmBeek=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=rsS9SCVB0F88g1esywzZsq5QpHXRPO7nyXV4M1euXQUGY/1LMhbIlyGQZ+CSzTo4rjehIOYyri6SZNEIzGDM3kJrQAQEBRw3rZilD6YgDwbTgdgqAlr2A14V3zH3AZ0JqYu5cbu57KzIAiTdDSFSuS8mtmJITcqdT7NG/c4io/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=R1nFMyUC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6322ie3xB2282471, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775097880; bh=MbtsNCqECce6XwQIOJ4coGNSBYe8fEfWdLdwSgxqtfk=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=R1nFMyUCBmaU8OfqWZE2TVoWOgexWf2nz3EGJEkT27PlYG0X0niVgnBbrhT72lAgP
	 SxzF6UI35wvxKuxo3AQs/IkFvIrZ0Gga5LkbxwC95JktD/lWzt4tiQibh0MDPexhpy
	 ezeW40GbArD+KMVOBjKreeluvq2KixV7tRdjNekF00VKWT3nVWpvYbTaXYZYqRGC0Y
	 U55Dq9yNZd1LNcKpKGzr1I+w0ogscDGrm/M+6PgZTzxJc0nZ+scE/pIUOqdQx0+Thj
	 cSTd/fIg3wOijlXwRgdaI9eN+6JmNxTlfVLRRPxIXPGC2lqVcz0uyeIEiRSr//Hn47
	 PCerN5oEWO2kA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 6322ie3xB2282471
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 10:44:40 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 2 Apr 2026 10:44:40 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 2 Apr 2026 10:44:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next v2] wifi: rtw88: Fill fw_version member of struct wiphy
In-Reply-To: <3701cce1-42c4-4382-9120-cd21012c1b21@gmail.com>
References: <3701cce1-42c4-4382-9120-cd21012c1b21@gmail.com>
Message-ID: <0ff20b21-f055-4852-9e44-a8aaa0e8280d@RTKEXHMBS05.realtek.com.tw>
Date: Thu, 2 Apr 2026 10:44:40 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34295-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 382A9382CDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Let userspace tools like lshw show the firmware version by filling the
> fw_version member of struct wiphy.
> 
> Before:
> 
> configuration: broadcast=yes driver=rtw88_8814au
> driverversion=6.19.6-arch1-1 firmware=N/A link=no multicast=yes
> wireless=IEEE 802.11
> 
> After:
> 
> configuration: broadcast=yes driver=rtw88_8814au
> driverversion=6.19.6-arch1-1 firmware=33.6.0 link=no multicast=yes
> wireless=IEEE 802.11
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

249716daa995 wifi: rtw88: Fill fw_version member of struct wiphy

---
https://github.com/pkshih/rtw.git


