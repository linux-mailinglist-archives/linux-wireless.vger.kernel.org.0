Return-Path: <linux-wireless+bounces-18269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 854E0A25171
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 03:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E319C162CF8
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 02:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2D82D05E;
	Mon,  3 Feb 2025 02:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="YqBlUBT4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C33315530C;
	Mon,  3 Feb 2025 02:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738550791; cv=none; b=Wry2PeobclWJdT/qJfcM/keXA5yd4NOfFsHbvWBpba7j6RjtH9oyQIiLHbJQ8mvzWZg5a3mNxmVl/OU8GoWFrINVQEG72NuiKWWKx352/eBYuJfkr7DEHahfOW7zW0lwaMNYKXdZeUQQRGp/0cVCnJXT/wiDCPjeQVKDYaTM9UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738550791; c=relaxed/simple;
	bh=xxF9UKEza+BTIJ9E9CrFAxc/E4/34oIM+6NoJW17eAc=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=uNbfyuqOLpc90/2FIkGCfNBqPF6yicKBju3CwXNy5v+5oQO/CrOOT/T04ey0iDif+2jTesyqT389YrV95aZn+/lwZkSSicAMS1lFWE9QI+I6LmrrqhA9TNzjdvrlzs8hxzmfM25BvYeAO6IGDAL6Po6xLAvtaCbkbbiLw/SQdtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=YqBlUBT4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5132kLqW5980742, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738550781; bh=xxF9UKEza+BTIJ9E9CrFAxc/E4/34oIM+6NoJW17eAc=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=YqBlUBT47GsSxWJZKy93avfCjhgCwYKYNVdZMS8YG3+XRel8Yf2YZYC6oqORuxeTg
	 aKLdmOprfLHVYzrImK7+czNvbclZH7NmkRGRO3C9Zj97/PU9L6WHnWC9Jq3hwyRkZC
	 iQjXzN/IMHM9yHjffsF5b7HxQ31K56kb0IAKs836tbh4jis2IL9r6PFJvMRyK1lsIM
	 4PAJfVJyDmodDul5vAec54dXmBSiZ9pnaUmVqenS1LtHncvnt3Q+sG6qycao3axuKH
	 nHz6OpICVFKrte1TLAA+hKGndvrH5GYxQrUvQnscYRD9s0QDlZa+5/oPfgoy7W242B
	 cDuJ9o+88wKTQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5132kLqW5980742
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 10:46:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Feb 2025 10:46:21 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 3 Feb
 2025 10:46:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Soeren Moch <smoch@web.de>, Kalle Valo <kvalo@kernel.org>
CC: Soeren Moch <smoch@web.de>, Jes Sorensen <Jes.Sorensen@gmail.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Ping-Ke
 Shih" <pkshih@realtek.com>
Subject: Re: [PATCH v2] wifi: rtl8xxxu: retry firmware download on error
In-Reply-To: <20250127194828.599379-1-smoch@web.de>
References: <20250127194828.599379-1-smoch@web.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <cab8c2d7-8844-44ae-8bae-181229c04d1f@RTEXMBS04.realtek.com.tw>
Date: Mon, 3 Feb 2025 10:46:21 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Soeren Moch <smoch@web.de> wrote:

> Occasionally there is an EPROTO error during firmware download.
> This error is converted to EAGAIN in the download function.
> But nobody tries again and so device probe fails.
> 
> Implement download retry to fix this.
> 
> This error was observed (and fix tested) on a tbs2910 board [1]
> with an embedded RTL8188EU (0bda:8179) device behind a USB hub.
> 
> [1] arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
> 
> Signed-off-by: Soeren Moch <smoch@web.de>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

3d3e28feca7a wifi: rtl8xxxu: retry firmware download on error

---
https://github.com/pkshih/rtw.git


