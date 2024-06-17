Return-Path: <linux-wireless+bounces-9056-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7222290AA46
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 11:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C31D1F21547
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 09:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D70195FD8;
	Mon, 17 Jun 2024 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="HVEE4c63"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74631195F09;
	Mon, 17 Jun 2024 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617500; cv=none; b=cm0A5URTCWFH5UBcwtkQSYnTHVKh8215TXBzkHIQfk0kULHvqpgJ0Uj+4iDtAsxcyHXG/2HVTy5De8rVLWry3xFrG7nv4DmJRRzHzwS+yqyIhflZnasQaBTX7+ovuOeGcZhhloFD/tNwT5kWim5cgmRiOM7xPyWVV3MbkIVMIuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617500; c=relaxed/simple;
	bh=Zl0H127CyeqOXk7mpS1eDFYTetGfKPwapBTVMhQmSlo=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=Dh8wo/AegKSQQMo+Tvk42PYJpERHZ35ks4mJ29MUWFw/FIClfrDMzmTvr+/J/cSmFHCTIMAjHcz+PqY19KLNr91PcbfWw5WIp/GkquA2SENTa9GYxXv9/HuQbgY9Yc9u2DLQNyE4/PaBnAnAAYX4jblFxO5f7uwGv5gCdIvnluE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=HVEE4c63; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Subject
	:Reply-To:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=y5NFcSqhUTL6fruZ1xgcLxOYcmeMsMeCG+Q/p9D+Di4=; t=1718617498;
	x=1719049498; b=HVEE4c63RYE7DoCjiOu7ODPQkqgcoMnXqCC/QIcV/iVPX1buMchXKwrAVGDa5
	Ua7G6mG/5FzNEMikmsnR2Fv8/svixUhgxXchZy1qcRFju5jkCoB1fxlP0r7EUNnQjAEn/YT/2KNty
	6+AVp9Actax9Cqo9MGztGf2Tp5VtcHfHZnyKyJkpkaCkz864kvKtveEn9bRIlTBPcZtekJKPmcseP
	uXbZrgcR68bjjszNEODeX5apNUVaUGKSepdkUZ6xQ+IT2GIrM1uI7QGbYFqMC2iDeV2p9JRO+FVAS
	ggIncKhRXwcqf2pUGI7ztr0XmVoagXI00KpAU09fzxWCBEz2GQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sJ8v1-0005bs-TO; Mon, 17 Jun 2024 11:44:56 +0200
Message-ID: <f16d49f6-01a4-45c7-aabf-ab6a1b8bfe6e@leemhuis.info>
Date: Mon, 17 Jun 2024 11:44:55 +0200
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
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Kalle Valo <kvalo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] iwlwifi 0000:02:00.0: Microcode SW error detected.
 Restarting 0x82000000.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718617498;0748ce8c;
X-HE-SMSGID: 1sJ8v1-0005bs-TO

Hi, Thorsten here, the Linux kernel's regression tracker.

Miri, I noticed a report about a regression in bugzilla.kernel.org for
some code you maintain. As many (most?) kernel developers don't keep an
eye on the bug tracker, I decided to write this mail. To quote from
https://bugzilla.kernel.org/show_bug.cgi?id=218946 :

> The linux Kernel 6.10.0-rc3
> [   17.124384] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
> [   17.124405] iwlwifi 0000:02:00.0: Loaded firmware version: 18.168.6.1 6000g2b-6.ucode
> [   17.124588] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
> [   17.124590] iwlwifi 0000:02:00.0: Status: 0x000002CC, count: 6
> [   17.124592] iwlwifi 0000:02:00.0: 0x0000198A | ADVANCED_SYSASSERT          
> [   17.124594] iwlwifi 0000:02:00.0: 0x00015920 | uPc
> [   17.124596] iwlwifi 0000:02:00.0: 0x00015910 | branchlink1
> [   17.124597] iwlwifi 0000:02:00.0: 0x00015910 | branchlink2
> [   17.124599] iwlwifi 0000:02:00.0: 0x0000DBEA | interruptlink1
> [   17.124600] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
> [   17.124602] iwlwifi 0000:02:00.0: 0x0000005C | data1
> [   17.124603] iwlwifi 0000:02:00.0: 0x00000008 | data2
> [   17.124605] iwlwifi 0000:02:00.0: 0x000001DC | line
> [   17.124606] iwlwifi 0000:02:00.0: 0x11C0C9B1 | beacon time
> [   17.124608] iwlwifi 0000:02:00.0: 0x006FB64F | tsf low
> [...]

The reporter later confirmed that 6.9 is working fine.

See the ticket for more details. Note, you have to use bugzilla to reach
the reporter, as I sadly[1] can not CCed them in mails like this.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

[1] because bugzilla.kernel.org tells users upon registration their
"email address will never be displayed to logged out users"

P.S.: let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v6.9..v6.10-rc3
#regzbot title: wifi: iwlwifi: Microcode SW error detected
#regzbot from: doru iorgulescu
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=218946
#regzbot ignore-activity

