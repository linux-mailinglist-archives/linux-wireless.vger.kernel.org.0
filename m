Return-Path: <linux-wireless+bounces-30423-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 639ABCFC7DD
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 09:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12991301FC23
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 08:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B6D232395;
	Wed,  7 Jan 2026 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="f6iO0+yi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABF121A92F
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767772899; cv=none; b=HpWH++OH7EG5CUKj58ufaQXRZux4UvFVkstnjbMHrWfBT9YmflPgNZ9tG9Lmzn6VwEUiGXaIS+IUcTVfpUDeQ11mvN0zT7LmP3AR+p48RLDH2tBNzZHDTrI1kk87Tmzcfe5vvzGsAlg59dSQ+x0FIm/RYx1YtBHY9rOR4OFHVog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767772899; c=relaxed/simple;
	bh=v32BDCd9YdydJe0wlcyI9/Moe87eCFEStPnJtqdGaiQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=RAENz8innHu3H9WFLcR8ouBTTENkTY7Nq5A9BY8q9lg/S8IgZtV4QTU6rKQqgUK6Nrk5GEhxMbxobpoUE7cU21s5VrwmxhCVpA8+VTljaP7SL9M0qOBNONwdJxf6glXatUSjp67HEmBCts6wro/gvUMIslDnG4dhX+drKZ9gsk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=f6iO0+yi; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60781ZHx82584618, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767772895; bh=SmOp2AmTpz09RSFXIPh7oNQHymUsclRVmCzsb4fTlw4=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=f6iO0+yipwt25Fu7z+rmUBAPgZ3CtOluvBzbE6xMgCruMcg0mvQB+0w0c50tLSHUw
	 6uN0YwUhYlPIckhRTqyoLol7kWR8ZPCejHs5FUVdHH/x0Z73zOEVl1d8b6DMOWv1vs
	 xN4jpR6VeqgRbNFbhEHVLKJFjEQl2+WWVCz03iCHWdRNGzyb3x1qlJXTFxvPS03uqD
	 I/JEO7sO4m3oxr0qDsq6gm+Tm/LzgDZsofVUm5tD04zRpD8POuOcH4IgW8zvnMjkBy
	 GLfMd6RP1AdB3l10RD9GzUUhdfo8RZv2loMgO4Aw3Kr5/hmRsqAW+SVZjSFF/4RmGK
	 MLFHeSa5RU6Fg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60781ZHx82584618
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 7 Jan 2026 16:01:35 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 7 Jan 2026 16:01:34 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 7 Jan 2026 16:01:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next 01/11] wifi: rtw89: rfk: update RFK pre info V2 for RTL8922D
In-Reply-To: <20251231090647.56407-2-pkshih@realtek.com>
References: <20251231090647.56407-1-pkshih@realtek.com> <20251231090647.56407-2-pkshih@realtek.com>
Message-ID: <21bf0535-5fed-4a41-bfa9-702d0d9da934@RTKEXHMBS03.realtek.com.tw>
Date: Wed, 7 Jan 2026 16:01:34 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The H2C command of RFK pre info is to tell current operating channels to
> firmware, so RF calibrations can rely on these information as arguments
> to configure hardware.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

11 patch(es) applied to rtw-next branch of rtw.git, thanks.

8c0ac5791eb9 wifi: rtw89: rfk: update RFK pre info V2 for RTL8922D
ed15dddd7566 wifi: rtw89: rfk: add rtw89_fw_h2c_rf_pre_ntfy_mcc for new WiFi 7 firmware
9485da4e4c9b wifi: rtw89: pre-handle RF calibration on link when needed
c5e5519fd981 wifi: rtw89: fw: change FW feature map to a BITMAP
2d986cf3cc71 wifi: rtw89: fw: introduce helper for disabling FW feature configuration
29009d98d98f wifi: rtw89: 8922a: tweak RFK_PRE_NOTIFY FW feature configuration to align handling
449a57911967 wifi: rtw89: refine mis-ordered entries in FW feature table
6a6b0aac2874 wifi: rtw89: fw: change WITH_RFK_PRE_NOTIFY to be a FW feature group
cd7ce83ff6da wifi: rtw89: rfk: update rtw89_fw_h2c_rf_pre_ntfy_mcc format
eb57be32f438 wifi: rtw89: fix potential zero beacon interval in beacon tracking
baef3d5d96d2 wifi: rtw89: 8852b: refine hardware parameters for RFE type 5

---
https://github.com/pkshih/rtw.git


