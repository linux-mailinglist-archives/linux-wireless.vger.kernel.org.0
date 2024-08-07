Return-Path: <linux-wireless+bounces-11053-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D5D949E31
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 05:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC1EB1F23569
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 03:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8B21A288;
	Wed,  7 Aug 2024 03:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bSd9xqkE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6DB667
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 03:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723000482; cv=none; b=e3W9DI855GJk+cQ4IvHDIRO3aMq60w0dFLrsnTJ+hrTtIWRhIaQ/4zPlJloC088ZmFlj8y4LzeyEgfGcbqM7qxEuGjXUQVGkOh4CaKwO3IqPJ8vFlLl0mfUCuR6F3v3Y56s2aQd8huH9u4Kj1qvI4k7AyB/z8+vDizxk3Lk5Vyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723000482; c=relaxed/simple;
	bh=vQ3tCGNroWmCaiHFR01pCHhgH6EUsyg5cmBbcXZk1uM=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=A7kP0CW4ZYLM8RunEU9cG9bkn9ivxs4zJRgDRSeOkDFz/qxjBapOazxSS1+KZNK3EpjrFQjvHZ8Qt9ctfp7GmuWJgDcYwSwPpLtvyH3BS0Qix9leE4V0q10mG2uXnMicW6O4dLe1tcIPZRwtnR8vVcn+lrWWfs1h4Q/gFoSDQkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bSd9xqkE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4773EazgE1889721, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723000476; bh=vQ3tCGNroWmCaiHFR01pCHhgH6EUsyg5cmBbcXZk1uM=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=bSd9xqkESh30Odjovel4cjz9K/JW1+tWg9I5PqA6+Q3pB+jRAuaDnfqvj54fOhEmz
	 m/vx7hOYPr3jtfcnxBnH97FmwzTHH7znFE8zgUTjrMEKEsBH1a1o6evGnGy2iSm+VX
	 0X2VKFKC4fML/7xn0bsFfcs023353oOixExnetPOqb1JTy3M0vsIBl1MzRmjKkWbQx
	 5nAudDEQ1nDPzSciF4Od8g7P+/XMOj+PffNiHPRYewuFSPpzRxuwsiTBoJkR3uGDhB
	 xoSWgs3k+ClaUXrwrvP7wt0JapsMEOJol5GRG954+yILkG/yKwcgzRVOnKioUk4mHM
	 88t1lIUDw/enQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4773EazgE1889721
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 7 Aug 2024 11:14:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 11:14:36 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 7 Aug
 2024 11:14:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>, <phhuang@realtek.com>
Subject: Re: [PATCH 1/5] wifi: rtw89: 8922a: new implementation for RFK pre-notify H2C
In-Reply-To: <20240731070506.46100-2-pkshih@realtek.com>
References: <20240731070506.46100-1-pkshih@realtek.com> <20240731070506.46100-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <09f26621-f622-4612-bd79-4e49f1412589@RTEXMBS04.realtek.com.tw>
Date: Wed, 7 Aug 2024 11:14:36 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Kuan-Chung Chen <damon.chen@realtek.com>
> 
> For firmware version 0.35.31 and above, update H2C RFK
> pre-notify to new implementation. Rename existing H2C
> to v0 for backward compatibility.
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patch(es) applied to rtw-next branch of rtw.git, thanks.

ca33c15a9360 wifi: rtw89: 8922a: new implementation for RFK pre-notify H2C
6ca6b918f280 wifi: rtw89: 8922a: Add new fields for scan offload H2C command
7dd5d2514a8e wifi: rtw89: avoid to add interface to list twice when SER
50961f88612c wifi: rtw89: add support for HW encryption in unicast management frames
89a4c16cbdc9 wifi: rtw89: correct VHT TX rate on 20MHz connection

---
https://github.com/pkshih/rtw.git


