Return-Path: <linux-wireless+bounces-7104-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B178B9398
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 05:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8131C211E5
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 03:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7BB18054;
	Thu,  2 May 2024 03:10:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6908E1643A
	for <linux-wireless@vger.kernel.org>; Thu,  2 May 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714619432; cv=none; b=G5MRn6W+kY2XL5wh3cFwULlUDRPtjdGRxJclAlLQaNAb03ansiWQCxI0shNSf5JpsYvQLJCUlut57VK0rUgXUega0Sv7gWhLLNU7eO3xC+3yOoFYAERQUbv+AtzKZDbk7H1qNx7Wdn1duHMB94aA57HlTh1N0Ieax+/zrHeoriY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714619432; c=relaxed/simple;
	bh=mopkGX2X8cXrL2cs6Qb9ktSUdgdikMun4gc78l2v3H4=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=u62/Df2PIaworcfaE24ZL6yjFr+a97Ury7PHFhS1JwCBTBt7cZ95OoeAqAU5oQ8Dxd9XyFW9h9Xm7pGPDYb+NDQeyl+kp1+H8h5MC1XrvRVotcebnroS+8VVrsLpVEajN/OMNDCaNvSw6QuynhD+LpXAp3zqxKQleq+yKL+QBXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4423AMNA02056113, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4423AMNA02056113
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 May 2024 11:10:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 11:10:11 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 2 May
 2024 11:10:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <Jes.Sorensen@gmail.com>,
        <linux-wireless@vger.kernel.org>
CC: <kvalo@kernel.org>
Subject: Re: [PATCH] wifi: rtl8xxxu: cleanup includes
In-Reply-To: <20240429024711.30992-1-pkshih@realtek.com>
References: <20240429024711.30992-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <96a9b237-4b6f-4af0-a17d-66d1f8b0cb5d@RTEXMBS04.realtek.com.tw>
Date: Thu, 2 May 2024 11:10:10 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Remove unnecessary includes from driver. The first step is to add
> necessary includes to driver's header files to make them can be included
> individually. Then, driver's C files include driver's header files first,
> and check if still missed header files of kernel.
> 
> The results show that most C files only include driver's header files.
> Only core.c needs to include additional linux/firmware.h.
> 
> Also sort includes in alphabetic order.
> 
> Compile tested only.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

949f6f3aeb87 wifi: rtl8xxxu: cleanup includes

---
https://github.com/pkshih/rtw.git


