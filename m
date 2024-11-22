Return-Path: <linux-wireless+bounces-15592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 604209D59F4
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 08:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF136B20C70
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 07:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42951632F8;
	Fri, 22 Nov 2024 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kVRdLHZX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAB81465A0;
	Fri, 22 Nov 2024 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732260340; cv=none; b=Zst1lfrYD8PmCaaK5SBSngZajSs/4LoykmL1wrNRjDjOmHl5mz0EXVrJrXW30/aXtiOOBNv+UOOsUear1xiu165vsh22nA6rvBf7YEEfssBhYFPVdYoq5WsrisJpLTSTr6ihXjRtrpgAVTo5HcdUItW2IxxIdaaLMcaiWPw/DiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732260340; c=relaxed/simple;
	bh=+3LBMIDU6kT+weG2QXrxqhvGNeFfqop4r0Rz1n+b0Wg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=bT1PyHdhqi6Gn7M2jl7KCzURqCYpa3U9kEGItudSmB8gwonv+fViNDnYqFxkFKWSbIubQtsO4iRFnVpiUBFDQQEiBKvXTewhuvpOkV7su3d7/rOEj6vS0559ZcI7IG/t42NMb5vRtiEcxJJf6+YmDyg6EU+wdtjCaI2W8Oj2G2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=kVRdLHZX; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732260320; x=1732865120; i=markus.elfring@web.de;
	bh=+3LBMIDU6kT+weG2QXrxqhvGNeFfqop4r0Rz1n+b0Wg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kVRdLHZXeOJYxgPVmOTwa52pkShs38aywk/08k1lv/dN7mwUl1d4r4vMPH5PaLU0
	 9K8HBFEEQWBd9HhCzAtGU7NrLd0Vnz8L5nqSTNOAXm0HxzNIg09MSH8zS5rTkifTT
	 I1Iv1YVBB8s7tyix2h43wnX5HiBcfPUdLxI6M7Ems31C/EPr2jF/H2FKiy9OpNxbv
	 s9ldA2MObAek3VTVgcTxtSDxwbSmdokH6ZfCPHOY9kRIRX6pQE8JIM/S1h6UO0NHl
	 2z2TEzEjXDPnSLHnxCdaaSvDCJSCLnYLVYdzLssHNYo8MxRiy+X3lCn5zS8EovbNb
	 NdAPV1FKMgobW/DUWw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNwfU-1t3Rns0U3c-00MhTL; Fri, 22
 Nov 2024 08:25:20 +0100
Message-ID: <66f051cb-13c7-47c0-9985-4c7c034e186a@web.de>
Date: Fri, 22 Nov 2024 08:25:08 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Benjamin Berg <benjamin.berg@intel.com>,
 Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
 Kalle Valo <kvalo@kernel.org>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Paolo Perego <pperego@suse.de>, Shaul Triebitz <shaul.triebitz@intel.com>,
 Yedidya Benshimol <yedidya.ben.shimol@intel.com>
References: <e37392a6a1fcb11db42646da2afe055416ca4cea.camel@sipsolutions.net>
Subject: Re: wireless: Fix a dereference before null check issue
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e37392a6a1fcb11db42646da2afe055416ca4cea.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dpK8bG/CzWDruyDmwu/3fqpAzkWR3UwIBvkW97IsUOQaLHrthuJ
 WdGsckxXYgWz0sy1gTq6e43oXLLAd4M/b5CXJYwm/uXv6KGKB4mHlx1QcPuGVY/YbrgqLfa
 LEtsUDyrNJPR4PCQ6+Vs2rVOEO6yAg0hNGs0aIp92pAn8gxRu+EiiMTnksw2fnS4wyLuGKh
 Z4G3TB+PQleh/mWMFY/vw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F44GFq45A4g=;OiQbKRvC43YUNCgl3iSbgDHUUhF
 usHXBKTHaGGEwSYh/FejfUreC3RMLS+I5M9La1HoZhNO8IwFbptm6XIjlXRgpuVVtHyYML59f
 h26Kyst1yqnHI/EtCEYhpt12RbOuStRG9iV4+d3At7Tm4RDOY4Tlh/F0krLzcOZEAQsPYwM9l
 mC1IYYWJOe53Whxjq2r0MyqSPt1CdRyqBP7/NI6KwOTeYzcIElD1l1Xk8BwslJejl6g7y9fd5
 4Qoi/mJwNe5BuxALWuExpBnz284+249K/WWwqaGVPFutTivhKwVUPCR3YbmNHRV1S7bC9UO1I
 s3k+OlbKYsirZEWlIaoqHQ3k4vRS8FvxfPiYBSrqmxnjV1JumSZWBu6yJmfSiRINGbOE8Rw5D
 pEJOoa3gM+1zfOoAh7PSeMya7OtXEhI0WiWfKogxtxFxnVRJP81Prsa2gWovxhDvxPhqseaQc
 BzgNy6ADCEiGrfXe1QD0rrM5ShgEkFUtB63iwdVKBgBeVPwUxr7LWWArrG9qBV+VMtF2ogX0D
 QFsDcOyN50xv9nsvC0zE2g/lId2AIrVW5p1Bhr7OliKkKZ7uUmq1NuIwLaIUwe8qMWcXAUo92
 NxIq9ry7b3PiSrvxX/OoTlxN8FETPmesO/XKSBtn1VjZMwR3+F+re84fX1S5gGCaX3FSjsUkp
 8c+NuOqkCEwpXlv55PX7pXXCadRGS2syv2hal5sE1xhATgHUrsvQafjzt5txlhqDZ8gL4PGMh
 RrLhQHFoU3BNzrjCt8op9imTvwosBeCo1P9Pp2uRZX7XkcRZw5anQyq4SNR0aZyU8lDHJRtjT
 Lm5cecE/S0o/6XhdMN9bK7cZSgg9oVTAa4BB83QCgMP9H/Z1+0qeKqj8qovsjgUw87tmqg5Bx
 0h2fpIhypA3hOxMWl24YM1a0+MleArsAzS5lLvRcQyl2+giuJvmXyW4qM

> This was reported before by smatch too, and Emmanuel just made a patch
> to simply remove the NULL checks, because the pointers are statically
> known to be not NULL. =E2=80=A6

To which messages would you like to refer here?

Regards,
Markus

