Return-Path: <linux-wireless+bounces-356-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7BC802CD5
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 09:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF46C280D46
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 08:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1017FD301;
	Mon,  4 Dec 2023 08:12:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7A9101;
	Mon,  4 Dec 2023 00:12:48 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rA44G-0007MD-Am; Mon, 04 Dec 2023 09:12:40 +0100
Message-ID: <b5063044-e82d-4f73-a1fa-db6eeacd0498@leemhuis.info>
Date: Mon, 4 Dec 2023 09:12:39 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: iwlwifi: rfkill locking up kernel 6.5.12, 6.6.2
Content-Language: en-US, de-DE
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Eliad Peller <eliad@wizery.com>, "John W. Linville"
 <linville@tuxdriver.com>, Gregory Greenman <gregory.greenman@intel.com>,
 Linus Lotz <register+kernelbugzilla@lotz.li>,
 Darrell Enns <darrell@darrellenns.com>, Bagas Sanjaya
 <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux Wireless <linux-wireless@vger.kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <5ef14fe7-84a5-407f-b514-1527f7279ecd@gmail.com>
 <af62295b-b757-49ec-83ce-9d3ef93e24af@leemhuis.info>
In-Reply-To: <af62295b-b757-49ec-83ce-9d3ef93e24af@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1701677568;02a0687e;
X-HE-SMSGID: 1rA44G-0007MD-Am

On 02.12.23 07:07, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 30.11.23 09:23, Bagas Sanjaya wrote:
>>
>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>
>>> Rfkilling the iwlwifi can lock up my machine, rfkill will not
>>> respond and other networking related things (e.g. ip a or ip r) I
>>> see this on 6.5.12 and 6.6.2 (fedora kernel). On 6.5.11 it does not
>>> lockup AFAICT, but also shows kernel oops. WiFi Hardware: AC 8265
>>
>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218206
> 
> TWIMC: More people that seem to be affected by the same problem joined
> the report. And one user performed a bisection on 6.6.y. According to
> that the problem is caused by a 6.6.y-backport of 37fb29bd1f90f1 ("wifi:
> iwlwifi: pcie: synchronize IRQs before NAPI") [v6.7-rc1] from Johannes.
> 
> Another reported user also stated that the same problem happens on
> 6.7-rc3 as well. No confirmation yet that 37fb29bd1f90f1 causes it
> there, but it seems likely.

TWIMC, it was now confirmed that reverting 37fb29bd1f90f1 in 6.7-rc
fixes the problem.

The bugzilla ticket has the details; it's sadly all a bit mess (it was
afaics actually a gentoo user that confirmed the above in a downstream
bug tracker [https://bugs.gentoo.org/918128#c21] and a gentoo kernel dev
forwarded the result to our bugzilla...).

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

