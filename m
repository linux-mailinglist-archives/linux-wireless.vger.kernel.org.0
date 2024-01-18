Return-Path: <linux-wireless+bounces-2169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A1683186C
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 12:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7782845A1
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 11:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24F323776;
	Thu, 18 Jan 2024 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcchM8YL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D62376E
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577062; cv=none; b=E5rBz+m8X8x3IoZAptR2drVTzVQRiZVUL53vSr2WYbLgpfm8136tyV9eyy9Nh7++TnrwICp+UNFdOc+T66cFaTCd77+6gODzn8GAog6YuwuQVR8/RYcoMLGi8jb5PMdILF4y/ypXnKWrOMiO07+YHOpW7tEExBvv28M3GyqQyyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577062; c=relaxed/simple;
	bh=bakl2yj1LvxQ/NlafqYNXGw4+EOr47EwgGliZDDL6KE=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=la7ZxyVpXfNKwZkTiQ3uboj4Q9gVjFBXFzJRH8b9G93Oxz89gbQO1OVR/IjiUuyAVaEysghLx3vGv8vV2NuwNhhVp8tR9vdY0lDaj9tJMofqshfNPJdRydDc0T4d3JUzuWhQjP4nKeUegjcd9Kz/CBJqQevnxTlH7N6Iv4gaz90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcchM8YL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B0AC433F1;
	Thu, 18 Jan 2024 11:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705577062;
	bh=bakl2yj1LvxQ/NlafqYNXGw4+EOr47EwgGliZDDL6KE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=jcchM8YLEhgiDZZMpOyQGfWXyeOAxtNMbo/MKi6nulmxYasg+bLx9Nl+6PDcVWpMI
	 AEHMw/TM29lHE+z/Tjp+x3/lwPk8jUUzX7cmFYKnF3a9DwvlHGTgWr4JKGuIWnWmlg
	 uAJ1e8K9zFwCA8R7+YLRWnCPtirD0JGlZBSkg2R2sE1Eukr8m6ZX7zq/+vvagMQb3d
	 Jdps49e+GD924uOfCT9Y1boaHXGStGB5lxO/EzBrTch2xfRjvKsvOYMTUBW28ZEyQZ
	 GvNFUyL0DAvTmKBGohIbkYyhBl+VTiNLD84a0T8bSlZm+UEu63CouXPMnfqi/adbiJ
	 H463szvngiZUw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmfmac: use generic lists to manage TDLS entries
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230703162458.155942-1-dmantipov@yandex.ru>
References: <20230703162458.155942-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Arend van Spriel <aspriel@gmail.com>,
 Franky Lin <franky.lin@broadcom.com>, linux-wireless@vger.kernel.org,
 Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170557705899.2924528.6474456189708090209.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 11:24:20 +0000 (UTC)

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Prefer generic lists over ad-hoc quirks to manage TDLS
> entries, adjust related code.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

This should be tested on a real device.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230703162458.155942-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


