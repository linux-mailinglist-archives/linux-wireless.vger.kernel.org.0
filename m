Return-Path: <linux-wireless+bounces-9998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C8C927FFF
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 04:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2641A1C2211A
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 02:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF7EEEDD;
	Fri,  5 Jul 2024 02:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="CcNnfbiK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9187ECF;
	Fri,  5 Jul 2024 02:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720144983; cv=none; b=iykNeiMRJD69GlY3cfsTggmKfwEYvGFS/R0Ghqje08Mi6iv3VHOpLIzqNsiC9iNbJXTAVC0aYkFTvvcOOuWKEZp2taqCWacA/RJjVpZz/YRZKBdmx+Vyg6oq4B2APPR8Zt02k5ZUF5+8YEwR/zf4djadhM6jmQ9ZDdCn7C7zdhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720144983; c=relaxed/simple;
	bh=510RnsDry9qRzAdB/IEwdodEmogXIW4nYwr8CSlyhks=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=YFglu5yXPL24dPDv6VLF5dRZUTsWNo22WyLhu99kcYH47RqaevYnNRyB1SoPNNESXTFcvH9UMli9VdJ+IREfahHqQCbCLwPtOWHUHjPMFtReB4wJLVHVf7TugpnfgAdQEGv1EzZTNdaLCt/vMs1NeG4IJ9Yjsnwqw897KfDbJlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=fail (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=CcNnfbiK reason="key not found in DNS"; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46522fWyA4098500, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720144961; bh=510RnsDry9qRzAdB/IEwdodEmogXIW4nYwr8CSlyhks=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=CcNnfbiKixBPvH0oMtpaMKbBxv/Fc7r4B7mziB2gC12urCQ95kkSDENeMcIy7O7vG
	 TBasZ36uDddC65odvd8o2SyJCEGW9FgmDHKGZERgj3J6ksILZt10DK02ncaeA26+zO
	 TdcyLaC7aXgRT1w1UROByX+nw1hpNCaGKDuPlDyxFF6p1cxnS3DGRTJEnHHX7OKzRx
	 JOqAHPse7+8uwcqqe6RdFNpAErOOp3m0UUMomIYqExHel23kgJfDYQmNCX4ECZ59En
	 Fr0XUFWI5E3H/meFNedxYCU6n/W/1tS8X9QEZCKNb0uxdGJoXfKT+yM3lThcY7cjqa
	 x/SRH9MK5lg9A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46522fWyA4098500
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jul 2024 10:02:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 10:02:41 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Jul
 2024 10:02:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <fredrik@frelon.se>, Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo
	<kvalo@kernel.org>
CC: <fredrik@frelon.se>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtlwifi: fix default typo
In-Reply-To: <20240703070627.135328-1-fredrik@frelon.se>
References: <20240703070627.135328-1-fredrik@frelon.se>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <0fc66de8-5b78-425a-b67f-ae50e5b45ae2@RTEXMBS04.realtek.com.tw>
Date: Fri, 5 Jul 2024 10:02:40 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

<fredrik@frelon.se> wrote:

> Change 'defult' to 'default' in comments in several rtlwifi drivers.
> 
> Signed-off-by: Fredrik Lonnegren <fredrik@frelon.se>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

a1e7eafd12c4 wifi: rtlwifi: fix default typo

---
https://github.com/pkshih/rtw.git


