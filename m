Return-Path: <linux-wireless+bounces-15429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D759D07AB
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 02:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D88B216F6
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 01:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA93E2F855;
	Mon, 18 Nov 2024 01:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="b92hxScI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E122BAF9
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 01:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731894977; cv=none; b=eEtIW3YI89QDSGJLyIHbRzzcsxJrwtT1NAIkgajFa0aU35986y5PZwlYdV6aEQjGqxBmm1BF1AZoHfvu93B5qfsxhpZ+DcTgEesj7A4XDqGcfp9WGkRR7IP1L9T72WfW9KpJDR8qMG6aRMGqPPg6v76qtb3WKNdjWsXTvIypok8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731894977; c=relaxed/simple;
	bh=mct0HoWmicObMC5Dk0L4A5sCpVsjulbH7nUXYPEuRwQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=Ik0HaEVpj9CnzcOSP4WivWvepXpgBDHtngQiD+ehK/JeQuVwqTJoVqN7f9MczTkVdDUCnPHrJuf+jP3CA214qx40rSuv0jOSqfv6NgUrP4m5rfiHBEOdF6w0iYgpu55mrt+AWeJm/lp5rmgbT+DbdOiSy7MfDjFS3GW00UBqgvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=b92hxScI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AI1tq8N34137094, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731894952; bh=mct0HoWmicObMC5Dk0L4A5sCpVsjulbH7nUXYPEuRwQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=b92hxScI/E/iJNFeMoacNCs8c1y4Oe8QaSbWXq9nSloagsVByACz1ujutRlHvoDMT
	 T9qy244xzlvf280L2auZ/VjX29bRLT4AfbYNAU2jOgcUArLH7c8clq22nCFhM1th4A
	 5nOGGs3QsNH+69ZRmXul4uEUyyGC1ENqShpHMxgB0uqwZZijV0IuqubeczgS+rudDQ
	 6Kz7HPMm5b/7blqUmbRvKS6xwzs3Sd2SH+/QcvqhIPmjHhbZ/w/XAev3MCnvKLV4a6
	 fHgFXJLPfHtyw1sGVahhTNBXNeDaiCVC0xpBYr/rHY+hAxdKy9iEtTwv6jVfa7UqCL
	 /PmgcwJDpFG6Q==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AI1tq8N34137094
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 09:55:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 09:55:52 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Nov
 2024 09:55:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
        <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        <kernel-dev@igalia.com>,
        Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: Re: [PATCH net 1/5] wifi: rtlwifi: do not complete firmware loading needlessly
In-Reply-To: <20241107133322.855112-2-cascardo@igalia.com>
References: <20241107133322.855112-1-cascardo@igalia.com> <20241107133322.855112-2-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <fb45f87c-ce51-400d-836e-76108437c14a@RTEXMBS04.realtek.com.tw>
Date: Mon, 18 Nov 2024 09:55:51 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:

> The only code waiting for completion is driver removal, which will not be
> called when probe returns a failure. So this completion is unnecessary.
> 
> Fixes: b0302aba812b ("rtlwifi: Convert to asynchronous firmware load")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

5 patch(es) applied to rtw-next branch of rtw.git, thanks.

e73e11d30394 wifi: rtlwifi: do not complete firmware loading needlessly
8559a9e0c457 wifi: rtlwifi: rtl8192se: rise completion of firmware loading as last step
b4b26642b31e wifi: rtlwifi: wait for firmware loading before releasing memory
00260350aed8 wifi: rtlwifi: fix init_sw_vars leak when probe fails
f79bc5c67867 wifi: rtlwifi: usb: fix workqueue leak when probe fails

---
https://github.com/pkshih/rtw.git


