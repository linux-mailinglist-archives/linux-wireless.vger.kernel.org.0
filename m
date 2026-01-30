Return-Path: <linux-wireless+bounces-31351-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lfTuBv1TfGnTLwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31351-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 07:47:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD20B7AFA
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 07:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 530743014869
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 06:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78873227EA8;
	Fri, 30 Jan 2026 06:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aGG61myu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A259321883E
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 06:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769755640; cv=none; b=a6Ega0wIY/h+Zc3PNNHoFybqU5OGE6A39QGVMWQke9Q4udWalFvpIcbSldjBDMz6N9nIxvloserZ/Vrtn4l+sNApegqpzFkNVuD88EAuJ1RXl677V/yCCll7sXnJ6NtrXppbG7I4iWo/fsqKw+0dy23YKaQg8g2e2PiOUGto7eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769755640; c=relaxed/simple;
	bh=t9IsKtEGcYUQtLWfFEcXCmpF7TRvkjAD0lWSqSYKmFI=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=umg65/YOq4RPjZtx3IVdF85okwR/3A1PEeFTQdeUGEYx6q1N63PNTonRzUnk6rXLR0o2cZevTnoWg70nHpAR/AcX7D6KRdijP0U79d+spCpJ3r03roXBm/VKZQ4t+xFvN/xV5NaHs9QOy7bafaJP0di6qN0eYfLpE6Tt16mgff8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aGG61myu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60U6lFuxD442049, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769755636; bh=4vV4QfhEcNA3JI94saEBv7+2Mc3sboaGOXhb2we9fhw=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=aGG61myuaWUfCJ5mlqCksxyi1K5CJoc69/ylbmEPzwf87V3zaTQ5uSLo2KQiy3Hkd
	 3pAeS6YOB4/vAPqSEiYnfZtpYFLGyzPWM6VkRxJpH0YuXF9SM8b5CV1Oo+CfNR/GER
	 gTRctD/TZyxXOlK9Xu75vOnzD9hdBV4/74SHqeQyZZTXMrI8tYhM9FeJO009n8rr6D
	 gCsTY7k9X5OFFAKKrf6lrtPfZgQOYBHEKu+fF/Ap0JIxHTmYnRE6OVibBuTnItEQvO
	 YWoQT2gSgSEY8hv34Rz41Th5ehQauruwy7c8vDrtYHrR4vBIUlEEWzbl5FdTIBH/SK
	 2MQiOsYDVichw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60U6lFuxD442049
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 14:47:15 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 30 Jan 2026 14:47:16 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 30 Jan 2026 14:47:15 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 30 Jan 2026 14:47:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next 1/6] wifi: rtw89: debug: rename mac/ctrl error to L0/L1 error
In-Reply-To: <20260127085036.44060-2-pkshih@realtek.com>
References: <20260127085036.44060-1-pkshih@realtek.com> <20260127085036.44060-2-pkshih@realtek.com>
Message-ID: <64d4ef3b-8d3b-432c-92e5-34a736f24010@RTKEXHMBS03.realtek.com.tw>
Date: Fri, 30 Jan 2026 14:47:15 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-31351-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7AD20B7AFA
X-Rspamd-Action: no action

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Sync Realtek terms on SER (system error recovery) simulation.
> 
> No logic is changed.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patch(es) applied to rtw-next branch of rtw.git, thanks.

9e1e967b4dbe wifi: rtw89: debug: rename mac/ctrl error to L0/L1 error
6792fcf6a691 wifi: rtw89: debug: tweak Wi-Fi 7 SER L0/L1 simulation methods
734bb61782d4 wifi: rtw89: wow: disable interrupt before swapping FW for 8922D
2258f2770e19 wifi: rtw89: mac: set MU group membership and position to registers
af1e82232b98 wifi: rtw89: pci: restore LDO setting after device resume
4c1552473acf wifi: rtw89: pci: warn if SPS OCP happens for RTL8922DE

---
https://github.com/pkshih/rtw.git


