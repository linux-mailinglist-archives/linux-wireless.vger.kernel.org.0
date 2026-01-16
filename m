Return-Path: <linux-wireless+bounces-30904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1D0D3017C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 12:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1845B30CAD2E
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 11:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F91347FD8;
	Fri, 16 Jan 2026 11:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WSYBcmUb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290A726F28D;
	Fri, 16 Jan 2026 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768561507; cv=none; b=s1OxOYS7dZQ3rUfpSlz2qdrxw+60wOtm0PR6/t6WvNTp7bqvXvvouMXmPrrbRh5zl65Cx4bnWCBQiYs+rb0ZzhJzXgQPfySodKaShRpW+vMvOTa7GsjiO9n+oh/BEWtKg9fShqD+QpDa6Gu/SxBXv97A2xBKLdIPPx7QE6PouCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768561507; c=relaxed/simple;
	bh=3yAwhuTkLLVA7Cfi7KlWUtkd5e9sibhs6RgbAySTRkk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=rGMHOc11Ya0HpzHD+SqA1bQ1hMgGlauw4D05/WiBOJ/sxy04y7nfRfqpb7kBYOUufQtNZcmK8dSocZGD7pVyL2DqmCA53Xg+yOd5iU4urtD1vaYarLhlOgl/VLX7R0Z8rBwnKf+QIsJypxFsulFsXnktjORk0fPl4WosQLp8qD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WSYBcmUb; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768561500; x=1769166300; i=markus.elfring@web.de;
	bh=3yAwhuTkLLVA7Cfi7KlWUtkd5e9sibhs6RgbAySTRkk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WSYBcmUbNCyG5tOfCqBpnYKA+GSGxO7vP5/19U1pt9RCKswKhRvjFuynPCEbH69F
	 UnDNX9GSY33+MNfTyJFCIuAm8ujB1ji2KU/lOJIKiMlaVFFxXKKr/PD1yvWwhAiB5
	 ooAyEKcg0DyyOPdaNB9vRSpJwFPVckbIKgHIpqI1ZzW/xqdNzT/D8inzLaSQ6HU9M
	 AfMNSUmwCADzVRmV6JM0zVAU7fCSohooL73rGVYbLvUabtxCRQIojqnYFHQbI7aED
	 5+i373hojzzlLRQt3q4lfAjq7aCem72iP7Cm8FM4Q0GLfhKqLdaTc6C2ec/ssiZi2
	 u7+Jyxc01pgiD2gm0A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.218]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MeDMb-1wGrfQ3ZKx-00oeyC; Fri, 16
 Jan 2026 12:04:59 +0100
Message-ID: <1d32418f-c315-4ce4-9b4c-6781bda72cfe@web.de>
Date: Fri, 16 Jan 2026 12:04:57 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zilin Guan <zilin@seu.edu.cn>, linux-wireless@vger.kernel.org,
 Ping-Ke Shih <pkshih@realtek.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Jianhao Xu <jianhao.xu@seu.edu.cn>, Zong-Zhe Yang <kevin_yang@realtek.com>
References: <20260116074836.1199951-1-zilin@seu.edu.cn>
Subject: Re: [PATCH] wifi: rtw89: debug: Fix memory leak in
 __print_txpwr_map()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260116074836.1199951-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sqhyuvIKgukV0bvD0r9FY2hGcGv0xAQHYpkEoNQo5f+0hFdA4DS
 ZPY7/7Ga35bKASy9zoivJoR+hk9UAQGOfh4laoNB8NrGYbesvm6xWo3ub6HfHnbdyCSA2FY
 c5c1xBe5QgAJcGA6bACjtu2z6oYnV40qYdPUe1/RTosvJELQ47VYMM88+Ii7xRBJZ+KIOSw
 iYspkRiGeS7xUC3D+sCbw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZCZPQbxJlZI=;r39TIMjR0NnVXOwRc9GNRbc+CGX
 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

=E2=80=A6
> Fix this by freeing the temporary buffer bufp in the error path.
=E2=80=A6

How do you think about to use an attribute like =E2=80=9C__free(vfree)=E2=
=80=9D?
https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/net/wireless/rea=
ltek/rtw89/debug.c#L815-L858

Regards,
Markus

