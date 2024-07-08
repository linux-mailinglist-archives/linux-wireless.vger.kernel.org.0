Return-Path: <linux-wireless+bounces-10071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543E292A045
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 12:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CFE1F216C4
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 10:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEEA6BFB0;
	Mon,  8 Jul 2024 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3Cyg1Vw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D971DA303;
	Mon,  8 Jul 2024 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720434792; cv=none; b=eFVVDmP2pk0izYb/VN+e0AoUrKhZDNd9fdfcMtEloGbUOzNyEOO4ZIWisqUXQ/6Sj2b3ncqf2+az4cIx5u8eoxGLTZ/EJO7jHRdspf3GXqYwo3cx+4VyxOcuYwkislGQlStjjyiNZ2oEVnSJ31UKCP2pnF45BUJCeBDdTfzYXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720434792; c=relaxed/simple;
	bh=WHPq6XGox2t5QBzjMLQf3aMokr2bbVCFuM47TTyBV48=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DRF+EC3DUkZXiAyLilMnNzKgtoJaX74ZrHFO7m5tuEljxgBzfh5rCKTxpOUilHAY6O2r8Z+BA9Alon69NZs67yuud8ui3WV3Xex6/kNirgs+Fo3Qyq8gSDDJmdvazpYrXkcqWBkGVn7wLR+s2dQmP3ZmYcc2wvidARPLT+LSoRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3Cyg1Vw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950FFC116B1;
	Mon,  8 Jul 2024 10:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720434792;
	bh=WHPq6XGox2t5QBzjMLQf3aMokr2bbVCFuM47TTyBV48=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=W3Cyg1Vwy3FFg1cZWs9jmLvodhj8id0aPGwX7oukQDFr3XEq38uxdHJRhNIjC0mG6
	 By/8xO5k3w/jrBJ+VQzQYPowUal2cDIK4ICRae+VeYvOwJhcUkDXgF2IchS61TxSXa
	 N+ujTz23HaMpfEHWI5X9HY9IIeEQL/Nv4LVZovLTbDaQ0E0tH52UsI+Z2oyJFHqi7S
	 eYTNwgZUVdo9qIdOCZZwaC5hpkORmbgmjlkq6oW4OajYV1d7tq6ljAji34BioGi/cG
	 7ENTsZ+Nt3oYRMrKRv/WQDMcZA37f9z0J6r6PENJ7+li1ZjYzUUQ+KbmKw5U4ViYyF
	 U1j8FHjA7ZY2A==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,  James Prestwood
 <prestwoj@gmail.com>,  <linux-wireless@vger.kernel.org>,
  <ath10k@lists.infradead.org>,  LKML <linux-kernel@vger.kernel.org>,  Chun
 Wu <chunwu@qti.qualcomm.com>
Subject: Re: invalid vht params rate 1920 100kbps nss 2 mcs 9
References: <fba24cd3-4a1e-4072-8585-8402272788ff@molgen.mpg.de>
	<1faa7eee-ed1e-477b-940d-a5cf4478cf73@gmail.com>
	<87iky7mvxt.fsf@kernel.org>
	<37ba6cb0-d887-4fcf-b7dc-c93a5fc5900f@gmail.com>
	<875xu6mtgh.fsf@kernel.org>
	<f7faff80-864a-4411-ad28-4f1151bc1e51@quicinc.com>
	<082024ce-fdd4-4fb1-8055-6d25f7d2e524@molgen.mpg.de>
	<462c97dc-f366-4f75-9327-04d9424b819a@quicinc.com>
	<b30307fd-4417-4220-a3ac-e3e80f23105e@molgen.mpg.de>
	<ceddb62b-61dd-44c9-babd-cd375c5a147d@quicinc.com>
Date: Mon, 08 Jul 2024 13:33:08 +0300
In-Reply-To: <ceddb62b-61dd-44c9-babd-cd375c5a147d@quicinc.com> (Baochen
	Qiang's message of "Fri, 5 Jul 2024 18:51:47 +0800")
Message-ID: <87sewkcgwr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Baochen Qiang <quic_bqiang@quicinc.com> writes:

>>>> 2.=C2=A0 invalid vht params rate 960 100kbps nss 1 mcs 9
>>>> 3.=C2=A0 invalid vht params rate 1730 100kbps nss 2 mcs 9
>>>> 4.=C2=A0 invalid vht params rate 1920 100kbps nss 2 mcs 9
>>>
>>> OK, these are due to mismatch between host and QCA6174 firmware, we
>>> can update host to fix them.
>
> Kalle, the root cause to these three warnings are clear now and if you
> agree I can submit patches to fix them. Or I can also wait until the
> NSS 3 issue is clear.

I'm not sure why would we want to wait for the NSS 3 to be solved? Based
on my (limited) understanding I think it would be good to submit patches
for solved issues now.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

