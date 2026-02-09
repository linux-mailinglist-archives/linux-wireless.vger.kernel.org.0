Return-Path: <linux-wireless+bounces-31652-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBaTLJqNiWnP+gQAu9opvQ
	(envelope-from <linux-wireless+bounces-31652-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 08:32:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F6110C78F
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 08:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2466430075D6
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 07:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D3C322537;
	Mon,  9 Feb 2026 07:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lynkxsd2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA2B31ED9D
	for <linux-wireless@vger.kernel.org>; Mon,  9 Feb 2026 07:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770622049; cv=pass; b=YMGeq2d+op0uHcLNgsdqN0ZyE+S7PdUGb18hFdixhvZTjwtgRJc55ml9/Z5rJMG+PK1Tj77nrKBi/uVls6h1LzrCY1IzKqmtbiEpmtmDJwiMi/fpwN9tJvsNw2K0pxuAIe5s0FTFp8QqCe9fSG9nX7KO/sl6c+ARxeko5N0YdXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770622049; c=relaxed/simple;
	bh=c9qLHkrtXI8OYz0/SFVxXUISFFjXd3Nlv8r/1IWtwEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQQC4n94EhIzcM8mpnbcVffUMcezUkIP2KAazTRVMUR1zaED5yZ5Wc4KenKOCXkSagiiOqbrqZoQfSIHuQMGrVWHNFt6Cdazo3tHqHSwKYfyaQuix7ZBHmTReLlhpFoW8JOWCMuKuo8F8PHMudQ7suYTfx1VMmz6J8PnQxDNwco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lynkxsd2; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1249b9f5703so3381381c88.0
        for <linux-wireless@vger.kernel.org>; Sun, 08 Feb 2026 23:27:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770622048; cv=none;
        d=google.com; s=arc-20240605;
        b=JiW/nl3cpR1SLqykLpjOnLKzdTlbK5k2itZJuluXwOGZ0gvB7Z4xQpvT2nYNF9qWaz
         gF0L2vUvtpPsFj/SFx6ceBgl4mxAG+HuFo4Ld2ffgcGSwX0bXYwSPL5LdXiLQdTgIPwX
         UAXE+o+DjxF6oTXuvibbRHb4XpWkj/dm3NW3ySsuD10oS2YJlzso7EY9ZiR4GPCovYK+
         593xPlEXuLVD/aFnlR7pp/GDGn6wJwrSWKANcMXxk8YWGi62KlPDh4/wqPwpFz8IfRhH
         Iyt5Yt1V9GckxNX1mG17NmZ4OXUfGIoLlMw/oX8igPUArZcqG86sUI9pOkJNyPMwFObh
         qVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c9qLHkrtXI8OYz0/SFVxXUISFFjXd3Nlv8r/1IWtwEQ=;
        fh=6BtSEZbyKIWBUHAlIwiJyumC/CuXGsnXsdL4cm0yFvc=;
        b=XsN4ryCEBf9x6hWnPx0jcZGPxsGlpXqs8DEeX2FwGjjpIOo9vE86eznb/K096kiJyE
         af0r47YT7lA55gyHvdu8zw8SftqoB9wOomuDr9FX9kGSeqZsIh0yHNo2ATpT3qd6r3Ke
         EA9WIp1Va3b874/WdaMPZl1Fr7kQj+Yu6xtGwCyVxKt5gGYJhQ1YDYrRRSQhEnKySD42
         Y5LByq6YpBJx9sz4v9uppxJzDHFVWPo93rmy+Cwp1U3kUYu3ozysP09A4vUTfvQqyO0G
         fxykmlh5pYi9KD3/4YLX5zX1mcWD1Eu03QrAO8oi/MRu9SSFzKQjqqPRXzBSLKdZdJhU
         oYEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770622048; x=1771226848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9qLHkrtXI8OYz0/SFVxXUISFFjXd3Nlv8r/1IWtwEQ=;
        b=Lynkxsd2SeZaHOkOKpF7Po/26N8HvwpPSMKiuW7l10z+vfAEoaBXDWd1DfOcu2hv/f
         N2stE2xqtwtpV/aMc3bi2k9QmGAbj+QEvaUM29hzmtZ4dOf5h0aVai2TA2seRkk0iBac
         stRBst7wjk2Jx8EBXz7XudwRbYIPAK8B+hL5qeR7IdneGluEsZF59Mx7ZlL2bL/mAcWK
         E3zr7L6MAZ28zdnHbPLoB3WQce+syY0Lmfu9a4okMzcMapAQoGz0Ct9qsBpD9uOsyLxK
         g+6ovp287qkJnkCTCIDyqJ/r66bPvQukRoBD7bBcXUx183AI5+H/OoKxPAmJbP8FqjtZ
         lB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770622048; x=1771226848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c9qLHkrtXI8OYz0/SFVxXUISFFjXd3Nlv8r/1IWtwEQ=;
        b=tQrxHn9qCp2ci2mnNpsJ+XFcBtMZhxDaNEGlgkGnGYZOsXYsUoBLrimpma3jrV0Uao
         ZqNzgWOnGsE9RM/wZL/Kl1BIxGnebRQP7UOffkcKD3KEDyBCoy0r4xgcS3IgRAFjtqiT
         VeLbclPXOpqonNe6Pylzzv2QWDRkRBOaBbcwHi489tMAAGnuexP2WvLPv3fqu/Oiv1MC
         I2ExkWJjTgVxQcAXTJyVM1ysO+ZF1NtuMAX9cmfp4cTRcC1rAVcOVQwxK619cjQtVgfQ
         zXYjf2ajH8rIxx3N+VMIMREoN6xR8BDZMqJ5Irvsxxd57OIHbKKD16SAtsF5scnosQdN
         fWBg==
X-Gm-Message-State: AOJu0Ywg9tAAC1g8Wd4OWELNww2hLrSvCvypCIxmN4OQ4EAZFT6cvi4i
	+vKS05967iHlcozPM5aNODS7x+18tzvDul5KLATOx2fU1y+h+RLCrVxoxYOc4ClNueLeuBHSAth
	ihhveUIEaex7+57N+/wK80UChvPlX2xVNLm7X
X-Gm-Gg: AZuq6aJXE5bRvUSmGblMet3NYHV21i5Sm81WWKPWBmB4lmGSIXtJ2W7W08Ox9RdW7kZ
	506En3lzRr/VvAjbwd6kF0pKaH8cWN46TgMUN2vwy/EojfzcAWZWNcXOCT5xbLGXkHGjtuQne4c
	SHQNQMcuJEPTtPXY8Zj7vDBQ2VYzSFQNBjOvyytSB03olf4IHGrlqnPz2u8LbLH68x0on74MBG0
	n0b0KvUsL+B6fiYzj03yI50VG+oDPilNH2zfRNeOCG27VLCMZDdzrUQf8x5Lqq1tfStr0mT+2zy
	HtKOGno3Jhclc/xGl9Ilm9yKPngIKidWcsJTjCA=
X-Received: by 2002:a05:7300:23c8:b0:2b7:8b4a:15b7 with SMTP id
 5a478bee46e88-2b85649572emr4339394eec.16.1770622047977; Sun, 08 Feb 2026
 23:27:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <wLZVXoPkLGec1OnYaA-mWI-GD0IzTZFMVJBP-E1d6q2xsBKubMhd67js94mBMze_5NuuYNQ3eeezFU-lddpFXqD4-cRhIOuCVXdWY4L-Fao=@protonmail.com>
In-Reply-To: <wLZVXoPkLGec1OnYaA-mWI-GD0IzTZFMVJBP-E1d6q2xsBKubMhd67js94mBMze_5NuuYNQ3eeezFU-lddpFXqD4-cRhIOuCVXdWY4L-Fao=@protonmail.com>
From: Emmanuel Grumbach <egrumbach@gmail.com>
Date: Mon, 9 Feb 2026 09:27:17 +0200
X-Gm-Features: AZwV_Qh6ActsMx2B7xaWCxrJ0vT_s4Je0KAgQXr_69p-b0E79QLnAX_cqhfioa0
Message-ID: <CANUX_P22TqBtXaGHMbvh+taEyvBDswXjUmn8R7QrXKVPSNeNcg@mail.gmail.com>
Subject: Re: miriam.rachel.korenblit@intel.com
To: Maxim Schoening <maxim.schoening@protonmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31652-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[egrumbach@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email,protonmail.com:email]
X-Rspamd-Queue-Id: 16F6110C78F
X-Rspamd-Action: no action

On Sun, Feb 8, 2026 at 11:19=E2=80=AFPM Maxim Schoening
<maxim.schoening@protonmail.com> wrote:
>
> Hi,
>
> The iwlwifi-bz-b0-hr-b0 firmware has not been updated past version 98 (co=
re98-161, October 2025), but the 6.18 kernel's iwlwifi driver has raised uc=
ode_api_min above 98 for this device class, resulting in complete Wi-Fi fai=
lure.
>
> On 6.17.9, the driver falls back to 98 successfully:
>
> iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-bz-b0-hr-b0-100.uc=
ode failed with error -2
> iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-bz-b0-hr-b0-99.uco=
de failed with error -2
> iwlwifi 0000:00:14.3: loaded firmware version 98.d661c37c.0 bz-b0-hr-b0-9=
8.ucode op_mode iwlmvm
>
> On 6.18.7, the fallback no longer works and Wi-Fi is completely broken.
>
> Neither iwlwifi-bz-b0-hr-b0-99.ucode nor -100.ucode exist in mainline lin=
ux-firmware or the iwlwifi for-upstream branch. Other Bz variants have been=
 actively updated during this period:
>
> bz-b0-gf-a0: updated to 100 bz-b0-fm-c0: updated to c102 bz-b0-hr-b0: stu=
ck at 98 since October 2025
>
> The most recent for-upstream commit (9a9285ce, 2026-01-15, "iwlwifi: add =
Bz/Sc FW for core102-56 release") adds firmware for Bz/Fm and gl but not Bz=
/Hr.
>
> This looks like a coordination gap: ucode_api_min was bumped without matc=
hing firmware being released for all affected sub-variants.
>
>
> Affected hardware:
> [17.350374] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX203
> Device:
> Xiaomi Redmi Book Pro 2025 PCI ID: 8086:7740 PCI path: 0000:00:14.3 Varia=
nt: bz-b0-hr-b0 (Blazer CNVi + Harrison Peak radio)
> Working: 6.17.9-76061709-generic
> Broken: 6.18.7-76061807-generic
>
> This is the same device class previously affected by LP #2102029, which w=
as resolved when bz-b0-hr-b0-96.ucode was added in the core93-123 release.
>
> Could the Bz/Hr firmware be brought up to match the other Bz variants, or=
 alternatively, could the ucode_api_min for bz-b0-hr-b0 be reverted to 98 u=
ntil the firmware is available?
>


I replied in the bug you raised here:
https://bugzilla.kernel.org/show_bug.cgi?id=3D221063
>
> Best,
> Maxim
>

