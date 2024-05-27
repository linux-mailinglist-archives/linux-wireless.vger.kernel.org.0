Return-Path: <linux-wireless+bounces-8079-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2D98CFC45
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 10:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1C31C2182C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 08:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8776A008;
	Mon, 27 May 2024 08:57:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF8960DCF
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716800228; cv=none; b=QYyGs4NezM9H/zL9QZz4dbP+MLXMdd4/KLjb/irlPfoIbUq5eaC3EeQPQVsKZKbsvOtVdwTwizS7TV4j26mvJTMdoGcvyEHYBZbTSqKITxUIeK2PLRYlhnH+l9U3ltCNq5HktdV4GTx0ELuhxkBSVfJZ1GjOn/wM7D89Joiz0Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716800228; c=relaxed/simple;
	bh=9wQ2WXhFL5BbS2O81jyVX9tddT7WgV8agOYUpqFob80=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=Zig4DkABY/DLVso0xOlN8J4QaurpGeVCdCY+vtuohQIBZFxconG9VOL2lRhbuqXB8UouuHvbNulWlbjgxpUwbcPQkCEZQXBOsY+Zsupup1/cpJpQgH8EWnXUNdhPJshhb8UtfkcOGbrpBwjRvm+zHVUymyitZqQVbTohN0kmyuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44R8v3aE5962246, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44R8v3aE5962246
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:57:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 16:57:03 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 27 May
 2024 16:57:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] wifi: rtw89: fill STBC and LDPC capabilities to TX descriptor
In-Reply-To: <20240522023830.9798-1-pkshih@realtek.com>
References: <20240522023830.9798-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <0d385ded-9440-4f61-ace4-4dc56a7a8306@RTEXMBS04.realtek.com.tw>
Date: Mon, 27 May 2024 16:57:03 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Fill STBC and LDPC fields to get better performance when transmitting under
> noisy environment. Old chips like 8852AE use firmware command to enable
> these two capabilities, but newer chips must use TX descriptor.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

f12fc2065647 wifi: rtw89: fill STBC and LDPC capabilities to TX descriptor
85e02a0aee58 wifi: rtw89: add LDPC and STBC to rx_status and radiotap known fields for monitor mode

---
https://github.com/pkshih/rtw.git


