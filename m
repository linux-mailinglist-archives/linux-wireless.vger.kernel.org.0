Return-Path: <linux-wireless+bounces-10843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0410F9455F4
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 03:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37B4285A0F
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 01:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059B2EEBA;
	Fri,  2 Aug 2024 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="HSjoY/LW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC40DB67E
	for <linux-wireless@vger.kernel.org>; Fri,  2 Aug 2024 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722562214; cv=none; b=SGmYlYlYmK8Ezhw/ECDQh8Zu+gU/uWf+G7uk/Pab1w7Q1MI2rWr/XtdfsQTxTYEVsHxKZbZjcvTJe/MPUuJ8wykkEIMya/3ZKHCFZZ62mgZc17jImHCPnBlxQHe9UIAK56KizQqNkOn42jm79BgPVbV6EiMPuHBVzGSg1z1Fn7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722562214; c=relaxed/simple;
	bh=TLfd1AaWreRNA0GZomCd7vhNchkSqM84TYKnuW4vZKg=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=XuO+suTnFHmRdo0uqPJEqPGo84hl5dtNPbxgYAqsWudHFZqK7rStLradZ/kabjeLZ5tOHYQFnHKW9fbTr/MohYJOOBCAMwqI7ZNsZvnGfrVKzcAVTtCe+szmPkTVC1QMkcKcWNGtkz6tNeD7KoHj/W3xqZqNcjWSE3+576jNhtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=HSjoY/LW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4721U9e04073866, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722562209; bh=TLfd1AaWreRNA0GZomCd7vhNchkSqM84TYKnuW4vZKg=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=HSjoY/LW+gcXp+auntt4IBO8xX6+Eg55K2ldBZxYJY9PxmYIoszXv7jtM9nNAoeRp
	 Fg9OAlMu0qV2k4mONAHulGdl3STKp6pZPl5pSOF8TFAPwmvVwCl8SZRXmBeJMAwX17
	 KPeJTL2b931C/LgDEw/7G1hpPLrMDml/XUencs8Rx+N/0cFRXBUAoUB0QhnEoHo9BT
	 pkjTqrbt8jHr/l79jqxHVxHUwfVfsNIbFb650UlVoWpWLcEAvgr8WbBPrqLw0W/jeI
	 FfWtDt7WTDn6E73I67m4XELLdyxmifTIjRKaOUubONAx97tYvCRgLLEg+PmITeXU4f
	 m0bLEZv6H4+tQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4721U9e04073866
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 2 Aug 2024 09:30:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 2 Aug 2024 09:30:09 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 2 Aug
 2024 09:30:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: Re: [PATCH 1/4] wifi: rtw89: add EVM statistics for 1SS rate
In-Reply-To: <20240724052626.12774-2-pkshih@realtek.com>
References: <20240724052626.12774-1-pkshih@realtek.com> <20240724052626.12774-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <638446ee-cd26-4ed5-a38d-2bcd3d8d9b70@RTEXMBS04.realtek.com.tw>
Date: Fri, 2 Aug 2024 09:30:09 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Kuan-Chung Chen <damon.chen@realtek.com>
> 
> To more accurately debug performance issues, EVM statistics will
> differentiate between different space streams, and only beacon
> and data frames will be included.
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patch(es) applied to rtw-next branch of rtw.git, thanks.

bd4a3b10fa0e wifi: rtw89: add EVM statistics for 1SS rate
0b38e6277aed wifi: rtw89: add support for hardware rfkill
80fb81bb46a5 wifi: rtw89: 885xb: reset IDMEM mode to prevent download firmware failure
27d90ad37771 wifi: rtw89: fix typo of rtw89_phy_ra_updata_XXX

---
https://github.com/pkshih/rtw.git


