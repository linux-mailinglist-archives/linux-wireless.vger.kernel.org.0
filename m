Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154A92A1571
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Oct 2020 12:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgJaLZy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Oct 2020 07:25:54 -0400
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:42374 "EHLO
        2.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgJaLZw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Oct 2020 07:25:52 -0400
X-Greylist: delayed 152002 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Oct 2020 07:25:51 EDT
Received: from player750.ha.ovh.net (unknown [10.108.42.23])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id 08588144E97
        for <linux-wireless@vger.kernel.org>; Sat, 31 Oct 2020 12:25:49 +0100 (CET)
Received: from webmining-systems.com (lfbn-idf1-1-284-37.w86-195.abo.wanadoo.fr [86.195.122.37])
        (Authenticated sender: info@webmining-systems.com)
        by player750.ha.ovh.net (Postfix) with ESMTPSA id 9176D17A2ABC9;
        Sat, 31 Oct 2020 11:25:48 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-96R001234630da-67a1-437e-9b14-d1b56792ef3b,
                    5A1BA32B9D2D82DFA4D995F9AB56433EB6550EE7) smtp.auth=info@webmining-systems.com
From:   Michal TOMA <michaltoma@sicoop.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: rtw_8821ce driver in kernel 5.9.1: wifi module inactive
Date:   Sat, 31 Oct 2020 12:19:39 +0100
Message-ID: <2104213.T3vFtHkSoI@linux-9g0r.site>
Organization: SICOOP
User-Agent: KMail/4.10.5 (Linux/3.7.10-1.45-desktop; KDE/4.10.5; x86_64; ; )
In-Reply-To: <5a6155f1-f8ea-b8b4-e38f-0ebf8bf720d0@lwfinger.net>
References: <6173742.tiux6Xeah1@linux-9g0r.site> <2483828.eKyWTE2oqM@linux-9g0r.site> <5a6155f1-f8ea-b8b4-e38f-0ebf8bf720d0@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Ovh-Tracer-Id: 5313403138123119046
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrleejgddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkohgfjghfggfgtgesthfuredttdeivdenucfhrhhomhepofhitghhrghlucfvqffotecuoehmihgthhgrlhhtohhmrgesshhitghoohhprdgtohhmqeenucggtffrrghtthgvrhhnpefgvdejledutdeffeegvdfgveevieeggfefffejgffftdfhieeludetffevjeelfeenucfkpheptddrtddrtddrtddpkeeirdduleehrdduvddvrdefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejhedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepmhhitghhrghlthhomhgrsehsihgtohhophdrtghomhdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Friday, October 30, 2020 05:23:53 PM Larry Finger wrote:
> On 10/30/20 4:21 PM, Michal TOMA wrote:
> > iwlist wlp7s0 scan
> > 
> > wlp7s0 No scan results
> 
> You should move away from those obsolete commands (iwconfig, iwlist, etc.).
> The new command would be
> 
> sudo iw dev wlp7s0 scan
> 
> It might not make any difference, but the new ones are better.
> 
> Any additional messages between the start and stop vif messages in dmesg?
> 
> I do not have an 8821ce for testing' however, I am not aware of any changes
> in 5.9.1 that should stop it from working/
> 
> Larry

iw dev wlp7s0 scan
returns nothing at all

No additionnal messages between the start vif and stop vif messages, this just 
goes on indefinitely:
[  832.419210] rtw_8821ce 0000:07:00.0: stop vif 2e:71:fe:88:e7:38 on port 0
[  832.940915] rtw_8821ce 0000:07:00.0: start vif 2e:7f:5e:d9:5e:45 on port 0
[ 1244.435074] rtw_8821ce 0000:07:00.0: stop vif 2e:7f:5e:d9:5e:45 on port 0
[ 1244.960984] rtw_8821ce 0000:07:00.0: start vif 5a:94:ec:c6:74:63 on port 0
[ 1656.506940] rtw_8821ce 0000:07:00.0: stop vif 5a:94:ec:c6:74:63 on port 0
[ 1657.040551] rtw_8821ce 0000:07:00.0: start vif aa:d0:5e:6a:0c:be on port 0
[ 2068.443729] rtw_8821ce 0000:07:00.0: stop vif aa:d0:5e:6a:0c:be on port 0
[ 2068.972402] rtw_8821ce 0000:07:00.0: start vif 5a:60:d3:11:e5:6b on port 0
[ 2480.455695] rtw_8821ce 0000:07:00.0: stop vif 5a:60:d3:11:e5:6b on port 0
[ 2480.976273] rtw_8821ce 0000:07:00.0: start vif 56:46:bd:44:4b:e3 on port 0
[ 2892.494486] rtw_8821ce 0000:07:00.0: stop vif 56:46:bd:44:4b:e3 on port 0
[ 2893.016142] rtw_8821ce 0000:07:00.0: start vif c6:66:3a:cc:8e:df on port 0

Michal
