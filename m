Return-Path: <linux-wireless+bounces-26885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6C5B3D786
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 05:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 471897A2829
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 03:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A801A9F92;
	Mon,  1 Sep 2025 03:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="rExFWrMr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D662852F99;
	Mon,  1 Sep 2025 03:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756697979; cv=none; b=rrf2n+UzFRnxir4JdorkF0cWOGOQHZ5z+jncbLKgyXGjnBp5WBVGRjAZdmdqZVCVqZdMzhFQ9zoxZEG/twm1Unh8/fFtdnYdiF0xRWwnfv7hUcf6GcWpwwW7EpI9w9Nms8jnbfP5tRJKpoGJoeKayhAxBJXPjmViTC9uHvnxZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756697979; c=relaxed/simple;
	bh=9zvhhq6mGtyjf273DudPZWYw9S6AS11m5OI4UuqAMv0=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=nKRPtCKKaSogFVUC5YvSGJ9RunjDGIv/cJr8YE8853dhcEGLvDm8O6SXrnzIliR50apDP+Tqk+sXat3YA3DbyLe3QJfyR+NqiIGOifxbJeUmAZO4zO4MZVP3UoFMUSQDnbbHCXUgufV6z0QzuScbATwrE5f7LR2r2tu56DZfDdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rExFWrMr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5813dXzL5229307, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756697973; bh=RUpQaq3IEPDDmlYiW/HYw72qH4KEXu933UBAZ7ltZ7c=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=rExFWrMrd3qR7VgyB7Mn6ISHWcRwK2uTLinfYrJG/QdUzTpEIX2tzbc2p3jYxf/C5
	 Hvws+9nTtdBFUQraadN6LN3kK5npQPGJ2QbdlAokjh21qCvBjKOv39ibvrKy/iEDDr
	 2m0OXwUHHH7DEUy1a1FoVkPAF5tLRXZhkuIWNGHH3yqBZzlgt5UPT9sQo/WOueb0W2
	 DmU68DB7o1OQzgahiQbIrLySpGi1EE2UV191jPSXo2fIoUimc8HhfGKjaREA92IeP+
	 O5+fr1OKliLiOu+zZgx1sobm4wZzME2mUSkPkB+vwHMnCDQXD0TWUWnK7sHYpLoyYj
	 1NWaykYvbeyYQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5813dXzL5229307
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Sep 2025 11:39:33 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 1 Sep 2025 11:39:33 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 1 Sep
 2025 11:39:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>, Ping-Ke Shih <pkshih@realtek.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: Re: [PATCH v2] wifi: rtw89: use int type to store negative error codes
In-Reply-To: <20250827150620.550641-1-rongqianfeng@vivo.com>
References: <20250827150620.550641-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <eb1ba911-a34d-4c18-a7f6-dbc75a5b4e0d@RTKEXHMBS06.realtek.com.tw>
Date: Mon, 1 Sep 2025 11:39:33 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

Qianfeng Rong <rongqianfeng@vivo.com> wrote:

> The 'ret' variable stores returns from other functions, which return
> either zero on success or negative error codes on failure.  Storing
> error codes in u32 (an unsigned type) causes no runtime issues but is
> stylistically inconsistent and very ugly.  Change 'ret' from u32 to
> int - this has no runtime impact.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

a650d86bcaf5 wifi: rtw89: use int type to store negative error codes

With below changes because of smatch warning:

  rtw89/mac.c:1197 rtw89_mac_hfc_init() warn: missing error code? 'ret'

Changes:

  The change of 'int' type seemingly give smatch a hint to treat 'ret'
  as error code, detecting if we miss to assign proper error code.

@@ -1194,7 +1194,7 @@ int rtw89_mac_hfc_init(struct rtw89_dev *rtwdev, bool reset, bool en, bool h2c_e
        if (!en && h2c_en) {
                mac->hfc_h2c_cfg(rtwdev);
                mac->hfc_func_en(rtwdev, en, h2c_en);
-               return ret;
+               return 0;
        }

        for (ch = RTW89_DMA_ACH0; ch < RTW89_DMA_H2C; ch++) {

---
https://github.com/pkshih/rtw.git


