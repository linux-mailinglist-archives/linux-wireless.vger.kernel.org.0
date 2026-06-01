Return-Path: <linux-wireless+bounces-37235-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH/7DVoiHWq6VwkAu9opvQ
	(envelope-from <linux-wireless+bounces-37235-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 08:10:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78199619FC9
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 08:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D624300901A
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 06:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3901F23393F;
	Mon,  1 Jun 2026 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="sNZvXun4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0931A680A
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294231; cv=none; b=dOaFl25gBs+VaHrq2gljHh3qK4Q14u2aCSQDweLor6TXAa4AOOzSqgcr6CSPJyD0iFxoP/E5gSjoJEZzXSqDRKaoXLzGQqpalsoe4CvnTIQ2wqX+t661bsOp216jFCumqpBGwKqlCUt8xWiJ+Pdof+Kf/FccIFADgiwS/S8+D2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294231; c=relaxed/simple;
	bh=gpihQYm31/UX2RS6gwPzwY/FlxOUEp5C5Y/cc+qY2Eg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j17Zt9rhUuxR+uUcWWtFSAtZC+AxFxa4nQgHxJnu5yDF/YaOUagLyK0nNn1039A/aQkXf2ruPS5FZcZdwgFJOhqkC/YoV8WMcCTVWii0E1s++9HB1bOV/75tuODPZ6LopC3BJp9jYiRWGWvBCXZlM52/6Qivdnvp8xUUPJeQxVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=sNZvXun4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6516APhC41856545, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780294225; bh=gpihQYm31/UX2RS6gwPzwY/FlxOUEp5C5Y/cc+qY2Eg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=sNZvXun4CSW4fTYtojQB102S2YpBpEl6aNpn+ecSpoyLLdD3DL6WIcVtNV/UcsmkL
	 DEBK9uIqfEQeuEulPqoQboquC/x7ys+svai9Zr7zP9iggVr8wl1BzNKPMgANegf+RK
	 mP0TjCJWxM0etB7k5CwO0AGO+M9D5q49jIM85hy9m6amtMK5rcm3f4hpJDGd84v21o
	 xqigNwFUqJHN9tXSqLweY/bBmFaqbkXeBoYCTUg6B1NBKwAQgaYjzHacrOmtxpvl2j
	 fbHAGKXWJ2id38Au3ALlWA6uMmK/4CNo7GvOnfc5kwO53kfEz8yj014ImP801stQMp
	 KV33yF1vVf0Hw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6516APhC41856545
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 14:10:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Jun 2026 14:10:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Mon, 1 Jun 2026 14:10:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH rtw-next v2 1/5] wifi: rtw89: 8831bu: Add support for
 ELECOM WD{B,C}-X600DU2M-B
Thread-Topic: [PATCH rtw-next v2 1/5] wifi: rtw89: 8831bu: Add support for
 ELECOM WD{B,C}-X600DU2M-B
Thread-Index: AQHc8VVRJDaNI5ihOkeWm/uHaerVLrYpNLkA
Date: Mon, 1 Jun 2026 06:10:25 +0000
Message-ID: <4779f2efe03a44f9973e3ebd9c853331@realtek.com>
References: <20260531232914.4406-1-zenmchen@gmail.com>
In-Reply-To: <20260531232914.4406-1-zenmchen@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37235-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 78199619FC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Zenm Chen <zenmchen@gmail.com> wrote:
> Add the ids 056e:4027 and 056e:4028 into the device table to support
> ELECOM WD{B,C}-X600DU2M-B, two new 8831bu-based adapters.
>=20
> Compile tested only.
>=20
> Link: https://github.com/morrownr/rtw89/commit/9e2db2834b37c6adfc4b872a9e=
f56c927df22bea

As I saw surface of this Link ".../commit/...", I'd ask you to remove=20
the Link, because a github commit isn't so important to be a commit message=
.

Look deeper.... The Link's content (the comment part) is to indicate where
you got these USB devices ID, right?=20
If so, maybe you can just mention that you collected these ID from [1].

(change to this style instead of formal Link)
[1] https://github.com/morrownr/rtw89/commit/9e2db2834b37c6adfc4b872a9ef56c=
927df22bea

Then, if a reviewer wants to save himself time, he can just ignore the link=
.

Please apply it to this patchset. Thanks.

Ping-Ke


