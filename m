Return-Path: <linux-wireless+bounces-13374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3975A98BCF6
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 15:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B83ABB211C3
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 13:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6164A06;
	Tue,  1 Oct 2024 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="B4Cu1V4r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FB0637
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787662; cv=none; b=rIT0C/mAd6AWuH43SuBdCsCx1nlvfwddG41CbfxtzqOqKG2oqxdYtHoyar8M2cwkOlkbR2X+ItrjHeqoPKZ+HMs4h7jJthXbF04uieLmwDE92XXviNp3WbF5Ajzxrm+jGQoT9di1KrYZvHfiq6heGrK5aodY7TWfDzatJmZEJWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787662; c=relaxed/simple;
	bh=p6cf2P/1KJ4fGzbVfBLSzIHbbgqNQQO5bIj5fNmCBek=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=sEz5XmWYEdcm+mBaHUCrLkPDRJnbW34f6PU9pQ6E/qbyNhzGKWNWz5ZgMP7ypzIRarDdkyu0nQ4PJSb42lTJiMW09ys7V6aGtivfC69X1hfQ62zQS40n6G6SxqcJPkuZePa6U7EcjqR4yUArdgtVw681lt8p6OkAXJmOENGYtzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=B4Cu1V4r; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 491D0oDE2999121, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727787650; bh=p6cf2P/1KJ4fGzbVfBLSzIHbbgqNQQO5bIj5fNmCBek=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=B4Cu1V4rPG0iWiu+l+Gd1/wbDUNLNjuVjt5DqZtBgwxKYvJoGq1/tFl3z1VE00J2g
	 KFGs1OAPgoBNmyOXE6BFzaGrR6ZXhKLYeXMuRctZvcMa8DbhhJBbaMaJYw7J9QwHtl
	 hnrx7JZaoRKpurmdSQsoR4yoI8EI0jwl/F9nFXLcPuVLJApgyDR3Xh3alOdqzOsXXq
	 yJ7jX9gKRkdixdpeUbPUgL7rakZawhIKCDcp+0qKt6MNl1Auoqbqwfjzc6laSAHMPn
	 BGI5vVFm3aLFwWUfUCdiVRgZ3Kw+hR7+ET4c+QqntXBpK6FZGqTY/xzyFrbeZmiJ/q
	 110B8Gfj5AgTw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 491D0oDE2999121
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 1 Oct 2024 21:00:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 21:00:51 +0800
Received: from [127.0.1.1] (172.16.22.72) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 1 Oct
 2024 21:00:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/4] wifi: rtw89: pci: consolidate PCI basic configurations for probe and resume
In-Reply-To: <20240925013901.9835-2-pkshih@realtek.com>
References: <20240925013901.9835-1-pkshih@realtek.com> <20240925013901.9835-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <5ccff54a-aaad-48c9-8119-9b87a1fdcbcd@RTEXMBS04.realtek.com.tw>
Date: Tue, 1 Oct 2024 21:00:50 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The PCI settings aren't always persistent after chip suspends, so
> reconfigure the settings after chip resumes. Since most of these settings
> are the same, consolidate them into a function to avoid missing somewhere.
> 
> Fix the missing case of 8922AE resume flow.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patch(es) applied to rtw-next branch of rtw.git, thanks.

1a82680839ee wifi: rtw89: pci: consolidate PCI basic configurations for probe and resume
bbc0be2ee2d8 wifi: rtw89: 8922ae: disable PCI PHY EQ to improve compatibility
c76afc421cf7 wifi: rtw89: 8852ce: fix gray code conversion for filter out EQ
6f46547d3db9 wifi: rtw89: 8852ce: set offset K of PCI PHY EQ to manual mode to improve compatibility

---
https://github.com/pkshih/rtw.git


