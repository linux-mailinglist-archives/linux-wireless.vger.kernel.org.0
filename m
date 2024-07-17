Return-Path: <linux-wireless+bounces-10280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3B59335FD
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 06:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CE9284067
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 04:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C723C8493;
	Wed, 17 Jul 2024 04:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ANX3+NfV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEB4101C8;
	Wed, 17 Jul 2024 04:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721189960; cv=none; b=AAVMngLNozjQlO7ASNxUkTQbzgOAzsq8oYaShCIFdH9s3zfVcBWPbqldjH9X6WsNi2v52CT8HBdZMbSCIDbyXXVdjbuTGPn2ulDgJsz3eWtY94pu3kpa6mIpFaWe+Kv+83g1cb6i/UAyiXXCfAJW6mUG87YkUUgfUOt8HWzKUh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721189960; c=relaxed/simple;
	bh=WatAHJAk9HtvZah7qSYlsS5qs4Jv2ZV2mkLGQMYLoMM=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=Xc4S0r2GDBCbgOFM/Az0xeGhdK81b9XXfdmXb5W3+fJw3FtfAjNKFeeHYploHv2SQsYust9mEDxrTF/+lJ/0uh6le7OZvauXigxh/vXBl1sALIYMBS8HAM3Rvc6nx1myH0Qsr5ibdY9GO5GORWkEHxwfh9ZKFMQiHX7ifFocqyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ANX3+NfV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46H4J8cZ41705346, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721189948; bh=WatAHJAk9HtvZah7qSYlsS5qs4Jv2ZV2mkLGQMYLoMM=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=ANX3+NfVtFBT85ZE18g/m8A2hQCf+Ey364aLHSSzNBxk0BiKBgDeP8PRsa7wLwR4O
	 u6p7K1FaRJ52f5Qp8rkDfFwizHVAHwdJY9n5zIDRFdjm0hRP9M51qZ1E0EDgikifG0
	 kcJKjNtr79sSw7iz1Lv/l8yANORIFss9G3yIKD46I0v+zHJCaBQRcE1SCFcgQMGDfd
	 yrmnKHZ1q0T4wEOZuEybtj5nqLuntUy4UBIkJ1nuvZ4hnJQg1QsKkjAmo+BAS4LB9W
	 5xdwhr7HlV3s8ChNOtY8xl12IJX1EdUDjJim0V+9bPm0II/gEl2acuBkvmOA2KDqHZ
	 Y7Z/g79SF91UQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46H4J8cZ41705346
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 12:19:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 12:19:09 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Jul
 2024 12:19:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Colin Ian King <colin.i.king@gmail.com>,
        Ping-Ke Shih
	<pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        <linux-wireless@vger.kernel.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] wifi: rtw89: 8852bt: rfk: Fix spelling mistake "KIP_RESOTRE" -> "KIP_RESTORE"
In-Reply-To: <20240710112253.228171-1-colin.i.king@gmail.com>
References: <20240710112253.228171-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <544d6f83-1698-40f5-823b-d2a3aefe748c@RTEXMBS04.realtek.com.tw>
Date: Wed, 17 Jul 2024 12:19:08 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Colin Ian King <colin.i.king@gmail.com> wrote:

> There is a spelling mistake in a literal string. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

d64270128bf5 wifi: rtw89: 8852bt: rfk: Fix spelling mistake "KIP_RESOTRE" -> "KIP_RESTORE"

---
https://github.com/pkshih/rtw.git


