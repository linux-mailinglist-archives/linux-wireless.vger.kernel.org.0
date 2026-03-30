Return-Path: <linux-wireless+bounces-34137-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bNoHFbXdyWnG3AUAu9opvQ
	(envelope-from <linux-wireless+bounces-34137-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 04:19:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF60354BC2
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 04:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34832300B9C6
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 02:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802F6391831;
	Mon, 30 Mar 2026 02:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="lQOT9UWK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302DD390984
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774837170; cv=none; b=XQu9Ov4FzbaMyAYR5M0zdtW42CfNfk5tA/oxw9s3Fag0QL7LpGMLGN/Ybp2LY8Rbvi1cPoztSFlv2bjvOjArNAnr80MIgplNbY++gWaE1qQkBdCawey0XDrASjGmb07vzcLAXmExXwMkmG2GF8R1mhqUXqvkh4uWgVkFA/zV2w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774837170; c=relaxed/simple;
	bh=/NeQx2Yo0gD5kn9zcH18npzF2YbqOHPb7zuJGfUkH5A=;
	h=From:To:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=LUvJyt1XkgT7TWXNj3bodIAouS/S63JrphtujPoYobgQP7KQtWV5AxyEAYlB76QXkG1GbVztV2v4Pm1TPipnbQISM3BDXvYbiaYTp6HE+XvpY0Nkz6o4Ups70Yi4Lwt8XeCRPQdwp0aeEXkCi3iLsiYkIiOd84caWahQ9eHQI3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=lQOT9UWK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U2JPzW4135315, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774837167; bh=CCRG61G2w8Qx10/J1s0RrzbWbAoHi9dqocPY7fzmCbA=;
	h=From:To:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=lQOT9UWK4rLJrz4pv7lGMq8I1fE6GpNtUkSe6nJU2hozUb6xt7CfF1pEzOjX2M7Al
	 m4dkV4P77kwVLb7nmggB4ZLXLZelITtEvlXNbgcXGEDzEawkEhUIQ9HNszzyqHKsUv
	 jfVOvHet4JaEMRP3PW/sjyBX2F1iyJG/JIddBQCzz4GwpiKfpaxYwxE/gKVoFDr84U
	 /dNa5xWl084CVDFGUDgICRtLkB6+34Ft2oRy8ZTL630XOKDQhG0btYEJQv2uScmNyF
	 okDoP4RgK1FxsRb4APmS99aPg81Yg5masHHQ9pbhxWp9A42lZ8V6+KMD55S7XI6OKh
	 1SYxrFs/WyunA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U2JPzW4135315
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 10:19:27 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 10:19:07 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Mar 2026 10:19:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 rtw-next 1/7] wifi: rtw89: 8922d: add definition of quota, registers and efuse block
In-Reply-To: <20260324062049.52266-2-pkshih@realtek.com>
References: <20260324062049.52266-1-pkshih@realtek.com> <20260324062049.52266-2-pkshih@realtek.com>
Message-ID: <307d2340-4098-4f53-b8a2-ff06c99fc3a4@RTKEXHMBS04.realtek.com.tw>
Date: Mon, 30 Mar 2026 10:19:07 +0800
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34137-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[RTKEXHMBS04.realtek.com.tw:mid,realtek.com:dkim,realtek.com:email]
X-Rspamd-Queue-Id: 9AF60354BC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The quota is used to configure memory size for TX/RX, and the definition
> of registers includes H2C command, C2H event, WoWLAN reason, IMR of CMAC
> and DMAC, ACK rate selector, RF kill GPIO, and BB functions of dynamic
> initial gain and EDCCA. The layout of efuse block is to define logic
> map of efuse, such as MAC address and RF calibration values.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patch(es) applied to rtw-next branch of rtw.git, thanks.

e51df91b894a wifi: rtw89: 8922d: add definition of quota, registers and efuse block
bbbde3d0fbe1 wifi: rtw89: 8922d: add power on/off functions
199e4235d33f wifi: rtw89: 8922d: define efuse map and read necessary fields
5b04b8049828 wifi: rtw89: 8922d: read and configure RF by calibration data from efuse physical map
56f48df95e7a wifi: rtw89: 8922d: add set channel of MAC part
521f3a653dbe wifi: rtw89: 8922d: add set channel of BB part
1b622535a577 wifi: rtw89: 8922d: add set channel of RF part

---
https://github.com/pkshih/rtw.git


