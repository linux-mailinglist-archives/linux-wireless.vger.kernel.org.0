Return-Path: <linux-wireless+bounces-20990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9AAA75EE0
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 08:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0F93A7999
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 06:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F961519AD;
	Mon, 31 Mar 2025 06:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Eg2n5dsB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D663713A258
	for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743403112; cv=none; b=afZY5TSKEua8CoWnQxxr28YvqNF8ssKfd+MJTJcYyfMjCtwcgG7jlxoYIAw8MQ2ik/hFG9leK1QPM7RLgDNKwPTFTzBpcda3DMMsmZwNpeNdoWcX+h+6zyuvOPLoafjz5dlN+ViJ8yyaNP8S0PW24ZboNWy1CrNUYI7k57frXHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743403112; c=relaxed/simple;
	bh=+DzqZLtMeEgPXoVYXqk67AyLJm8rK9G+Z2Hu4Oj8V6M=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=GXNoSwTpypZKUk7C2RXLM4fkTXEP0sQ+waGcnZ6LLQEgIpq5JSIcMwZBfRksdjXe1MfUCm5rVQ7eiFYhRE3ASByoP0+moH32J6dz8ZzH2m3dVdK3kl9Kxh0R190KBRyy9BNTqhYsG5pqUcaKmTyDAWspat+9iNe8jSBHXoliY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Eg2n5dsB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52V6cQH012899858, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1743403106; bh=+DzqZLtMeEgPXoVYXqk67AyLJm8rK9G+Z2Hu4Oj8V6M=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=Eg2n5dsBBmlyGc+tsucYWFyveKhxZ1qjUztIvYZtHxbStIcGXpGjZAnvFCBMrDXRb
	 xMIeLquqfZPAzGU9a48LH7zxVp0hqkQax55aQQUnPCsfPZOhKAsEYVLAoO7rpp1LwH
	 Se12UEzWEGov3B+vaFx2hznGnNUWrAFJl1CxJ2WiJL6cRR5rOpu7vPlRjhrHMywQBi
	 YOOknwFk7y7gXMPRP2zci6/GVhXjjDn8YEfZkUBwp1n47RFBQLTqSvwob5iYXIJ5p6
	 M+z7i6HjafRw9inygQ+PzMSXRZ6xas1joSS4lletLIAI0389xHRhi4w/lEjcTq7VYR
	 S55oQASKHnBHA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52V6cQH012899858
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 14:38:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 31 Mar 2025 14:38:27 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 31 Mar
 2025 14:38:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next v2 01/12] wifi: rtw89: fix typo of "access" in rtw89_sar_info description
In-Reply-To: <20250326020643.14487-2-pkshih@realtek.com>
References: <20250326020643.14487-1-pkshih@realtek.com> <20250326020643.14487-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <258c5c99-1309-487c-acbc-96b1eaeeb743@RTEXMBS04.realtek.com.tw>
Date: Mon, 31 Mar 2025 14:38:26 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> The "acces" should be "access".
> So, fix it.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

12 patch(es) applied to rtw-next branch of rtw.git, thanks.

8bde621f124b wifi: rtw89: fix typo of "access" in rtw89_sar_info description
4cecf9912492 wifi: rtw89: regd: introduce string getter for reuse
1e262fc8df10 wifi: rtw89: sar: introduce structure to wrap query parameters
88ca3107d2ce wifi: rtw89: sar: add skeleton for SAR configuration via ACPI
5ee5f848469f wifi: rtw89: acpi: introduce method evaluation function for reuse
91f4ea117467 wifi: rtw89: acpi: support loading static SAR table
2eba885ab8e9 wifi: rtw89: acpi: support loading dynamic SAR tables and indicator
5bafc85d71a3 wifi: rtw89: acpi: support loading GEO SAR tables
c6c830b26590 wifi: rtw89: sar: add skeleton for different configs by antenna
711b6ce3e816 wifi: rtw89: 8922a: support different SAR configs by antenna
7b51b39368c0 wifi: rtw89: 8852c: support different SAR configs by antenna
28b921020bab wifi: rtw89: 8852bx: support different SAR configs by antenna

---
https://github.com/pkshih/rtw.git


