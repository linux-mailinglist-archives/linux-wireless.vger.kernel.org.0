Return-Path: <linux-wireless+bounces-13221-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A989873A6
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 14:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8330B2139A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 12:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3E0380;
	Thu, 26 Sep 2024 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="d97cKRcD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADED3FF1;
	Thu, 26 Sep 2024 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727353984; cv=none; b=eJR2Ht66trHhkMb5puWUMna2kh/6pVFWtd39Zo2N2c46KkztVYtUsCmFXb8kvhB8dpXG/PlqTWO+qpJALFc0lCOMPMWftqQnAOsiXoFjMDS5CUwu5eiRVY2hOscs+Ill0f7eTi8jlDkTJ00O/XYKyy8S51VgV+eh9xaPvY+XEnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727353984; c=relaxed/simple;
	bh=8OurblmibErlPKdxaddhV4BQHJpZYMzOI31SB6FPYwg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=St0yIp+xl/LOBg12yIDrOoDyaNZsQ51h7SyycHabRhSpKE2qsWibiku3puZY+c+7z/5LSTAGzyvaMTToKM3fJEtxAjuvDa0MVXF62T+4w3jAFHeu05JF59uhQBwI4f7T3eQ5IP7srCPAlSdmRbaOjyFMVxIwra7qWmIvqtwrf38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=d97cKRcD; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id 589C54076184;
	Thu, 26 Sep 2024 12:32:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 589C54076184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1727353972;
	bh=8OurblmibErlPKdxaddhV4BQHJpZYMzOI31SB6FPYwg=;
	h=Date:From:To:Cc:Subject:From;
	b=d97cKRcDsD//nrdKDeZo58og22GzjfKJTdTG8+vN4e47ewfQvguBnOF8z+7rCU5PH
	 5erZQ1psQRx54XovXaYJJvCbHA47PSFP9S4kj0ETcx2HYfOZggGReWk3bKHDhWtAPV
	 t4cHDc+9G8UDhSWlqK+V54XQvyjG6DK0RAbYm0TY=
Date: Thu, 26 Sep 2024 15:32:48 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>, stable@vger.kernel.org
Cc: linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6] Revert "wifi: cfg80211: check wiphy mutex is
 held for wdev mutex"
Message-ID: <20240926-0b7fe990233f57538c94891d-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The patch was also backported to 5.15 and 6.1 stables where it's causing
the same splats.
https://lore.kernel.org/stable/20240918-d150ee61d40b8f327d65bbf3-pchelkin@ispras.ru/

Need to revert it there, too. Should I send the explicit reverts to the
mailing list?

--
Thank you,
Fedor

