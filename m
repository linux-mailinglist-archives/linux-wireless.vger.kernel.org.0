Return-Path: <linux-wireless+bounces-15433-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB0F9D07DB
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 03:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12BC1F21B41
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 02:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CE31D696;
	Mon, 18 Nov 2024 02:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="aB1nkNf2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1177F1802B;
	Mon, 18 Nov 2024 02:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731896624; cv=none; b=kCXyBSPBEz6bGQy1DIZaaaJ6aDR3EpoxP8o3ij6RJKq50E/+2C0k57HwtmDrS6VEQkEo1t3xvLZuV75MV7CLEfNQM6q4vKKi5V/zL1zAt8B2+MXE3CLwWDHBxuBhni5913b+cKaHMGVSWjy6eMwdwA3fL5d2kNfOlVyEbXaqQ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731896624; c=relaxed/simple;
	bh=zBvyMW1l3nuOVD4PLCHV7981Hc048pK4JQXFcTCUR6A=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=aC63WdWXlcZL2R/58DIgCef99YqXNiHOpolhd0YzhuHfRmBU4M+FQ19CTDYCd0DGD4e+iaAe5jGKEGfvCdUytv1ypAgbORgIJqQ7fHz/ycfL7qQuM2tH9yOSSkCz0oddcftTopHM5H2wFfz/INA25SGY3J9dT5vREarVBN3TzpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=aB1nkNf2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AI2NSeV44167482, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731896608; bh=zBvyMW1l3nuOVD4PLCHV7981Hc048pK4JQXFcTCUR6A=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=aB1nkNf2AMG+xI4SwGdLvVUsBrcTUuzUlS3Zrd/0aPHrWjGYNqlTI5NgpcplzwtP8
	 g5/+7ps8m8A8q6cWmptS+DBkW9LPYwub1W+jmC7sCM24xbMEacv61WnxwH5pKGqb2N
	 XMmh1lXQC0le3yhi/tqseOjv02Lf34SKT/NO0ONhfUGPXHTEbE1IFFpBZU0GsjZK15
	 Mazfj2YiNQYfOfGSfw2Hj3FsvVFVR//JqoabgLUaKtsAzHxiFifWIV9gwpmOC41ZtL
	 mIJWbyxrd19Nuzai0edPCS04LVW7qWPjRDCahaX2rB8G851o4JAQRfIP6VEvS7CbJM
	 DK8Kufw7veMqA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AI2NSeV44167482
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 10:23:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 10:23:28 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Nov
 2024 10:23:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Hans de Goede <hdegoede@redhat.com>,
        Jes Sorensen
	<Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>, <linux-wireless@vger.kernel.org>,
        <stable@vger.kernel.org>, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH] wifi: rtl8xxxu: add more missing rtl8192cu USB IDs
In-Reply-To: <20241107140833.274986-1-hdegoede@redhat.com>
References: <20241107140833.274986-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <6cf370a2-4777-4f25-95ab-43f5c7add127@RTEXMBS04.realtek.com.tw>
Date: Mon, 18 Nov 2024 10:23:28 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hans de Goede <hdegoede@redhat.com> wrote:

> The rtl8xxxu has all the rtl8192cu USB IDs from rtlwifi/rtl8192cu/sw.c
> except for the following 10, add these to the untested section so they
> can be used with the rtl8xxxu as the rtl8192cu are well supported.
> 
> This fixes these wifi modules not working on distributions which have
> disabled CONFIG_RTL8192CU replacing it with CONFIG_RTL8XXXU_UNTESTED,
> like Fedora.
> 
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2321540
> Cc: stable@vger.kernel.org
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

31be3175bd7b wifi: rtl8xxxu: add more missing rtl8192cu USB IDs

---
https://github.com/pkshih/rtw.git


