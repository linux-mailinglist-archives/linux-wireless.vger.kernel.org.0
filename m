Return-Path: <linux-wireless+bounces-16881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 645579FE194
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 02:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332791881CD2
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 01:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5EE8F4A;
	Mon, 30 Dec 2024 01:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="vrLKDzHt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C6833F6
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 01:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735522055; cv=none; b=TVol3/BCGnzJHu5uRtWxlvVP0R0BoLg3/hrNUYMkFJwIYAbyN4dnFraLHElUl9cuMLAirTQFed7BKhv18cg5EC+tuiI8VTivcj4mSizwgkxTUEabvpwac0EEf22SkN4UNKD27KbCZu6ipnA+xl99V/oQG9crlSMMhkFEv26w4wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735522055; c=relaxed/simple;
	bh=VNlJRur4A710M9MUsyHsZx2PDwJt/zRKqbyq8gfftgw=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=qKMgqEywNZ/zumguNJ/n4aRwTce+sMWx3WxVc82G2FdKdJ5JZAXDTSezDtQuuiCyB4/QqERFzjzVSVWG11ufsiFX2hEMyP90Y0R2Q9paKc7wcuThHMInmZwHnyhkRlKsgFbyV40NIH2yfW4wusuqYb5GLhUi6wK1WC6dKqMFlvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=vrLKDzHt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BU1RTnaC3530756, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1735522049; bh=VNlJRur4A710M9MUsyHsZx2PDwJt/zRKqbyq8gfftgw=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=vrLKDzHtvPvP7T00vPNTAMkUCZKcsx6tJnWlmCaXNf1OEpoGH9DK2vexv5QlRuVaA
	 j/xhJQlCfaDyzwaSn4TRLp1Vm1+ixmkWNaY1KKYVtkeVzX/+4NrHWUJqel0gh3DhWe
	 zgW3PdOrbzHdKatsdINHKh5SKyWIxgUREcNrlV3aN8OS2c6wrIGNqeJxMCkYUW+El3
	 1qGfqiFZh3Gx3N0O7YqjRRgG8EVkvdIsvAk59Px4iPkWwAlyDu6vunxcILc37zuDHj
	 r93wVuXz8iW/TNAWRLmkI6mNqmLXROD+Vr7FTvfG/yW11YPxtN4btFbtM/s9A2xZti
	 bohe3pN5g/mhA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BU1RTnaC3530756
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 09:27:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Dec 2024 09:27:30 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 30 Dec
 2024 09:27:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: debug: print regd for QATAR/UK/THAILAND
In-Reply-To: <20241219014545.9157-1-pkshih@realtek.com>
References: <20241219014545.9157-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <99e94917-df77-406d-9be3-bd811241b967@RTEXMBS04.realtek.com.tw>
Date: Mon, 30 Dec 2024 09:27:29 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> The regd enum was extended for these countries. But, the dbgfs doesn't
> recognize them yet. So, add them.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

2927cb7b3b4f wifi: rtw89: debug: print regd for QATAR/UK/THAILAND

---
https://github.com/pkshih/rtw.git


