Return-Path: <linux-wireless+bounces-13959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672FA99E33F
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 11:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BEC328416D
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 09:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24061AB534;
	Tue, 15 Oct 2024 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJFrDM43"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBB217DFEC
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728986369; cv=none; b=VWMnIdyNyM5SfC5l97cOadvrIG2mjFoC7SU5bxEkYT7IlOpTD9Xdqbsm6e9vmwnN96mpVBUQaUJzpquiOKzTZF15qMbp2TiNhXt7UxvVDdPdPHu4JUZXIDg2ifG5KopsAFxSMke7+JmJNspu9AyioCAfzEEBl30v1TAF8/ub10Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728986369; c=relaxed/simple;
	bh=RNlRMD3eaFAhEC52+XuWUcDS+FqDL91nWc7Jm19SleY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=RN6pbrHEn1z5LcTDRB+ecwn0gW7VYqNPv34JtfsjmOhum8PW9IxDp7E8U6j3RS3CadVSOwUR0fv+DN7v0VTkNjC03+luzfHj5qWVbzNtkAniE+ht7ZcBmJ65NHGKBnF+BGj9jBU+PNrQntlAYQ02rhWhjBQDJUNRSAFPOwlEYXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJFrDM43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BBCC4CEC6;
	Tue, 15 Oct 2024 09:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728986369;
	bh=RNlRMD3eaFAhEC52+XuWUcDS+FqDL91nWc7Jm19SleY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=nJFrDM43figFmyPY1kP70mD4eKpMjOg70m551kXServ0jPdxyO3dimytjeINvptR9
	 Wo4Nz9hvRcptxYN5F9B7wJuOi3GYbKv1Ifgfaz5w9aa7LeBuZ6GOKVayxDgDcmch8x
	 6rru31h+7DRhZq/E8rCBctQIgnGddiTmXS7g01tAdgOR7h/feUhmuEDyPdDsteBFw2
	 8xqU5lZeMMT7vI6Li2+T0UztovLDeRFuEUhckszjZR08w8A71+LcIToWep6G8qz4Mk
	 1o/ZFM1/evtN4lpP74qPiVz8KNYNtdnCb7lVf0yHb4HKL3x5p9tGS7QefS81lon09E
	 lkSRB1LQ2hNaQ==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Dmitry Kandybka <d.kandybka@gmail.com>,
  "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,  Dmitry
 Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH] wifi: rtw88: coex: remove rf4ce unused code
References: <20240820055244.128644-1-d.kandybka@gmail.com>
	<2c5c0d485df7b334ea0bfbb87325a5fbc7b52663.camel@gmail.com>
	<9c83fca1a28c4b3f8fb2ca65752ad655@realtek.com>
Date: Tue, 15 Oct 2024 12:59:26 +0300
In-Reply-To: <9c83fca1a28c4b3f8fb2ca65752ad655@realtek.com> (Ping-Ke Shih's
	message of "Fri, 11 Oct 2024 00:26:32 +0000")
Message-ID: <87a5f5660x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

>> This is kindly reminder. Could you pay some attention to this patch and
>> clarify if the rf4ce is actual for this moment and future?
>
> Yes. Our coex developers want to keep this chunk. For me, this kind of cleanup
> patch is not very help to driver, but I and developers need much time to
> confirm and judge if we keep or remove them, so I would want to ignore this
> kind of patches... 

Yeah, I share your pain. Cleanup patches are most of the time
unnecessary extra work for us maintainers. We should try to write that
"cleanup policy for wireless subsystem" doc at some point, then we could
just point that to everyone submitting cleanup patches.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

