Return-Path: <linux-wireless+bounces-34310-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGuqAr8Bzmk/kQYAu9opvQ
	(envelope-from <linux-wireless+bounces-34310-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 07:42:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66377384154
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 07:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A018B305DD49
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2026 05:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EDD366569;
	Thu,  2 Apr 2026 05:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Apz1lHMD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DEC31F9BD
	for <linux-wireless@vger.kernel.org>; Thu,  2 Apr 2026 05:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775108349; cv=none; b=I2RJ1hLNOogHRe3Vt8UijmKxczMSHYElJ7M3WCUizOScjDrQoIl9Bfa5spuyu5YqWe8GVPOKTvGq4X+UNdVVwX46/+5eKgHNxhzvHr87uBXCFYpkyjpvBIIrWwdc2FyQ1xfrifKCkDkRIbf26mlwxfplWBpZKl44Q3VoNpH8z/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775108349; c=relaxed/simple;
	bh=BQIqy41XWczUr0bXb9p+kJBHJWTv2lxEvAd6iCyNEO8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tiM8EykbC9ANRelpaQKzHpQsEiGVbpwi0kuzHdMe8d7klZYsAUDz9XMcPWqHjwIErNiIb5QDrE3smIRkgSB5Wi+iKcIEGz22zNhKs9CrosGmxP8WzYEk2CK6CEnhbORP+VLBjg5pyLzostxgPPMc7IPb9FhASQv7Hr/AMxkox7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Apz1lHMD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6325cnYtB2528177, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775108329; bh=uXjKSZMW7AhqE0l7iitTob7KcKjLf7C9myGXVxJSZ7U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Apz1lHMD+jbRpuWFLNb5NUB77R+SzMZmbkdfr2UNHM7dKU+sTdq0rryqLXFZ7sEJr
	 OnQnuf/BmBq42e6giFNLk/KkpkbfLUYY6UqODBsOUaGvqWqo8xrZqaw6tjAiu6jnBN
	 lI34vGWIjlL4zbtNk1RH1Pqr/1hNRnwCDXq/Rml72uyIXZzCfF726boFXq8wjMi0/Z
	 PaaLBHvWif5GgE4IfvL5N9kfhWwhy26/jhETMezbKGvfGEGCZOG2OULhux8bvOrraS
	 Z8eUZkYbYe4hj/PbQOFEvUOGOluopY63IpnXUgMMkkqbSRPWvmsuDMDj6bncR9R/Jw
	 3nGl+FKyMoCLg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 6325cnYtB2528177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 13:38:49 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 2 Apr 2026 13:38:47 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 2 Apr 2026 13:38:46 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::3d92:67de:2cd4:b292]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::3d92:67de:2cd4:b292%10]) with mapi id
 15.02.1748.010; Thu, 2 Apr 2026 13:38:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Lucid Duck <lucid_duck@justthetip.ca>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "morrownr@gmail.com"
	<morrownr@gmail.com>
Subject: RE: [PATCH v6] wifi: rtw89: usb: fix TX flow control by tracking
 in-flight URBs
Thread-Topic: [PATCH v6] wifi: rtw89: usb: fix TX flow control by tracking
 in-flight URBs
Thread-Index: AQHcwmGE4Z2nGmA0OEKq1BvA711AAbXLQOiA
Date: Thu, 2 Apr 2026 05:38:46 +0000
Message-ID: <687060c7d52f4346b4075553f76d47a9@realtek.com>
References: <20260330025959.399018-1-lucid_duck@justthetip.ca>
 <20260402052216.207858-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260402052216.207858-1-lucid_duck@justthetip.ca>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34310-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,justthetip.ca:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 66377384154
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Lucid Duck <lucid_duck@justthetip.ca> wrote:
> rtw89_usb_ops_check_and_reclaim_tx_resource() returns a hardcoded
> placeholder value (42) instead of actual TX resource availability.
> This violates mac80211's flow control contract, preventing backpressure
> and causing uncontrolled URB accumulation under sustained TX load.
>=20
> Fix by adding per-channel atomic counters (tx_inflight[]) that track
> in-flight URBs. Increment before usb_submit_urb() with rollback on
> failure, decrement in the completion callback, and return the
> remaining capacity to mac80211. The firmware command channel (CH12)
> always returns 1 since it has its own flow control.
>=20
> The pre-increment pattern prevents a race where USB core completes the
> URB on another CPU before the submitting code increments the counter.
>=20
> 128 URBs per channel provides headroom for RTL8832CU at 160 MHz
> bandwidth. Tested on RTL8852AU (USB3 80 MHz) where 64 and 128 showed
> equivalent throughput, and on RTL8832AU where 128 sustained full
> throughput under 8-stream parallel load.
>=20
> Tested on D-Link DWA-X1850 (RTL8832AU), kernel 6.19.8, Fedora 43:
>=20
>                      Unpatched -> Patched (128 URBs)
>   USB3 5GHz UL:      844 -> 837 Mbps (no regression)
>   USB3 5GHz retx:    3 -> 0
>   USB3 2.4GHz UL:    162 -> 164 Mbps (no regression)
>   4-stream UL:       858 -> 826 Mbps (within variance)
>   8-stream UL:       872 -> 826 Mbps (within variance)
>   UDP flood:         0% loss (690K datagrams)
>   60-second soak:    855 Mbps, 0 retransmits
>=20
> Reported-by: morrownr <morrownr@gmail.com>

Can you share a reported link?



