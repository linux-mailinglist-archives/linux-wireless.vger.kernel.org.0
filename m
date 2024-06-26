Return-Path: <linux-wireless+bounces-9606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 138159180F7
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 14:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7BA1F23571
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 12:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF1513CFBC;
	Wed, 26 Jun 2024 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGmgqk0v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0281C10A11;
	Wed, 26 Jun 2024 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405279; cv=none; b=nhcWqQ4+xqDFlSQWFbhEzyu6DEY+567FjqMcbbCUd6ZWznrBDisIgw/wC5jBEgv5e/nALgARmMcuC9Lz3pY63BlAAVQwXR+0R5ZwqO9I65Y0y1C31rVfZGICqRH0ZB/s6aZsYiX2fD4m5wpNuFhdVyaaYSo2/xi5lF18oAgPJK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405279; c=relaxed/simple;
	bh=vrGR49umSrf6jXsmHMnbHGXbB2t/2+C/fhNk0egBlRM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kuMIFFugXAQWCMBifEABiJmFCVxuU5fK0Mpk29Coe/CP481bOa2/qVd1SYsPuyzC61ivg8G9Aasboz0qh1EHJ+EIYeesvUJuda7XtpChbxO6/XJTGIWQYFliVAgeHRZumRQmJ5zil8/HCnlafJKnE9CT57jKw6fsrR/whu+cdb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGmgqk0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A369FC2BD10;
	Wed, 26 Jun 2024 12:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719405278;
	bh=vrGR49umSrf6jXsmHMnbHGXbB2t/2+C/fhNk0egBlRM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OGmgqk0v/2DSdHP2PehmCcFWE0tpK+Tr/6pIC6YHZYUJhx5ISOW692+cZKlMFi1Dh
	 R2UDifrfuCz35g/fVQg2doIYQVOP5XDTlWs1qQ+JoNEazkKFWc6X8n+cS9h/Lxbxyy
	 NIKKbdtDD/3u6Ci/9mXaKK+6M+8E496cVoA5E7yGCo3OqHgdw2Gbcbp3UzQwwhqSho
	 bMxD/dqiTXh7et+58LWQbdOoZRic4bZPbg+xDx2+Kio94N+lBE3lE9Q5Kpl9JlEjaE
	 TCWew9pss1StJkv4ZuTJLSGgNbj6k+0L/S+EGGPCWhKy1WYOlaAyJhCKI4OQaBI59b
	 u6oOZajc7R4fw==
From: Kalle Valo <kvalo@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,  James Prestwood
 <prestwoj@gmail.com>,  linux-wireless@vger.kernel.org,
  ath10k@lists.infradead.org,  LKML <linux-kernel@vger.kernel.org>,  Hans
 de Goede <hdegoede@redhat.com>,  Kai-Heng Feng
 <kai.heng.feng@canonical.com>,  Hui Wang <hui.wang@canonical.com>
Subject: Re: invalid vht params rate 1920 100kbps nss 2 mcs 9
References: <fba24cd3-4a1e-4072-8585-8402272788ff@molgen.mpg.de>
	<1faa7eee-ed1e-477b-940d-a5cf4478cf73@gmail.com>
	<87iky7mvxt.fsf@kernel.org>
	<37ba6cb0-d887-4fcf-b7dc-c93a5fc5900f@gmail.com>
	<875xu6mtgh.fsf@kernel.org>
	<f7faff80-864a-4411-ad28-4f1151bc1e51@quicinc.com>
	<082024ce-fdd4-4fb1-8055-6d25f7d2e524@molgen.mpg.de>
	<878qyshuud.fsf@kernel.org>
	<d19d520c-547b-46c1-b59e-748c2cccaf53@molgen.mpg.de>
Date: Wed, 26 Jun 2024 15:34:34 +0300
In-Reply-To: <d19d520c-547b-46c1-b59e-748c2cccaf53@molgen.mpg.de> (Paul
	Menzel's message of "Wed, 26 Jun 2024 13:48:01 +0200")
Message-ID: <874j9fj31h.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paul Menzel <pmenzel@molgen.mpg.de> writes:

>> All firmware releases are available here:
>> https://git.codelinaro.org/clo/ath-firmware/ath10k-firmware/-/tree/main/=
QCA6174/hw3.0/4.4.1?ref_type=3Dheads
>> And more info here:
>> https://wireless.wiki.kernel.org/en/users/drivers/ath10k/firmware
>
> Thank you. It looks like the latest firmware version is 309, and
> Debian sid/unstable still ships version 288 in *firmware-atheros*
> 20230625-2 [1].
>
> Unfortunately, there does not seem to be a change-log for version 309
> (or any version for that matter). I am going to manually copy it
> anyway, but it=E2=80=99d be nice, if I knew what to expect. ;-)

Yeah, unfortunately there are no changelogs available for firmware
releases but I do understand the need for those. There has been
discussions to create them but no success yet.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

