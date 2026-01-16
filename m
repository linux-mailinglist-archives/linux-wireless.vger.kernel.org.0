Return-Path: <linux-wireless+bounces-30907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 583B2D3130C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 13:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A03E3301B4A9
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 12:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC16F20E030;
	Fri, 16 Jan 2026 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QY7A2uAk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1FD1632DD;
	Fri, 16 Jan 2026 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768567101; cv=none; b=ktVPAm755+lqe4ZWIzecTqZpIxUz0GaHsHE6iFJsoI8wnkVZz3fIuodgEvcM+h67KhKAbqLlzvZjDW0Va5w2/7hu/T+MqrlIkeRfksid+l3q4eD+flY5dBOShJbPRQHh7tPhLXWeTtUxEvKqgTBWeCNoIdDzGZotu/zxftkQKGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768567101; c=relaxed/simple;
	bh=owg61UDKPdmbeqt4rgMCye9P/BzI6ozZCqabv/dasYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YK8NXWnr30kXnzeegAIE8t2xeEh4+1Zv9biQZXFr21dK8T8eIYMR1QLtthwl6cFFtypPLyPfnyS4sC4jimUk2lvXWBKNOYhxQchZslr+NtqUFRLLsexYM8QevsuzMOgv3BUEXqEQ/bE6D7DtXdtb01FkKgc5EOc+KHlJLpX8PSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QY7A2uAk; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768567086; x=1769171886; i=markus.elfring@web.de;
	bh=owg61UDKPdmbeqt4rgMCye9P/BzI6ozZCqabv/dasYo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QY7A2uAktlLAQlPRKV89Le3X8bC5hXkpsTsCH2aNILsfMyzd/nqzVKCFRWAA4QlH
	 8ZytnJJNR2q80laIuC5bNtkhChZdz1ZF3d2mrqMKMspe9kvCvaDo2UAOwdobxnzc/
	 Q1bEpJhJi5wtuvDQ8ri6barB/8Jdpa5h+aL1gU+iz1NJ5X6fv+gm+BdDOmONB8Nqs
	 nOrFTut5E2fE8yEzbBGVKO/ee5dnuhJG1dUtmdkm4ztv0bVL73KSLYKHumS6VRT7I
	 ofr4oidQ+sD7+wpem0DkCM9pe4MSsw7PqSrqCUYXcoHw1mz5tGvaqQwZAYOB4Ucfd
	 u7rmna1QqeJ8v/pa3g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.218]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1u6d-1vnmTP2J6v-00ww3V; Fri, 16
 Jan 2026 13:38:06 +0100
Message-ID: <0ad16f51-8caf-469b-882d-4928560c0b64@web.de>
Date: Fri, 16 Jan 2026 13:38:04 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wifi: rtw89: debug: Fix memory leak in __print_txpwr_map()
To: Zong-Zhe Yang <kevin_yang@realtek.com>, Zilin Guan <zilin@seu.edu.cn>,
 Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Jianhao Xu <jianhao.xu@seu.edu.cn>
References: <20260116074836.1199951-1-zilin@seu.edu.cn>
 <1d32418f-c315-4ce4-9b4c-6781bda72cfe@web.de>
 <acc90353107248b98215847e56bb374b@realtek.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <acc90353107248b98215847e56bb374b@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:itzwY9VAakbPSAYg3Jo7vFqiHfEvM/arbeTpHvqRnnNAqWvAZwF
 yHJBJLMxP24ZeNR8uPvdHOzBeemkoeUC90RSUv1YKkqCwfIgr75iI0+vngRqe7GDUU0sDly
 uc1k1+jawEy3fy3Jkl/tSmwhBx2X8tiPoR6BMkhQWaLo7ftWDuQM12wMjr+gcEk9je2qNaA
 lt/inE7BQCAah/qmcEo4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:O/sy0Kv9Mq8=;1XUhrSpVvLtM0ddCSd+0ZBeZhDb
 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

> But, I don't seem to see DEFINE_FREE(vfree, ...) yet.
=E2=80=A6

Would you dare to support the addition of such a macro call anyhow?
https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/cleanup.h#=
L157-L161

Regards,
Markus

