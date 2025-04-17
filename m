Return-Path: <linux-wireless+bounces-21625-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F805A912EF
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 07:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D737A2F40
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 05:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909821DE2C7;
	Thu, 17 Apr 2025 05:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Qyad389l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6E41D89FA;
	Thu, 17 Apr 2025 05:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744868604; cv=none; b=lNsaHjDK2UlYhgFqaQM47b685kKwd8QxgYTXNv3rplFyD5xi9bndheWkq94FTTAZyWRn6JXh/KcN56ejyx6Wuc1e2Qneye+wK5r68QkPsQrsHYCjNhtiIBSUXMPgSO2TQVArNhmWnuvSQVXcuSTrwK3gBCfXGyMYE20rK7Jy5EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744868604; c=relaxed/simple;
	bh=TRJ6twXpH4iMA/qz2kvp2gzUPDHSYQfKQDAI4sKb+RQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=bzdYtQz1tGxTj4LvQWLEphxTCx76rtKV93/1bPtxgK0n0XyEwfkpYQBO1s+Pjo0z56CZj57PWgZOX61pfjsyOTTcDNlQ777XWG5xDSaVmXTTSEjA4mj/85kFwAomp8qurIF82r0ixkXcGzjMn8kF1Vwm0DgONB8H67iw0jKyGmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Qyad389l; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53H5hA7k9368765, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744868591; bh=TRJ6twXpH4iMA/qz2kvp2gzUPDHSYQfKQDAI4sKb+RQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=Qyad389lKUlD9IR8KRNlNNPqV1Wg4el7w+PdtcXKuJ+kZ6cldUOaMxK0oo31Ia0lQ
	 ARs/llOSWsY/GDkNvg8DAZMD74omrRXWlceIYtoeLIYDfVc7A/hgJxdKfplF46ZSqZ
	 3qCcnXNUMB+O6qmiT9lVT2bLQh/gpfWbVib91VGQmZnhLpssrpRp4IVebn1AAJZ80P
	 Zln95Dm1XvfvfcAc1oqrQoBzc4T/1UbdfKXg4AhSyazoFM/ejUyZFIEsdzuqpoGSR2
	 l+VYji3+87upntfRtk7lRJIvZHtazyGCuPZz8carSn4kPUJNI4xqOZvyFUohMPbof+
	 fsQy6h7zfPbkg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53H5hA7k9368765
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 13:43:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Apr 2025 13:43:11 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 17 Apr
 2025 13:43:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zhen XIN <zhen.xin@nokia-sbell.com>, <linux-wireless@vger.kernel.org>
CC: <pkshih@realtek.com>, <linux-kernel@vger.kernel.org>,
        <martin.blumenstingl@googlemail.com>,
        Zhen XIN <zhen.xin@nokia-sbell.com>
Subject: Re: [PATCH -v2 2/2] wifi: rtw88: sdio: map mgmt frames to queue TX_DESC_QSEL_MGMT
In-Reply-To: <20250410154217.1849977-3-zhen.xin@nokia-sbell.com>
References: <20250410154217.1849977-1-zhen.xin@nokia-sbell.com> <20250410154217.1849977-3-zhen.xin@nokia-sbell.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <b638cfa9-b2eb-4feb-bb06-b3fd8c2fb497@RTEXMBS04.realtek.com.tw>
Date: Thu, 17 Apr 2025 13:43:09 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Zhen XIN <zhen.xin@nokia-sbell.com> wrote:

> Rtw88-sdio do not work in AP mode due to the lack of tx status report for
> management frames.
> 
> Map the management frames to queue TX_DESC_QSEL_MGMT, which enables the
> chip to generate TX reports for these frames
> 
> Tested-on: rtl8723ds
> 
> Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
> Signed-off-by: Zhen XIN <zhen.xin@nokia-sbell.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

b2effcdc2379 wifi: rtw88: sdio: map mgmt frames to queue TX_DESC_QSEL_MGMT
fc5f5a0ec463 wifi: rtw88: sdio: call rtw_sdio_indicate_tx_status unconditionally

---
https://github.com/pkshih/rtw.git


