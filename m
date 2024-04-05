Return-Path: <linux-wireless+bounces-5889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B58F78998BA
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 11:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43510B21985
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 09:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F291179BD;
	Fri,  5 Apr 2024 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T824kDsZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B707611E
	for <linux-wireless@vger.kernel.org>; Fri,  5 Apr 2024 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712307681; cv=none; b=MwIR6EY1YbOZidW+eiGhSfzWBBGR9v85f3vvUwhW2NC9i/hRLy8LAgI6ZbWtxVdHOymhhYaMyAAxHtWZTERohhsmFqDoIlhVHdldkZizN4hOS7R5DvRBSzyxCXT/7glWuMzIlOEl5Dl5ufDyfsKVlHkO7fDhanSMd58Gz870GfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712307681; c=relaxed/simple;
	bh=uw85ezuMCE7FJWO8qa9sN8qSxCngd+bgGcSnAWAydCU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=GoACn0FzsPO61FdYOgRwPoOgsJpWp0LH0MIE0HQnmPkRF3xN6m7So0Wg0Y9e0c0inPJ8gWZFXTD/AcY0p97vJ5y1zN97pzOf/zBnJoGmkixkHC8NV1fKtuH2xQwGSrOrlTulR5KUBb9MjZpm55V8CxAB3Y8X6JBbzgTfTAAGHlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T824kDsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A400C43390;
	Fri,  5 Apr 2024 09:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712307681;
	bh=uw85ezuMCE7FJWO8qa9sN8qSxCngd+bgGcSnAWAydCU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=T824kDsZcYdoFnKrAXezpReoKI9vWG4FHhEBbQRO9JGaEmqdrU2EZ+mHyr5uUhKD8
	 3sZSKVWHJxVEgpfMjmfvgkAyj1N4SxOlweaMQRoyD5HttNNlw4PooIAiiiRsMgEgeY
	 v5etf5xw9Pe8MzpV8Cmsdbadf3IzKB9sUit3zCjOhsOK5dIZEtFq5SUvuMggXGEbcj
	 Gxyeud/dms0Zhq0FQ/VhJkEHYQx/xpYF04ODIsPu+ybqZjUZbrrgIkhjk5e3bxrQ+h
	 aK/LJTkZZ3/544gCsucGKpZV0qT2gbs3WSFR+kJU+nE7T3tm7PTh9Jm3c+k9UUEPUI
	 WYOivfv2dXGFA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: rtw-next-2024-04-04
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <fc4ed5d9-e93d-4f5c-8f25-df28990ed363@RTEXMBS04.realtek.com.tw>
References: <fc4ed5d9-e93d-4f5c-8f25-df28990ed363@RTEXMBS04.realtek.com.tw>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171230767840.2149729.14448695973268910181.kvalo@kernel.org>
Date: Fri,  5 Apr 2024 09:01:20 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Hi,
> 
> This is first pull-request of rtw-next to wireless-next tree, more info
> below. Please let me know if any problems.
> 
> Thanks
> Ping-Ke

Pulled, thanks.

132c2a1cf76d Merge tag 'rtw-next-2024-04-04' of https://github.com/pkshih/rtw

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/fc4ed5d9-e93d-4f5c-8f25-df28990ed363@RTEXMBS04.realtek.com.tw/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


