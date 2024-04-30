Return-Path: <linux-wireless+bounces-7029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B841A8B6AA5
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 08:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4421C20E2E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 06:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50B73B2AD;
	Tue, 30 Apr 2024 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9evOk1w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAC63B1A2
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714459371; cv=none; b=erVVd2UP9IGWEkShKTi+jewfc615xdQlhqkPkMKVfR5penCmik0D2p+vf42pMfcnliX1R+uqKvHmd+vsZSt9JsPfRnv0fqMTfXAS2GF5WEEiEPtb0++uW0mqDnHL2MmaOTgExvfPjD2hbSYEreUq1T942kYmCvv41fwh96J4g7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714459371; c=relaxed/simple;
	bh=fdQHboO+wwZXDX18KuhgKPneJcVoTv3BPscY3vNMF9M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=hams9crthQcwP5ZXWnD68gs2S3EUtXeWzBPc3StMR3HEeyD76hpfuoRIOGR8di38dduHpmoTT4lu7dk24m3hhfdzq0wXTi62AYQ6Cj6lRwVyCrFu0RJ2Z1krnup1ErrJ089jXTkNK8kLC47ZWRt8wLbSxA6TQcM+mQbhJEqqHew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9evOk1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D221FC2BBFC;
	Tue, 30 Apr 2024 06:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714459371;
	bh=fdQHboO+wwZXDX18KuhgKPneJcVoTv3BPscY3vNMF9M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=P9evOk1wfx3V5Yyau4PBE3WTeaJ6877CHJVLIU6aT0VxPQHMNI+hHRV2rQ4y5vTjJ
	 ZsmA6WKpMt2ToYqnjE+DMUL0Aij11nuTCr23vRnVJTlgSokXQmZVPELHK8IaTvk954
	 Y9j8Zi8R1YlJXvhTkS0dmlDVTXsbtOpEIWwbIJrJdMorfZSf4gpa5ve4F3sFV9IgF3
	 HLOCTWIlR/egsRRv/njCEQEYqsF7xKXGe96gXE7tOiXr0S/Zai3l8Jvk4qw7LLZPP2
	 9Z9W/fqGOEHNuhdXRvrOi/Oeh20eKDUgCMrQg0Kjialr5h/71eJTHNGBDYgkFfRq22
	 CUtfCYwBelm2g==
From: Kalle Valo <kvalo@kernel.org>
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>,  Muna Sinada <quic_msinada@quicinc.com>
Subject: Re: [PATCH v3 07/10] wifi: ath12k: add support for setting fixed HE
 rate/GI/LTF
References: <20240424201959.935-1-quic_pradeepc@quicinc.com>
	<20240424201959.935-8-quic_pradeepc@quicinc.com>
	<72bc6772-8bf7-427d-8f03-01e8dbf30d0c@quicinc.com>
	<87y190fulv.fsf@kernel.org>
	<198e317f-a849-4fe2-8080-3d1834d07481@quicinc.com>
	<87sez4fk1o.fsf@kernel.org>
	<51073e2c-2138-4957-a78c-2708c7742451@quicinc.com>
Date: Tue, 30 Apr 2024 09:42:47 +0300
In-Reply-To: <51073e2c-2138-4957-a78c-2708c7742451@quicinc.com> (Pradeep Kumar
	Chitrapu's message of "Mon, 29 Apr 2024 18:41:37 -0700")
Message-ID: <87ttjjpd08.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com> writes:

>>> I did run ath12k-check but I don't see these errors. Trying to see if
>>> this is due to version differences. will update further once I have
>>> more information on this.
>>>
>>> This is version I ran:
>>> qca-swiss-army-knife/tools/scripts/ath12k/ath12k-check --version
>>> ath12k-check (md5sum cb8a85242f2ec7343f6f94af9fa5ebb2)
>>>
>>> python:         3.6.9 (default, Mar 10 2023, 16:46:00)
>>> [GCC 8.4.0]
>>> host gcc:       gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
>>> config cc:      gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
>>> sparse:         v0.6.4
>>> checkpatch.pl:  Version: 0.32 (md5sum 12ea394e9bf27280f30a684ff937cc57)
>>> gtags:          gtags (GNU GLOBAL) 6.6.2
>> Your sparse is too old, you need to get the latest from git:
>> https://docs.kernel.org/dev-tools/sparse.html#getting-sparse
>
> Thanks Kalle and Jeff for sharing the tool versions required..
> I am able to see the errors reported now..
> will fix and respin the series..
>
> ath12k-check (md5sum cb8a85242f2ec7343f6f94af9fa5ebb2)
>
> python:         3.6.9 (default, Mar 10 2023, 16:46:00)
> [GCC 8.4.0]
> host gcc:       gcc (GCC) 13.2.0
> config cc:      gcc (GCC) 13.2.0
> sparse:         v0.6.4-66-g0196afe16a50
> checkpatch.pl:  Version: 0.32 (md5sum 12ea394e9bf27280f30a684ff937cc57)
> gtags:          gtags (GNU GLOBAL) 6.6.2

I added a section about tools to the wiki:

https://wireless.wiki.kernel.org/en/users/drivers/ath10k/codingstyle#tools

Feedback very welcome, it's important that our documentation is
understandable for new developers.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

