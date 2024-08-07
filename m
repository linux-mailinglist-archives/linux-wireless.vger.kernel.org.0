Return-Path: <linux-wireless+bounces-11075-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F3A94A3DE
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 11:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E252D28355C
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 09:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541A21CB32D;
	Wed,  7 Aug 2024 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="F0ws4b/L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D761CB327;
	Wed,  7 Aug 2024 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723021945; cv=none; b=HsH6n/mL7u6p62QSydzS+yMgcCXRa4fZA6XGzXGcQkQlSh0cXx4BHd2siX5AZmeg1Wjlr6/C+S9F28iBu0/dD7TmimWzak3z/TAlOGirMhfFf4GH/rERClDGJtD4EuxDK7lK0AbpNHf8Wr8x4oZyrGwOFvuiqSbaqPJ3rxWHVvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723021945; c=relaxed/simple;
	bh=CJNm1GubiAX2fLXyxwYfBDtfMO8OYXU9LaZ1zSUcUFA=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=H0A5/f2flD6/uHL7Bm+nAo7es/VuwUDNiVXwbnYOIyxCG51ux7dpTlvJSQby+pjQ5JyXPlcfYOzkvOidwVZV5/AI3oTpC805uRa7ZQi5l5oZrLmV6SkqEH69oAzxSQlHQK7/kvULIV57pXnhqfz8+Z7ANed5wkHS0KlqkcozJO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=F0ws4b/L; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:Subject:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To
	:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=NC29QY+AFTQHnrlEBxtLkRVzp5/68wW+9kEMyNjfTz4=; t=1723021943;
	x=1723453943; b=F0ws4b/LSn2FUme5Hu43gUKuEITHUWEm0xJsUjhC44enxh6TF2vBarh2KkNps
	CvmihNPPzSva0I/iu0VJLVS0oOXIUwEGNOq10A+DDNyQwLw0+I+auYPl/PenEzFNe36LiF+VHmdfe
	vf3LPWZI/HIq5/jeXe7sh4RcX7ParCs+I1jTMps911Xvr0jUnQhaiyVxR2MsHsePfkEpz2SzQr6+/
	pHaKZpo7ldm3yRMetJLkinyh8rMMjnN0xg5oA0EU7e6fPzohABLEk2mstI1Ou+Ivvk/1B77RPcxi/
	bYEaEEcHplDSH1FCvvUOsfomrJtwLGXLYmFo4VrWPBPiH43nOw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sbciS-0001H5-Ab; Wed, 07 Aug 2024 11:12:20 +0200
Message-ID: <7a43d26e-95eb-49d4-bc02-434c239909ff@leemhuis.info>
Date: Wed, 7 Aug 2024 11:12:19 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Johannes Berg <johannes.berg@intel.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
Subject: [regression] Significant WiFi Speed Reduction with Kernel Versions >
 6.8.12 on Intel Wi-Fi 6 AX203
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1723021943;9525817b;
X-HE-SMSGID: 1sbciS-0001H5-Ab

Hi, Thorsten here, the Linux kernel's regression tracker.

Mukesh Sisodiya, I noticed a report about a regression in
bugzilla.kernel.org that appears to be caused by a change of yours:

099a47dbe71b75 ("wifi: iwlwifi: Add support for new 802.11be device")
[v6.9-rc1]

As many (most?) kernel developers don't keep an eye on the bug tracker,
I decided to write this mail. To quote from
https://bugzilla.kernel.org/show_bug.cgi?id=219114 :

> I am experiencing a significant reduction in WiFi download speeds when
> using any Linux kernel version greater than 6.8.12. The issue does not
> occur with kernel versions 6.8.12 or lower. The only change is the
> firmware version loaded by the kernel (I have attached the full output
> of "dmesg | grep iwlwifi" for both kernel versions as text files). I
> have also tried downgrading the firmware, but it did not resolve the
> issue. The problem occurs across different Linux distributions,
> indicating that it is related to the default kernel.
> 
> Hardware Details:
> 
> Laptop Model: Acer Nitro 5 AN-515-58
> Network Card: Intel® Wi-Fi 6 AX203, REV=0x370
> CPU: Intel i7-12700H
> Bluetooth: Intel Corp. AX201 Bluetooth
> 
> Additional Information:
> 
> lspci -nnkv | sed -n ‘/Network/,/^$/p’:
> 0000:00:14.3 Network controller [0280]: Intel Corporation Alder Lake-P PCH CNVi WiFi [8086:51f0] (rev 01)
>         Subsystem: Rivet Networks Dual Band Wi-Fi 6(802.11ax) Killer AX1650i 160MHz 2x2 [Cyclone Peak] [1a56:1652]
>         Flags: bus master, fast devsel, latency 0, IRQ 16, IOMMU group 10
>         Memory at 6105274000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: <access denied>
>         Kernel driver in use: iwlwifi
>         Kernel modules: iwlwifi
> 
> lsusb | grep Bluetooth:
> Bus 003 Device 003: ID 8087:0026 Intel Corp. AX201 Bluetooth
> 
> Thank you for your assistance.

See the ticket for more details and the bisection. Note, you have to use
bugzilla to reach the reporter, as I sadly[1] can not CCed them in mails
like this.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

[1] because bugzilla.kernel.org tells users upon registration their
"email address will never be displayed to logged out users"

P.S.: let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: 099a47dbe71b75
#regzbot title: wifi: iwlwifi: WiFi Speed Reduction on Intel Wi-Fi 6 AX203
#regzbot from: siero.o.p.33
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=219114
#regzbot ignore-activity

