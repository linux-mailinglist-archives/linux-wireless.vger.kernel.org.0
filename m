Return-Path: <linux-wireless+bounces-35560-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOJSBXae8WnxiwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35560-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:00:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A018748F989
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6AD7030090A9
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 06:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F1F276058;
	Wed, 29 Apr 2026 06:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="AJ0MYki4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CB2240611
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 06:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777442418; cv=none; b=Pn8/OKl2ov2ZV8U2l/WBAvoZ3SvDP1aOhavP0GwDILbt1p/3XrPd8eVMk1OvXupx8/7tLMm8RpAy4gajpMOkOjTMZCTEvbItWOGKXKjNEE5UC8fQy2oWAlvavrm3QowG6PAsabzUhUHGcLpR/1+D2DVohWC9PWgaYTQrB7Gu0RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777442418; c=relaxed/simple;
	bh=e8t4ZoyQxEv6eqoS1vFcRD3U/F6TKxQ80w1+IC4SwLQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=pWwx5HTv8eIFb01G7L4DmfL8g04ZCpw5JcG/zL6J8A9HHc7kc7ipG9wKRvatPNEdlOpTXrQl7/b8L6ICHemHlrcZZkt64DgSTRlWqZfdjhc8DMjDJWM8But2NT+D0oj54P9NN/cYFXPKUEqALoMS3sSR4ZzcYNbSbPwi37xGJMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=AJ0MYki4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63T5xxdC71043194, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777442400; bh=27YwqYIkUN3XvR7C7DpjLS8G9fcZiwukHgmrsP+GgaM=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=AJ0MYki4T5hwZ0+bpDnA3D85fOGlZHl92PpDSAV5LEep5/bNMy9APy8KPpq+7Yb8d
	 pdzUxia19bwN0zQpT7n04u+UPV2wMnGpANgytFRO7JNeiRvrSF84Savmj3efSOPPsw
	 uW+BlIx1gDfspuMFN4KKLC3ZJUwOoTfX3gGpF2FEJmVX410tMAozmSDBjSMSsfAm6l
	 Ffg3Zy0du+zwxtE5QZ730gBVN0RreewrTzYsXKjK6gOhHDgpcHDBZM/Hfgk/Lq+7v7
	 hVusxlU+y3EphA9Bau5mfAlst8Q+kpWTDxFhtQPdtxT7qzke56cggQmp2q4rxrH0vT
	 IoopJJp976AvQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63T5xxdC71043194
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 13:59:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 14:00:00 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 14:00:00 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 29 Apr 2026 13:59:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>,
        <art1310@proton.me>
Subject: Re: [PATCH rtw-next] wifi: rtl8xxxu: Detect the maximum supported channel width
In-Reply-To: <092f18cd-f3a6-4e3b-b0de-1cb23615e86b@gmail.com>
References: <092f18cd-f3a6-4e3b-b0de-1cb23615e86b@gmail.com>
Message-ID: <85489709-decf-40ed-a7b7-bafeec0259bc@RTKEXHMBS03.realtek.com.tw>
Date: Wed, 29 Apr 2026 13:59:59 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: A018748F989
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35560-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,proton.me];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,RTKEXHMBS03.realtek.com.tw:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.996];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Some devices malfunction when connected to a network with 40 MHz channel
> width, because they don't support that.
> 
> RTL8188FU, RTL8192FU, and RTL8710BU (RTL8188GU) have a way to signal
> this (and some other capabilities) to the driver. Get this information
> from the hardware and advertise 40 MHz support only when the hardware
> can handle it. We assume the other chips can always handle it.
> 
> RTL8710BU needs a different way to retrieve this information, which will
> be implemented some other time.
> 
> Fixes: dbf9b7bb0edf ("wifi: rtl8xxxu: Enable 40 MHz width by default")
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221394
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

Failed to apply patch:

  error: sha1 information is lacking or useless (drivers/net/wireless/realtek/rtl8xxxu/8188e.c).
  error: could not build fake ancestor
  Patch failed at 0001 wifi: rtl8xxxu: Detect the maximum supported channel width

Set patchset state to Changes Requested

[rtw-next] wifi: rtl8xxxu: Detect the maximum supported channel width

---
https://github.com/pkshih/rtw.git


