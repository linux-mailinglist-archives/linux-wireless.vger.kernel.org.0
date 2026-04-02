Return-Path: <linux-wireless+bounces-34296-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGHzDR7bzWmliQYAu9opvQ
	(envelope-from <linux-wireless+bounces-34296-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 04:57:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCBC382E41
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 04:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 591D430858ED
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2026 02:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977AB23BD17;
	Thu,  2 Apr 2026 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="glI1qLQ7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2A42E266C
	for <linux-wireless@vger.kernel.org>; Thu,  2 Apr 2026 02:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098480; cv=none; b=r1siG/htemwjuv7rQMMieJJt79gyG6Wpcgw86kCuttj7YAtZsJVhkRmDp7S52H0KLvjcO1Fk1ccqvzXGcnoSf/25v+6jAg1RN7lET4HPh4nk+Wtn/7OhZyf8iaObjhuDUxfrASghInVXg3LDzfGmSTyyXLqBqscT/OgDBTF31IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098480; c=relaxed/simple;
	bh=Q20LF5q/YOYxGN1GDPsteqVDIpf+czcMaZeyEUIws2w=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=TskRhmLnUfukqZxU8JvieR28xP39DBdpqHchJ/4wdUPVZuuBSKq0VL0t+qfytkeAPJmDbpGTBWzKmlYtfZrmZxQrWy9BN0PxZ/lx2HvbwVzYEIc5NSYNjchqgoPJZmiyfxS278SPpxfSLR3DWGbsWUmq3pCRXx5US6IxIB3s6Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=glI1qLQ7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6322sZq952292343, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775098475; bh=Chh8XRaW1i++aWNNoUvMXcEO8WAScHwDR3YQGDSunCs=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=glI1qLQ76sn33+Ic6XEWOEVCQxet4KyZAwyPPFC9SgWnbfVXzEYjQuyLoLHh8RoCu
	 ruY3vZZNx+N8PkkWRJh4T6TK5UUZg+0qOUu1qPUc1gzcbWOW+W5mCYYbsfFO3+IWp0
	 A19IaAHor+tcjqy1tDjIosneaZ3kq+FpZgf6gs6F8IQvIu/LBXysDDpS7KOPlV3Ivd
	 XaBkaJsazgf4oFtVD9iTFYTXiR3Ym75f6pGVfZVPkBy+ksTZP2+youGFojAODTD8zk
	 4Hvl3YAFlJRJNE1vk7CYxeVcEZDJsYEOUkkpJE6WXl2ImffbFugdvlXLn2DPAKJlPV
	 6N3fYCQW5KaFA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 6322sZq952292343
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 10:54:35 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 2 Apr 2026 10:54:34 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 2 Apr 2026 10:54:25 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 2 Apr 2026 10:54:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next v2] wifi: rtw89: Fill fw_version member of struct wiphy
In-Reply-To: <a46ed12c-387c-4063-849c-c6457bf97810@gmail.com>
References: <a46ed12c-387c-4063-849c-c6457bf97810@gmail.com>
Message-ID: <abeb7832-fac8-4a5c-901b-dacd296f91bb@RTKEXHMBS05.realtek.com.tw>
Date: Thu, 2 Apr 2026 10:54:25 +0800
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34296-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,RTKEXHMBS05.realtek.com.tw:mid,realtek.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BCCBC382E41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Let userspace tools like lshw show the firmware version by filling the
> fw_version member of struct wiphy.
> 
> Before:
> 
> configuration: broadcast=yes driver=rtw89_8852au
> driverversion=6.19.6-arch1-1 firmware=N/A link=no multicast=yes
> wireless=IEEE 802.11
> 
> After:
> 
> configuration: broadcast=yes driver=rtw89_8852au
> driverversion=6.19.6-arch1-1 firmware=0.13.36.2 link=no multicast=yes
> wireless=IEEE 802.11
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

c2ca7b9d27f8 wifi: rtw89: Fill fw_version member of struct wiphy

---
https://github.com/pkshih/rtw.git


