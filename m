Return-Path: <linux-wireless+bounces-4757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD3D87C169
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 17:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08A21C2149C
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 16:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797CC71B5B;
	Thu, 14 Mar 2024 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjdiiwLI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C1571B39
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434348; cv=none; b=ltfqYHWNIyIRNbAqzLI2jEAUnY0TfLM7USf9SQjy0mXo5TQYEW05EDJkU3DlLGZW/ZoPTUwsOwNPrw7V6r0qkb+8IL1Y/YdB2ACZ7/gz/HGdZx+M9FcCn773AEpdQfX9p45uECurBzYdGplCC3Ms0uBsAgf8JyU2yk92VAGjjjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434348; c=relaxed/simple;
	bh=rF2DLgDO55iegvKQy0bAVedrMvrHU7TJp19+CD7rlrI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=mJjMcIa7uXznZ5LrFD/z9Jz0nuA971YKWP5obpk69z595WqNv7VYUtPr8Wwv9lL/tpSBJSa/0ZFAvWRP7fHz3aOsBsg5O+ukn7ekzcBe+GbvTLTTrISfa9CcsK0I6bcgnaEUdjc81Z7sGsuifeP7O9EuYvHvM3+5KHzh/nk28c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjdiiwLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4619AC433F1;
	Thu, 14 Mar 2024 16:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710434348;
	bh=rF2DLgDO55iegvKQy0bAVedrMvrHU7TJp19+CD7rlrI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=QjdiiwLIYrllow9oz3zUDcu5mG5et8UeBpwFKRRNIGZZStNPNmuIb6D28KejV6hz2
	 SxedUW41SfgRXy9ipE0WZEq5mb+o/6I0WS93lRU0GM6KA1d0euGesEkZtZG0np5/xL
	 slOs9D1KPyy34QXCrlqRJIjWspGc0wOodUdA4vlsqX0ECYNa9TpZZoyRr5JCOA0Out
	 FQZiCW5qEMMFWtJjkcOpdy5FTIyb7UXGm8e78AhaA4GPf3HeF0Qb2t8vMLcgw8SXpP
	 tQjt4x8kccjdF43zTwEX3yPJL8DLgAFBOaGPK+rdcyErtIdw2XWNstUyhV5J5PErFA
	 0OzjO8uQ5NppQ==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,  Miri Korenblit
 <miriam.rachel.korenblit@intel.com>,  ath12k@lists.infradead.org
Subject: Re: [PATCH 2/2] wifi: iwlwifi: mvm: disable MLO for the time being
References: <20240314110951.b50f1dc4ec21.I656ddd8178eedb49dc5c6c0e70f8ce5807afb54f@changeid>
	<20240314110951.d6ad146df98d.I47127e4fdbdef89e4ccf7483641570ee7871d4e6@changeid>
	<87bk7g4x08.fsf@kernel.org>
	<09ca997159333980a168051a2a49c675a8ad5eeb.camel@sipsolutions.net>
Date: Thu, 14 Mar 2024 18:39:05 +0200
In-Reply-To: <09ca997159333980a168051a2a49c675a8ad5eeb.camel@sipsolutions.net>
	(Johannes Berg's message of "Thu, 14 Mar 2024 17:09:47 +0100")
Message-ID: <87plvwepjq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> On Thu, 2024-03-14 at 18:08 +0200, Kalle Valo wrote:
>> 
>> > -		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
>> > +		hw->wiphy->flags |= WIPHY_FLAG_DISABLE_WEXT;
>> 
>> I think we should add the same for ath12k, right?
>> 
>
> It's really up to you, I think. I'm hoping to even get this into stable,
> FWIW.

ath12k doesn't support MLO yet but I feel that disabling wext already
now would be consistent from user's point of view.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

