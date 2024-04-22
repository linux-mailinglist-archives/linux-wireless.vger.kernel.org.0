Return-Path: <linux-wireless+bounces-6608-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3978AC289
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 03:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88199280D5C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 01:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913D81391;
	Mon, 22 Apr 2024 01:33:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775B81109
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 01:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713749582; cv=none; b=MGa8GhK3s8eBb3ZdFe6vYy/1lfS032sist+NzxF9w38lUKogUpLMJ9fVZiBkLtCpw3sZQVQmsYamaUAEb+n4C/FqRxrsliKqBV1K/a/DAXzXT4WNQK07a6GmkTmbYh042NHdGrYcSeUQmhu6aT1tn/WSzT3l2bPZmKoiwHq2O8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713749582; c=relaxed/simple;
	bh=EuCRe3hjZmrjMl4rBLF10nHxpZW3FM1HPrpzyD4LTL0=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=XRfBQOTjVGRiMRJcl/sUmYyP8sOuXIdn+gq75O/ae68MqcWjNLLAm7ClPqIa930SMzmSw9s2C4ZyqbEKF+0XM94NFVV/oW2k2h2qnzM0LjYW4tb9iuVKfTjPjZ8POu0oRUZ4RKXihllWsfDxFxeE/jDmLq5Eee91XOWSd07hv6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43M1WoMF23697720, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43M1WoMF23697720
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 09:32:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 09:32:51 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 09:32:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: Re: [PATCH 1/2] wifi: rtw89: set WIPHY_FLAG_DISABLE_WEXT before MLO
In-Reply-To: <20240417090050.42607-1-pkshih@realtek.com>
References: <20240417090050.42607-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <0d6ed492-91cf-49af-bb40-df30bef618e5@RTEXMBS04.realtek.com.tw>
Date: Mon, 22 Apr 2024 09:32:50 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> We will support MLO on 802.11be chip, e.g. RTL8922A, in the future. At that
> time being, we will set WIPHY_FLAG_SUPPORTS_MLO according to chip info and
> FW features at runtime. But, with WIPHY_FLAG_SUPPORTS_MLO flag, cfg80211
> will disable WEXT. In case inconsistent user experience, if 802.11be chip,
> we disable WEXT uniformly from now on.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

d50334c38af6 wifi: rtw89: set WIPHY_FLAG_DISABLE_WEXT before MLO
0a548ecac7b9 wifi: rtw89: 8922a: fix argument to hal_reset in bb_cfg_txrx_path

---
https://github.com/pkshih/rtw.git


