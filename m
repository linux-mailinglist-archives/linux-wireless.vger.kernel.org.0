Return-Path: <linux-wireless+bounces-22421-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BCFAA8AA5
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 03:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7989918931C3
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 01:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01860188587;
	Mon,  5 May 2025 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="HybIZt8p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C98214B950;
	Mon,  5 May 2025 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746409215; cv=none; b=VrmkDQApPjwxfTesrEshDtHIvS35m1pPNLiEuAwYaGqd6nWP2y4hagPcos1sDP8uHvn8z9KFqwq9Jg7d2kXZjSKQDhPaUdUxGEsQgBzaTmWasQQlkjsWDRrvVNyhMT9qIzIqNQJ4uzuYVO5YqkoYiEHh8nBbQjJYSk0tkcwd+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746409215; c=relaxed/simple;
	bh=4sCB9tgQppUJl7cUoS9258sEW/5by1jhCOsqXVeoQSM=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=XnpZCzbYnEefp5Hg6nAcXmsKBZz8bBUVK9om2YFCD3cqk8sHXUKEKwfclcxT891NBLSbi+iVeacuTqYtNbc39CN/sZpp9jAxFl4wHbsaW6gXVHUTojnp136Dq/iPhNf/iyZwoI2rddBFkFeVM2Mu5S2H5zW9CJ6tkXJXq0zgs58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=HybIZt8p; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5451e0Sw93384589, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746409201; bh=4sCB9tgQppUJl7cUoS9258sEW/5by1jhCOsqXVeoQSM=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=HybIZt8pV89odwUMc16CA/n0RF2oapZEhJ01aeNv3Xtz+bJ7TVMQUGvLLJ1v5JV8+
	 CUrhmMvbSFK3qiF13CAq8Vzr2RCQXiijDuPLu4f/ClIjYfXeyp9/OFSVlaxzTOiW94
	 3Q2CqHdE9rzJilZQ+v2eIcQEAoVNMX8PW277Q6pQsPWwPFULYbWKjzcxRvY8X5jc1Q
	 2do5IVkAItQYrcsY3PbGWtEon0RkkEtt4WkFAKe+Tt0xCa2etaNpYbu8S5rkl9xQox
	 sWQt68WyOGO4h6Ajd7KG0YUYDdDgDPgDPT93UXhEsc1gPTrlA++zFFLWTErOyiYrlI
	 cqGhgtqh+Sa8w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5451e0Sw93384589
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 May 2025 09:40:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 May 2025 09:40:00 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 May
 2025 09:40:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kees Cook <kees@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>
CC: Kees Cook <kees@kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: fw: Remove "const" on allocation type
In-Reply-To: <20250426060935.work.049-kees@kernel.org>
References: <20250426060935.work.049-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <501a4bd4-cb49-45f7-b47e-7f59f80a497f@RTEXMBS04.realtek.com.tw>
Date: Mon, 5 May 2025 09:40:00 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Kees Cook <kees@kernel.org> wrote:

> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type is "struct rtw89_reg2_def *" but the returned type,
> while technically matching, will be const qualified. As there isn't a
> general way to discard "const" qualifiers, adjust the returned type to
> match the assigned type. No change in allocation size results.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

5b8dfb75b2c7 wifi: rtw89: fw: Remove "const" on allocation type

---
https://github.com/pkshih/rtw.git


