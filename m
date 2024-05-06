Return-Path: <linux-wireless+bounces-7213-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C18E98BC86E
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 09:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D403280E9B
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 07:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3247128374;
	Mon,  6 May 2024 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGxAoTY5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EED7127E3B
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714980927; cv=none; b=JpWImVKoEIoPVrPaSUrSijTLg4oVhsxpzNs4HhAm7PMHeZ9q/R6XaQGYOnjJzJUxW8Rhp6QbWObkrpLcDCbD0KE7kerb96ZAlqW7DrLs2+n72UNEAJnpFwlQ8UDqfVOdtqUxUMqncGt4LQuJrBaFITcR/zTH/7U6fD8OdiRCIcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714980927; c=relaxed/simple;
	bh=9XEVjGDto9xzx8sforPJDmq9OK8fTvs7CX8OymuYdq8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=cZ75o4iHsbJ98eYG6eWekVYfXHwTwTsB5vrn20NR75AdZmoXh+TrfCApDQHJtNq5oG2/dhSISiFy5KDui4n8koKs2P+aQKrz6YrG6fOTWWIdzUocauqgFPsIIOHmt7Omc39Yad7EnoUsTXK5xsUWRv77LlcvftRqWLthduP74aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGxAoTY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90AEC116B1;
	Mon,  6 May 2024 07:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714980927;
	bh=9XEVjGDto9xzx8sforPJDmq9OK8fTvs7CX8OymuYdq8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=VGxAoTY570igKe19Iv6Cu7xdkx4bqWAIAyi41uaxPDMCcBqXEPdhPCTy44w02ZRKB
	 Fm/oouM4ZvuXsBCnrUbn51svEtKbgYm6DTq5xl1YHEqHh1wiC7MY1jrkIRUZMvO7I6
	 RAJkoif/HjD/wKQYxpDCu6q3Ixm9aSukxyMnVaAS+PwIVb0Lsy9gktnMh64Xf1WdLq
	 4ap3YakxETZECKnDXFTsZ8gl2T7wf3KURWIJR31ajFaokZ0KnPICR8BqmdbyR3WVn8
	 fzGbtSQVPg/mtxb8YMQzt6QqzVvwzb2eOpuEsR/nGSkYjB7yx8Xxyk1SvBgUvYtz6+
	 m3TP9PGus7lfg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: rtw-next-2024-05-04-v2
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <2ea1dde1-1baf-481d-9783-33b94c113521@RTEXMBS04.realtek.com.tw>
References: <2ea1dde1-1baf-481d-9783-33b94c113521@RTEXMBS04.realtek.com.tw>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171498092457.3511823.3975770225507699815.kvalo@kernel.org>
Date: Mon,  6 May 2024 07:35:26 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Hi,
> 
> This is v2 pull-request of rtw-next, which additionally fixes GCC
> uninitialized warning, to wireless-next tree, more info below.
> 
> Thanks
> Ping-Ke

Pulled, thanks.

2d6c71776056 Merge tag 'rtw-next-2024-05-04-v2' of https://github.com/pkshih/rtw

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/2ea1dde1-1baf-481d-9783-33b94c113521@RTEXMBS04.realtek.com.tw/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


