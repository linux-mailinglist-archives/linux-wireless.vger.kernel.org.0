Return-Path: <linux-wireless+bounces-31055-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGx2MymbcWmdKAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31055-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 04:36:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABB5615F6
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 04:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 298E73E893A
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 03:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66724329E76;
	Thu, 22 Jan 2026 03:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="T4Pp/Xdu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB152EBDFA
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 03:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052689; cv=none; b=BjXvuME39du9KyALig7AmKuDB/HR0c4Qx1RfJcqUTjfTtKHHqK3Vgh+Y2VekxyotBreqPgKYAigffHH1Yb3ZK0xWpSr9pFSUdEYw6+aqc58C2VKH+gBYh1cPovjwLml4J1VjRu/9MhfAH3zGjq4GTLR0Q3FY+/Fx+8HXu3vC+sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052689; c=relaxed/simple;
	bh=B+VfbE/asJidRtLlGaRoh8tKFxJE3CtAPBo+4W5Mx0c=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=o/d6qr+TaE27bwTmlqCvMGWaAiH6LtDcT6JUHWVVddYbYgVb+j76CY7mrc9qleMX3kp93vupVLxRAGYHV7yM6keSyO1IGXkijFcO3RnYXuSyN8UkQWhZ5ag9tnUam85tTizX0nZ/9XeIE5AY2+neuAKaeRZtOlFS8yrGbu1s7ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=T4Pp/Xdu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60M3VOYG0272276, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769052684; bh=jgjMjYl+zeu+Tmjl7UGEtVrrD015dXd1Id9Ll7LqoyI=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=T4Pp/XduGUKI56+ibZJ0NTVZD36RjvbdbWn9zxRSu+o/XdNUm8tE6cyAkovZSucPs
	 CqBRbbG3JJLQjt/YTzhq4Qenz5Lxx3xu5XJ7WVke+zBXjalVP6BSZC+wrx98IQSx+I
	 C2aBBtqbBXespgC7emFeOUyhXESMIeQgoYaqYqJqhmeIeLdZRKLM2EH2jfLFFiOZBO
	 en4ByhEB5ZGJeMErapvAC2dKmWPPqDQr8bQto7iBQxjN/YClW3kxq13upWzYPiTR7U
	 KraCQ5kQwZPbiB9/ZWcguKexIkY6HQj/G33gqpzREbZp4pCeW3SQLbu40CdKxgIPXM
	 cRtUmSx8nP96w==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60M3VOYG0272276
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 11:31:24 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 22 Jan 2026 11:31:24 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 22 Jan 2026 11:31:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next 1/9] wifi: rtw89: phy: add chip_ops to calculate RX gain from efuse to support PS mode
In-Reply-To: <20260117044157.2392958-2-pkshih@realtek.com>
References: <20260117044157.2392958-1-pkshih@realtek.com> <20260117044157.2392958-2-pkshih@realtek.com>
Message-ID: <5815a77c-3042-4da4-8f08-72fe4bae512b@RTKEXHMBS03.realtek.com.tw>
Date: Thu, 22 Jan 2026 11:31:24 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31055-lists,linux-wireless=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[realtek.com,none];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5ABB5615F6
X-Rspamd-Action: no action

Ping-Ke Shih <pkshih@realtek.com> wrote:

> In PS mode, it needs to restore RX gain settings while waking up. Add to
> get RX gain values from chip specific ops, and pass these data to firmware
> when going to enter PS mode.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

9 patch(es) applied to rtw-next branch of rtw.git, thanks.

32f6bf1872cb wifi: rtw89: phy: add chip_ops to calculate RX gain from efuse to support PS mode
496a0752fe50 wifi: rtw89: phy: handle C2H event for PS mode report
20380a039ddd wifi: rtw89: phy: add H2C command to send detail RX gain and link parameters for PS mode
bcd23ebfef1c wifi: rtw89: phy: update edcca log parsing for RTL8922D
4809013c088c wifi: rtw89: phy: add firmware element of digital TX power compensation
5fe702e4b2cd wifi: rtw89: phy: update TSSI flow for RTL8922D
9cc1a84c53d4 wifi: rtw89: mac: clear DTOP disable excluding CID7090 variant for RTL8922D
1945c83dc5ce wifi: rtw89: mac: set force MBA duration to 0
8da7e88682d5 wifi: rtw89: 8922a: add digital compensation for 2GHz

---
https://github.com/pkshih/rtw.git


