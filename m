Return-Path: <linux-wireless+bounces-14880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8652C9BB750
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 15:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4643E1F23149
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 14:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939322AEFE;
	Mon,  4 Nov 2024 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSDf6X5U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6983A111AD;
	Mon,  4 Nov 2024 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729784; cv=none; b=tpKwNVjeTlUSEVMaZ7sHiTlE/foriHKq/of8boz02rcidwHuQd7IEL4zqXo4D5MM8B/7V5QU+pUaf8unujpPncKRucnKO30+6TLoc6rMIiQFJN7BMA8Ia3fzps6Be6j6syAUdXYZ8daYPTdK+g1/Y4O/gbHzPNKzWRlAYcxPB4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729784; c=relaxed/simple;
	bh=NHtGRcHt0tNEtOAmt8eYChejJpE34p65uqV3SGg3qXU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=HbAcC2mKODKUJ6BzMPT2g0g0+TIluCE6Q/Jg0hxuMExxV2CUTVPV2IhJe8Vifly7LaPod9HbZnpLcyly03CMXE1towoya3nsfK7co3weuqP0Kk/0ePahbRZGKdnVqMTqNVEtSCLGiqrqNYkr8ehO245tsk3H6s+nRip31yZgCdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSDf6X5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A97FC4CED2;
	Mon,  4 Nov 2024 14:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730729784;
	bh=NHtGRcHt0tNEtOAmt8eYChejJpE34p65uqV3SGg3qXU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=YSDf6X5UV7u2hiSlK2AluccXuhJvtfXSOXkpIXZsMH+AzsMlkVcF4VT5jhHFalbSQ
	 7xzHGvPzh8TOdtNu/JPxvC4Mv3OEUULr4DSw5K+GPOYmivgYAL//PLQl30IVYqn95D
	 CnQO5cgrWSp8+JTVyb45rPnIJQqkoW/78FaZ7mRDt/W2PevK7jRLh0aQE7rExeRBRT
	 N66JZJCEtgiE07qtAI7whl1iKCppnG6L77DqXizhzwmPSqRa9y4yMTnPVDMQEWmX8G
	 2q+lxENmjWeVUcAc5tpnmkiZYvqQSiHRpwQmhVcfyH5ybHX/VUM6qVX00ssNl92Ae1
	 HzVoHzizw0XbA==
From: Kalle Valo <kvalo@kernel.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: pkshih@realtek.com,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rtlwifi: Remove more unused functions
References: <20241103153857.255450-1-linux@treblig.org>
	<20241103153857.255450-3-linux@treblig.org>
	<87y11zxwlr.fsf@kernel.org> <ZyjDn0R7gzDQ4jnT@gallifrey>
Date: Mon, 04 Nov 2024 16:16:21 +0200
In-Reply-To: <ZyjDn0R7gzDQ4jnT@gallifrey> (David Alan Gilbert's message of
	"Mon, 4 Nov 2024 12:52:47 +0000")
Message-ID: <87msif6q4q.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Dr. David Alan Gilbert" <linux@treblig.org> writes:

> * Kalle Valo (kvalo@kernel.org) wrote:
>> linux@treblig.org writes:
>> 
>> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
>> >
>> > exhalbtc_dbg_control(), exhalbtc_stack_update_profile_info(),
>> > exhalbtc_set_hci_version(), and exhalbtc_set_bt_patch_version() are
>> > unused since their addition in 2014 by
>> > commit aa45a673b291 ("rtlwifi: btcoexist: Add new mini driver")
>> >
>> > Remove them.
>> >
>> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>> 
>> 'wifi:' missing.
>
> Oops, can add that.
>
>> Also in both patches the subject could be more unique.
>
> Do you have suggestions? I don't know the code to give good titles.
> They're both 'btcoexist'; I could merge them into one
>
> wifi: wtlwifi: Remove btcoexist deadcode

No good suggestions really. Usually I add what I'm removing to the
subject but as this patch is removing several functions the subject
would be too long. Maybe something like 'wifi: rtlwifi: remove several
unused exhalbtc_*() functions?' just to throw out some ideas, I'm sure
you can come with better ones.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

