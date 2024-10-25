Return-Path: <linux-wireless+bounces-14487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD529AF749
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 04:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B35280E7D
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 02:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C214409;
	Fri, 25 Oct 2024 02:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="t0jWYxPp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E87132111
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 02:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729822283; cv=none; b=aE0NXXlytMy7DtmHC1JTLUxPgTWJouk1q7/qzz2ByGGwxhA1xZiYT9FP/mYwLU5GeQIErOA+kD2WMXE/CWPmY8O6aSs57pnsRABWkDvtyW9XKzvfIry4LqeTqkvjynEpYH4J/KIXUR3IS3CJdZmNMYOPmFCV+dv1e7MIRK3Ew2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729822283; c=relaxed/simple;
	bh=+LZCVNprLeyQt+Nvbb+oRDWGRDbCb8ivYVHynpNLd4g=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=S6XGGnprjUjZ82wcT7ZOWr05luUnTx9vcLZ8o/5x4JPadlJSDllWIKla8S9XVMJl4vaHCvRfPxR6/wAdfWYfNO3HX/W/eHCwMnusivlDJfjQgHCmA4x4ePO5fgA8umoPnyYAAlzrcs8N8I7nu3aMlqnaddLDiNcu5G31XiKbZFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=t0jWYxPp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49P2BJRR04055325, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729822279; bh=+LZCVNprLeyQt+Nvbb+oRDWGRDbCb8ivYVHynpNLd4g=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=t0jWYxPphLHq2pZp9BGvseNWdxAnWumlVPWy8kgauaptCp2KvxLpFZjdfhPe+0iHS
	 6fRGbFsnHfmKGW4juaFSLyMX6iJT4w4tSczoEatDbgwJJS7BD6M5TkLGrZ3hoxr5Q6
	 Tg4zpyb/Ln+a1XFHBEPEd6gbMapZ1xrMUHmVrB7/MuQNACOlxRnoAS8wxlVk3DZLgs
	 OpF6Cy57YpYxA/+tSkG9FQDvKGZmR2MyQ51vr69kuGeuaKiWbBsUihE0eFkCbs6X1Y
	 Kk1lifAEMtfgCIRHbaEuc4bd4vepjdRrIFW+2uYBRLuHxjfpPJSTDADv5NsUh18+ld
	 nQ2XCsQhgE41w==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49P2BJRR04055325
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 10:11:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 10:11:19 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 25 Oct
 2024 10:11:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: regd: block 6 GHz if marked as N/A in regd map
In-Reply-To: <20241016134457.9375-1-pkshih@realtek.com>
References: <20241016134457.9375-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <7fda2085-0d38-4c82-bcec-fabb1d77a159@RTEXMBS04.realtek.com.tw>
Date: Fri, 25 Oct 2024 10:11:18 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> If 6 GHz of a country is marked as N/A in our regd map,
> we block 6 GHz channels now.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

39fc7d38654d wifi: rtw89: regd: block 6 GHz if marked as N/A in regd map

---
https://github.com/pkshih/rtw.git


