Return-Path: <linux-wireless+bounces-33278-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD81Bjeet2l/TgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33278-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 07:07:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F05F294F7D
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 07:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 148A9300A755
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 06:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76466346A15;
	Mon, 16 Mar 2026 06:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="OECqDiid"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C16D221F0C;
	Mon, 16 Mar 2026 06:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773641268; cv=none; b=hMmaFxfE7MHeCboTf90Fm8n3Yjfu4PLD/tV0mmAOePNoO1RpkbUKfL+/JdzMTEmfIq8NH+fRFZx0OLpHbiXRh1wSiRf1S3vU83zT0y+ZoEIvT8hsEcSu8M9bgqjFguKAT6IUaFnDNBiQpK7Iukv7fYS3kLzGPHYtUyHtX5KpqrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773641268; c=relaxed/simple;
	bh=lDduGvEqLo0dfSOUZAKT5zAs/eID8rpytofvzP63ZzI=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=kepej5ZLbELjmNX2muatAW0IAeGOtfX/wIIh/gUB0tHkEWt1Vc1GPbFpFw+uXCPBG9K4+nO+kTB99D4AGmS0exw3EQervjdaUL/DJ7Yp8rLRhbW5odSEaoSR9q7L9ZBEFbVfD037acSEp3AH3eL1pMP3Z5n4oEh2sz0UxptDCqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=OECqDiid; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62G67fZ721342135, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773641261; bh=5rsNug6DJ/biLK14OLA2ISRCopF1JZ1FCyfTiXDZ100=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=OECqDiid8Zu1r8P/N9883vXvZdWOs6UjMP6WERfGBZmJxgZq62wYAOzggJ7bwFYl4
	 VCcBqByDYOkmfatlHq0JghIya+wctGCkGXtETyyxDOk0IMfg7As+9HfRtneGjGRo7M
	 IU8XKlsuiBTZ3HfZZ3A1gXLV4YsYxkLPttJTVL/Ara0mX6D8JJcT1qjV/za33Dggun
	 ktI+fXGbYATszjnuksEfBa5lk+kvBjS83tMZTDSF5NsRFGY9xpdNAuIKmIfCbdFBE2
	 /anRDp/Y165eY55pnJ4zyYejTnV8uGuwonBz4g/X9SCU/sxpiUyrrAmZAA2L3trs5l
	 Qa9lzKkwy+LBw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62G67fZ721342135
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 14:07:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Mar 2026 14:07:41 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 16 Mar 2026 14:07:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johan Hovold <johan@kernel.org>, <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, <linux-kernel@vger.kernel.org>,
        Johan
 Hovold <johan@kernel.org>
Subject: Re: [PATCH RESEND] wifi: rtlwifi: usb: drop redundant device reference
In-Reply-To: <20260309083336.16397-1-johan@kernel.org>
References: <20260309083336.16397-1-johan@kernel.org>
Message-ID: <7ba2d33c-6f0a-46ec-bded-0b8d237b0553@RTKEXHMBS06.realtek.com.tw>
Date: Mon, 16 Mar 2026 14:07:36 +0800
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
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33278-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,RTKEXHMBS06.realtek.com.tw:mid,realtek.com:dkim]
X-Rspamd-Queue-Id: 6F05F294F7D
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

fc25b384fc0b wifi: rtlwifi: usb: drop redundant device reference

---
https://github.com/pkshih/rtw.git


