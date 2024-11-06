Return-Path: <linux-wireless+bounces-14957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890099BDEC6
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 07:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D1C1F2468D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 06:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1C11925BD;
	Wed,  6 Nov 2024 06:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="WjnPCr/J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB78190676
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 06:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730874122; cv=none; b=VjtBQfN2UVe9wIPIdMwccmkXtFudNqqpYgCmMt1mqql/MhwEkLkKveuJ3q/GOjaefSDPK3rcK11Vlq7s62pDub5YgOt82A8mx/R43kSgizEjlCa9rNI8C5/v4jK9efgFyjrzLUU94+20ZCFssXIPTNe26EtLN21C7cZmXHOnGsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730874122; c=relaxed/simple;
	bh=bbbjdID036empNEb5Us8PXuTsg8AzL2VtDxpNuo3BzA=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=hPfAnb5VLx65hJhr8PViZMHpaCR7WNQS4aLCReBVdk1hlERtUGsZ8P1dCJ9DwPNM2YTVK4iGLjYChGiRX4xfQcTTiqUxessdsfOtL7yGFdlyQihw5toMDR9YUNwVOyXgSSdZp7BKtqocVaBk2uF1KRSeMIFw6kBVgIH/RKV7gBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=WjnPCr/J; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A66LgqpE2306731, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730874102; bh=bbbjdID036empNEb5Us8PXuTsg8AzL2VtDxpNuo3BzA=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=WjnPCr/JZQX2L/5Z9ykcPKnyo/e5TRBinz9dT2EbcGqDRYrVnUGhoaH0GKG9x0KaS
	 dQogiIm3AyLvEib9TmkrcLz4UGRKm/OyVK14702yZDbiUs/hTGBNXakG3FsmEcVNRA
	 w/8tJIKg9xRxBtjSbnJ7ZRP9np2HfXs45KkliQ35d5hsIJjZMKnEr87T205MHi+i2V
	 ql9eY5yNbXArmMtgpZu0jkJo/AZjiq3us2QWouT3a06busOrNxgp6C79wiAbV1fwbN
	 lP0TSE7vuOzCZMtE1NkjPDtJFi0q6O4m8MwPYwGFDJ6Ba7EKHhdlUL8uU007jXetI9
	 qxd6GoMMB4fLw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A66LgqpE2306731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Nov 2024 14:21:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 14:21:43 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Nov
 2024 14:21:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Pei Xiao <xiaopei01@kylinos.cn>, <xiaopei01@kylinos.cn>
CC: <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <xiaopeitux@foxmail.com>
Subject: Re: [PATCH V2] wifi: rtw89: coex: check NULL return of kmalloc in btc_fw_set_monreg()
In-Reply-To: <516a91f3997534f708af43c7592cbafdd53dd599.1730253508.git.xiaopei01@kylinos.cn>
References: <516a91f3997534f708af43c7592cbafdd53dd599.1730253508.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <e4b66fd3-a2dc-48cb-822f-01b9b8eb4423@RTEXMBS04.realtek.com.tw>
Date: Wed, 6 Nov 2024 14:21:42 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Pei Xiao <xiaopei01@kylinos.cn> wrote:

> kmalloc may fail, return value might be NULL and will cause
> NULL pointer dereference. Add check NULL return of kmalloc in
> btc_fw_set_monreg().
> 
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> Fixes: b952cb0a6e2d ("wifi: rtw89: coex: Add register monitor report v7 format")

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

81df5ed446b4 wifi: rtw89: coex: check NULL return of kmalloc in btc_fw_set_monreg()

---
https://github.com/pkshih/rtw.git


