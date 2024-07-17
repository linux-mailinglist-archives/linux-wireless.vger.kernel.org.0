Return-Path: <linux-wireless+bounces-10279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA599335DC
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 05:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94B9283882
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 03:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D81223D2;
	Wed, 17 Jul 2024 03:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="No1CEuYi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F54538A
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 03:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721188243; cv=none; b=NWSCkUk+bNsZzrNOGK4Lb8iSn474HL6n+zf2r8a+FGH15KVmkYXQNwOIBaMfls3ipaRFIF9hGoduq+6BQygzihwwgtWHmCuWspvGSkW9KHoa99WK7VqSnibTBKLLFBBlQptJhDHxG7V25MXrB0r9ZbNhIHO8oeFE3jIKTli7NS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721188243; c=relaxed/simple;
	bh=Och2RPzfEL9fwpffRtu5zYo4caMrahDgtM2DjMJO6YA=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=qZfQxseNTg/gZZLDWUmuBc+rCFGSsFn4go4wrueoHyLF8pPHvDiGT+Ur+kf33ZO7ibiLrWLsJXrLKWB4RQVrduCNeCPEYDdkdIZEctCwf2LgxiSJWFYrhwiNIMTUQLBCiuswGDkLYB9g0BpOf6Al0PmtSEvoj+j8JV8w6iLFs98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=No1CEuYi; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46H3oYnbD1675327, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721188234; bh=Och2RPzfEL9fwpffRtu5zYo4caMrahDgtM2DjMJO6YA=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=No1CEuYigQJeP3HhNokU4pG8dw0+aRnrVX9IHc3DIXF3qnWXKfl7KeA1pyXNRD9Y4
	 ILphiYEOOB4pY7/Mov/e1ja43yn3uhXWGK6LsjzjKQG694E+ahQQR75Vy7z5NCxwNk
	 HRTPhgGEQye1MOIW1yUQgBbsaPYKZFUyT7vsWRAow1B5cXiCTGEMqZumZeMgzZ1+IV
	 UWnNJ2SOx7ZaUnhh304C8IqTfWEPrBhIKcJgpTak2VieJFt74aaeUtSVP9xkuHb+Ur
	 sf1MPMENGYyn5ciecG0RUhbhqfqzOQzX9f6LY/OD1FEJCDDpFCjZulo0sX5KqDNF02
	 M8CR3+xLbuIFw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46H3oYnbD1675327
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 11:50:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 11:50:35 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Jul
 2024 11:50:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH] wifi: rtw88: Set efuse->ext_lna_5g - fix typo
In-Reply-To: <8ccc9e13-0d45-417d-8f88-93a0ad294f77@gmail.com>
References: <8ccc9e13-0d45-417d-8f88-93a0ad294f77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <a75c3023-405b-4546-a22b-829bc5c16b5c@RTEXMBS04.realtek.com.tw>
Date: Wed, 17 Jul 2024 11:50:34 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> efuse->ext_lna_2g is set twice and efuse->ext_lna_5g is not set at all.
> Set each one once.
> 
> Nothing uses these members right now. They will be used by the RTL8821AU
> and RTL8812AU drivers.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

8fbcaa308591 wifi: rtw88: Set efuse->ext_lna_5g - fix typo

---
https://github.com/pkshih/rtw.git


