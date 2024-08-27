Return-Path: <linux-wireless+bounces-12015-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD8796007A
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 06:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8B02835B5
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 04:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06907823DF;
	Tue, 27 Aug 2024 04:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaMBG4br"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC50481AD2;
	Tue, 27 Aug 2024 04:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724733907; cv=none; b=BIWgW+o+QH2v5PGZ/fgHVt3OEQzdSCq9QSK2xWEgzMb9Y0g/B8GHsJbjOZGCoeh15SMNHxPOwQu0zoObWZDalb3MEjZa3tLOtUKrARKBTM+TElWxq63gnjZoNEnHSuRnLORzcDjMFAB4GEJ+M43Z7X8RrYxRacgPDO3Rdj3XX8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724733907; c=relaxed/simple;
	bh=/ZD5rwjaxXCN0zfj/hf6KqnnV/iyGMI7aLUbK8uMiT4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kqlt80MN1LhD3OPmT8RI5bOoeUJUj1qMERXzAL9ecFCeKUWhvPHW3DbUeYTLF+kuN35R6al654d5pBleDj9nL3dlafjdEz9kyWqTEhVzsT2y6aAblSpMQI+QunJvOF9Pwt9th7Jl6hpUmbgF7alPOByC2NFoScfI/BLzsWMgIIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaMBG4br; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87663C8B7CA;
	Tue, 27 Aug 2024 04:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724733907;
	bh=/ZD5rwjaxXCN0zfj/hf6KqnnV/iyGMI7aLUbK8uMiT4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=WaMBG4br++PWiQKr6fJqoaodBynD4Np+AfGYkLbbU7skB9WfQSLwVUKdbVx/a/gvm
	 /CoimdXgqVH0RVKeOv5cPF8k6+ghYTUKDz057Dd5CnavKPmfKmjeS3frSQkIiqY+fq
	 c9dqfTPEf+aL1PKYSWNZqAIt/MjxEQ1sDq3vpW0fNG1TIhir8Zt+8l2bcSmFMxoQxf
	 DQ+cPiYA11FaVY2g+B/TrW6TFdHTb1nzPnU/8BIUfzlDVDZFn8M8Go7XyM3EySm728
	 Vo9nduXL/I/djYlOAQziKBEQvjSqY90JwksLYEBesTAkiWsCSRFev8FZDRD/8kEX22
	 I3+PSmbqIx2hA==
From: Kalle Valo <kvalo@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  <johannes@sipsolutions.net>,
  <davem@davemloft.net>,  <edumazet@google.com>,  <pabeni@redhat.com>,
  <allison.henderson@oracle.com>,  <dsahern@kernel.org>,
  <pshelar@ovn.org>,  <linux-wireless@vger.kernel.org>,
  <netdev@vger.kernel.org>,  <rds-devel@oss.oracle.com>,
  <dccp@vger.kernel.org>,  <dev@openvswitch.org>,
  <linux-afs@lists.infradead.org>
Subject: Re: [PATCH net-next 0/8] Use max/min to simplify the code
References: <20240824074033.2134514-1-lihongbo22@huawei.com>
	<20240826144404.03fce39c@kernel.org>
	<4a92bb68-7fe7-4bf2-885f-e07b06ea82aa@huawei.com>
Date: Tue, 27 Aug 2024 07:45:02 +0300
In-Reply-To: <4a92bb68-7fe7-4bf2-885f-e07b06ea82aa@huawei.com> (Hongbo Li's
	message of "Tue, 27 Aug 2024 10:57:06 +0800")
Message-ID: <878qwifub5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hongbo Li <lihongbo22@huawei.com> writes:

> On 2024/8/27 5:44, Jakub Kicinski wrote:
>> On Sat, 24 Aug 2024 15:40:25 +0800 Hongbo Li wrote:
>>> Many Coccinelle/coccicheck warning reported by minmax.cocci
>>> in net module, such as:
>>>          WARNING opportunity for max()
>>>          WARNING opportunity for min()
>>>
>>> Let's use max/min to simplify the code and fix these warnings.
>>> These patch have passed compilation test.
>> This set does not build.
>> 
> Do you mean some patches will go to other branches (such as mac80211)?

Jakub means that your patchset had compilation errors, see the red on
patchwork:

https://patchwork.kernel.org/project/netdevbpf/list/?series=882901&state=*&order=date

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

