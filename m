Return-Path: <linux-wireless+bounces-11828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F97095C6E2
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 09:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7881B2823CA
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 07:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D4313C9B8;
	Fri, 23 Aug 2024 07:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="LP9DIin5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C1E13CA93;
	Fri, 23 Aug 2024 07:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724399028; cv=none; b=fwAyG/ekVOEzCIM3Bf1D2jk+jtolaPZLhV5UagmDr/zpDL0vwfJMPLkqclrAVnajzLdUFrPbDGybu2TN5ygg/psR0cG9ZGmjBpc4bT7D4I1RfID+8goB+2OThgLSFxfAHYlNViS520ywqOH2yETv2Z75pVLDHfRgMNiFhAo+mog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724399028; c=relaxed/simple;
	bh=vooEbT77eLpTdBATWoNDZBwC+8pJO1eSpImi/0tEkJA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pQEoTQeNR1WSZYnVHJBA1V4RvUdjlmZFXd8l871mD+tOApJVazMBn/XgKkeWuaacEWyVFyR3uTd0DoD9RRoq6sth7y3GW046CMaF3XK1LWZ4s9q6tSGbMk1Tv9NZae0V8wq1m0fV5Uts4JPgxXsm8CCvtvRFXI+WSxylkBUT4LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=LP9DIin5; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from [127.0.0.1] (unknown [176.200.79.65])
	by mail11.truemail.it (Postfix) with ESMTPA id E785E20ACA;
	Fri, 23 Aug 2024 09:43:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1724399014;
	bh=vooEbT77eLpTdBATWoNDZBwC+8pJO1eSpImi/0tEkJA=; h=From:To:Subject;
	b=LP9DIin5PiCItz2VFMHQzvTRlOcySYPkLb+mR5rYhgljtFlOPw3ET2JdaDylqUBbM
	 1AyaYDMpHrg9J4ueoKXjVjlbV9GR2/8HXoMGVWYdqORGqHiV5SH+2WqIPMQqQPimEq
	 I5lpnMSQTv9JkWS5MTWovagmi4QrQfQ1Fv6MRjen2Z7439/u+4V21ifQ3RdKVNLsoU
	 raHyGWF3oEB/7zJ5DjvyLBAhJRe++KnlFPE96olXQ8fPJaDN73ShwwfMH5PH22dpYW
	 I9bi8tVhqyZD5NQHK8D3/FAUuInDSNICclRTQsw7/Jrck1ZV8JhzZw6O28IA+P9/fI
	 KRFa+FB3lt2CQ==
Date: Fri, 23 Aug 2024 09:43:30 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Chen Yufan <chenyufan@vivo.com>, Brian Norris <briannorris@chromium.org>,
 Kalle Valo <kvalo@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
CC: opensource.kernel@vivo.com
Subject: Re: [PATCH v3] wifi: mwifiex: Convert to use jiffies macro
User-Agent: K-9 Mail for Android
In-Reply-To: <20240823070320.430753-1-chenyufan@vivo.com>
References: <20240823070320.430753-1-chenyufan@vivo.com>
Message-ID: <50A2B5CD-5AEE-440F-872D-3B03206DFDDA@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Chen,
thanks for your patch


Il 23 agosto 2024 09:03:19 CEST, Chen Yufan <chenyufan@vivo=2Ecom> ha scri=
tto:
>Use time_after macro instead of using
>jiffies directly to handle wraparound=2E
>The modifications made compared to the previous version are as follows:
>1=2E change the type of mwifiex_auto_tdls_peer::rssi_jiffies to
>unsigned long=2E

The patch changelog should not be part of the commit message, you should h=
ave it afterwards=2E

Francesco=20


