Return-Path: <linux-wireless+bounces-15685-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0887F9D8377
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 11:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C37281C6F
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 10:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FC1192B84;
	Mon, 25 Nov 2024 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="STtYNeC+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B701426C;
	Mon, 25 Nov 2024 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732530902; cv=none; b=fhKOPtCAcnDR4+9MbQh0YbYZrVsWnL8ELJSF45nv5XPG6T2L2k6/nQg460ls/Cywu3e9fHC1qDTaVBj0QP43LP5CuNJ866SVQguhFFNw1LoMk3oI4a7aioXp8iWMbIlX4KeVo+DkuQy6Gs1NYH33eNEyxkknNfHkuhNT2KyG2sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732530902; c=relaxed/simple;
	bh=dD6jdQ2Ttl2B2gtAU/uC9kxl7PsvaKisXM5WODPJfHo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=oFYl1Jm7SnhA1vOhHP0DwKNQ9bn+2Glx4A8HklHPCr34vdKDyOzUzY0JEVu9VONUvMhdMFVaIwO7LWoYP5/by4FtbJaBNJEaWIvtCKPlM+lEeAwbW60UuJZahdhQvJmtzDSghNpzoREyxHRuZKW4PtIdONfpOG5c2fqz82RxFGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=STtYNeC+; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732530874; x=1733135674; i=markus.elfring@web.de;
	bh=o5uBdUNquJHQi73QLveWVA003LlbDdqxpHsFv6U4gJk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=STtYNeC+4S2OY7xY0j8ADS41ii3BPoBv0NT7SrIY15nQYTtmiCjtrpdt8jCPTnJu
	 LLmUq7Wy9P3yahea5ZPn4ABuNnMx5kkKymhKbxyy8HQQuLQgpOWuMbWtQvHvZ0RRL
	 E07VS5qZB2QScHfMBUBEnz7il0ShJ41DQL/SSVu4uB5p56c6sMoq5IfXrMWXSi4Ro
	 pStE28PpIW7GGN1AmXuB8kO3uMLG6rWtD/ePEVG0NuuZVBvJhx4C7ouPb5ACO3ElT
	 KNAsfSW920xXC6JhFQbWcsfZRA5Lgw2iIZpEeHC9ymtSp2HCh1K+pOMcK/vYCxTMs
	 RWm87IsaaNfl1xAWxg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mvbms-1tWdps0fTS-00xmj5; Mon, 25
 Nov 2024 11:34:34 +0100
Message-ID: <4b1b5c12-3f81-4004-8eb4-44a9fbcc7223@web.de>
Date: Mon, 25 Nov 2024 11:34:33 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Baichuan Qi <zghbqbc@gmail.com>, ath11k@lists.infradead.org,
 linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Johnson <jjohnson@kernel.org>
References: <20241125050821.149898-1-zghbqbc@gmail.com>
Subject: Re: [PATCH] wifi: ath11k: Fix NULL pointer check in
 ath11k_ce_rx_post_pipe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241125050821.149898-1-zghbqbc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cfbrid79ZOOhMehvtKDGQKtUSMXSepXT7yOaAZtWsXb4rsacPum
 pMu8e+zzii/u/AQQIBAPoMJlBZQNZsJvm/7UM5gZCxUn4GIaA3O14pHAmIC05xR9qEcNsmk
 6GjOXERidan28guytZr+bfYkPuBvAHX8EIRvU2nAiGNhTZNjbV+EseOyreSwbRTa14n/0FO
 Z58Q3EEYgjKd6pi1h5MDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C2ka7QxYyTo=;k8m90meHyNDXyM/15IQtzhWnEqX
 SZnN8EAfxV7CgecGoqb/VDdFBt/VU/G5XSDeCcex8MRKSy1P9ohd9ONWszvGxUBKwy7HPgHT3
 XmlsRoUvaP9mOD29cI+yeSpfOov2jvqDgPqqceAqHSDdUe95e371L148qOn016LBDPSgFbC+Q
 A7aVtT9PyrB46zRpfwnpwpHXYtIxEefYuv62VnFkf8RXuo5Imevt4pO6/cTNgo2ekeT6mQslt
 akXHQONnE5/hSwyZIBXbTVz4ap+cxq0CnE6op4VobCRPLheEYb2iNNV+dT485CsgRNDOsb2uN
 +V+w0+6DUoMN3RasgfvA0miFsy9RVhBd7/y6Wsqnz7bWNCk6PknM+KT8PZ0sNhYfZO8m1pcEh
 8Xk/mXHPmP+4Ooly4yZpHgT12JuRIr/Tw5SIKkjJ2+Pp6YCRSowoMZtKMJL86n+GnU0jQQLIp
 XQ3JHcLqBuqCZKzU/grZk6tIgDwQUe4xDvkpjpf+q1HzOpZK6k9UytErLCQlNP6owRz9/Fux/
 iTyANA4Tcb9PGW3BKaUd9apZJxmw04YSdcTVxLAQ3I4A+Qms+wQun7dvRRdwDcnTijlK/b5hx
 pUvolKzZ5321pTbCWvRHQ/4l5RAIuo21dKAZZ9bFNw1RHnu0GVu4eWyOkLLvjOArDW1DrW97w
 tWUUQmlNrzSJzde0bQcXdux0sGjS1oxHArLwXN5lWnsXuoqwigCQduic2h5E8Nq7XIgU42JbR
 /sVhthUu5xdtURJlPv0l05gMxPPGAQpSbE5Vhsuun09AKO8qHEutkNlR09+cnVKIyJfoasc1i
 iD6gtl8mDt7ddYabOyJi4I9YcWS3wNwJU0JcFI3m1r0vgGUIjO2ymW/nrl1LyGwG8KDZyyfNe
 0za2WxL1VKhtOVB1+ds99O/ZRIo0EfhqSNiWLr81xxZ0Wbm+GycOHEa9o

> The previous code used OR for NULL pointer check, whitch can not
=E2=80=A6

                                                    which?


You may occasionally put more than 64 characters into text lines
for an improved change description.

Regards,
Markus

