Return-Path: <linux-wireless+bounces-7154-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A588BB8A2
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 02:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7081C21637
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 00:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C5F629;
	Sat,  4 May 2024 00:15:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D70836D
	for <linux-wireless@vger.kernel.org>; Sat,  4 May 2024 00:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714781738; cv=none; b=paFSFRDmkjjQ/9bH8N3+JyhNDqfyXif2ewypa2lJm4s2bVw/IdgoPiJriyXDkdbfYCW4/Xb5wuoAtJFyQn2JPjrbS0F69+5i1B6NvZsLDvorlgWAe02ONOFQEDJqOn6/TXwErze0z0U7Kfx/eQi8nhlSGaIbANcR7Nv/U6F+xR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714781738; c=relaxed/simple;
	bh=QrmygkHse79j5ziZCHNUVPPbALXpu0nIt+8sYPMxVKI=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=GJizUwOm+nE4mHC7+XtAvFnxMOGWVUuGDro4vQfhnnyD6PLEq0aHghf7ED25wRkJX0JPMUGDwGyhEuJVfSsZ7FDGTFPAqzlSkW8bAiLBr4szuXS6QczEAKrLz2N5lJcWirfe/gU4ue3Vj+f9ahPCN6ULVsRqI99h8SiD6Qpiadw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4440FWvbC4008160, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4440FWvbC4008160
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 4 May 2024 08:15:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 4 May 2024 08:15:33 +0800
Received: from [127.0.1.1] (172.16.16.175) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 4 May
 2024 08:15:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: correct aSIFSTime for 6GHz band
In-Reply-To: <20240430020515.8399-1-pkshih@realtek.com>
References: <20240430020515.8399-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <c27a8ffd-0696-4d07-b939-aaef4d796ba2@RTEXMBS04.realtek.com.tw>
Date: Sat, 4 May 2024 08:15:32 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> aSIFSTime is 10us for 2GHz band and 16us for 5GHz and 6GHz bands.
> Originally, it doesn't consider 6GHz band and use wrong value, so correct
> it accordingly.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

f506e3ee5476 wifi: rtw89: correct aSIFSTime for 6GHz band

---
https://github.com/pkshih/rtw.git


