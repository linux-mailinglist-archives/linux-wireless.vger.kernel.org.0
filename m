Return-Path: <linux-wireless+bounces-20284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD59A5E926
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 02:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF00C1896E5E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 01:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2434FDDDC;
	Thu, 13 Mar 2025 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="h1WQyKQ3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020A847C
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741827635; cv=none; b=jw9T/xHj6RTKQ0w5um7Md8Ky6qI3dIu1oXjQo4eZcdWUxmR8nTRMESOqe6tMamrO6qRhheYdGXSSpIXyQM1cY4Zu3zeuW8HONGx+HtAAaO1LRejm0JhP4lrNL41MVi9h8JDltPYlmlF69017HI7/+V0J4uOhqop7HlCHDWta9EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741827635; c=relaxed/simple;
	bh=KTUTE0GA+7UYYudrr3/wPuVw8R8wBvcP/1amXeMjpZU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=rn+UTvEXKL5ezF1PppSydxmUWp1FiAc7630NgUnkci7Jg3o6aWklrF3ZnGs+AQcA52dFf1NRZ4u4BEA89zaukHr3VCrBp03ErMYKKBDXhJb7i0YiaMzi3uzk0nRBiaGp21Rhb3PSKcDgC97D94Fj8M5avB9FdBuwpgf3gFQaucA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=h1WQyKQ3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52D10SiK4233704, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741827628; bh=KTUTE0GA+7UYYudrr3/wPuVw8R8wBvcP/1amXeMjpZU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=h1WQyKQ3Teui9n9iH8uSxKkPAByu5nwAr4y+8duzE/Ms8uIE3rYrGljAYuW0Df9PS
	 94N/3QPqy6PbHIPb5u2T4qKvsT+ramb4qXy/R20CAyMorsZRUmL4+0Hsd7LU78tCIJ
	 y3uek2RTtLYCqy0SQlWfvw84btgC50SNmJOeA3iHQTN1q/6EyiaKGu8OXPHst7xyVc
	 ltGdYvRQFurT9+F0nVcabDZgZFhP7bybF/1NVhLdx17Igr03t9ubVtxWEq84a3onZF
	 6044oN1v9JEXE7MH+WPE7DOYjnT9eW++BXLIVrK8UwqwAeQYBYp4IAVZGeXaPsMMRP
	 ETRNQpTCgY7nA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52D10SiK4233704
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 09:00:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Mar 2025 09:00:29 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 13 Mar
 2025 09:00:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>
Subject: Re: [PATCH rtw-next 1/5] wifi: rtw89: add support for negative values of dBm to linear conversion
In-Reply-To: <20250306021144.12854-2-pkshih@realtek.com>
References: <20250306021144.12854-1-pkshih@realtek.com> <20250306021144.12854-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <7dc5ace7-ddd5-4399-b25a-24a9707c497b@RTEXMBS04.realtek.com.tw>
Date: Thu, 13 Mar 2025 09:00:28 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Kuan-Chung Chen <damon.chen@realtek.com>
> 
> Enhanced the dBm to linear conversion function to accommodate negative
> dBm values and improved the precision from 1 dBm to 0.25 dBm.
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patch(es) applied to rtw-next branch of rtw.git, thanks.

3df4583ae0cf wifi: rtw89: add support for negative values of dBm to linear conversion
8ef675fc797b wifi: rtw89: refine mechanism of TAS
9c225e119866 wifi: rtw89: enable dynamic antenna gain based on country
6f039d9ba9cb wifi: rtw89: 8922a: enable dynamic antenna gain
a9b56f219a0f wifi: rtw89: set force HE TB mode when connecting to 11ax AP

---
https://github.com/pkshih/rtw.git


