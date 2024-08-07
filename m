Return-Path: <linux-wireless+bounces-11086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE18194A902
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 15:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810D51F267A8
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D1D1E7A28;
	Wed,  7 Aug 2024 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goUs2Map"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E0C1E2122;
	Wed,  7 Aug 2024 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038576; cv=none; b=kfU7njqUoC8kBaP86Yve7x8JsJNFvPRdDUnCcNUrQgj99jXjkk3A4TcvFGrmjzpJvPdhmdAmSjwG2K2UGjf6vT8dFFKZZCFxqPcb06DmQ4uoimiwBKgo7GMQ0uaMLyAbiPV2IHQ+7KDUFOiailh9jdQYhXS1iU+JeEKWmoyVUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038576; c=relaxed/simple;
	bh=iplRde1Hac6HbYja1csB4kDBR8wsgdL2oD7JgPyPcd4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DQKKQGiPL5f7Ub3qCtFGuipnYkleb0Y9vvdaaGJ8Vb1p4ZuS1IKq9U2YZN7Exaa0NvMLP6rP4h5m34PhrABU3WQBddr9y8CEw4xh6YqQV9sKXb3XkuYslRWQMuxFz02KgV3dFCHMSUwtfHcVbRgXunQIJ46qDddEutSEyoR4ZlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goUs2Map; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAACC32781;
	Wed,  7 Aug 2024 13:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723038576;
	bh=iplRde1Hac6HbYja1csB4kDBR8wsgdL2oD7JgPyPcd4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=goUs2MapFj2GzURTXw/pJLduJPreiVgKU5XVfdJ4Z9NC9gC71DemnoLN92K3X/HZY
	 X/bugoO9bxq6SFgc5Rk+czvVYw30FfHqx5YGdAsBwbbs+0nHtcj1Uixw8gaZLBVyQh
	 hGQtjqebP4RHeUvwtpijYW5MLtuMrqSw4mCBrVoJEmIodN1SMq/LQpPBq8r7DcxEKT
	 VOiozNcExpslRK34yvO+9mEXc/dbc8xb7s0ng9LKGVGU+390sLguvTYLDxh7WeNszU
	 0HbI4Tq7CKUts3/YLmAJn8N15+D2aETWbMl1u2yyXveGPpcIubmevWtRAOHqxLrf+u
	 zIWk0O1AnoLbQ==
From: Kalle Valo <kvalo@kernel.org>
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: linux-wireless@vger.kernel.org,  benjamin.berg@intel.com,
  miriam.rachel.korenblit@intel.com,  regressions@lists.linux.dev,
  johannes@sipsolutions.net
Subject: Re: [REGRESSION] bisected: iwlwifi: use already mapped data when
 TXing an AMSDU
References: <ZrNRoEbdkxkKFMBi@debian.local> <87le18ile6.fsf@kernel.org>
	<CAP-bSRboZLWg4pzHHrD66NFeKKbsX0z-wUcxJS4OYmzcHXdG1w@mail.gmail.com>
Date: Wed, 07 Aug 2024 16:49:32 +0300
In-Reply-To: <CAP-bSRboZLWg4pzHHrD66NFeKKbsX0z-wUcxJS4OYmzcHXdG1w@mail.gmail.com>
	(Chris Bainbridge's message of "Wed, 7 Aug 2024 13:34:38 +0100")
Message-ID: <87o7644f4j.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chris Bainbridge <chris.bainbridge@gmail.com> writes:

> On Wed, 7 Aug 2024 at 13:10, Kalle Valo <kvalo@kernel.org> wrote:
>>
>> Chris Bainbridge <chris.bainbridge@gmail.com> writes:
>>
>> > I hit the following bug in 6.11.0-rc2. Reverting the offending commit
>> > fixes the issue. This happens immediately when I run `iperf3 -bidir`.
>>
>> [...]
>>
>> > [   42.873868] ------------[ cut here ]------------
>> > [ 42.873989] WARNING: CPU: 1 PID: 529 at
>> > drivers/net/wireless/intel/iwlwifi/pcie/tx.c:1836
>> > iwl_pcie_get_sgt_tb_phys
>> > (drivers/net/wireless/intel/iwlwifi/pcie/tx.c:1836) iwlwifi
>>
>> Does the connection still work after the warning?
>
> Not really. It is functional but tx throughput is severely degraded,
> iperf shows ~1mbit/sec instead of the usual ~600mbit. Rx throughput
> (measured with `iperf -c ... -R`) doesn't seem to be affected.

Ok, so a quite severe issue. Hopefully Intel can find a fix, otherwise
we need to consider should we revert commit 90db50755228 ("wifi:
iwlwifi: use already mapped data when TXing an AMSDU") for v6.11.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

