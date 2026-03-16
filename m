Return-Path: <linux-wireless+bounces-33276-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIclI4edt2l/TgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33276-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 07:04:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F35294F1A
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 07:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E72A2300DD7D
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 06:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130FD346FA5;
	Mon, 16 Mar 2026 06:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="uODYgy4m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA6F221F0C;
	Mon, 16 Mar 2026 06:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773641092; cv=none; b=QHTF0RE6j5O2rdRdFKGkx8sYh10wd5KQpG8GSYRu/wuMNU/kBNT3UjB60T0pZRMStRWc9I32/bZPXaAqAAfmjCQZlfC3wWmnG8iYPjikk+D5UyTmsdXUSv22cMoAVrOe8j04gaj1D/l8qQcyGxzmE8qttfaBfQ/q7S/3y4G1qK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773641092; c=relaxed/simple;
	bh=thJYf0ve0iD4l9nBj5Ef1bLaO45vGe3Kdf1N7GGwYsw=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=gn3E4kOKPImc/Qc+3IW7S7wQQMQAaiuD5k0mxZAh2ZTP+ixowDu+lxDKt5V3VqeTSfw7Du3DAoOSjaU0gVEFd/5y1AZt/bI1FI450krQpOYY9DK+TiED6qcEnb4wNh/8Wsy8mfAVfRzpWTOrEEgm2y+9XpZpm6QFnhF09MwFtgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=uODYgy4m; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62G64ixH61340056, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773641084; bh=0XX6IbHYah5S57Wrh7NxhVflr0CbTvT/UsR2hexzbWA=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=uODYgy4m6lbzb46ZiYRpUh7AW3lXXCy7ciytPtQXoxtk07EWVQRa+USihPK1/HymH
	 nAHh7AgiEGYMFV3vMood/0wRBlnILJ5KkCHA26rkFgrY3sbE+3uqou9ew7i8iFUhOd
	 3bx8ATlI44p1Ak5U5DmCS0xKeP4YgBwKbbnjv80QAqKZS+yiyM3V4Ao1EekWE0nIw7
	 EFx7wbbZLRn5wjwHLeZyHSGEb+ed4EmHOO0imZ+O6treL2I58LxViFBrWlHX/AJ4fP
	 m+jJgSq45IitzteZe9TSPgked7xuwekd7REsiD1+SrL8DHfSvA/E2ySnyH3MmEjFMU
	 wsMFVLozcWmcw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62G64ixH61340056
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 14:04:44 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Mar 2026 14:04:42 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 16 Mar 2026 14:04:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johan Hovold <johan@kernel.org>, <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, <linux-kernel@vger.kernel.org>,
        Johan
 Hovold <johan@kernel.org>
Subject: Re: [PATCH] wifi: rtw89: drop redundant device reference
In-Reply-To: <20260306093206.21081-1-johan@kernel.org>
References: <20260306093206.21081-1-johan@kernel.org>
Message-ID: <da0d54d8-1d59-4138-a80f-63b97b1d525a@RTKEXHMBS06.realtek.com.tw>
Date: Mon, 16 Mar 2026 14:04:37 +0800
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33276-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1F35294F1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Johan Hovold <johan@kernel.org> wrote:

> Driver core holds a reference to the USB interface and its parent USB
> device while the interface is bound to a driver and there is no need to
> take additional references unless the structures are needed after
> disconnect.
> 
> Drop the redundant device reference to reduce cargo culting, make it
> easier to spot drivers where an extra reference is needed, and reduce
> the risk of memory leaks when drivers fail to release it.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

c2a21f35cea4 wifi: rtw89: drop redundant device reference

---
https://github.com/pkshih/rtw.git


