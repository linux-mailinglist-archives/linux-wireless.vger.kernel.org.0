Return-Path: <linux-wireless+bounces-25640-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96362B09B9D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 08:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0B31C4418B
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 06:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3701F3B97;
	Fri, 18 Jul 2025 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="YlNFCiHS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23B01A315C;
	Fri, 18 Jul 2025 06:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820986; cv=none; b=GeFAX77MWYze157ja6lfHhOgTlZaHTdH+RKentvIYTpBEo+sAoXjm7CAxpABaG98u9pee5n6DVMZ/oqFrQpnpJvCSwQFLutlzRBa9KcCQWJg/RcVFoMrOdf0Zx0FMOU0ybRuSfixkLSRGmY/MnuQ0w/EGB8ijri4Rh3RdZ5E50M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820986; c=relaxed/simple;
	bh=pvj22hJnIB1p4D0t04zThvjjdencLqZJzyAOMzd0ctQ=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=s2y6/JlY64RmALL273NIdROWfEABcwAdppAvk9eMP/6jrIf/toCmyeTwFEAhd2UCaLo1ppqW7wjnl4Krjt1lY5ZYOqCHnsP+7MEZUZUQ8UlX3AZw2B4sakZYQeFlHmp4R6U0wyZA/qp/4+t2ArfE9PrNOYRb2JHI70duz7lZiyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=YlNFCiHS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56I6gq6sB1154915, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752820973; bh=4/2QoFgFJq1oKmZJAASPxr826x8ISG7bFQQmb4NeVNU=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=YlNFCiHSCL4f4j6hts83yPhP/rMGsQj25addBoPCl+jHm8xOv6MbDJiZvTCNAwNBY
	 KMCsAENpn6JiCXGh0kgHE1pZRbl72XXaklTFWWbZvxHkHsakgn6juboY2sKX2W3iOm
	 Y+dLqlZRmOaf/xjqThAi6I/O0ubP/mfJLpSuyAAEeXhXfoSsdgpoJxLilo9mVpl5VV
	 09Wb5zPkiUlwtXSsLgyMI+PgPoq6T1DWOibNZ4WV61tJfa65o3/vsI8VKcwOL5HyZn
	 xiOdAgx8LdABKOocztnmt8/jpFhnAhsjhfgwEtqEsGz7jFhPuoasL6Eis1mdmkniB3
	 FqLRmbVpsGsag==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56I6gq6sB1154915
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 14:42:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Jul 2025 14:42:53 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 18 Jul
 2025 14:42:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>, Ping-Ke Shih <pkshih@realtek.com>,
        Arnd Bergmann <arnd@arndb.de>, Qianfeng Rong <rongqianfeng@vivo.com>,
        "open
 list:REALTEK WIRELESS DRIVER (rtlwifi family)"
	<linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] wifi: rtlwifi: Use min()/max() to improve code
In-Reply-To: <20250715121721.266713-8-rongqianfeng@vivo.com>
References: <20250715121721.266713-1-rongqianfeng@vivo.com> <20250715121721.266713-8-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <e8052803-fcc6-4ed5-a8b6-78fb02883eb7@RTEXMBS04.realtek.com.tw>
Date: Fri, 18 Jul 2025 14:42:52 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Qianfeng Rong <rongqianfeng@vivo.com> wrote:

> Use min()/max() to reduce the code and improve its readability.
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

94cd0ba1842e wifi: rtlwifi: Use min()/max() to improve code

---
https://github.com/pkshih/rtw.git


