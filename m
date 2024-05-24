Return-Path: <linux-wireless+bounces-8044-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1532B8CE413
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 12:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C16E9B2199B
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 10:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781E784DF5;
	Fri, 24 May 2024 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="JGm9A3oG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF5E1AACC;
	Fri, 24 May 2024 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545955; cv=none; b=FY+20d2ZScULraP7uLgIwDMzCJoZwJzrqtBi2PQSaqBVSc8zCena754UomWI+VEDRApg7Y+rmv0wtwUKX3Gw+gGRTFtWeFCfix2KDJXDoJcf5czPjtopDaszTGx9GckEB+WM8e9ZvvzJN+q+AyCDGBum6lT617B3doyEkVKXnZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545955; c=relaxed/simple;
	bh=nReJdwDjYKcKtI9FDKajlqqInbmssOMeKltqgga7Xe8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=epKc+2e2i7tckegAsPWB5HgVhMX2LiAxwT1Mg95n0Kgus2o8eAitu6fPvWZPdJDThcy0t7W+Q9FmznKHZ/Bi9Gyn7cG5r5hEm/3YzdaOzcyJta4x2DrCW059gmCmgVDOVGRGvGyvUyIouHmcRwWW+payZ2X0qo56V3hb/pshEgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=JGm9A3oG; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716545936; x=1717150736; i=markus.elfring@web.de;
	bh=eD4aGK2cX9KrbvG0DJp/VpQLhAY1GKGKoM5iZey2/S0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JGm9A3oGw46GtDQxgiMe6SJkDlIhUFIIrYCXNM6YFzCp7eLHLmiOKbaNZQhfv2sN
	 2ly3Jwz9pWwxaUUJ23wq+BRtBEBxsrSlooKJPfaieIPrS5HaQsBZZefSjY3uc7FYU
	 S9w6xYsASGIP0yrf1nIa/oDd8ale6aOxBwUL0jX+l2mEM3tliXal+1M/1OPLxBBXa
	 AuzExC1vrXoKAukT0An3WsMzLhDrlJOG6FHW4MrDBIOIj5wNAfI5YkWIQ+LwG9pMJ
	 eZlIJJy9WEZVOhJi9MDvi1M+ddtG7heig6K44Me1ah/u0KZ92OCteodpO89w1wDQE
	 muEpFuQdb++Ryx2CFg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ml46w-1svqWq15m0-00fyCw; Fri, 24
 May 2024 12:18:56 +0200
Message-ID: <5da17b58-c407-498b-a666-be98584c8011@web.de>
Date: Fri, 24 May 2024 12:18:46 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, abaci@linux.alibaba.com,
 linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Ping-Ke Shih <pkshih@realtek.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>
References: <20240524075819.2789-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] wifi: rtw89: chan: Use swap() instead of open coding it
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240524075819.2789-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yvXSYyhRuNt+LnoNZgQSyhtIG2CajJYTbJ54zQb2j9ihrzwk4Pe
 1DzaZo4XB7QvBgPvQWnxsXj7VAmFzOHddLOad549auPmJDBozB+Svf16EyN72B4lzzbyDu3
 3dJXtPSCEOY1LduvsqTyG/yiSvTJPQeGn7vKP3wKPUX24TpDoKDDFfScN5/zM0A1i6V4udp
 ypd3eQOUAr69eJTHP67+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:K1LvBUbMTqI=;Q0kze4LcBNm3U2z2itILblmvdPJ
 951ScoDbyuiZpj7qZqrDf1xpDhwK+JhD+s358K85Nppdu95mlXGBENgmDlWz6dsswaMbEhUzd
 b/EkiPRyyMyKCiWMefrpBzYAZeUAorgvXzfMdCmZWa5uHf/D1leUlr6gXLQy7Z+aQKe2g5GRn
 7uAIsHuVQMwTF6gIqJNDEsecIqYqs6MNrLCkfQr9RfLQDgGYr37gaYS8J8MHL/schh28ufKNw
 gLXs2sUYPbVuufPptIlmsaWJtjlI4bVxBKk1b8UJpA+gurAe1Io9WsxUTeeZLdZMRBWyMRMaC
 a18BDpIQNU0IS1hM5jKgcQUVcdQ0DCYqEth7NV0ybXBx1m1GHuBOkFZVY+EF4qHA2qqw851zI
 tahAd3iBeorjX/cnffLpIPyKELH7GfNqebc2Vj3ZGPnoXB/QD39h52G97k2vZfXOaV60dW+9f
 33Q0skWotM5G3O0nRHcVn2Ur8IM3oNwAwGe5+lvphe3ik8dYGKnUegWwjpQ+9mv7UW7LQbf7E
 EsF/3liVEJkbTnTVXwsV31/hB2pFOrOjfiEZaafjtuaBJO6oBvt7hrCQ77G+myZHqbwOBcGe7
 DuDJthCywqSfP8tMXwK9goULnOR5R3hzFUQrcnnMqzudJVWr9XZuDNbwDqdjNVjQnXd6YY49G
 A7BKfyhWAagHYolOfdN9J6RMll7/VgfcVGHffzOancIhLGS8ASj/QKjaRHFxHth//TAq/pAVF
 14J11CJidodCQ0j3bEursWSvH+LbcGz5P86bTeCxqf6h8TBevd6rBkTgSdPRMt1zDTMA4TNAU
 OqN+JHC9FCxfa+T6HxPfuMbeJIxyMgJll8b3WyuAy+cDA=

> Swap is a function interface that provides exchange function. To avoid
> code duplication, we can use swap function.

Would a wording approach (like the following) be a bit nicer
for the second sentence?

   Use existing swap() function instead of keeping duplicate source code.


How do you think about to apply the summary phrase =E2=80=9CUse swap() in =
rtw89_swap_sub_entity()=E2=80=9D?


> ./drivers/net/wireless/realtek/rtw89/chan.c:2336:32-33: WARNING opportun=
ity for swap().
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D9174

Would another indication be helpful for the involved analysis tool?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sc=
ripts/coccinelle/misc/swap.cocci?h=3Dv6.9

Regards,
Markus

