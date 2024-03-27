Return-Path: <linux-wireless+bounces-5315-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A69588D6DE
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 07:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536E92A3B3C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 06:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B7723765;
	Wed, 27 Mar 2024 06:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="WSR1h4l0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448431DA22
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 06:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711522622; cv=none; b=HUMuzjjZaBCAxYjYHyMI3kqPLeXoYBnbsVfQ+IT36KwMnVvCV0kN2a7EIRhvbHwkvMdqEo2eu+7Zz9Z958pDfR2cEUC0Zzth+bjBuEDMMVVj0jL8NjkUUeJZ6rasv6n/H73PGFlQ+pLsyirazCvb2jJklcQck8ZGrgIvyay3Z4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711522622; c=relaxed/simple;
	bh=ZE0+gcHENToIas+kvoZ2Rp65h6NcjfZHlFy9xEHHhfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0V8lfgWheyLNm12jknJzIasXd2BXT/x8BbLIsfmIyPJAu90jo9A+fhl70aLMcB3YIIgzf3CzsJhhwEXhZPyxJqtprmUvzlesY7b02h2KguTDDU+acK3Oz8E2yVAqijM2NfTLM7GCsuO615rMgfNpG0WPt4GIh+uqXOSWZA89V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=WSR1h4l0; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:230c:0:640:f8e:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id 7B5626162F;
	Wed, 27 Mar 2024 09:56:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id luFgQU4n7Ko0-b9UeVAbS;
	Wed, 27 Mar 2024 09:56:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1711522608; bh=dQ4YoloDRvU/8LmYkI9FlzLpSDI9DN//jYVVrIuY1jc=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=WSR1h4l0KdTWzSgKd1ufa4Ahf1/MaZg+l+yXBuIlsAazT/QNRKryWZD4u1gnSbPgk
	 5F6meKDFtUyMsmCWBMT3SPBJ2R7puL2nyf0NHiFGaOqA6Sg9deI+rdOve2Og4+NVBk
	 OwQvoAbZlIsax2bLsL2FsZZcvS9mVlU54BA2L5tw=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <69d64ce4-d613-466f-a902-78883a2725b0@yandex.ru>
Date: Wed, 27 Mar 2024 09:56:47 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: don't use rate mask for scanning
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
 syzbot+fdc5123366fb9c3fdc6d@syzkaller.appspotmail.com,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20240326220854.9594cbb418ca.I7f86c0ba1f98cf7e27c2bacf6c2d417200ecea5c@changeid>
Content-Language: en-US
From: Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <20240326220854.9594cbb418ca.I7f86c0ba1f98cf7e27c2bacf6c2d417200ecea5c@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/24 00:08, Johannes Berg wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> The rate mask is intended for use during operation, and
> can be set to only have masks for the currently active
> band. As such, it cannot be used for scanning which can
> be on other bands as well.
> 
> Simply ignore the rate masks during scanning to avoid
> warnings from incorrect settings.
> 
> Reported-by: syzbot+fdc5123366fb9c3fdc6d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=fdc5123366fb9c3fdc6d
> Co-developed-by: Dmitry Antipov <dmantipov@yandex.ru>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Tested-by: Dmitry Antipov <dmantipov@yandex.ru>

