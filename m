Return-Path: <linux-wireless+bounces-34210-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNhuLVqUy2nMJAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34210-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 11:31:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5825C3671A6
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 11:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD21A300C000
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 09:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99B53CF034;
	Tue, 31 Mar 2026 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fonJx36x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490CE3E5596
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949464; cv=pass; b=N9+2QwVPE5PNGjNLwETyayhoRPrZ071L0PsPgIIYKLcXg5na6v5CKaSP7YZd6MF6P7CXkZL5q5GfzefP3HSyfoF0oUXXd2qO35wsMA5ue+ln2VJH7ngg3W0eFnQuD9Zke9fevENmiDrS4rwTRMsQ2NNdpCPIylAZU7gsesdkfL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949464; c=relaxed/simple;
	bh=N4IZZidSD2WIAS3m5FuPO+zmZWOkjgPwvsnfgKOy5uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ey25t5TgcKbn8t5gy6v9n5IuCgxwWRCPMkHlMBm5nzKzCf2omj37dOrgh/PHPqQdkir39xtNNMFJpKVB9PqALDtCVfGYbldaO8EcQ6s64zaxZ1swBzCNz8HhJ4C8UCZJFgCwalAHMAwDzySJzK+wNh8UWHZ9GxQr0MJWEk1cOTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fonJx36x; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6501c4857b2so4853988d50.3
        for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 02:31:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774949462; cv=none;
        d=google.com; s=arc-20240605;
        b=NHG6p8FqrfxbbhbNvIqMOTDmdQmHqxde49E5T/x7qIVNPd2Pb10qSHGEibeqcX1U8K
         oGoGW74iDWdbZRAI2rRtikjhpLQk9s+BnIo34LKr3WJ2ClUv6RwR7erpZPMcmNRc/KYs
         tdek6wMdSUOQVBpe0xrnQMPqr6DXT3If/jkq6fSGw91Yswdg8uHyO8eRniA6lHt9yZPU
         1eVF6ijdr5DO3rfyb6j2w1A0rpgvf5xR2NWKpxYfekWj5/aLOTGByh5hfqNSm3Pvhu5+
         wPB098oRAoRgThty8YyZkutcRQESIB8K44pJOLju0NjVMeMf4ktkdqldntOyR8UmbaZl
         fE4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N4IZZidSD2WIAS3m5FuPO+zmZWOkjgPwvsnfgKOy5uk=;
        fh=dE/6iz8y9NwCZzSl9Cp1ZTdGRQgCiiqlnLmKpyNY/yE=;
        b=IvLC9sBeSai8aAAOlBPix3kx5kpXMF6QsqJTdeIHZe15cT2MRvn+ZLKrHmL5LuRO8d
         jVV3Eul7qxe177ZWhHcU/3p288r0vIgNWTYujy4V1gaye1by3Fs9W12Coktu2iWxvMys
         2F9yhaqTM/RTF7/F7DwuO2nvVBSrVTnX5JXDqKDFLuYK/Wgf5WlM2wBXqazx9/cxzn6n
         UcTvC209UK7VKpv95kuVME1FySwvv9ilRKs/+2g7EHvoUj9ojC9OgJyTQY+Da6MSPDcs
         3KdTK/JoZ0w7wvGWao4LbtTOnS0Jp9r40BHnukyBQUVIUlX/dQwBYqhmIwrWeqVGiM7X
         AmLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774949462; x=1775554262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4IZZidSD2WIAS3m5FuPO+zmZWOkjgPwvsnfgKOy5uk=;
        b=fonJx36xXTtzKMDNERGdIg/QKbxy9lwPZGzncPE8G+/GAv72aP1oz6njs8U9ttydvA
         wRHMdEhMBn91Z2pDoMhsfXWfbsoRy3j5uNDSdwp+VWXm9ZAyum7eD0RetfxONlVeN3KZ
         voMrIE9nYA68eoTOOsjtAlFtl9afhDdmYAuhdCFiaLCx/9edu8EaUWlJZFFAWNiCP6Gl
         ybSfcsERuV93z+nSMQ7KcL0CGitBBzOMudnMyuFlv81BWmVVAR+014cKfqSQK+OPhPSq
         bS2RyeF8kPFZozpA3IkHod5qcjOdtOkMXeXGe19yFWQdhASwHOSQfVQbAxvmUzQTfudJ
         nctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774949462; x=1775554262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N4IZZidSD2WIAS3m5FuPO+zmZWOkjgPwvsnfgKOy5uk=;
        b=mRFFqM50L08WYiRb2zGRJFLMq8rW4+usnylqi94rEGfRMAFaJmA3eW+SNSfCb5ovk2
         y8mnWgVDdOnves3XefjFtwf67TWCpCHYfAIQD5wYPhG2/TIJepfBhA8YpCbcbDesut3Z
         3yPdK1dkpUkYGxuXWQhlDluGDEV+ErN1BBttR4cJikfSvm5ekeS69x4Z9kgp0aC6FBdj
         +pvuV1iPiSGPWG5aWOZTWTz6v8QD/jwiSE4iysaUM0yUIwdyRs4PYKQFuptRUWY1bfDf
         IAUSaUPlX4MmQlyVXJMhChkbPI0PlCTQppVps4x0NVpPNKtDZCEqpD3xYcxVzjCswr8i
         y9Vg==
X-Forwarded-Encrypted: i=1; AJvYcCV8v3FvZPbGfVMGTXD/gln56P/Iqq75fNSmQPkrmNI9nCAVYZCSjBUb4OqQqK7VhU4h1ldpuWQ+2/SAp2CB3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyC6KeadD+ZWfJ8STL4Z3f+wyjtFELX2OgAAJ2yHrUeo7fpCaUB
	KlPEB0jG/3PXKPUY1n43jizF33KOqUnR0wbIvdTTnL/o2UH0VMAWTqpWJ3f1x0LpKIwGzoFMrpT
	SuQkYxL3IVuHOu5ItDpZ1aTsDpPrKFDc=
X-Gm-Gg: ATEYQzyGzBu1Y3E9/GWu72M0osM9gxVUQAAJo5wKcrcgmkvviLRFAeTGXAjMKJN8hr0
	N5LWRGo9nBiodjw1ecrZ8q2eVdo10Om8QHsfi1W5o5OBAish8zluMrW4e9vIfw6PWNrIHfBc10N
	EAuuzllc610Zok0RdMZO4559BerNh1dbhmHcCIjDiNVbxm007J8WQ3pVo/9tMsxiDHuQDOwMLO+
	VtcWRBU13lTca0lA4K8ce5zzpBmV7AJbVxXpDtbD+gzRVsoUHz4c/Ua6wzeguDoD+4GogryCQBt
	/P71vA==
X-Received: by 2002:a53:acd7:0:10b0:64c:a0c6:da8e with SMTP id
 956f58d0204a3-64ff720f358mr12073996d50.29.1774949462281; Tue, 31 Mar 2026
 02:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327021534.448552-1-lucid_duck@justthetip.ca> <3f4103d9-4871-4ae8-93a7-d286fce37443@freifunk-aachen.de>
In-Reply-To: <3f4103d9-4871-4ae8-93a7-d286fce37443@freifunk-aachen.de>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 31 Mar 2026 11:30:51 +0200
X-Gm-Features: AQROBzCjgtPgpLreH4PDh3vAfKNOaMMXa_BnpfjYnpFtP-Mj3gf6hF190Ym92R0
Message-ID: <CAOiHx=nm+9Kna6VDyug8Lxg7NQHJYoWnZO1Mo=pvbRRAscsPtA@mail.gmail.com>
Subject: Re: [PATCH 1/3] wifi: mt76: connac: use a helper to cache txpower_cur
To: Felix Baumann <felix.baumann@freifunk-aachen.de>
Cc: lucid_duck@justthetip.ca, linux-mediatek@lists.infradead.org, 
	linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com, 
	morrownr@gmail.com, nbd@nbd.name, satadru@gmail.com, sean.wang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[justthetip.ca,lists.infradead.org,vger.kernel.org,redhat.com,gmail.com,nbd.name,kernel.org];
	TAGGED_FROM(0.00)[bounces-34210-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonasgorski@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 5825C3671A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Felix,

On Tue, Mar 31, 2026 at 10:24=E2=80=AFAM Felix Baumann
<felix.baumann@freifunk-aachen.de> wrote:
>
> Hi Lucid Duck,
>
> thanks a lot for your contribution. Very much appreciated :)
> The kernel has a strict policy for contributions: real names only.
> https://www.kernel.org/doc/html/v4.11/process/submitting-patches.html#sig=
n-your-work-the-developer-s-certificate-of-origin
>
> May I kindly ask whether it would be okay for Sean to use your real name?
> https://github.com/Lucid-Duck

You should update your link, the real name policy was relaxed a while ago:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#deve=
loper-s-certificate-of-origin-1-1

"(...) then you just add a line saying: (...) using a known identity
(sorry, no anonymous contributions.)."

See https://github.com/torvalds/linux/commit/d4563201f33a022fc0353033d9dfeb=
1606a88330
for details.

Having said that, I don't think the real name policy would have even
applied to Tested-by / Reported-by tags. For these it really doesn't
matter, as these are not code contributions.

Best regards,
Jonas

