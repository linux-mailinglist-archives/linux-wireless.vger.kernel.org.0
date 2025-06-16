Return-Path: <linux-wireless+bounces-24123-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B770EADA7D2
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 07:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D8216BB1F
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 05:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45CE7262B;
	Mon, 16 Jun 2025 05:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="wyDsnzJ+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15362E11CF
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 05:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750052999; cv=none; b=QOlxiRzjCjN6DfcweAFu0DhpSjmosGq2X4pbMgaPc2p2YkmrOPlI7+e8/nnOgNbrSoeqaUbbG1D9QrdKvFVVn9sgycLCallKjRdqHzjbkTK+RPobtxq8esPjSFuKSEj+jdNH29SrIoEwVE+EefonbJl2LR8zvlaKaont73ZN0og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750052999; c=relaxed/simple;
	bh=/jZK1I9QaTvg3V4BrWU9X9E6Rj/MMYH4v9S/oTJcV9U=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=cILJIOOVF4dzrkyKNpOAXHo7rY+J4ZbaKT6bX6g5cLjilYKQB09eSNoajXROIYheBK1PbMYEKJKEqutgcR/QSf9mNDe4CdFLV62UDKHjcxMHGtqYpPJG9WGpXS70KNDe3u+QrR/QFCycG+Nypu1lSOBDPF3f2eX6jAkeY/fTNLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=wyDsnzJ+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G5nqJqB4157267, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750052992; bh=VIB0S1CTrivlsMOXq6J7/qzQuaTn9BJNeTQBEqgNtoM=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=wyDsnzJ+YnQcof51PSz8w6rdPYG0fKaZCa1RWDsXiEZQEGchtoWp98ZbOf0AtIYO+
	 yHtWgw48jTdpJE4s9L+9ZZlprWNVfhymRxv997HsHig3flsJgAkp1m0pp4yn6He0J9
	 AS+MeNs/3iW65XOs8nPUtEfsE6VyP7mUpOHa4k927zlxBkJGs2rqUedPi9tfmDOLXf
	 qhss8rqsA5ZYk0buVYLox3kg2rW4tZ06+K9q8iNQaN9UZWSIdUkgZiAAPef7m0gani
	 c45vQmVWqNkKuczt5tH1eJjroCafn/LftsHkMPsHQzKuNtWYw0e8YRMop8hohU6mt4
	 xwh8IuqeYW/7g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G5nqJqB4157267
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 13:49:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 13:48:12 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Jun
 2025 13:48:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next 01/12] wifi: rtw89: extend HW scan of WiFi 6 chips for extra OP chan when concurrency
In-Reply-To: <20250610130034.14692-2-pkshih@realtek.com>
References: <20250610130034.14692-1-pkshih@realtek.com> <20250610130034.14692-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <928d7eab-03e9-4ba9-9790-c04a3a310849@RTEXMBS04.realtek.com.tw>
Date: Mon, 16 Jun 2025 13:48:12 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> HW scan flow has considered the timing when to get back op for the scanning
> interface. But, when concurrency, there are two interfaces with connection.
> The OP channel of another one was not back originally. It then easily lead
> to connection loss when scanning during concurrency. So, HW scan flow is
> extended to deal with second OP channel. And, H2C command is also extended
> to fill second MAC ID.
> 
> The changes mentioned above are done for WiFi 6 chips first. HW scan has
> different handling architectures including FW and driver on WiFi 7 chips.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

12 patch(es) applied to rtw-next branch of rtw.git, thanks.

dbaf5c3aa952 wifi: rtw89: extend HW scan of WiFi 6 chips for extra OP chan when concurrency
519defe4e8c8 wifi: rtw89: mcc: update format of RF notify MCC H2C command
f70fe6eab088 wifi: rtw89: mcc: correct frequency when MCC
95ee7464d374 wifi: rtw89: mcc: adjust beacon filter when MCC and detect connection
182c7ff8b87e wifi: rtw89: mcc: stop TX during MCC prepare
47a498b84f01 wifi: rtw89: TX nulldata 0 after scan complete
62784eae8784 wifi: rtw89: mcc: adjust TX nulldata early time from 3ms to 7ms
8bb1c30769b2 wifi: rtw89: mcc: enlarge scan time of GC when GO in MCC
12af7fcea837 wifi: rtw89: mcc: clear normal flow NoA when MCC start
b3cf6f392dc9 wifi: rtw89: mcc: use anchor pattern when bcn offset less than min of tob
b470b8951983 wifi: rtw89: mcc: enlarge TX retry count when GC auth
3db8563bac6c wifi: rtw89: scan abort when assign/unassign_vif

---
https://github.com/pkshih/rtw.git


