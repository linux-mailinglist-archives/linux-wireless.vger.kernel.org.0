Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF8E41838B
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Sep 2021 19:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhIYR1U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Sep 2021 13:27:20 -0400
Received: from 8.mo561.mail-out.ovh.net ([87.98.172.249]:52435 "EHLO
        8.mo561.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhIYR1S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Sep 2021 13:27:18 -0400
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Sep 2021 13:27:18 EDT
Received: from player691.ha.ovh.net (unknown [10.109.146.82])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id 84D76213DA
        for <linux-wireless@vger.kernel.org>; Sat, 25 Sep 2021 17:19:49 +0000 (UTC)
Received: from gk2.net (37-173-0-231.coucou-networks.fr [37.173.0.231])
        (Authenticated sender: gerald@gk2.net)
        by player691.ha.ovh.net (Postfix) with ESMTPSA id 91D542297EB3B;
        Sat, 25 Sep 2021 17:19:34 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-95G001ff05c6a0-7eb7-4f8b-9bfc-7d875a2b5d37,
                    107BB8FA651BEE704DA9BB541DF68390FDC7F12B) smtp.auth=gerald@gk2.net
X-OVh-ClientIp: 37.173.0.231
To:     linux-firmware@kernel.org, Josh Boyer <jwboyer@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Ganapathi Bhat <gbhat@marvell.com>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        Cathy Luo <cluo@marvell.com>, James Cao <jcao@marvell.com>,
        Prashanth Ranganathan <rprashk@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Zhiyuan Yang <yangzy@marvell.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Rakesh Parmar <rakesh.parmar@nxp.com>,
        Cathy Luo <xiaohua.luo@nxp.com>, pali@kernel.org
From:   =?UTF-8?Q?G=c3=a9rald_Kerma?= <gandalf@gk2.net>
Subject: mwifiex 1.0 (16.68.10.p159) - PCIEUSB-8997 firmware is buggy
Message-ID: <edeb34bc-7c85-7f1d-79e4-e3e21df86334@gk2.net>
Date:   Sat, 25 Sep 2021 19:19:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr
X-Ovh-Tracer-Id: 6500101638294199128
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudejfedguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefvhffukffffgggtgfgsehtkeertddtfeejnecuhfhrohhmpefirohrrghluggpmfgvrhhmrgcuoehgrghnuggrlhhfsehgkhdvrdhnvghtqeenucggtffrrghtthgvrhhnpedtudfhhefhhfefkeeijeehjeeugfevjeehgfetfeegvdduhfdtuefgjefgffdvkeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucfkpheptddrtddrtddrtddpfeejrddujeefrddtrddvfedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieeluddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrghnuggrlhhfsehgkhdvrdhnvghtpdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Héllo All,

I made some few tests on EspressoBin-Ultra from GlobalScaleTechnologies,
because of problem with the WiFi.

I have done some quick tests on all the firmware of PCIEUSB-8997 using
the pcieuart8997_combo_v4.bin on OpenWrt 21.02.x

Here is a summary of the tests :
- W16.68.10.p159 = KO
- W16.68.1.p195 = KO
- V16.68.1.p145 = OK
- 16.68.1.p140 = OK
- 16.68.1.p133 = OK
- 16.68.1.p97 = OK
- 16.68.1.p70 = KO
 
REF (and all details of tests) :
https://github.com/NXP/mwifiex-firmware/issues/1


Broken firmware :

Version |W16.68.1.p195| of |pcieusb8997_combo_v4.bin| was included into
linux-firmware repository by this pull request:
https://lore.kernel.org/all/CA+5PVA5yQbjg3vaT7F8120B6ngLn7+sZC0OWt0KoUiQR9hS4FA@mail.gmail.com/
<https://lore.kernel.org/all/CA+5PVA5yQbjg3vaT7F8120B6ngLn7+sZC0OWt0KoUiQR9hS4FA@mail.gmail.com/>

And latest version |W16.68.10.p159| of |pcieusb8997_combo_v4.bin| by
this pull request:
https://lore.kernel.org/linux-firmware/CA+5PVA5on7+CRtEV7tThPxgucwt3W9i-tEXm4cgH-AmMB-Jrtg@mail.gmail.com/
<https://lore.kernel.org/linux-firmware/CA+5PVA5on7+CRtEV7tThPxgucwt3W9i-tEXm4cgH-AmMB-Jrtg@mail.gmail.com/>

Olders looks to works better.

In quick tests, they allow more than 1 clients at a time !

I am still testing the V16.68.1.p145 and report the results after some
longer use...

Hopes it will help...
Regards,
Gérald Kerma
gandalf(at)gk2(dot)net
