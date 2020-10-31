Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D0D2A171D
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Oct 2020 12:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgJaLwQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Oct 2020 07:52:16 -0400
Received: from 20.mo5.mail-out.ovh.net ([91.121.55.239]:48236 "EHLO
        20.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgJaLwQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Oct 2020 07:52:16 -0400
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Oct 2020 07:52:15 EDT
Received: from player726.ha.ovh.net (unknown [10.108.4.136])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id 85A0D29C5E3
        for <linux-wireless@vger.kernel.org>; Sat, 31 Oct 2020 12:36:35 +0100 (CET)
Received: from webmining-systems.com (lfbn-idf1-1-284-37.w86-195.abo.wanadoo.fr [86.195.122.37])
        (Authenticated sender: info@webmining-systems.com)
        by player726.ha.ovh.net (Postfix) with ESMTPSA id 3242E17A11318;
        Sat, 31 Oct 2020 11:36:33 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-103G0050122403f-530f-4c41-92dc-5b403d13989c,
                    5A1BA32B9D2D82DFA4D995F9AB56433EB6550EE7) smtp.auth=info@webmining-systems.com
From:   Michal TOMA <michaltoma@sicoop.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: rtw_8821ce driver in kernel 5.9.1: wifi module inactive
Date:   Sat, 31 Oct 2020 12:30:25 +0100
Message-ID: <9610201.fqzlqthHOd@linux-9g0r.site>
Organization: SICOOP
User-Agent: KMail/4.10.5 (Linux/3.7.10-1.45-desktop; KDE/4.10.5; x86_64; ; )
In-Reply-To: <5712da17-6f45-247a-e9ea-a13c6b9b683c@lwfinger.net>
References: <6173742.tiux6Xeah1@linux-9g0r.site> <2483828.eKyWTE2oqM@linux-9g0r.site> <5712da17-6f45-247a-e9ea-a13c6b9b683c@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Ovh-Tracer-Id: 5495235972320213446
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrleejgdeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkohgfjghfggfgtgesthfuredttdeivdenucfhrhhomhepofhitghhrghlucfvqffotecuoehmihgthhgrlhhtohhmrgesshhitghoohhprdgtohhmqeenucggtffrrghtthgvrhhnpeektddvgfdugfdtteeftdehfeetteetfeevvddvgfeghfefteekhefffeeijefghfenucffohhmrghinhepohhpvghnshhushgvrdhorhhgnecukfhppedtrddtrddtrddtpdekiedrudelhedruddvvddrfeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedviedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehmihgthhgrlhhtohhmrgesshhitghoohhprdgtohhmpdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Friday, October 30, 2020 08:30:16 PM Larry Finger wrote:
> Michal,
> 
> My rtl8822ce works fine with 5.10.0-rc1 and 5.9.1 from openSUSE TW.
> 
> Larry

I didn't try 5.10.0-rc1 yet.
I suspect some kind of deep sleep mode that seems to survive hard reboot.
I'm on a laptop where I can't remove the battery and I don't have a double 
boot to Windows to make a test.
As additionnal context, before kernel 5.9.1, I was using the rtl8821ce driver 
for openSUSE TW which packages the driver from the tomaspinho github repo: 
https://build.opensuse.org/package/view_file/home:Sauerland/rtl8821ce/rtl8821ce.spec?expand=0

And my wifi was working perfectly fine.

Since then I tried to blacklist the rtw_8821ce driver and use the rtl8821ce 
driver compiled for 5.9.1 and the behaviour is exactly the same: no wifi 
either when the rtl8821ce is loaded by the kernel.

Michal
