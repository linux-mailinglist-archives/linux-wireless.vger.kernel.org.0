Return-Path: <linux-wireless+bounces-28152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DF8BF8A19
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 22:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF295357634
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 20:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8949B279798;
	Tue, 21 Oct 2025 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HzBRz680"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6BA1A3029;
	Tue, 21 Oct 2025 20:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077484; cv=none; b=FtWNX67wi/RfYaHgstMQnx8dVcHAS3GT4+eMOcraufPLSX6KlM+++kCHlSMfClTabWYrCliEA3erCKDp+IG3cDDViNWRk24aWwSZi2WHs57WGyi+JkjmN/g2H9imnEpJAOPSHRVOmKdXln8F9kKyrrxUbF1bpyBOqWGs5zDmoeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077484; c=relaxed/simple;
	bh=hmLvN75sO17uP9tnpkjXJmC25unxut94+Nb1a4wzpys=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=UsWnkHeG+/8ak54RQT9KchbgstE9Ng+XmhGMYf0PQEsLr3JMVAHIfPUv288FM1u18aDZ7DP8nTBrNX7sn/rHKl7rH3kSNe9Sb5DGLfHUxiEGFcvpD80Crzc0+S5PyB04AYr4rXGEbfeUFgHHS8up1Rfrht9xVPTKPi4NSN1yZzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HzBRz680; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761077472; x=1761682272; i=markus.elfring@web.de;
	bh=3D1Tsa200j982ukeP1tes/iOMKxn4mnZdic1IsVU9LQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HzBRz680YPA0etjK8Fs40c03K8XwKBiavod/9fOIwrg4zCk6av48FoJ/ifS9C8yF
	 QhM+YYdn90e0KCxGM/nTMrTfDdQH49R9VkZwDZbnZ2txvFE8ii+y3GCbmcDH64PPM
	 Wc4/WPb/5umOeNJrdTtSjHrSzSbmoTvlwBHNDjeZSlVPnNJc9ftE6vfkT3N6IlH1g
	 bR/jhPw6/+q3WekOXRk2yOrNkaRegMrS3raqafLc07K51wdCptJcrcYOMIdMiMAiL
	 7ZXFFikIJmwdI1Fej6VouBgJCOsoRMx2jqk0nkIMMPcJfL+mmxhnoc66hJDNrdBJb
	 +TBEdb/F3+jMyeh7EA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.255]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ml46w-1uUE7P3sey-00bb9Q; Tue, 21
 Oct 2025 22:11:11 +0200
Message-ID: <933b7662-8ed2-40d0-b959-fba4f7342d71@web.de>
Date: Tue, 21 Oct 2025 22:11:08 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Biancaa Ramesh <biancaa2210329@ssn.edu.in>, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>
References: <20251021141337.33268-1-biancaa2210329@ssn.edu.in>
Subject: Re: [PATCH] ath9k_htc: fix WMI command handling and improve message
 sending
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251021141337.33268-1-biancaa2210329@ssn.edu.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wVrRB/N19cuDGO+clQX/BaBotQehoZPYRe8KNUGT0Vv1p2nXbaP
 JhtmCXQctOGZpyGWGRfD/FCB259h2YRWdvF5vnagvpbYWgQUbuyeNS96fpI6lZG4OMqsjWG
 4j2O2aUslGjDfzLlkhbOpUbZZlRg7Yk7XqZg2ptmVHR5pbcRsEAQJGBpU1ub4y7jX+WP3ze
 57Edy7ewmpTHTshwhbG6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AEGaucb+CFw=;FiicGnF/urQRLhq/p4chEbCfKVB
 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
 lgKBBcyajxcmRAMNpUjhV/x63A=

=E2=80=A6
> ---
>  drivers/net/wireless/ath/ath9k/htc_drv_main.c | 139 +++++++-----------
=E2=80=A6

Thanks for your try to improve the implementation of the function =E2=80=
=9Cath9k_htc_add_monitor_interface=E2=80=9D.
https://elixir.bootlin.com/linux/v6.18-rc2/source/drivers/net/wireless/ath=
/ath9k/htc_drv_main.c#L350-L437

Please recheck the indentation approach accordingly.
Not all leading tab characters need to be replaced by space characters.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.18-rc2#n18


I miss some information so far.

1. Helpful change description
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.18-rc2#n45

2. More appropriate recipient selection
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.18-rc2#n231


=E2=80=A6
> --=20
> ::DISCLAIMER::
=E2=80=A6
> The=20
> contents of this e-mail and any attachment(s) are confidential and
=E2=80=A6

Please reconsider such hints once more for communication by the means of p=
ublic mailing lists.
https://subspace.kernel.org/etiquette.html#do-not-include-confidentiality-=
disclaimers

Regards,
Markus

