Return-Path: <linux-wireless+bounces-7983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D508CCB32
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 05:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C265D1F21CDD
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 03:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D89224CC;
	Thu, 23 May 2024 03:34:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4CA20319
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 03:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716435293; cv=none; b=MKSL4Ec+Jw82H3iKcafWcfnLvhOZQEvOdtXTo4ELtZlLEpSyFXFmykfSzNLSdWrs9BrYmVrNill1uHcGUIi90C2ENM4Y5vubmp/EbNcQMtkkgSOih15cIc6vm7r5nJvC89HqMQI7L7+TL+kxq/VDnTVXqujUmnP+AlSoYLNCMc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716435293; c=relaxed/simple;
	bh=KmobFBysNnj4paWXxXo4hRE9qkQg8gIzS5G7stRpGZk=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=o+vw5VgbCuDrceLBRuJSfr0AuuiEn6DoNnLTUYr6lFJQJ5wR+DCfhDx7gMoICoJhTr8cBWztk83LhWlVpvTLjYKbV2KMUeO4mlvFHnfobVOjDm53ghsDKU15dr9CucZ9GZDN+NbgGhUwJtCWmuF5sSV1X2JUNonmNYXrk4BRYLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44N3YnfmE467252, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44N3YnfmE467252
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 11:34:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 11:34:49 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 23 May
 2024 11:34:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: 8852b: restore setting for RFE type 5 after device resume
In-Reply-To: <20240517013543.11533-1-pkshih@realtek.com>
References: <20240517013543.11533-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <241d3c55-4ebb-4623-8c6b-5b19ee13f987@RTEXMBS04.realtek.com.tw>
Date: Thu, 23 May 2024 11:34:49 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The RFE type 5 set SPS analog parameters only once at probe stage, but the
> setting is missing after suspend/resume, so remove restriction and set the
> value when card power on/off.
> 
> Fixes: 3ef60f44830a ("wifi: rtw89: 8852b: update hardware parameters for RFE type 5")
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

2c1fc7c24cd4 wifi: rtw89: 8852b: restore setting for RFE type 5 after device resume

---
https://github.com/pkshih/rtw.git


