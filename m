Return-Path: <linux-wireless+bounces-18705-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7A4A2ED1B
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 14:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3061F1888B68
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 13:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E37B222574;
	Mon, 10 Feb 2025 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="qo5+2b8a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92731BD01F
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739192518; cv=none; b=kS1Hw+cXoQ3OsD6Yo1Xdo0M0bry2Mxq1SN+XLAsPEdsS9wO5hmCVQAHPq0wG39y4K7C84XaQE+Y0JNaRjgemSuk3iMD2kIQSaUDPbUF8Mf0yaRqBwYPvEJyfUITwPthMF0q4h1HXBwGzbTFPeanx7a+1E6XdB4jGKc54LEgj3x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739192518; c=relaxed/simple;
	bh=lVgcK3eJ+i83CqjqrlVlrwVIBMj85xCxH/BCgQG8jpc=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=TdIbvEszGw8doBf7R47A1qE/FgUoa0RQADCO5pYPfmdwfAt7PFXVpF+STC7YutAnM/Rm6lm1OANu9BEYQiKf9ON02XjU7kAywFyafVGEmWo0ThLQLe4LPo1216dnJmeHJMv5iHOEkF/TSlKbg+KRlRI9ckBSV/ERe6Z3Swn8KbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=qo5+2b8a; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51AD1q9aA2244194, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739192513; bh=lVgcK3eJ+i83CqjqrlVlrwVIBMj85xCxH/BCgQG8jpc=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=qo5+2b8azEGZCu0tvTq37cQOWDoZpSsJvojGn1nrD0WOkkYO29nG/u21FJ93ldzjY
	 OSdJMCgpY4q+lkE6l2nr1To5aaWWk7QHo0egf/+y0M1f3mj2/AQ8uePiwewZZnxahK
	 1N3aN/8Y76+K5RzTaAVWqv1uTcZnKxIhM/lXIalm9aSnOvxyhBX5fq6goGFdxgYgCd
	 kDiH4/xrglwxzbVcJ0Cyh0gpPZDxoBF/nkF2r8ck46MV+QbkZko91C3cB8WRzIVKvE
	 +wAdy4ntmZwmiBORRvz1Ug1quw3VSoAEc3yAaPg4ezJEmZO+MeWXARePbVsCnrPVSM
	 cDSEdc2qak7Cg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51AD1q9aA2244194
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 21:01:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Feb 2025 21:01:53 +0800
Received: from [127.0.1.1] (172.16.24.241) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 10 Feb
 2025 21:01:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: debugfs depends on CFG80211's one
In-Reply-To: <20250210123105.10466-1-pkshih@realtek.com>
References: <20250210123105.10466-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <ecc82d3b-d77c-41f6-8139-8a08bdfa2bcf@RTEXMBS04.realtek.com.tw>
Date: Mon, 10 Feb 2025 21:01:51 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The wiphy_locked_debugfs_read() and wiphy_locked_debugfs_write() used
> by rtw89 are defined if CFG80211_DEBUGFS enabled. Add the dependency
> accordingly.
> 
> Fixes: 8fdf78f3cd5f ("wifi: rtw89: debugfs: use wiphy_locked_debugfs_{read,write}() if needed")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502101810.3CUpUL7p-lkp@intel.com/
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

a0519433ad8d wifi: rtw89: debugfs depends on CFG80211's one

---
https://github.com/pkshih/rtw.git


