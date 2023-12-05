Return-Path: <linux-wireless+bounces-432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9F38059A2
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 17:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE3428210D
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 16:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EB460B9B;
	Tue,  5 Dec 2023 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cOeb0GIe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vtgdDnG+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E798F109;
	Tue,  5 Dec 2023 08:13:46 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id B08DA5C018E;
	Tue,  5 Dec 2023 11:13:43 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 05 Dec 2023 11:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701792823; x=1701879223; bh=y6
	Hk1f3TvWVwGuvImHjCJ2nJCwXtF63ThlWgK1ceqsg=; b=cOeb0GIedth98N+xst
	8nl1mcXf/x5/uieHPUPEgAgWacy3iEFxwhZx8mlDlXrSS6vNJzn7jxYfUznTO2Qq
	eNF5DMx5aLXD9G3xjQFrX/NeE6ERY/x+04qBBw+oZ0b3sl0dj57/XfJHvZKefwFf
	rive7HGQeP0rvXsytHHifmSN9BQM9oWi/8nrx06rzdSrhDT+nhn0YQZ5VXAU5LWY
	3CjJ7gps8R/KVk+VypItu54hWt/Bv2ILy9V+Z42MFvJ+wbx9PxsHHAupUQNZADDv
	ICv0Mzt/+sypAoQRkJaAgNqZwUwAHotLUTOCyD2XpExxq/gbmCjtKAAeJNP9qmSP
	CiKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701792823; x=1701879223; bh=y6Hk1f3TvWVwG
	uvImHjCJ2nJCwXtF63ThlWgK1ceqsg=; b=vtgdDnG+/JwsT2dB5GXmWUaFKffjp
	UfidPv4AC31RzJ6PG4eDP+mWJ6ysHLvOO0lmoZ0Ndi7E/pIn7AcTOAz2kziRXxJN
	ooi83PSxcT+E05Yu5+fHpcmu0Vj+Lm0wJycH+IlnlIpih/Goe4kaP1E9D55W0w40
	fuaWznHV4Y+k7j6T4DR/JjyEJuqmkyFtxKTbeHcmT0TaUaOKe4Ey4Nl8uP6Tg6pt
	QGwZ24H+zRdbZVLRoxeafErZcXic3ZdzUAuTVEL6xOk/DliG+WxCo4BXLu4bLawd
	pUhUogL55olo7YUdBiSLSlV/KH9ehXs5zXFZk5kF6Yip3Azo+YHbK2LQg==
X-ME-Sender: <xms:N0xvZSMv2GabzSy8AhUWHwdY3F1w-VNRxqvZPeePjRI4eM_obWRB6g>
    <xme:N0xvZQ-gnxp1UrZzc08rXCTso7u0z8OSpsYhRaWsergPPUpdvWOmsGyBwNTdBMouY
    D6iVFw4wHQmY0g6dLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejkedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:N0xvZZT4-EZPFcoVRTVdlRmtlTcf-Yf39ariapqMiRMfYBDzl7aayg>
    <xmx:N0xvZSs7qqzWkIE7-qIVHrlNma7oiH3tIAUfDhSLKc7dBBN65wmeeg>
    <xmx:N0xvZaeXi4cCYgpLF9dUPfksAtZMRK_vSW0NiDl_XNdP_FhpBg4b0w>
    <xmx:N0xvZXDSCBBAM_clRn4DcdQIeX-A8BMUE5gv5nA8v9M2TJng9dZnoA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 61132B60089; Tue,  5 Dec 2023 11:13:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ce99918f-eb6a-4ad7-aa44-9d27c27b6b00@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYuL_-Q67t+Y7ST5taYv1XkkoJegH2zBvw_ZUOhF9QRiOg@mail.gmail.com>
References: <20231205031535.163661217@linuxfoundation.org>
 <CA+G9fYuL_-Q67t+Y7ST5taYv1XkkoJegH2zBvw_ZUOhF9QRiOg@mail.gmail.com>
Date: Tue, 05 Dec 2023 17:13:22 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Johannes Berg" <johannes.berg@intel.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Guenter Roeck" <linux@roeck-us.net>, shuah <shuah@kernel.org>,
 patches@kernelci.org, lkft-triage@lists.linaro.org,
 "Pavel Machek" <pavel@denx.de>, "Jon Hunter" <jonathanh@nvidia.com>,
 "Florian Fainelli" <f.fainelli@gmail.com>,
 "Sudip Mukherjee" <sudipm.mukherjee@gmail.com>, srw@sladewatkins.net,
 rwarsow@gmx.de, "Conor Dooley" <conor@kernel.org>, allen.lkml@gmail.com,
 Netdev <netdev@vger.kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 6.6 000/134] 6.6.5-rc1 review
Content-Type: text/plain

On Tue, Dec 5, 2023, at 16:53, Naresh Kamboju wrote:
> On Tue, 5 Dec 2023 at 08:51, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> This is the start of the stable review cycle for the 6.6.5 release.
>> There are 134 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.5-rc1.gz
>> or in the git tree and branch at:
>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
>> and the diffstat can be found below.
>>
>
> The x86 allmodconfig with gcc-8 failed but passed with gcc-13.
>
> x86_64: gcc-8-allmodconfig: FAILED
> x86_64: gcc-13-allmodconfig: PASS

Note that at the moment gcc-13 (also 11 and 12) turns off the
 -Warray-bounds checks because of excessive false positives,
see 0da6e5fd6c37 ("gcc: disable '-Warray-bounds' for gcc-13 too").

I have not yet figured out what gcc-8 complains about,
but I assume that gcc-13 would find the same thing with
the check enabled.

   Arnd

