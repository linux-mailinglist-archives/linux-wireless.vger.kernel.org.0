Return-Path: <linux-wireless+bounces-9149-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE3F90C979
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 13:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FBF1C21505
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 11:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65EB145FF0;
	Tue, 18 Jun 2024 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJXV3IQz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C32A1459FC;
	Tue, 18 Jun 2024 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706786; cv=none; b=Iu9KNfE2H53QKeB9suUu2HKwHKngqhiPfr1E0gnOEcHADHbsAfbbL4Yo+AwNK5cdiKvtmCT71OsL6eop5FhWwzHDZTyTw1WW3xpLhvvLnQKA4eyal++pL3C6hl+Pein9Qsw9d8uTaPDWuZibqF+PnEGhfRjPl/eLBAsr4KAIB3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706786; c=relaxed/simple;
	bh=d+KqVRY5r/LUL/F6ah5QCeCmdElPdVXvx+9zgrOlu7o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Uxii9Asvx/Ai6pcD1UNkmyHZUFdx3B6PO+BnPKYC/3HLRJsJ57fwp8WeVDGS/7TyCuPSL67gyPm5M83GL4e55DSsAukwHsc88FXmIzhy11LJVZ5H+SsQQ/DOXXY+cdFkZmEGcOAJj40/y0xyaedD+sbe22CC00JqIqcOYbsQ17E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJXV3IQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989C6C4AF60;
	Tue, 18 Jun 2024 10:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718706786;
	bh=d+KqVRY5r/LUL/F6ah5QCeCmdElPdVXvx+9zgrOlu7o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=uJXV3IQzYzApcJx1UiqO3xDsCBLmVFvslf9vTp2nXSDx7FQA9qnuENz4iJFwrcVhc
	 b+0ZGaRoztJ628NOBrnChS9XpCRXqlrH9GoMVED698mZobumVTbZT3Ro2jJGnyDTpN
	 nsRX5G2RYZQeoX4a7MiCsWzxF8m9kjiQj+uNJagQDlXvRpVQ76sQA+S++dOaVv3e3q
	 EmPgSpLpS0QfLT10PM5s+2cMawcao1jb3oUdq/V/LyJA4KxF+Wd9c/jT8XFBIzOmEL
	 qEtK3sD82C+U/iMqwpw+VPwaVSMeyGVqggZ0WVZip9rsB+VqCAHoMI5rdFaWgSM/zx
	 l5CMPMv/RYTOQ==
From: Kalle Valo <kvalo@kernel.org>
To: James Prestwood <prestwoj@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,  linux-wireless@vger.kernel.org,
  ath10k@lists.infradead.org,  LKML <linux-kernel@vger.kernel.org>,
    Baochen Qiang <quic_bqiang@quicinc.com>
Subject: Re: invalid vht params rate 1920 100kbps nss 2 mcs 9
References: <fba24cd3-4a1e-4072-8585-8402272788ff@molgen.mpg.de>
	<1faa7eee-ed1e-477b-940d-a5cf4478cf73@gmail.com>
	<87iky7mvxt.fsf@kernel.org>
	<37ba6cb0-d887-4fcf-b7dc-c93a5fc5900f@gmail.com>
Date: Tue, 18 Jun 2024 13:33:02 +0300
In-Reply-To: <37ba6cb0-d887-4fcf-b7dc-c93a5fc5900f@gmail.com> (James
	Prestwood's message of "Mon, 17 Jun 2024 08:40:23 -0700")
Message-ID: <875xu6mtgh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

+ baochen

James Prestwood <prestwoj@gmail.com> writes:

> Hi Kalle,
>
> On 6/17/24 8:27 AM, Kalle Valo wrote:
>> James Prestwood <prestwoj@gmail.com> writes:
>>
>>> Hi Paul,
>>>
>>> On 6/16/24 6:10 AM, Paul Menzel wrote:
>>>> Dear Linux folks,
>>>>
>>>>
>>>> Linux 6.10-rc3 (commit a3e18a540541) logged the warning below when
>>>> connecting to a public WiFi:
>>>>
>>>>  =C2=A0=C2=A0=C2=A0 ath10k_pci 0000:3a:00.0: invalid vht params rate 1=
920 100kbps
>>>> nss 2 mcs 9
>>> This has been reported/discussed [1]. It was hinted that there was a
>>> firmware fix for this, but none that I tried got rid of it. I got fed
>>> up enough with the logs filling up with this I patched our kernel to
>>> remove the warning. AFAICT it appears benign (?). Removing the warning
>>> was purely "cosmetic" so other devs stopped complaining about it :)
>>>
>>> [1] https://www.mail-archive.com/ath10k@lists.infradead.org/msg13406.ht=
ml
>> More reliable link to the discussion:
>>
>> https://lore.kernel.org/ath10k/76a816d983e6c4d636311738396f97971b5523fb.=
1612915444.git.skhan@linuxfoundation.org/
>>
>> I think we should add this workaround I mentioned in 2021:
>>
>>     "If the firmware still keeps sending invalid rates we should add a
>>      specific check to ignore the known invalid values, but not all of
>>      them."
>>
>>     https://lore.kernel.org/ath10k/87h7mktjgi.fsf@codeaurora.org/
>>
>> I guess that would be mcs =3D=3D 7 and rate =3D=3D 1440?
>
> I think its more than this combination (Paul's are different).=20

Good point.

> So how many combinations are we willing to add here? Seems like that
> could get out of hand if there are more than a few invalid
> combinations.=20

Yeah, but there haven't been that many different values reported yet,
right? And I expect that ath10k user base will just get smaller in the
future so the chances are that we will get less reports.

> Would we also want to restrict the workaround to specific
> hardware/firmware?

Good idea, limiting per hardware would be simple to implement using
hw_params. Of course we could even limit this per firmware version using
enum ath10k_fw_features, but not sure if that's worth all the extra work.

Baochen, do you know more about this firmware bug? Any suggestions?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

