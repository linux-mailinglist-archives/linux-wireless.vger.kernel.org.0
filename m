Return-Path: <linux-wireless+bounces-38885-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eG9rMDftUmoUVgMAu9opvQ
	(envelope-from <linux-wireless+bounces-38885-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 03:26:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FBA743625
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 03:26:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=QEwpHRix;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38885-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38885-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38ED030151F7
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 01:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C357A1C69D;
	Sun, 12 Jul 2026 01:26:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D1A18FC97
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 01:26:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783819572; cv=none; b=OKsd9Nw6YszR5WHy/xVl7J2/+ZL+/VANmuQlWYoLnPkZLP93DQFq3VQWk93d7jBSqVzlbOnWYewf5j1MKhtwVE3q9iddnIvXILlvOWyk/q/CJ6uUE8qXfClQJXcbVUB8B+kYqDZKo2NFQrvqGMpctj9J6qqwbZT3KonsbSFh3p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783819572; c=relaxed/simple;
	bh=l6wQsIz0S8JRa6gIkCC0HhAGr88xa+zc/obXZMWPqIY=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=P+fTzTvuJukTCwouePlWqnnpIpA6Ictx1MFm6c8NlX18ahCp4vSbd44IOsvGABHkb71BTkH///orYrXVYaNo37GNDrHZqDQ45llxGBfM0s/+PTTLgMUiDtM0AubgAOlFTP+0jdRp3daGZGGIaLd7XIF+nYZ25dVabE3BmlExovA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QEwpHRix; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66C1Q10k8483864, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783819561; bh=gr85vKEzRgAzSZlU8k3LZnnDxyQ9yQA5la2ZaWWvl2Y=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=QEwpHRixBHOc/0YaAs6KI3eQl4NF2BcCNdTdysXpwxhWotOjLa+gp+CmOPILg4qFn
	 hZ5m7/hk82B3x6NYClF+RiD9VDCQx1upNh2hkYBJRADyZ/2tgl0JvSE1qAoeXNDjli
	 TzYSb/B1RPh00bGPIMAmBQSJWUdM+fEXDsfCWJN8NJCvfeZC/VPWnOhUmrAcw18/z4
	 E2djUWEQlMBpZh5JjogXTDeAWxKA5QN08P/N9b24FQSOUFpz23Y02klw5XqEynLhNR
	 8JGyFV33g8+QLckwzExrKEV35X6gIt0HLt7lBOylCqgmqujwh3tlXAX64Ar1oM0FM2
	 5cGHe1CMofwdw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66C1Q10k8483864
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 09:26:01 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 09:26:02 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 12 Jul 2026 09:26:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: Re: [PATCH rtw-next v2 1/9] wifi: rtw89: coex: Add Init info version 10
In-Reply-To: <20260706025445.18428-2-pkshih@realtek.com>
References: <20260706025445.18428-1-pkshih@realtek.com> <20260706025445.18428-2-pkshih@realtek.com>
Message-ID: <499475ec-2687-4403-9a13-4a45178ed717@RTKEXHMBS03.realtek.com.tw>
Date: Sun, 12 Jul 2026 09:26:02 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:ku920601@realtek.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-38885-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22FBA743625

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> The version 10 Init info add I/O offload type & variable Bluetooth
> function (EX: Zigbee/Thread...etc) into the structure definition.
> Firmware need to synchronize these information to do corresponding
> setting.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

9 patch(es) applied to rtw-next branch of rtw.git, thanks.

0b79ae7b09a8 wifi: rtw89: coex: Add Init info version 10
c595e0a0958c wifi: rtw89: coex: add rtw89_btc_init() entry for initialization once
2c5af470819b wifi: rtw89: coex: Update TDMA descriptor for dual MAC
2b497ba92abe wifi: rtw89: coex: Add Bluetooth binding for Bluetooth TX power setting
fe8f6ddb9095 wifi: rtw89: coex: Add Bluetooth binding for Bluetooth RX gain setting
564dd7a95047 wifi: rtw89: coex: Add WiFi/Bluetooth adapter binding info
3244261af915 wifi: rtw89: coex: Add TDMA binding for dual MAC
36f90091ee57 wifi: rtw89: coex: Update scoreboard related logic for dual Bluetooth
d01bcd34dd98 wifi: rtw89: coex: Add Co-RX logic

---
https://github.com/pkshih/rtw.git


