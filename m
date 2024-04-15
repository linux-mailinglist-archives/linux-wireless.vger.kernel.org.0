Return-Path: <linux-wireless+bounces-6332-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544C18A5777
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 18:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B821F20F95
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 16:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FE9811FE;
	Mon, 15 Apr 2024 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvyWfw4z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B93B82486;
	Mon, 15 Apr 2024 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197789; cv=none; b=P3zuZvx+nIjd78t3rOLNNmoDEgr4iRU+IxkAgstGOIN4ksAjvMIc6nMOeVF9BLRO3eGUgom2oFIb+gPuV4M5zwUAa2FVWD8Vx9gwfVR87Zqr4XA5BSABLaHLeiXxGFrB0eaLlLcr93kfaPr6VPZNzPvWgAiP3P2HrQpHUVcjv2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197789; c=relaxed/simple;
	bh=BdZGSB1256DF/1eZ+jWN3CpnXK1PATIu70B5WWeEE+o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=SCzJBhDnLksRsB0V6lRVsmZk5FOeBVjU97TSm4V207EapnBpcBetYEa7/FHBLGPcPc5v0QRK3CIcykfQnLkEd3iEcbAsR5AA7T6i9yx7hyeNPZMeIuikQGqiWejRUd7izS56QrNOkF9mYCDZ3TbvkOIXtJp/XtYC5NWGZ2RZNDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvyWfw4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037DBC113CC;
	Mon, 15 Apr 2024 16:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713197789;
	bh=BdZGSB1256DF/1eZ+jWN3CpnXK1PATIu70B5WWeEE+o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=lvyWfw4zxDxxxLorZffuVzr11Hp0iGFTgfefZURV9/tIj9IjrnUfIbOT/JD9wr8wK
	 K2ylb/lP5Q4G7dERmDrMeZory+fCNc53mGi05QmEpv1YTYZadnn+meF1MeTC0B967P
	 PQyMdjCLiMbcJBDKuwVDtwBpZoSbhb7FArr04HmYWa3/mOqaWpNWoV/t45/hZ5mYXC
	 oC4MowtHCyLhHvbFIeX1BW0Hy4eP3pt2/iygwBHrELfdCYHsKWYoVvlWlWucehphX2
	 CiFfryCpaK5YoRKVOmXGUjTrsku/+zgET1bHbzPGJyA/xSmHs03wQKIP611YSfnO+2
	 BJCpj3Ra9af5A==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Lewis Robbins <lewis.robbins2@gmail.com>,
  "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw88: reduce failed to flush queue severity
References: <20240413230030.390563-2-lewis.robbins2@gmail.com>
	<694ac10692114ed8838909df5010687a@realtek.com>
Date: Mon, 15 Apr 2024 19:16:25 +0300
In-Reply-To: <694ac10692114ed8838909df5010687a@realtek.com> (Ping-Ke Shih's
	message of "Mon, 15 Apr 2024 01:40:36 +0000")
Message-ID: <87le5ey52e.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> Lewis Robbins <lewis.robbins2@gmail.com> wrote:
>> 
>> Reduce the log message severity when we fail to flush device priority
>> queue. If a system has a lot of traffic, we may fail to flush the queue
>> in time. This generates a lot of messages in the kernel ring buffer. As
>> this is a common occurrence, we should use dev_info instead of dev_warn.
>> 
>> Signed-off-by: Lewis Robbins <lewis.robbins2@gmail.com>
>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>
> I'd like to know situations of " If a system has a lot of traffic...". 
> Did you scan or do something during traffic?

The driver shouldn't print any warnings in normal usage, even using info
level. If this is expected scenario then maybe change it to debug print?
Or if is this an actual bug then it's better try to investigate and fix
it.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

