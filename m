Return-Path: <linux-wireless+bounces-30917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7580CD33983
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 17:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75E6E300196F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 16:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED9E338906;
	Fri, 16 Jan 2026 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WEcTJ8Nr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982432571BE;
	Fri, 16 Jan 2026 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582625; cv=none; b=c2puDODfsUs1CW5ZrxyYDpeDacUNvl+4iZQIeCwDqHE7G7oUBtIY5f2DpDC9rlRqHGa6P1RnT3i8wZ819XHE4XLyKTHLMqLj6YNF018vIe2lbCdA47J0+Wy7CuOS73Y10lG2fbe1CaupPyvSgfZVh8xB+U0/hyC4I1mGBWxoDas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582625; c=relaxed/simple;
	bh=UCRzFnlL51J3r1v3KtHPuReG0jTDE1cPz5Nk0PllpmI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=nWbAGG3qUz0W5dgxsh3USM8PusdlWmAuY8N0vNYC7G2OXhZrpQVX40mkEBAG3E94p60wutNkjsWP7bjXbjD+g46m5LET+DwFZU9rVUsYqctA88T+OLxhz5ZgBZtv45mAXF37G2StUGa7a+fnrqveWRGHk8/jEtW6Fy83G5TgCD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WEcTJ8Nr; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768582621; x=1769187421; i=markus.elfring@web.de;
	bh=UCRzFnlL51J3r1v3KtHPuReG0jTDE1cPz5Nk0PllpmI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WEcTJ8NrCXkdhCgtKJ8A+ub0H9dMTILNfgxtpoYFn7ubm/AIyUwKTJc4SbzyOq53
	 Mw66Q1Z8c8f2iILtRporoy/pVnvaXHPFEVjkRl11ifD9ujv6iWTSPwMQVUj1bQK9b
	 DuKkPdR+G+50b0Xe+4CqB4LctgAossZAVvFbqdykJo9jR0wVaBJ8kaSWc3p/NA58Q
	 k34YSf0Rf9g8fm3g59xwF9Y6x92aMbA65WndQ862sf4ehQ86L/AtD3XsFAvskH4MN
	 Pr8NMC+G5BDH9VME+Gv0ZjGLXgfbS+FAhiQydwFshFBr232OJt8m+FafPDoKW/AoH
	 IZDKJclmcWI0aKLS7w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.218]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6bCu-1vsNfP1y0M-00r8r9; Fri, 16
 Jan 2026 17:57:01 +0100
Message-ID: <d16ff74d-aa01-4b3a-aa76-9ac9a5c6c86b@web.de>
Date: Fri, 16 Jan 2026 17:56:58 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zilin Guan <zilin@seu.edu.cn>, linux-wireless@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Felix Fietkau <nbd@nbd.name>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jianhao Xu <jianhao.xu@seu.edu.cn>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Ryder Lee
 <ryder.lee@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>
References: <20260116144919.1482558-1-zilin@seu.edu.cn>
Subject: Re: [PATCH] wifi: mt76: Fix memory leak after
 mt76_connac_mcu_alloc_sta_req()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260116144919.1482558-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GhP3f0OmHoEwyzJl8nBiItufgqDkyBKO0l/k/9qznQd195MT7I7
 S88t/NC9arBrJ2IyFVqH9lHcaBi2Ic0GAYqnFQsbtbyosRCZ7IOh5jDyDW18MOLzQSZI84M
 YrXMdY715Lgzxilyl+jDmVycI6FoFC8tA104J5120o5fGnYpVc6273zW1jgz158hRhORAf3
 hF6Mx0crSLV+r6UxNxC/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ENFTm9ZfFjE=;w7K+NAT/CaEQqIzyBRmbmhuFTpS
 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

=E2=80=A6
> Fix this by explicitly freeing the skb in these error paths.
=E2=80=A6

How do you think about to avoid a bit of duplicate source code here?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.19-rc5#n526

Regards,
Markus

