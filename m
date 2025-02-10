Return-Path: <linux-wireless+bounces-18684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6E7A2E2BB
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 04:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F4907A27DF
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 03:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216DA5336D;
	Mon, 10 Feb 2025 03:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="MYSjlHoS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077BC35957
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 03:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739157998; cv=none; b=BkOKWPPN7wl3SmmZ0LEvf4sYS9XsJ/5m0v73d5dlGRctLpcbD1b0u+FXzJ+UDTzGIQCOjwlGhMM7PvGsUAebo2FBdkj4vP5E0a8s2gIVl8Oc8R7V9E0oZuJgNbd2n2Ym1lk3tYPxjLlu5Y4r/63QBsMb6ZVhX0PzHmG2JZDP0UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739157998; c=relaxed/simple;
	bh=venAAyHHLjHPFfOxHHH23qChY1m1vCs7oBbHeFg9Y7g=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=IemgCACi7L7ECXxUbaHGFsMJ1Nxj4g50bkKDvz1Cf0uHqp6smrQYOMDKUJSGZc580DFssV1cVnMRstGStDg6YHnF5TfKfHBz62cQfXU19i3IaoN8CJWRvZBHhn7wxkLV0ngnYtTxIL7fYNegrdTfW0fa9q/kHT0/mJkIXJ+zcW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=MYSjlHoS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51A3QWL801573522, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739157992; bh=venAAyHHLjHPFfOxHHH23qChY1m1vCs7oBbHeFg9Y7g=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=MYSjlHoSJDwVrCB66pHgu9CC15H7o/tx94fZ2f2rThgZkYYArxKTMbokqvlpJIYT4
	 TqFICUbQ/LQELVKjFzN/iyqnBUE924G3kOiYEFQ0A/IBO0W5v6Qsgu8GQbBmF7x9+L
	 dBd41+4oN8gKg9C2S68Zcay2fpWF/t/JGfaR0uqBoe/CEo6DdMVyr2837eXm/3IRwC
	 BD6o7uovw9wSyj7g8dTdbX7yVU/TS83OajOgMeembUcziycKSwp4HwXd8XRb2ME+qd
	 DW2nFU2J463JzmRHC0oHXfNvHRlrUzs9UsZFy1/oak4ZBZPFHMh5QBSmDiukRZ5DiN
	 6e59zg5HKGTGg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51A3QWL801573522
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 11:26:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Feb 2025 11:26:32 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 10 Feb
 2025 11:26:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: Re: [PATCH 1/3] wifi: rtw89: coex: Assign value over than 0 to avoid firmware timer hang
In-Reply-To: <20250205013233.10945-2-pkshih@realtek.com>
References: <20250205013233.10945-1-pkshih@realtek.com> <20250205013233.10945-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <e606e615-975b-4b1d-a4e8-31c788ef149e@RTEXMBS04.realtek.com.tw>
Date: Mon, 10 Feb 2025 11:26:32 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> If the slot duration is 0, the firmware timer will trigger timer hang at
> the timer initializing state in a low rate due to hardware algorithm.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patch(es) applied to rtw-next branch of rtw.git, thanks.

2e4c4717b3f6 wifi: rtw89: coex: Assign value over than 0 to avoid firmware timer hang
e53aa85e4b8a wifi: rtw89: coex: To avoid TWS serials A2DP lag, adjust slot arrangement
f94ba3c640f6 wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 7.0.3

---
https://github.com/pkshih/rtw.git


