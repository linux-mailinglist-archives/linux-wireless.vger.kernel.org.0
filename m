Return-Path: <linux-wireless+bounces-19527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D48A475AA
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 07:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307B21885301
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 06:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864332E403;
	Thu, 27 Feb 2025 06:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GjSFNMHS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2FB1E835A
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 06:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740636028; cv=none; b=WfvLD3lG0Ako9d7VPOVNEuZlC49M9VVwkFo58z/DlzMr904XPYznjFz2HSxUpT01isVjVHrzYT9nTLFmDqgByhvtQ+w1amKetH+/LHO+oQV69/WMQyr/yoYC31q06oOH5cmnAHUXe/3aqWVU9UsJTabwKkO+gLcp04C8WvLmQvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740636028; c=relaxed/simple;
	bh=FCsVzAoE2EABN0dvDVvDFG7Jj3Au46+qo7ur8DIC17o=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=f9GSCTzQkXQB9Qj7DeaD5JBPaGaTzg84lAZN1LxdEYHaf3/64n2zPnBtpFT84EfaJPdyAeAXE6N8c4Fk9jDVG2jumuz4OSv8nqQTFcH4s8FoyN3YeeE5hzKSQPB0GDsAi3goUKBUpoHEDrH/rCWtG/cqAZNmvJHkKZwG0YluQw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GjSFNMHS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51R60NkZ41307865, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740636023; bh=FCsVzAoE2EABN0dvDVvDFG7Jj3Au46+qo7ur8DIC17o=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=GjSFNMHSGjXd4QHEgGwBLjbA8PN1Yh1YTs0cWKMKLcSbgzX9FYSqti+PNNIKVlgDL
	 iJs4i28eRyxbMWDEIp8UbpvinS807VggZ9MsoWb2OhhOsdd0VgQhletgjupYWnk5/M
	 dSPpARP7hebiXTP8oIL2aMP6zCIzCzE09yEx6ItZKfS27MTnvTFDA8wquL24iMNqDQ
	 czoJBmY8fD3hhU9qhi1Ca1HPbCP7JvOdIeL0Yx2TiEMt1wcpSMBSl7jRt41SXihr/q
	 AgzMA0zATtuK48MBqoSkvleQAHbPXa1gh87dvo4UqGR8/EDawPzmlvWAsYs22fqBEG
	 iAmS9PTvDP6/Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51R60NkZ41307865
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 14:00:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Feb 2025 14:00:23 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 27 Feb
 2025 14:00:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: Parse channel from IE to correct invalid hardware reports during scanning
In-Reply-To: <20250220064357.17962-1-pkshih@realtek.com>
References: <20250220064357.17962-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <316b46f8-a7fd-4766-b70a-b3a9eb51c962@RTEXMBS04.realtek.com.tw>
Date: Thu, 27 Feb 2025 14:00:23 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chih-Kang Chang <gary.chang@realtek.com>
> 
> For some packets, we could not get channel information from PPDU status.
> And this causes wrong frequencies being reported. Parse the channel
> information from IE if provided by AP to fix this.
> 
> Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

e16acf907a3c wifi: rtw89: Parse channel from IE to correct invalid hardware reports during scanning

---
https://github.com/pkshih/rtw.git


