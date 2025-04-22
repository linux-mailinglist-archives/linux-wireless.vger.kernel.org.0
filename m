Return-Path: <linux-wireless+bounces-21835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FEEA96674
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 12:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B68B1897B69
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 10:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B4F1F5827;
	Tue, 22 Apr 2025 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jB9AYxem"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1051EEA5E;
	Tue, 22 Apr 2025 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745318981; cv=none; b=aK5YF7vT8Y7LjdGK+KU8dpN1983Q+FCslGH//thHEa3yPlyTZoiTX6lqVWq3POUfU8KF1Hd4dPcmbWTgqmiYZ2GpgpchJdeUhFvDzI5RGlMfCdIIE/evXfsZyUyDNATat3wKUYGBkrHLmLd5CgN//1b9ynHfawh9RlwXnJ3N+0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745318981; c=relaxed/simple;
	bh=n9YStttPzf+7dwNCPnt66gph95yNu+I9t34XZeiQbyE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=mJQ6y7123ZBqC7cAv8o0ZytxvKVgz/XZHRBefitbg71O5QO7dV/AS0DfjQMw60wf/vMZOutR75SsG9kGKrfp+nUI0Sfa/0wuIOwcLMWShpFPEOPEONaHu1mUK9ZOteAS8KoIN330gAPV1AIKxFmkWH20A9EfTOY5s0O1tZBok6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jB9AYxem; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1745318971; x=1745923771; i=markus.elfring@web.de;
	bh=n9YStttPzf+7dwNCPnt66gph95yNu+I9t34XZeiQbyE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jB9AYxemw+eyeB6vsi27Y00BaQv/kHJd3++w85L7PkqmVXEHPWe8msEmrEpn/RKj
	 59AqXgxwpU9XOguwtChjJZgt5mYAFnQa16QPPsYe0PSSPFDB7lcFvS2CDpsQ9CAyc
	 pZnpjwvScr2CpxvOAdSgMLmraOeksJ1ga7IpdP7UnAPWWNOMlyQoN3sfjafcg13R1
	 97/SOL7/HpQSn9tdbzJJPWigr1kv0ajhBzGoWthdy4tx/UGQWnoBUiHHDvWfFemUx
	 8sTiYKxDEwb1v8+6rU7B9dfoqFV75bWB4Vrtya/GDK1iJvWYKbyNBM21qHxmSXrWD
	 yyFsUwaXBedc7C68Qw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.44]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSqXM-1uY29u2h3O-00WJdM; Tue, 22
 Apr 2025 12:43:28 +0200
Message-ID: <d4de3f9d-5748-4969-98c6-7d17395eef4b@web.de>
Date: Tue, 22 Apr 2025 12:43:19 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, brcm80211-dev-list.pdl@broadcom.com,
 brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Erick Archer <erick.archer@outlook.com>, Jacobe Zang
 <jacobe.zang@wesion.com>, Kalle Valo <kvalo@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20250422042203.2259-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH v2 RESEND] brcm80211: fmac: Add error handling for
 brcmf_usb_dl_writeimage()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250422042203.2259-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0yUhLNxFOPtA0NXGmqmCyA7AYhTmkLF5aBbUbpQecai2dHLd1N2
 OKH0vrcRLRiqQ6Nf5ZulLI7rdXhIct4L137OFFsnAbKg/f/h3F3YZVOBE4Z75ijlJ0a5bLj
 /5V2BxLUvLpKw2UBVZSQvEZC4/CGSczkqnTZ5lnvNPYpcn91W3qviBhjlTQjKiNu1CpNtin
 Pkyt1WyKGqpvnolvEAHdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eHVpLVmPWac=;z6S7tJp14yB01OBgOZF5M47wyCU
 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
 pNxtDWx7MrSSxjiy11x2mc=

=E2=80=A6
> brcmf_usb_dl_cmd() but dose not check its return value. The
=E2=80=A6

Please avoid typos in such a change description.


> Add error handling for brcmf_usb_dl_cmd() to jump to error
> handling path if the brcmf_usb_dl_cmd() fails and the
> 'state.state' and the 'state.bytes' are uninitialized.

This wording is improvable.


> Improve the error message to report more detailed error
> information.

Please offer such an adjustment by a separate update step.
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.15-rc3#n81

Regards,
Markus

