Return-Path: <linux-wireless+bounces-38729-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5luYLljFTGrdpQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38729-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:22:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3406C719AF3
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:22:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=vS2Mzopb;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38729-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38729-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDE4B31A5BAC
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 09:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515FD392C3C;
	Tue,  7 Jul 2026 09:12:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802DF392C39
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 09:11:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415521; cv=none; b=cZfU7WNVhGu7lTn3FNlzoPPNVGi4+cZBPcTuB+u4d5HkvjFA0ylBzjDUBhkV9kgJQEuk+fJT0xt3Epswqa3fzawGctUpaigmlc2kGEAi1w0HLT1rTia+3yjNzP5uDvoRW3kYPugT/uhdFqCHHjMyvhwNvnlETw6MR0yM1uzZrwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415521; c=relaxed/simple;
	bh=sNT7tXVh70+OSV6tqyqottgJwSnBBjxcsaNkMX0f4EY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AuIvZWsMxJf0sbNBvPdO1mRqqA4LChWicd7ZPrl2BsyeXI89Y0feXfhVpmmjrfxCnzNDLlKyjqjo8pRFRxN62U8cbVmiSOwu6AjERGD9ZFBrK95yAnVb+qPvVThtfiPVmRmY7JVwDMdhPKSbKGmF9u+dqnbfBJlWyAzrps/VtuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=vS2Mzopb; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6679BvYsA1359415, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783415517; bh=ueBvWC06y8ivF8842ua0w9kObETk8zriAES3/2nHIyM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=vS2MzopbCavf14LLApi+UjdXsrqd70vNCH2+7NklCDdgvVzYWFVfu8jj2z8IGslMB
	 vyk1IPZ5EhoFekoyiu4/+dFTtwtpgQ/xoCb87ARXf00/cQClFzJ6lBqmlEd3lbhvez
	 /NPiyzHEIqWh0rEEeuAce9oRgrbmYNMMNnbrjCiSnMBDdsI+wOqQy5FEX7L+4Zf6c5
	 smbYQMEFYPZF+yY+h7+ngaCCGMVGYUuUNniGZ/32LsMNtwMb2is/ggWe/uunS/K3nj
	 ahRPeXYvDDt4JnduQPfPr7SkxOKd1v+f14BooHhIZp2MXv+gNZE9DwliBCCF3gDCuU
	 kEVwVHJ19DbnQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6679BvYsA1359415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Tue, 7 Jul 2026 17:11:57 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Jul 2026 17:11:57 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Jul 2026 17:11:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <echuang@realtek.com>
Subject: [PATCH rtw-next 01/15] wifi: rtw89: 8922d: remove CCK bandwidth compensation
Date: Tue, 7 Jul 2026 17:10:42 +0800
Message-ID: <20260707091056.42771-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260707091056.42771-1-pkshih@realtek.com>
References: <20260707091056.42771-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38729-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:gary.chang@realtek.com,m:echuang@realtek.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3406C719AF3

From: Eric Huang <echuang@realtek.com>

Remove the 40MHz bandwidth compensation from CCK efuse gain calculation.
The design no longer requires the +3dB compensation for 40MHz channels.

Signed-off-by: Eric Huang <echuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index f78d6d46e65f..625f8d675f08 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -1634,10 +1634,6 @@ static void rtw8922d_calc_rx_gain_normal_cck(struct rtw89_dev *rtwdev,
 	s8 rx_gain_offset;
 
 	rx_gain_offset = -rtw8922d_get_rx_gain_by_chan(rtwdev, chan, path, true);
-
-	if (chan->band_width == RTW89_CHANNEL_WIDTH_40)
-		rx_gain_offset += (3 << 2); /* compensate RPL loss of 3dB */
-
 	calc->cck_mean_gain_bias = (rx_gain_offset & 0x3) << 1;
 	calc->cck_rpl_ofst = (rx_gain_offset >> 2) + gain->cck_rpl_base[phy_idx];
 }
-- 
2.25.1


