Return-Path: <linux-wireless+bounces-3469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC84785189B
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 17:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040EB1C21A82
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 16:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BF93CF7C;
	Mon, 12 Feb 2024 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tq42PtKj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227FD3CF79
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753794; cv=none; b=rX40Y5V9OQaJvkA2N9Hk2teLQg9eNaIUvxkXmihD+98Z3teE1iZClCo8C3LMSZlnlvyo0Uvh97IwGhDObeaeiJ2l4zsIVvTVz+HUqbLgO9YX5SdcDjmFLnBdTqMpW0S6yVRLE1TnhRGOXH6YSAb/W3/2ChOn2DwtsauNVurKsrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753794; c=relaxed/simple;
	bh=SMiqT3HZQCIrizVx7l8/yUdi09rf3NvXoSFSFjz6/rI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=OEVmHa6AtA8GN+nRLtB6zU6zJJWinNhzCh0f/BqPSVNFNGohab+Me8ucaof7h/Fp4dAnNCeHol+fQ7e4LLtv1hQPGevCcuiyIjmGl752W8mccy8cplefAPHg5Oyjw6ojs0MeQLeV/mtkcSqb8s+TjBWndf89xzUJtn60wQGfcEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tq42PtKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695C2C433F1;
	Mon, 12 Feb 2024 16:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707753793;
	bh=SMiqT3HZQCIrizVx7l8/yUdi09rf3NvXoSFSFjz6/rI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=tq42PtKj1CWK2b13e+O22hLu6HV16YuyZvoOXleWI9KsssTadtc50L3tB5rbAz1aA
	 rCttOE9wj080vwIPEjGVnH1fiOsEw3fva88ht+8e2owZYFexOf0BRmFp3gjiSTl4S7
	 rQcj/zQjPTPdXymXRQ+m7hVst37XqSdpHxjsHqPHdi9unk3qN+rqjhwBt+XykYUak2
	 eOEvnVDyKDYBZFcXxqwbBAsRRFiTWgL5gi/NCN1kEo0YjVTXfY59Hrbz+V2cCQFSRj
	 1uQj7zLgUGdZhZAo9XFE4+hvW5/SxbyEFpESbv1AKiLyO97St9QfyLtACiIoRAyk2Y
	 yUEaK9gkfR80w==
From: Kalle Valo <kvalo@kernel.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Alexey Berezhok <a@bayrepo.ru>,  Arend van Spriel <aspriel@gmail.com>,
  linux-wireless@vger.kernel.org,  lvc-project@linuxtesting.org
Subject: Re: [PATCH] wifi: brcmfmac: do not cast hidden SSID attribute value
 to boolean
References: <20240208085121.2430-1-a@bayrepo.ru>
	<170775233602.2851594.8173116143852900695.kvalo@kernel.org>
	<9667b492-d3d3-4b04-bef4-f507387a9261@broadcom.com>
Date: Mon, 12 Feb 2024 18:03:10 +0200
In-Reply-To: <9667b492-d3d3-4b04-bef4-f507387a9261@broadcom.com> (Arend van
	Spriel's message of "Mon, 12 Feb 2024 17:00:59 +0100")
Message-ID: <87cyt1pt4x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> On 2/12/2024 4:38 PM, Kalle Valo wrote:
>> Alexey Berezhok <a@bayrepo.ru> wrote:
>> 
>>> In 'brcmf_cfg80211_start_ap()', not assume that
>>> NL80211_HIDDEN_SSID_NOT_IN_USE is zero but prefer
>>> an explicit check instead. Compile tested only.
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>
>>> Signed-off-by: Alexey Berezhok <a@bayrepo.ru>
>> Patch applied to wireless-next.git, thanks.
>> f20073f50dfd wifi: brcmfmac: do not cast hidden SSID attribute value
>> to boolean
>
> Alexey,
>
> Can you do a follow-up patch addressing my comment? If not I will do
> it myself.

Sorry, was I not supposed to apply the patch? What did I miss?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

