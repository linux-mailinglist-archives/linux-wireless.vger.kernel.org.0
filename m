Return-Path: <linux-wireless+bounces-29219-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4C6C77328
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 04:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 599114E2134
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 03:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F16244661;
	Fri, 21 Nov 2025 03:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="bQaBRmyV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8BE20C001
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 03:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763697382; cv=none; b=RSckyS7rf+6+w8XKZKIgckNJIaBPBqpDZQ8gGCGqVNx27rpw4hxViDeRgltprd1gHDEejCX1JVh7HtVCxgeZjHV95gwHnpXiDGiwy83W0sddrZClPXXVvUkdlv+nYenOrwwX2LcVRm/166WFr8N87IMyB8H2+rpZvz8eiTHO6Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763697382; c=relaxed/simple;
	bh=3fkqUWXvDuxMoGlRUcJvGWUvjCiHr5qGrgnr6Jx4/kE=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=HXKqAs5i8SBnU6Ozt+u6EiGOrfOAfNNrShtR4OzJ74knWxK5MNRG3fvMMhWf0FbAon63zoTo7eRCZZLJuXMD7B5Gt3ZprDb5wontoQ3p8t1Rge8ujR5W4r7RK7ncogGa5T7zcZDW/mm/xQbZ66xVMzcCw3kscOq7lxRLLK5bXPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=bQaBRmyV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AL3u9Vx92882969, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763697370; bh=K3GtIz1avidM8w2eHJwGUXm2XFUj77PPBaopWM18xVE=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=bQaBRmyVZmGR51+0pwD2ia2NKvENg/RYkkcOze/xTNq0g4Ndq5jaOtSzG5qkinNse
	 wsTq/gGEJ/PrFozl5SyzYJL0SesVpBu/FslgwXuQzS2TawBhjq5r+0J1HKeh4CAjZn
	 EZ5HNMdossW+zLKHRKQcYenaTZd4X+aJfExTkbP78ZUl/EdVXudM9YM+E4urM93Chq
	 J2pRlYnNwzMAykA1QJxgmz/CCnG0ioLwY2Ttg8ZGcX8Yq9yk1sde2pmDnidGSxqgB6
	 3At24BMUrkevK39Ryn5EoRKx0kprQZom2YJyVsYy1QqRDk37dRSJ6PTZTzsGyYn7bv
	 IWZxPRRwadwPA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AL3u9Vx92882969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 11:56:10 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 21 Nov 2025 11:55:59 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 21 Nov 2025 11:55:57 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 21 Nov 2025 11:55:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <geert@linux-m68k.org>
Subject: Re: [PATCH v2 rtw-next 1/2] wifi: rtw89: 8852a: correct field mask of reset DAC/ADC FIFO
In-Reply-To: <20251120031044.12493-2-pkshih@realtek.com>
References: <20251120031044.12493-1-pkshih@realtek.com> <20251120031044.12493-2-pkshih@realtek.com>
Message-ID: <d39f3b6f-382d-4bbb-83ba-a486a14f3211@RTKEXHMBS04.realtek.com.tw>
Date: Fri, 21 Nov 2025 11:55:57 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The field mask should be bits 16-31, but suddenly use wrong bits 24-31,
> rarely causing a little performance degraded if DAC/DAC FIFO stays on
> an unexpected state.
> 
> Found this by Geert who works on bit field functions.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

2a2aae365534 wifi: rtw89: 8852a: correct field mask of reset DAC/ADC FIFO

---
https://github.com/pkshih/rtw.git


