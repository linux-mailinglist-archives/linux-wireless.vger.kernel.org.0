Return-Path: <linux-wireless+bounces-2383-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE9A838F2C
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 14:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD491F2841C
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 13:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F03604C5;
	Tue, 23 Jan 2024 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbqDY4GV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0301604BE
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014784; cv=none; b=O47h++gyTEzRZAM8/+SRfmZuAtAHBjRkbYmXIye6E79Wfqa6tqduraH5xaKuCcaxCubC1c/lyEMqm3eZ+JOsbKan1WQx9wcvT68o4ffFrBjsmFbXrKUiJp+5wDqu314df/AmxI5mAf/IXFUFiWDXg393V7IplatGx7el6Je+IwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014784; c=relaxed/simple;
	bh=69IWKKN04y4FL/5Xfa2y2kr6Hf1Fwg13O18Un+9gC40=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=pkljeqzKZ76e8hIkZf+193d1By6SbsY4TPczMv4rKkvVcLRQKepyATr9P0WtG5YdJ9FcRICC/NEl1sxZ9QRKkuN7ceLgIH7SkJ4IH8dDOBdcI+LcsY0AOX7tzLHnedEDKXOoZ/BCcBGJ64uNAPGoGyvV3c4jRDYndBtTGGTAQDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbqDY4GV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052AAC433F1;
	Tue, 23 Jan 2024 12:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706014784;
	bh=69IWKKN04y4FL/5Xfa2y2kr6Hf1Fwg13O18Un+9gC40=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=HbqDY4GVEJ/MB8/9zxFtqaGQr+EVqNbNAW4GDWnnYG9YyxTeLhtUGCgpe1m+CmTrN
	 JF0JxaW124XoN6FR9IwLSaJcSHdi/+D59mIy5Toju11x+OpqCrVnj6yb3iY2UdY7B9
	 fLKvzxTBAwe0+AORsyA/CloWpItLxXxmye/6BhEreLPAWts06uzVee0BnBc6Dvs4X4
	 wTJjjTR0pOKtGAD7E4aRW/zcD6k8lqh7VzBmQNodBSJseJdMxjVYeFoJuuP6vAWNZT
	 tqgdHIu0Y9unHRs7ajPbFwfLGlOEdhleDLlROBtCPGwiX/tOkzz9RKr4EdSKCBezeZ
	 HOxC91cII8OYQ==
From: Kalle Valo <kvalo@kernel.org>
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: David Mosberger-Tang <davidm@egauge.net>,
  linux-wireless@vger.kernel.org,  Ajay.Kathat@microchip.com
Subject: Re: [PATCH] wifi: wilc1000: validate chip id during bus probe
References: <20240122211315.1444880-2-davidm@egauge.net>
	<20240122220350.1449413-1-davidm@egauge.net>
	<751bf8e4-c81c-495b-9166-9f91f9c4b2d5@bootlin.com>
	<8734uo2ts1.fsf@kernel.org>
	<94d08fd2-ce43-4085-a6f6-d91981853393@bootlin.com>
Date: Tue, 23 Jan 2024 14:59:40 +0200
In-Reply-To: <94d08fd2-ce43-4085-a6f6-d91981853393@bootlin.com> ("Alexis
	=?utf-8?Q?Lothor=C3=A9=22's?= message of "Tue, 23 Jan 2024 13:44:40 +0100")
Message-ID: <87y1cg19z7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> writes:

> On 1/23/24 12:06, Kalle Valo wrote:
>> Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> writes:
>>=20
>>> On 1/22/24 23:03, David Mosberger-Tang wrote:
>>>> Previously, the driver created a net device (typically wlan0) as soon
>>>> as the module was loaded.  This commit changes the driver to follow
>>>> normal Linux convention of creating the net device only when bus
>>>> probing detects a supported chip.
>>>
>>> I would gladly help review/test the patch, but please give us some time=
 between
>>> versions to take a look (even if you can mention if you found issues yo=
urself).
>>> Also, each version should be a separate thread, bearing the new version=
 in the
>>> "Subject" line.
>>> Additionally (to answer your cover letter), the patches must target the=
 wireless
>>> branches (likely wireless-testing), not linux-next
>>> (https://wireless.wiki.kernel.org/en/developers/documentation/git-guide)
>>=20
>> Actually wireless-next is preferred for the baseline (unless it's a fix
>> going to -rc releases):
>>=20
>> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.g=
it/
>
> Oh, ok, thanks for the correction, I may have misinterpreted the wiki then

Ah, we should update that page. That page was written before we had
common wireless and wireless-next trees.

I don't know Johannes thoughts on this but my recommendation for
baseline:

* use wireless tree for important fixes going to -rc releases

* for other patches use either driver specific tree (eg. iwlwifi, mt76,
  ath) or wireless-next (if no driver specific tree available)

* for automated testing etc. use wireless-testing as it's a merge of
  wireless and wireless-next and contains all latest code

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

