Return-Path: <linux-wireless+bounces-28879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE20C555D4
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 02:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD8F3B66C7
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 01:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B168229AB11;
	Thu, 13 Nov 2025 01:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="wMaIEhAD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476E113AF2
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 01:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998487; cv=none; b=qE3Aqd3vffuVtvs5RFSJVFxYY5V625SFRK9h5q8GOH/9+UL7iSd+W7kz4Fw2i3YQGjJuNAh9+VhQxh5yozcAP6mhABbi3LGG1Ffz/iEcru1QKykCoo3SRHjWi50FhDYUr6+B61rrgiQHUZBelZ9pQckb0ybKgTlC6dvDjycpvVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998487; c=relaxed/simple;
	bh=yk+fqIAYalCyqkppMQPM6CV+7QJu4TUu6kll5IvfYPE=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=gYToN7JhXVU+lg3hs2XoxyaO2Oww1wWMAYj+QdZoUfoxUOtWiRfeSMJS5jjvDfy3AVHqW077U6RQCUdzSuOD2KRUMRFM5ukFMi3XzDfUSx2rBSi/ND9vm3xgO0JbQPGVX255mCqhog6akHc7f8so/fLPx5rNcJ5ZauMxXQtCICo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=wMaIEhAD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AD1m1Hu92722620, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762998481; bh=0DdMOpfeCVdJIwiSzrjU7ghzSHWcrzpHwj+5k6LYemo=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=wMaIEhADV+Okjr6kqVQ1pmftTPoophmwLFaOTYFr2y6lf5BSi77rzbaEhAEPxSVBw
	 94x00s/Jwz3Mk5g2au4xSdpe+onOzTmUjMzkKH7nvNIXVCV43zWzu5EAG19dXKu7rz
	 sphFsxgZIy1QnmBjXXK9XcK5luMZzRqEN7UMAEim2T9lQZHJIpvBBfEp6ClCu1qnHL
	 uNJ4fp663ZJduWjO7Yip9pq3GuFT2gGg9YgpkIjAaZe59qxqDn2zQriMSXxlgcKLZj
	 Mej/26j6XikZBlpi6PTC1bPKFiB3RJHUlEJmxyX73M4f/sWLDGXJLkTT3QXaJ3kAMM
	 jCPsJQshr9TmQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AD1m1Hu92722620
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 09:48:01 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 13 Nov 2025 09:48:01 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 13 Nov 2025 09:48:00 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Thu, 13 Nov 2025 09:48:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: Re: [PATCH v2 rtw-next 1/8] wifi: rtw89: pci: add to read PCI configuration space from common code
In-Reply-To: <20251111022452.28093-2-pkshih@realtek.com>
References: <20251111022452.28093-1-pkshih@realtek.com> <20251111022452.28093-2-pkshih@realtek.com>
Message-ID: <813bc97d-fa27-4534-9a32-0bfd7c18739e@RTKEXHMBS04.realtek.com.tw>
Date: Thu, 13 Nov 2025 09:48:00 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Normally only access PCI device in pci.c. However for debug purpose,
> a set of registers predefined in firmware element including PCI
> configuration space should be read for diagnosis.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patch(es) applied to rtw-next branch of rtw.git, thanks.

dae8d7d63b74 wifi: rtw89: pci: add to read PCI configuration space from common code
de19cc7def5a wifi: rtw89: fw: parse firmware element of DIAG_MAC
7bf433c6767f wifi: rtw89: debug: add parser to diagnose along DIAG_MAC fw element
b37fb77d4530 wifi: rtw89: 8852c: add compensation of thermal value from efuse calibration
1dd7e743dd37 wifi: rtw89: phy: fix out-of-bounds access in rtw89_phy_read_txpwr_limit()
e96abe4fd7cd wifi: rtw89: consider data rate/bandwidth/GI for injected packets
d9204e99b696 wifi: rtw89: do RF calibration once setting channel when running pure monitor mode
7465c0a91278 wifi: rtw89: configure RX antenna if chips can support

---
https://github.com/pkshih/rtw.git


