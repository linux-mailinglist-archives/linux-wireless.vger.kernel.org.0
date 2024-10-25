Return-Path: <linux-wireless+bounces-14490-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 783B79AF757
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 04:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E6D282928
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 02:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA44487A5;
	Fri, 25 Oct 2024 02:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="H932T8uz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E6F79C8;
	Fri, 25 Oct 2024 02:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729822891; cv=none; b=LUL53vY6VWgWSzL2sdDa5zYRRhEA8DYiqt5Ow2OVs7+GkV4i7mhL2IongiiozesTGY8l1iqR3R1o2lcbCkQ2JqGloBLIm54iOY6cGyjjwIGYMMkFmeV6xVkFWrEj0sQc6O46JPQcNKUvPuO8AVUnAu3GSvAshMf8XCtGVNAaxt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729822891; c=relaxed/simple;
	bh=jDFSmREG/q6rnIsZwW0bgYwSks1jRCfXiYw9NFA1yTg=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=ufyOFjRtOVY+kmidwMdzuiR6aViAmTsxxcemZ3hoesmAL9TJHiNHfdkAzxuVaq5yICCMfElj16TtL4D82BT7OGN8xDpP/gE0J3rXmZUTXRxWyOtoRXmUhPI8mN4UvLNS0LnqIQPxO74Jw6uaBF4xfS/eanXktTCdG4SYpY+Vx4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=H932T8uz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49P2L9UK04095298, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729822869; bh=jDFSmREG/q6rnIsZwW0bgYwSks1jRCfXiYw9NFA1yTg=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=H932T8uzNp/RkvTdyTx2Emp0adN0KJQIf9djNFDHzHRrv/LuvBtUBWDPisRXZbLFr
	 1d9BSQRY/LpV33MXG0DFrLlJEuOVHEawQhiKpd17RYG27JhHwr0e0LXZ3gwJ6hBz8U
	 QTnPu7UL5DeDpGeOwGWVHd2myF6knBYWJdkb2vUY0fXPftYqcYChDaoZpxFMJH5ch4
	 gQ8hDi5TMQy2pWDpg+4aN3XZjT4OTJIUVAtwtNoO2HyIbHwtL5oALbgZf+Wdfqt9jo
	 Nj6opZ0bXPrSByAQXA/5PZm8LAPLrOLB3V4qfA5bHeYy9m12roGn17HUr+eTZk2yr0
	 iys+M7CGtKCqw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49P2L9UK04095298
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 10:21:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 10:21:09 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 25 Oct
 2024 10:21:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Arnd Bergmann <arnd@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>,
        "Kalle
 Valo" <kvalo@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Zong-Zhe Yang <kevin_yang@realtek.com>,
        Kuan-Chung Chen
	<damon.chen@realtek.com>,
        Chih-Kang Chang <gary.chang@realtek.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>
Subject: Re: [PATCH] rtw89: -Wenum-compare-conditional warnings
In-Reply-To: <20241018152311.4023979-1-arnd@kernel.org>
References: <20241018152311.4023979-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <6aab4077-90aa-42ef-9abd-fca315f1919e@RTEXMBS04.realtek.com.tw>
Date: Fri, 25 Oct 2024 10:21:08 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> This is one of three drivers that trigger -Wenum-compare-conditional warnings
> with clang:
> 
> drivers/net/wireless/realtek/rtw89/core.c:1806:14: error: conditional expression between different enumeration types ('enum nl80211_eht_gi' and 'enum nl80211_he_gi') [-Werror,-Wenum-compare-conditional]
>  1806 |                 return eht ? NL80211_RATE_INFO_EHT_GI_0_8 :
>       |                            ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1807 |                              NL80211_RATE_INFO_HE_GI_0_8;
>       |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/realtek/rtw89/core.c:1810:14: error: conditional expression between different enumeration types ('enum nl80211_eht_gi' and 'enum nl80211_he_gi') [-Werror,-Wenum-compare-conditional]
>  1810 |                 return eht ? NL80211_RATE_INFO_EHT_GI_1_6 :
>       |                            ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1811 |                              NL80211_RATE_INFO_HE_GI_1_6;
>       |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/realtek/rtw89/core.c:1813:14: error: conditional expression between different enumeration types ('enum nl80211_eht_gi' and 'enum nl80211_he_gi') [-Werror,-Wenum-compare-conditional]
>  1813 |                 return eht ? NL80211_RATE_INFO_EHT_GI_3_2 :
>       |                            ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1814 |                              NL80211_RATE_INFO_HE_GI_3_2;
>       |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/realtek/rtw89/core.c:1818:15: error: conditional expression between different enumeration types ('enum nl80211_eht_gi' and 'enum nl80211_he_gi') [-Werror,-Wenum-compare-conditional]
>  1818 |                         return eht ? NL80211_RATE_INFO_EHT_GI_3_2 :
>       |                                    ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1819 |                                      NL80211_RATE_INFO_HE_GI_3_2;
>       |                                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> In this case, all four warnings can be easily avoided by splitting the
> function into two separate ones, in a way that helps readability as well,
> at the expense of a few extra source lines.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

c67d7c7f4151 wifi: rtw89: fix -Wenum-compare-conditional warnings

---
https://github.com/pkshih/rtw.git


