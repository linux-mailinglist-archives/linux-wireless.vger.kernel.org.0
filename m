Return-Path: <linux-wireless+bounces-9057-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A498090ABE2
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 12:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC10285C44
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 10:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FA4195381;
	Mon, 17 Jun 2024 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjfXdF8y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B421946D2
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621033; cv=none; b=GAgU+QKViytZGyjavaB2FW3mvMWW4zzh/XpQ4AZaR4wXo+8iLremnWforOl9Yc6XgrwQKuD9TWFGvz/RgybzbzJm588Ta9q2QdQNkbYIM4kR8pHtT9D8cgdGFBOmBmc9TznuNjxdIyfFCqcQtwMwiT2b8G8DX/7DNAhjRxEndTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621033; c=relaxed/simple;
	bh=rCJPCXIu8LZY5v9GcPLg0APTKd8DO7Lztus0sEHhEFE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=oTdTpv6LCG2PjM2g8fof91BKgUCT67d2Mq9IMoE0gGJw3p6ZfEnvPZQpkSTshXn2LGZPIiIW7pellhv9B2pCB5/IZhs5a8uNS0j5G18JIUymtLbEQC3MpPrC62SMVYemxR3Goh+nGDvpbzvGqwrzxM0uqQD/JEz+HjM35ahdHsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjfXdF8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A47C2BD10;
	Mon, 17 Jun 2024 10:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718621033;
	bh=rCJPCXIu8LZY5v9GcPLg0APTKd8DO7Lztus0sEHhEFE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=tjfXdF8yeQXG7NHwMyvRhY64QiV4Jpi+EKf5H6RnIid2pfXuHgz4FexxL6kJzc6bM
	 21Rr3WATrrZ6pjTPTs2sHov/GbD7Ixh9ajNTQXVaZar4Hrh2oGP9n1o7IfY1XdDCKg
	 /zM0VxjwsPkkNIOLxjeGi4U9z1ohT4el28U2+1eHAKM6vB1aY+QbACCrjNM6eQsEIh
	 Ng3Q7G3qsUYX99+7kKEA4hDVmtP7H2ZbUY86Klz578yjGkhkFoTJSWswBkf77Ym8O/
	 jJ9vXc8j7vjICWOLp9yTf54rYjtLYkom6eCjlLVSVPFcUzh6GOj/HmBE0IqUfUuAmw
	 MWqXfnAuYvY/A==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
  <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Aditya
 Kumar Singh <quic_adisi@quicinc.com>,  Zachary Smith
 <dr.z.smith@gmail.com>
Subject: Re: [PATCH] wifi: ath12k: fix legacy peer association due to
 missing HT or 6 GHz capabilities
References: <20240612225336.2303119-1-quic_pradeepc@quicinc.com>
	<760d99d1-c709-43b5-9d15-c2a0fef98b66@quicinc.com>
	<a7921a28-6f36-40b4-9d56-284b2c2684a6@quicinc.com>
	<199dbb00-424c-4827-ae9a-0e657918fc06@quicinc.com>
Date: Mon, 17 Jun 2024 13:43:50 +0300
In-Reply-To: <199dbb00-424c-4827-ae9a-0e657918fc06@quicinc.com> (Jeff
	Johnson's message of "Thu, 13 Jun 2024 15:15:52 -0700")
Message-ID: <87y173n921.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 6/13/2024 11:59 AM, Pradeep Kumar Chitrapu wrote:
>
>> 
>> 
>> On 6/13/2024 8:42 AM, Jeff Johnson wrote:
>>> On 6/12/2024 3:53 PM, Pradeep Kumar Chitrapu wrote:
>>>> Currently SMPS configuration failed when the Information
>>>> Elements (IEs) did not contain HT or 6 GHz capabilities. This
>>>> caused legacy peer association to fail as legacy peers do not
>>>> have HT or 6 GHz capabilities. Fix this by not returning an
>>>> error when SMPS configuration fails due to the absence of HT
>>>> or 6 GHz capabilities.
>>>>
>>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>>>
>>>> Fixes: f0e61dc7ecf9 ("wifi: ath12k: refactor SMPS configuration")
>>>> Reported-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
>>>
>>> Per checkpatch:
>>> WARNING: Reported-by: should be immediately followed by Closes:
>>> with a URL to the report
>>> #17:
>>> Reported-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
>>>
>>> Is there a separate public bug report from Aditya?
>> Hi Jeff,
>> No, this was internal report and does not have weblink associated with 
>> it. Also, do not want to ignore reportee.
>
> I'm unsure what do do here since there is a requirement that an acknowledged
> reporter have a public link to the bug report.

I think it's ok to ignore this checkpatch warning. Reported-by without a
closes tag should be fine.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

