Return-Path: <linux-wireless+bounces-35557-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNs4CLGb8WlfiwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35557-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 07:48:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C6D48F855
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 07:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D9DF3001FCC
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 05:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF4C2E5B2D;
	Wed, 29 Apr 2026 05:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="sYd+Pmow"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9034F405F7
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 05:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777441708; cv=none; b=vCHlbZwds8MZCACN0gG6MXijOzBRozepZ69IOV08bxh9vXXPT3LSld3oPWYSzX4wRcLBnP5GQ6W1DMsxbT/BihBUQ1rlXeyDy5TXh2rEUMbr8G45IvjCz/cmRC197fhs+SLBXfX+lDwxpWY4DElJ+sVDyJ8Oa19QecH6QiGnmcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777441708; c=relaxed/simple;
	bh=H5oEWEYj1xtdYZRlBkp5jimE8wwZe6RJiJ+SXtcGLVs=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=Dl6TfhkrA9izzh5aJFaDNK68lxaeJmpzNxYkJqj4h4Kwcsd2rHI84m/+xy4Kf6saDee7+I+O4GMRTuawDjbCzalDPxcovm2B+WTjZK41hyfNixzYQbhhv0p4HQc3JtKPrfMn1JxRlsIEdwpg+Eqlrf76PgQqxlZRm+DiK5HCPNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=sYd+Pmow; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63T5mO6i91021406, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777441704; bh=Z4xpx2Ymm3bx+Vkf/xtKUQkHJJJnSQ/xii6Pdavq4MM=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=sYd+PmowooDXvA2HOdcOf4hCN7itWVxPZtr5gplzmWT7duRETz/bYZNHrCLSIyrm1
	 mFnGtBhdJsNjWYxaR/8VZCta2ahTXVlLHcHkOThjnIDzh99skyd6ySYqdCj4WausKy
	 N/22VjJNboVFc7VZc581/aT6RprFK7WERWP7smh23XwmJtqMhPfM3OPHJTvBZONFOA
	 KQwVUikxOhNC7L3JzUJYnnwuVCEmpxorXUp21k0h1QEooHEgJliqi61FUg6kp0UXC5
	 MCI3t26eSpPaxRborGeSjTxbv+oa0cGIZKQ1cRvNrk5yMwHUzK1ByHAN59gIJ3iz6A
	 kVbXFDBZtoxkg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63T5mO6i91021406
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 13:48:24 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 13:48:25 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 13:48:24 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 29 Apr 2026 13:48:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <dian_syuan0116@realtek.com>
Subject: Re: [PATCH rtw-next 1/3] wifi: rtw89: pci: no need to wait CLK ready for RTL8922DE
In-Reply-To: <20260424072552.59220-2-pkshih@realtek.com>
References: <20260424072552.59220-1-pkshih@realtek.com> <20260424072552.59220-2-pkshih@realtek.com>
Message-ID: <e2be7ce5-f21d-476a-a644-dce777e04af5@RTKEXHMBS03.realtek.com.tw>
Date: Wed, 29 Apr 2026 13:48:24 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: A7C6D48F855
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35557-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[RTKEXHMBS03.realtek.com.tw:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The bit is to wait for CLK ready when entering PCIE L1SS. However, a
> certain host might not enable CLK for a situation, causing device state
> stuck and trigger PCIE SER. Unset this bit as default like earlier chips.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patch(es) applied to rtw-next branch of rtw.git, thanks.

329e9fff98f8 wifi: rtw89: pci: no need to wait CLK ready for RTL8922DE
1e53b826d5f8 wifi: rtw89: disable HTC field in AP mode
d1fba5522868 wifi: rtw89: disable CSI STBC for VHT 160MHz

---
https://github.com/pkshih/rtw.git


