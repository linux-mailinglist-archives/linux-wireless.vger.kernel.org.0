Return-Path: <linux-wireless+bounces-14959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6680E9BDED5
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 07:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CFA1F21F2A
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 06:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6740192581;
	Wed,  6 Nov 2024 06:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="OP17jV5n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AFE191494
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 06:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730874497; cv=none; b=eFGKQzRNNu+CnwmK19f8e7hhHZ8FarqV2wlu9VLNuIZnKQI1vYpId+nVLT7yDBGLfQqwYLCYR9q7jGRnjDtqeyYNqGwYBJn8hdy5ifdEWkQQ+3oQtwekF0F96xPtJBfpcAreX/4TvFUq3Ve4iTtVAjKz0mHhmiapYPqI63sTSEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730874497; c=relaxed/simple;
	bh=oUSZuhZYd05nILZ3o+mHRYFZdPgbzNWDiwFXuKQUayw=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=jMz8h5ZN88LvXjIPgG356x9WThCd0F4qNhdwcKtajR+05DwkrKfBCHATaI4vercWZpbXFwST4c+k8xMngldzbMElGvL2FD35972Ahym8xevzBEZ8s/BVPyAVl8Axj4EsyV4+m3ne8D88lf160IpdZqpF09M+mR1AuGU321mnEJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=OP17jV5n; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A66SDtgC2311626, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730874493; bh=oUSZuhZYd05nILZ3o+mHRYFZdPgbzNWDiwFXuKQUayw=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=OP17jV5nA3qzsXjg5SlmTZaQdhZYogjJ2uJ8GacyOokacsHBBBU/m3rIoUxzhkCUK
	 dkfuXJQmCgMFr1DZmgQfQ7I7ubs575yUKDZ1nheLpjz3SAlpYDUwPL/TyyojNoA2NU
	 xH37HYhtlF5SLGFfd7EeId9g782lHolu4I/tb5qxjJc+8MxriHaNzPr/PjkzyNuLjD
	 BUxYQmCofNpc1xqygQN4JJ7OhZ1HkQgiCk/vSb8doHkK29Pr+T3crzWMZYbbzautV2
	 7hcHnHQuHyXlWHMjvqZZ3Q4+u6m/+Nsqh7FY3i6ZFFdt21ejAYcZ4PBhp5Tzt0QmES
	 KsLmO7jTF9iYg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A66SDtgC2311626
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 6 Nov 2024 14:28:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 14:28:13 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Nov
 2024 14:28:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: coex: set higher priority to BT when WL scan and BT A2DP exist
In-Reply-To: <20241031023032.7102-1-pkshih@realtek.com>
References: <20241031023032.7102-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <b84d1b73-5c11-4fa0-a2b5-d4c27477b869@RTEXMBS04.realtek.com.tw>
Date: Wed, 6 Nov 2024 14:28:12 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> If WiFi operation channel & scan channel both at 2.4GHz, original will keep
> going at WL > BT priority table for a long time. It makes A2DP can not sent
> audio data to SUT device in time then performed a lag audio. Assign
> a BT > WL priority table when A2DP exist, to avoid the issue.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

1b1350e2008c wifi: rtw89: coex: set higher priority to BT when WL scan and BT A2DP exist

---
https://github.com/pkshih/rtw.git


