Return-Path: <linux-wireless+bounces-9866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E83924263
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 17:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E591C24678
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 15:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12CE1BD003;
	Tue,  2 Jul 2024 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/ooLIxR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E291BC09A;
	Tue,  2 Jul 2024 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934166; cv=none; b=d9XyjG5vxdgt7bUG/HanJAk3FZGq/cC1LQORIx+WI10zbudUteQc/FhHtpCZfh8bb/6ITalNpytPvxTL59+W+rSNpPTiEea5S8V134cLbKBeBR25HrEG4J9eSPZQjiumoN3dHa4mSZfYC30cPdzwPbZ1abMowBIMdty+RFRDruY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934166; c=relaxed/simple;
	bh=9TcP9iOfSfJuc2qAGzbKkXqdTM5BVUPMB45+Ia4mwtA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=sQayjzzASb92nNRnDPWv7Puw3yEaJ/+bw7MqCLVhP8Au4ycvBQJJ4Rmlpe4pNBi+nnUMcPuX9S0Hl02EMKD54PCwxLi4V4iDufy8Nu20uYxjzTrIXLyErYYhO5yApsnD+cKzqIm50JSMLr0MYFFtbHJJJsvfLcprUabmhInKezM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/ooLIxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27EBC4AF10;
	Tue,  2 Jul 2024 15:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719934166;
	bh=9TcP9iOfSfJuc2qAGzbKkXqdTM5BVUPMB45+Ia4mwtA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=M/ooLIxRWwnd1eiHpmdjJxyVlpmoqsTjAgFLlU93F/HURPUrA8epEG9GKojMkVx0J
	 8wdx1aC7wgQL0poXAvl7IfskYMxRCHo60nFgbbpfl49EyQ9onD6XFn780iDpDITU0s
	 ERbGFNuC4b5Dk5lfdqDShWXDo+FixAUM8exQ0ORPAiLYqRdTefiTsObJ0f00FK12y7
	 gd7ZRGfnuRDfDdnl7Vb59ZR02i+QTcvC48KOmukRkDyc5ePldLRSyPCxTC8JUCwbG3
	 EocbB4k+1nAZl7KvZwLFm5cKT/bHdxU/q2EORvg45x370FlVbjnMd8uIkdwXlcxUwh
	 qSecZMXXSyGlQ==
From: Kalle Valo <kvalo@kernel.org>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,  Su Hui <suhui@nfschina.com>,
  <johannes.berg@intel.com>,  <kees@kernel.org>,  <a@bayrepo.ru>,
  <marcan@marcan.st>,  <quic_alokad@quicinc.com>,  <zyytlz.wz@163.com>,
  <petr.tesarik.ext@huawei.com>,  <duoming@zju.edu.cn>,
  <colin.i.king@gmail.com>,  <frankyl@broadcom.com>,
  <meuleman@broadcom.com>,  <phaber@broadcom.com>,
  <linville@tuxdriver.com>,  <linux-wireless@vger.kernel.org>,
  <brcm80211@lists.linux.dev>,  <brcm80211-dev-list.pdl@broadcom.com>,
  <linux-kernel@vger.kernel.org>,  <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH wireless 1/9]  wifi: cfg80211: avoid garbage value of
 'io_type' in  brcmf_cfg80211_attach()
References: <20240702122450.2213833-1-suhui@nfschina.com>
	<20240702122450.2213833-2-suhui@nfschina.com>
	<ba67020a-04bb-46b8-bc05-751684f71e8a@suswa.mountain>
	<19073fcc9e8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Date: Tue, 02 Jul 2024 18:29:20 +0300
In-Reply-To: <19073fcc9e8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	(Arend Van Spriel's message of "Tue, 02 Jul 2024 17:07:45 +0200")
Message-ID: <878qyjg6cv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arend Van Spriel <arend.vanspriel@broadcom.com> writes:

> On July 2, 2024 3:57:27 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
>> On Tue, Jul 02, 2024 at 08:24:44PM +0800, Su Hui wrote:
>>> brcmf_fil_cmd_int_get() reads the value of 'io_type' and passes it to
>>> brcmf_fil_cmd_data_get(). Initialize 'io_type' to avoid garbage value.
>>
>> Since you're going to be resending anyway, please delete the space char
>> from the start of the line.
>>
>> It's weird that brcmf_fil_cmd_data_get() uses the uninitialized data.
>> It looks like it just goes to great lengths to preserve the original
>> data in io_type...  So it likely is harmless enough but still a strange
>> and complicated way write a no-op.
>
> Not sure if it helps, but I tried to explain the reason in response to
> patch 0 (cover letter).

Would it make more sense to have just one patch? It's the same issue
anyway.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

