Return-Path: <linux-wireless+bounces-23909-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E855AAD2B5A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 03:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9181891BD9
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 01:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C5D17A2F6;
	Tue, 10 Jun 2025 01:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Lw1vtFY0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454B010A3E;
	Tue, 10 Jun 2025 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749519108; cv=none; b=GkGt5KcaEbD7VIX4h6q241uFahliEStgw6/U36F95rhfP8Zy/4v0NQ5FBv0LGw3r7KN2yPrilKcs8mJyw29UN6ckRWKlWHoeSlCMo71bIXbkF9M3hQ/ClxsAfXyRg91Z6kqWnT0f1Iuf0bm0WTwvjPUlvy06NF9IgxpnoX9s9fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749519108; c=relaxed/simple;
	bh=+hzWpgyZHIg/0mn392OVAybIQ9Wnj13oNFrfGYZ8jeU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=eCRagWPl/7gOBI/3THVHxAVbAQYR0JyJLuxxJOxRdDCB5WgwfZWykYpM6EQkeErzE7rotZn81cfzx/9vXz+rYvCCjyGQfoz4h4DBRyqZzrZZNoS+1WmJlYk3ABUVkuj0RpoSNIsnGjG5cDt5jNqLtn5rUm7dI7mrdCNazJEwo+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Lw1vtFY0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55A1VglsE2052518, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749519102; bh=llptG3Lo5qJQxsfbCH3iERlfXjkr6iRItYzYyZVfres=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=Lw1vtFY0aw6s1z55h8fda9xPzVwCy4LI51Bb9sKbdCpey8Mi5i7isHKFw9M65I5SW
	 XJDfNd/AE6Aeo4ESrtgTI81rDBYLf3lmaoEm1E90T3k2djTKFPihkBVT8Rqe2nXkVJ
	 EWSOH7Xbfahr4Vc7lh+VMjC5pXT+7BzuV2wZFkrgm6f9XymHLUufdLsthLZdw+Ob8/
	 oZuERxYPA/T9Of+/Eniw0ZN409qngQ638tBvGS2191he6FJ/omSxao7m7RK6KbhNFm
	 88dHI4IL2lbAdNR6il2Nr3ukIwPpY/EdY6cmfpngvsd1+tJ82bqc6xY1wAPpjSNgHl
	 5VDj7T6MbL0cg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55A1VglsE2052518
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 09:31:42 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 09:31:42 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 09:31:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Zong-Zhe Yang
	<kevin_yang@realtek.com>
CC: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2 next] wifi: rtw89: mcc: prevent shift wrapping in rtw89_core_mlsr_switch()
In-Reply-To: <aDbFFkX09K7FrL9h@stanley.mountain>
References: <aDbFFkX09K7FrL9h@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <74c6ccbf-708d-4ee6-9b4f-16f6b163980a@RTEXDAG02.realtek.com.tw>
Date: Tue, 10 Jun 2025 09:31:41 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

Dan Carpenter <dan.carpenter@linaro.org> wrote:

> The "link_id" value comes from the user via debugfs.  If it's larger
> than BITS_PER_LONG then that would result in shift wrapping and
> potentially an out of bounds access later.  In fact, we can limit it
> to IEEE80211_MLD_MAX_NUM_LINKS (15).
> 
> Fortunately, only root can write to debugfs files so the security
> impact is minimal.
> 
> Fixes: 9dd85e739ce0 ("wifi: rtw89: debug: add mlo_mode dbgfs")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Zong-Zhe Yang <kevin_yang@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

53cf488927a0 wifi: rtw89: mcc: prevent shift wrapping in rtw89_core_mlsr_switch()

---
https://github.com/pkshih/rtw.git


