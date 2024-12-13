Return-Path: <linux-wireless+bounces-16380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED9E9F0CCF
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 13:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3623C1881B55
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 12:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08E71DF975;
	Fri, 13 Dec 2024 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiiYa6TQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEBB1DF254
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734094709; cv=none; b=sLA8f+XcveUPy0SCrSr18NOmQ/Ki5J59LmD/zoP5yLZA/u6WTUm6tT5I68mwAV8OKoYr1fvPljQ/V812M9X2Br/bvSZTXa6tC3BvLUF0RZudpFGjZafuENJSkw84dlQ8/3tFx2DUwH86ogIjTiMeCmU0MdXCmlp6RRGqBKMKidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734094709; c=relaxed/simple;
	bh=MVbDtGeD99wK/wOZ1ZBeGTzDCeGHrBbOnHgUV0IaKlI=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=N07DkCG1xbeD0Jc9n6K+IxWZahI52OgnxLAiI8JEs7YycZv1W68FFgBHt/6s7Vs5gAA2lVBVT8sl0g00T9YGyx2IbKBk23oHliRObyeVs9v4DzvBSTQAZ4s2EvyhC/0UVYmoOr6p7YFh6APfwzVOV79YYunyqa5bCvOvzIEi3xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiiYa6TQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DEDC4CED0;
	Fri, 13 Dec 2024 12:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734094707;
	bh=MVbDtGeD99wK/wOZ1ZBeGTzDCeGHrBbOnHgUV0IaKlI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=UiiYa6TQkIc1uH47G09P4TmMXhoZi3Lzank1XfmeWf3XBFDq1jGipTv/N+SRoi97L
	 AHdeDgak16cz/1Ss0OQegVCl2+0NTTfB6dUj7HJgnf0hnSx274JZ8gH8psNrRqb0or
	 lEQQoMvUbXC636+rD5GLGV0BrewPDxGqhc0P8+G+gNAGIEYENMRWBhYYnTLrZ1OHDD
	 VfTZWYIscfSoTdJ8HC6yoDW9Ew670uMH7WdOObLMtAw0Bs7Mew9ipqU8ZL6zPVnN/9
	 fdBsnoXmfYohb1wYZhWKnDKjggg1sE1pk567J/4JPJrI6kvOYyeBqeH+oNuXf4jRFF
	 LmePda0JHJlAA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: rtw-next-2024-12-12
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <34aea27b-9825-454f-9c0a-2e8bccc8ac5f@RTEXMBS04.realtek.com.tw>
References: <34aea27b-9825-454f-9c0a-2e8bccc8ac5f@RTEXMBS04.realtek.com.tw>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173409470456.1115965.6770943659074969743.kvalo@kernel.org>
Date: Fri, 13 Dec 2024 12:58:26 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Hi,
> 
> A pull-request of rtw-next to wireless-next tree, more info below. Please
> let me know if any problems.
> 
> Thanks
> Ping-Ke

Pulled, thanks.

104372ff3594 Merge tag 'rtw-next-2024-12-12' of https://github.com/pkshih/rtw

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/34aea27b-9825-454f-9c0a-2e8bccc8ac5f@RTEXMBS04.realtek.com.tw/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


