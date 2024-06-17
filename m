Return-Path: <linux-wireless+bounces-9041-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DC490A28D
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 04:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0CB72840B8
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 02:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD144176AC6;
	Mon, 17 Jun 2024 02:40:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CED6176ABF
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 02:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718592045; cv=none; b=PgWHjXbhyFdI1EtxUImo5CVMU3ELisv1ZLk4oddicYG1/52vOORM/iKUpLYc0T9Oj0ENkkOPXlVSHZF5UYF2KXoE+IRRM3dNkGL9uKhjA/5RtLLFIU3E8fvxJm8Et7AOiXKKHtqaaPnXja3ng8sis+8xwo1CkNAs3tc3i2W52cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718592045; c=relaxed/simple;
	bh=hCCvzVgwNwDi7v3667EETOi2sY9fOZ8p3Xg2kcg4Maw=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=JrATi0bBU45znzlirrws+LWodTGtesXXuBrTRA40+ZbzljrLDV7PvkisrhfeEUXEcGN5n0n/y13473pCUepii+1PNQJe33o4LeFD4LgdlNGOkec1wb50+J+jL+806o+j7BDLmFFPIYyop+YxSS+/vy/l8Y2CdiFIhG5q5BcY10c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45H2efZfB2604093, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45H2efZfB2604093
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 10:40:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 10:40:41 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 17 Jun
 2024 10:40:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] wifi: rtw89: pci: support 36-bit PCI DMA address
In-Reply-To: <20240611021901.26394-1-pkshih@realtek.com>
References: <20240611021901.26394-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <f7177335-884d-4961-81e4-229418f96e3f@RTEXMBS04.realtek.com.tw>
Date: Mon, 17 Jun 2024 10:40:40 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Modern platforms can install more than 4GB memory, so DMA address can
> larger than 32 bits. If a platform doesn't enable IOMMU, kernel needs extra
> works of swiotlb to help DMA that packets reside on memory over 4GB.
> 
> The DMA addressing capability of Realtek WiFi chips is 36 bits, so set
> LSB 4 bits of high 32-bit address to register and TX/RX descriptor, which
> below figure shows 3-level pointers in TX direction, and RX direction is
> similar but 2-level pointers only.
> 
>   +--------+
>   |        | register to head of TX BD
>   +---|----+
>       |       +---------+
>       +-----> |  TX BD  | (in memory)
>               +----|----+
>                    |        +---------+
>                    +------> |  TX WD  | (in memory)
>                             +----|----+
>                                  |        +--------+
>                                  +------> |   skb  |
>                                           +--------+
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

1fd4b3fe52ef wifi: rtw89: pci: support 36-bit PCI DMA address
94298477f81a wifi: rtw89: pci: fix RX tag race condition resulting in wrong RX length

---
https://github.com/pkshih/rtw.git


