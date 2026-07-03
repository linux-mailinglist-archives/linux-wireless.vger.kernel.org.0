Return-Path: <linux-wireless+bounces-38548-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CsdGGeosR2rsTwAAu9opvQ
	(envelope-from <linux-wireless+bounces-38548-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 05:30:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E2A6FE360
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 05:30:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=IuPWvvU0;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38548-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38548-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5236130063AE
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 03:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFE830567F;
	Fri,  3 Jul 2026 03:28:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E58F30566B
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 03:28:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783049308; cv=none; b=XD6XivZTgfr7a9kveJvlbQU5xhY3RNKtzWygd9b6GSvnJZB4x7RYFPuWLUnOr2QzH0lwqcuST6h4NULOCGM6izGC+hR825nFsy1yHDPzK+3ujt+S/X2hYJhY7V5/AYRZLFDh5lvQxujKrL/6DJnhOEhYWZ5I99Vl6u7AC1fK8LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783049308; c=relaxed/simple;
	bh=U0xL/cnvdN04xjRjALmZE+0rhjZ4anv2VlwT0ib3zv8=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=qcMkhiAEPK6DgrMM7HfXPl6h2nmBNEHJqo7hLVMDAQ7xcnOsFC1l1v7E5yneKjmdP+K3grkHDl9hvWGD8of0JBl7YxcVjiBjcKPNP8xRyQHS4OTXV3bKc3Lpm1E+se1jysEaJ959fyoKu5u5h+3LfvuWqW4dxuB4H3IMItQ3FrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IuPWvvU0; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6633SGJ502417722, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783049296; bh=WdqTn6MANZGTo6klshnrp2gKizUyhfCmSZYAKOAmQFA=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=IuPWvvU0PIvCX5Ry3mzq0WQNkUyuI13i6+3vZ+ooG37gXsQa0xsKEpNNMWQkhNNEe
	 BgDZ9bzYJuXHqF+G+kvh5DcAQyMgxWL+2rC1/dBx4gI1fd1KUWDquxEyZubfPjxxex
	 VplfKpxXHMzMqjWLNW4/4ibxQOAmnihbeQNYvlGBIej+WIGFr8yGPBplcxY6hSAchT
	 9zZiOR9Ih/pWqKd/X+ZY97Igk4Gh22roclVHMsyhIsy3gIYoe3V+/XlQpBcIUZiVG9
	 cW/8sFPq2PsrkchbOCUEyc2XZGL57Z22py6FXhrfSPDJ+ayIz1J5UIQ6aURu0ZP3pQ
	 bOE6W1cjSVdSg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6633SGJ502417722
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 11:28:16 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 11:28:16 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 11:28:16 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 11:28:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: Re: [PATCH rtw-next 01/10] wifi: rtw89: coex: force to exit Wi-Fi LPS while Bluetooth profile exist
In-Reply-To: <20260624033941.45918-2-pkshih@realtek.com>
References: <20260624033941.45918-1-pkshih@realtek.com> <20260624033941.45918-2-pkshih@realtek.com>
Message-ID: <8bd21c8c-39e8-4491-a653-6ab5fd644746@RTKEXHMBS05.realtek.com.tw>
Date: Fri, 3 Jul 2026 11:28:16 +0800
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-38548-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:email,realtek.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1E2A6FE360

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> Wi-Fi can not reach LPS leave threshold while Wi-Fi only throughput
> not good & Bluetooth share bandwidth. Add logic to let force leave
> Wi-Fi LPS while Bluetooth profile exist. Update COEX version to 9.0.1.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

10 patch(es) applied to rtw-next branch of rtw.git, thanks.

04e91bb237a4 wifi: rtw89: coex: force to exit Wi-Fi LPS while Bluetooth profile exist
ce9b6ca8f4ba wifi: rtw89: coex: offset current BT info to BT0 for dual BT configuration
6ca62c49a679 wifi: rtw89: coex: Move wifi related counters to wifi info
257cdb2c6e38 wifi: rtw89: coex: Extend bt_slot_req for dual MAC wifi
77e219a25501 wifi: rtw89: coex: Move Bluetooth related counters to BT info
195ce7889423 wifi: rtw89: coex: Refine third party module related coexistence
ebb69df34148 wifi: rtw89: coex: Add TX/RX RF parameter format version 9
600649fa9c10 wifi: rtw89: coex: Renaming drvinfo_type to drvinfo_ver
5c071a06bbba wifi: rtw89: coex: Add Wi-Fi firmware 0.35.94.1 support for RTL8922D
9a149cf572e9 wifi: rtw89: coex: Add RTL8922D chip string

---
https://github.com/pkshih/rtw.git


