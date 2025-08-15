Return-Path: <linux-wireless+bounces-26400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E953B27D28
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 11:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6CA620A17
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 09:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CC726657D;
	Fri, 15 Aug 2025 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kIgWNc07"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE8123AE62;
	Fri, 15 Aug 2025 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250138; cv=none; b=D+je/x05OfTiGU8+WNOPlD/osyT+qY+TpfkcG64hItH3PYuFxhDGvFnUyjLJ6zsB6JCWQLe9SSCViji6I+1In3rUaM1+WftMs3mP07znY47RG+//BSP2SF5qmO26BNUl0TVHFVXkOeYhyPjg4/3RRVdN7g4VeE1pqXCtRq4q04M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250138; c=relaxed/simple;
	bh=SuHaR6bKZyA/ZESvQG8oNkxfrNI182cpcXQG5Dcne6A=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=INiJTpP0W4V2oWUKtLweqcueRnneMChcAX2XSjR/HzDg9ml6NDBnsh1E/6SI7AdCm/NH5e2uVJc1mgTdOR3b/4NI00EFaZH40898EhJ07D9emCgKJRty4MtbIpN1Z3PU/rCJ7MLSt4U+CjtHdZmS7DEx6D4VWiom46QYYrTwNE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=kIgWNc07; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755250127; x=1755854927; i=markus.elfring@web.de;
	bh=SuHaR6bKZyA/ZESvQG8oNkxfrNI182cpcXQG5Dcne6A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kIgWNc07JbHTL8UgNc9HGiNP78KOuor32IyVnfXsqjMsHSyKVcDFq3z7GjLKG5Mt
	 hU3Sg094WsmfB4RRoDURfq0Mejj+8kjSH8nfYZc//HmNzw2LTtzDXmC+AuNHmiUES
	 eoCH2cZTHd3MbzGbXnAjeuQvOrv7DBNCHmASYTRK9QiVNxKph+tq2EO2y+4J3qedC
	 qttHwwX3kWkWOdoCLpB6UoZ7OA7o4j3j4PNKHKFPllatAgMIp/JhneOGEfrVLNUnj
	 Tvyz7hFWuggauwFsRs9BBaLAvfWWh+rGsEe90yHiyitrKC0Rc2xnmAIYhayt16vbr
	 kOr9uzbHPbwhRGlZvw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.211]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4vRm-1uchkh1moG-011GCv; Fri, 15
 Aug 2025 11:28:47 +0200
Message-ID: <f45a137a-5b83-4c05-8918-928db5e1ac51@web.de>
Date: Fri, 15 Aug 2025 11:28:44 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Qianfeng Rong <rongqianfeng@vivo.com>, linux-wireless@vger.kernel.org,
 Aditya Kumar Singh <quic_adisi@quicinc.com>,
 Avinash Patil <patila@marvell.com>, Bert Karwatzki <spasswolf@web.de>,
 Brian Norris <briannorris@chromium.org>, Cathy Luo <cluo@marvell.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Francesco Dolcini <francesco@dolcini.it>,
 Jason Xing <kerneljasonxing@gmail.com>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Johannes Berg <johannes.berg@intel.com>,
 "John W. Linville" <linville@tuxdriver.com>, Kalle Valo <kvalo@kernel.org>,
 Rameshkumar Sundaram <quic_ramess@quicinc.com>,
 Roopni Devanathan <quic_rdevanat@quicinc.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Xinmin Hu <huxm@marvell.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <aJ33vFdOfMRDbpls@stanley.mountain>
Subject: Re: [v2] wifi: mwifiex: use kcalloc to apply for chan_stats
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aJ33vFdOfMRDbpls@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XzzQxVMpWCSsi8GpDhL9YZIrAe/8TD8vQGET/Kvjm52rpyS153F
 1nFfXuXNUQCSqR1ss6fr3do4dsEnbMDB/ls843K6+skD9z4bLhIVOaldiSA3lbpYKc7zAcm
 zlxpse5Q+mhRMJdzNr4bWuXbYybH+m3qLFbRSG2+zR8v2TOgw2WWv6Z2v28UtusC8ImLUU7
 PpaqkpaYxyMfv0LB7bieA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1uqyESsEDIE=;D2aCCqhnv8zcubSxuWdA60UrsT7
 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
 HBqoxjlvqheo7RYA=

> This patch is okay, but lets re-write the commit message:
=E2=80=A6

Can such feedback trigger further collateral evolution?

Will any related software design options become more interesting?

Regards,
Markus

