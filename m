Return-Path: <linux-wireless+bounces-37324-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QG1kK7bTH2oTqgAAu9opvQ
	(envelope-from <linux-wireless+bounces-37324-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 09:11:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E17C635090
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 09:11:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=duU8i+qv;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37324-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37324-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7518E30AE544
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 07:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DD23FFAD6;
	Wed,  3 Jun 2026 06:59:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0C73FF8A9;
	Wed,  3 Jun 2026 06:59:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469953; cv=none; b=DoXdOgVOQEG7KTATY2GxL8xvD5quFWZ3sKSkj+ixAPIrBfgODtcAPjgliiyX0B0sKy6aX/zd+0q3asOopEWgEcosgKx9Z7C971PujXFVA8UO0kOPgCpij5JUOqt3MYWvZtWOHe4rZDiwW8k4m3TvanG48UmLxFyYoegTEVE3vgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469953; c=relaxed/simple;
	bh=RnDtmd5Wej+T2ViyisX3FeAMZc9agicby/TSjZYpi9U=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=GeU/0WF70EgLrjAcejhusKuiGfxsy1DQLFOdUH70nyu6IUk81bG30qyVlzs4jLl6LoeQXTLE4T5O4USJ9ZUI6mDrqGAEPpJMiD0fpV3IgPqu6pfVbD5V6Tp3qehen88LszVwqm+OybmY7k2Zx026VeLaEFk/U1AFkfwqcxpKEmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=duU8i+qv; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6536x5NR13643690, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780469945; bh=7EtFDqL5gw9w3gvUwe433RbCcFvFiYsatKrWuBd7PgM=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=duU8i+qvOroEdn3uSyfe35UsgAWp9ngq/GQeW6IbNtUCje6unn7dtWG+Kzf0Nit5C
	 y+DgIFP+m2ddwgpLFJGbkDOxMdgfZ+9G/MY/vMRSM3oGXUhwPYJCgFlPctbEY4IbBw
	 v2OpbTNXif6ZwNEQ0UrO9mvKR2x26QXdAUz/D38L2jYeuDnA7P89mAeSWxPw5a8Xfg
	 umguA9CR+mTbBCTs3LoiUSZDIIQdf49MRUAP6KZYVJFOZD8aDCa0fVdvoYAjv4lmOP
	 Z/WhtQUjV+Z62UKBExAFrXPj5vg5+g9367Krx/yMd/5IGqUF3WdG7ekCGLVvJ18cIP
	 jZZeKddoljzxg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6536x5NR13643690
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Jun 2026 14:59:05 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Jun 2026 14:59:06 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 3 Jun 2026 14:59:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <driver-core@lists.linux.dev>, <johannes@sipsolutions.net>,
	<mh_chen@realtek.com>, <wenjie.tsai@realtek.com>,
	<charlesl@valvesoftware.com>, <sabae@valvesoftware.com>
Subject: Re: [PATCH v3 rtw-next 1/2] wifi: rtw89: add dev_id_quirks to driver_info for per-device quirk control
In-Reply-To: <20260529075032.16807-2-pkshih@realtek.com>
References: <20260529075032.16807-1-pkshih@realtek.com> <20260529075032.16807-2-pkshih@realtek.com>
Message-ID: <3dd30036-d5ea-4cdb-84b4-b94b2d12d1ef@RTKEXHMBS05.realtek.com.tw>
Date: Wed, 3 Jun 2026 14:59:06 +0800
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
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-37324-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:driver-core@lists.linux.dev,m:johannes@sipsolutions.net,m:mh_chen@realtek.com,m:wenjie.tsai@realtek.com,m:charlesl@valvesoftware.com,m:sabae@valvesoftware.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,RTKEXHMBS05.realtek.com.tw:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E17C635090

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Johnson Tsai <wenjie.tsai@realtek.com>
> 
> Add a dev_id_quirks field to rtw89_driver_info so that per-device
> (VID/PID) quirks can be expressed independently of chip-level
> default_quirks. Apply the bitmap in rtw89_alloc_ieee80211_hw() so
> both USB and PCI probes benefit automatically.
> 
> All existing driver_info structs initialize dev_id_quirks to 0;
> no behavior change.
> 
> Signed-off-by: Johnson Tsai <wenjie.tsai@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

7554f6602a80 wifi: rtw89: add dev_id_quirks to driver_info for per-device quirk control
384cc80f3097 wifi: rtw89: usb: add serial_number and uuid sysfs attributes for 0x28de:0x2432

---
https://github.com/pkshih/rtw.git


