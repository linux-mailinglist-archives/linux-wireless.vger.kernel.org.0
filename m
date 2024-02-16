Return-Path: <linux-wireless+bounces-3662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E92948578F6
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 10:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36724B238EB
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 09:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FABA1BC2D;
	Fri, 16 Feb 2024 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CA3yN9zA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B93A1BC26
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076242; cv=none; b=otkK3sv9KAKIP/iFl7KvVmvecc3A+d7STaB3Oo9m2GDkF8FpA/WY7HoBqOMxyHr9TEQByK14P6lhjICfshcdbWhP7g8sZnwr/pZybV3Oxz0K02pMQWhTaaoCzVJublHBWNvvdxTYShKi1sBgvFgkyJYyIKxIteQYx2fOip/Fu2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076242; c=relaxed/simple;
	bh=zuCbg8sDnnhMm7RPCStaqaGzw/WGmXmwWCsAJkKY3zY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qBavMRpBLLJ/4OeV/kxRgN85JRN5YU4lEJHJNlawshgzmnghMJtqMS4HQZutpwDPjK2S48Xa/bu5K/ZB3zdq3SCy/pNUlhgGBnFQjsyAOLn5fB6hoqDAeKqyMRx1Nsf+rj0FbdaofQVko73Vu2uS9SowwBZfouERSh3qwlse+oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CA3yN9zA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870F0C433C7;
	Fri, 16 Feb 2024 09:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708076241;
	bh=zuCbg8sDnnhMm7RPCStaqaGzw/WGmXmwWCsAJkKY3zY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=CA3yN9zA3qAw6PK+99E/yUOMDb4SVuV1F+LMVzr5hdEiN9ASv4MYx9nZyxOXluKz5
	 AT2MUgzUZGd+uvoHTmnlIE0GjteOg2ydVkdKms4hHAs+evPibjRclBqj4pav+5cfmd
	 FrxJGDTKGlx81VZx42mfrgtj7qEqDii41I5v2sQITYzO8nGTL6nUT6yewc7xoAiicF
	 fluN3mh513r1JrgJ03WJEjBZIZkgQMA/H+0NRzzHXs4hKl6a3P71Ndl++x44nYzjeN
	 yS2iczqm8rmT5BEK5MYzb0AA7XTVnahbPKIYoG6C+81kjf00RDZGTVofkMAuRZ7TuE
	 uNlnrWxjx2REA==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>,  Johannes
 Berg
 <johannes@sipsolutions.net>,  Ajay Singh <ajay.kathat@microchip.com>,
  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  <linux-wireless@vger.kernel.org>,  Igor Mitsyanko
 <imitsyanko@quantenna.com>,  Sergey Matyukevich <geomatsi@gmail.com>,
  kernel test robot <lkp@intel.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>,  <srini.raju@purelifi.com>
Subject: Re: wireless: orphan qfnfmac and plfxlc drivers?
References: <20240215-nl80211_fix_akm_suites_endianness-v1-0-57e902632f9d@bootlin.com>
	<02c155ff-f880-4e88-b600-9d632019729f@bootlin.com>
	<875xypejwt.fsf_-_@kernel.org> <871q9dej8j.fsf@kernel.org>
	<89bc5ff1-b049-49d1-b15a-4e01a4659c74@quicinc.com>
Date: Fri, 16 Feb 2024 11:37:17 +0200
In-Reply-To: <89bc5ff1-b049-49d1-b15a-4e01a4659c74@quicinc.com> (Jeff
	Johnson's message of "Thu, 15 Feb 2024 10:51:14 -0800")
Message-ID: <87le7kda2a.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 2/15/2024 9:21 AM, Kalle Valo wrote:
>> <imitsyanko@quantenna.com>: host mail.quantenna.com[50.87.249.29] said: 550 No
>>     Such User Here (in reply to RCPT TO command)
>
> Apparently Quantenna was acquired by ON Semi in 2019[1], and in 2022
> they closed it down[2]. Seems pretty abandoned to me.

Thanks Jeff. I do wonder is anyone even using qtnfmac and plfxlc? Maybe
we should just delete the drivers as nobody seems to care about them?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

