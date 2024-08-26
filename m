Return-Path: <linux-wireless+bounces-11983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4372C95F003
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 13:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E2D28522F
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 11:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD94A154C11;
	Mon, 26 Aug 2024 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfMzAhWx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941C71482E3;
	Mon, 26 Aug 2024 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672524; cv=none; b=t05MXnlascHAlnf16Puf0bLmdO1XrvcJc4pQVP1EpmGeCYocmV9AxjCBZxP3eISkzjMaZf+82onaG4mSOqw/Iq9xBAVMqPQRd8ixRCWmFalHbgpjDLPnVUPU4AkhhVFSZ9Ekj/QRQmZzwiT3jdrRB2u/ncn93ay3kONZdq7irho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672524; c=relaxed/simple;
	bh=3vH/QMaGRSsoqKjoBMoil/aDWRAiSIq+fBv32gLkIM0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=K7GTnFEzJUdQCFbuFgCPnt/aUaobL/ggINCH0Llqff7qR6N2uXo5wz+VDmjD6o68P3Nfd78RVCp6qHFIUB4hnGRdqLzNqdxWyw9YOvsl8OJXimqfGT4NVfipdkUT7rAS0+E4oiFImkBICqWiS9oLUsI/z9CwApXejJgH0YDpSag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfMzAhWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB7CC5140F;
	Mon, 26 Aug 2024 11:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724672524;
	bh=3vH/QMaGRSsoqKjoBMoil/aDWRAiSIq+fBv32gLkIM0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=qfMzAhWxoNZNzhvhuJECIJjQAHNkANFee7t6dgBa/KFGMBbMF6cgWOU78dNI7MfTR
	 4pd7LSWq3Sytbr1BYmjwtOdZu9bO0myNWHsTCJ/9CCnUcx5k5EJa4j4bUIGGLB2p6m
	 qACE6iR/vAzNqY+F2gPLT3vFJJf7/E+AafgtYWPhuPRVTWU0F8YHCek0bQKqcXGyEy
	 CB+PzsvKiUkgqDd4ElEN6/ohTkI32vJpL5IRkfzJb/vQV0Py28iV97cU1BnRL2LT7q
	 b7K9a+m0K5azbog9P+4YC+5l8aDqjhnvxEu2ntbULaGplKvzepyUGmKcsaVgIjrXuu
	 B/FUltTE7K88A==
From: Kalle Valo <kvalo@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: gregkh@linuxfoundation.org,  linux-kernel@vger.kernel.org,
  linux-usb@vger.kernel.org,  linux-wireless@vger.kernel.org,
  netdev@vger.kernel.org,
  syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com,
  syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] wifi: ath6kl: Replace ath6kl_usb_submit_ctrl_in with
 usb_control_msg_recv
References: <tencent_1D9967CEC6D952EC86530991EED86ED70C06@qq.com>
	<tencent_F0CB92D8867509922ED02ED5CCA4E7D2C606@qq.com>
Date: Mon, 26 Aug 2024 14:42:00 +0300
In-Reply-To: <tencent_F0CB92D8867509922ED02ED5CCA4E7D2C606@qq.com> (Edward
	Adam Davis's message of "Sun, 25 Aug 2024 22:21:49 +0800")
Message-ID: <87seurfr3r.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Edward Adam Davis <eadavis@qq.com> writes:

> ath6kl_usb_submit_ctrl_in() did not take into account the situation where
> the length of the data read from the device is not equal to the len, and
> such missing judgments will result in subsequent code using incorrect data.
>
> usb_control_msg_recv() handles the abnormal length of the returned data,
> so using it directly can fix this warning.
>
> Reported-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Did you test this on real ath6kl hardware?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

