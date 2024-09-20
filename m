Return-Path: <linux-wireless+bounces-13060-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 140E397D68B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 16:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7D18285356
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 14:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D3314264C;
	Fri, 20 Sep 2024 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=carrierzone.com header.i=@carrierzone.com header.b="vYsLL0oi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail36c25.carrierzone.com (mail36c25.carrierzone.com [64.29.147.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EEE1EA73
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.29.147.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726840873; cv=none; b=Ms6b4wE+zp0M5l8vCDwb7//E6cKRDGtnt8DbBtaUzHcisx0R0Uu94a8ERU3KSsK6H9V72DbDGMoBdL40qPSKkWHCm9c++PnJRTrs/3fp3SyiKYIn4rUIwcKGwPg7ZwvtKt7NGSt+0f/c+N2PyP3ElMhB7Juu2vDXHdH8P2M0tmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726840873; c=relaxed/simple;
	bh=VNyUJu6k3VnnIvnt9gW/+k4KpjjWXajxFGy2I2TqVKo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CrgeRdMD4SW663SiFRO6aXhu/+hriqLhWJbuxvv/jTjpqUYVSGo62w12W4nH4TOTbZ5ZYgtUupDceLQ55uHbX30SY6A0+OnvujKOiqF4IQM62pLMbtqmkpySYYxZXKI3oJhBAt/GNl0vZcg9vn7/cUO5dCNNlxG33rvTQGFzziI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hindutool.com; spf=none smtp.mailfrom=hindutool.com; dkim=pass (1024-bit key) header.d=carrierzone.com header.i=@carrierzone.com header.b=vYsLL0oi; arc=none smtp.client-ip=64.29.147.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hindutool.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hindutool.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=carrierzone.com;
	s=mailmia; t=1726839696;
	bh=VNyUJu6k3VnnIvnt9gW/+k4KpjjWXajxFGy2I2TqVKo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:Reply-to:From;
	b=vYsLL0oijl0/8Bj3XkA8D0RTDnlv/SeIOCxlG15WR4omO+mZFJFr9cNN2fSwoyox3
	 Tr1JLnMtphDXazXIhB35wDRjeNVX0SfcW8LWxGwsaYXN+AOtUbyMoR57S/UjcxHfpN
	 /6XOq52okYmkjpAm0Wu4FGznrT3bHIVAk5HRQP9w=
Feedback-ID:pgupta@hindutoo
Received: from mail36c25.carrierzone.com (localhost [127.0.0.1])
	by mail36c25.carrierzone.com (8.14.9/8.13.1) with ESMTP id 48KDfVhM094486
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 20 Sep 2024 13:41:31 +0000
Received: (from webmail@localhost)
	by mail36c25.carrierzone.com (8.14.9/8.12.2/Submit) id 48KDfUdJ094453;
	Fri, 20 Sep 2024 09:41:30 -0400
From: "pgupta@hindutool.com" <pgupta@hindutool.com>
To: dknueppel@online.de, quic_jjohnson@quicinc.com,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
CC: 
Subject: Re: ath12k - HTT timeout error with NCM86
Date: Fri, 20 Sep 2024 09:41:30 -0400
Message-ID: <1726839690.xnskyi9sg84wgsw4@mailapp03.register.com>
In-Reply-To: <1920f9bd1b8.285f.40f506ff0c43803c7e4cd5785e25da93@hindutool.com>
References: <14e17e9a-638b-4bfe-8a2a-99b524a20acf@home.xx>
 <1MvJjz-1s0CoP3EEz-00rhmL@mrelayeu.kundenserver.de>
 <7488ed13-82dd-4b41-97c7-5692cacfa631@quicinc.com>
 <6d3f1f33-2a9a-4b62-a0a0-02e65bd1b461@quicinc.com>
 <eb1c8576-bf2f-4ec0-8651-62e97446e940@home.xx>
 <2271e7e8-2e25-42e5-a162-e79f65ee8798@home.xx>
 <1N4h7p-1rrEib2AJr-01163u@mrelayeu.kundenserver.de>
 <1920f9bd1b8.285f.40f506ff0c43803c7e4cd5785e25da93@hindutool.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Image-Url: https://mailapp03.register.com/api/storage/pgupta@hindutool.com/profile/picture
Reply-to: pgupta@hindutool.com
X-VADE-SPAMSTATE: clean
X-VADE-SPAMSCORE: 0
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudelfedgieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffquffvqffrkfetpdfqfgfvpdfgpfggqdevvdehnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkjghfgggtgfhrsehtqhertddttdejnecuhfhrohhmpedfphhguhhpthgrsehhihhnughuthhoohhlrdgtohhmfdcuoehpghhuphhtrgeshhhinhguuhhtohholhdrtghomheqnecuggftrfgrthhtvghrnhepveejkedvieehtedvteejleefueffffeviedvheeiteeluddugfeuheffhfetveegnecuffhomhgrihhnpeifihdqtggrthdrrhhupdhkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddrudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhhvghlohepmhgrihhlfeeitgdvhedrtggrrhhrihgvrhiiohhnvgdrtghomhdpmhgrihhlfhhrohhmpehpghhuphhtrgeshhhinhguuhhtohholhdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopegrthhhuddvkheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehquhhitggpjhhjohhhnhhsohhnsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepughknhhuvghpphgvlhesohhnlhhinhg!
 vrdguvg
X-Rspamd-Status: No, score=0.90
X-Rspamd-Result: default: False [0.90 / 6.00];
	FROM_DN_EQ_ADDR(1.00)[];
	MIME_GOOD(-0.10)[text/plain];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_REPLYTO(0.00)[pgupta@hindutool.com];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Origin-Country: Unknown

I purchased my hw modules (2.4, 5, 6 GHz) from compex. They were not recogn=
ized on my std Ubuntu 24.04 installation. According to compex the hw bit ne=
eds to either be hard coded into the module or a software patch applied. Be=
cause I am using all three modules in one machine (Dell R730xd) and using P=
CIE to M.2 riser cables they had to hardcode the identification bit and I h=
ad to send the modules back. I would ask your hardware manufacturer. I was =
told that the encoding will vary depending on the use of the module.  You a=
re right in that Wifi 7 has proved to be exceedingly difficult compared to =
the wifi 5 router I built. I have almost given up myself but continue to fi=
ght the good fight.

Cheers

Prashant gupta



On September 20, 2024 6:17:01 PM Dieter Knueppel <dknueppel@online.de> wrot=
e:
=C2=A0
I'm wondering, is this the correct mailing list for my questions?
=C2=A0
I know you are all working on best effort basis, but at least my
questions related to supported HW shouldn't be too complicated to answer.
=C2=A0
The information I found so far are almost not existent, stone old,
misleading or even proofed to be wrong (e.g.
https://wikidevi.wi-cat.ru/Ath12k, 17cb:1107 equals HERALD-BE as well,
not sure who maintains this page).
=C2=A0
I'm almost at the point moving back to my legacy HW.
=C2=A0
Anyway, I would still be very happy to receive any feedback :-)
=C2=A0
Thanks a lot,
=C2=A0
Dieter
=C2=A0
=C2=A0
P.S.: Due to my background in mobile networks radio interface, i would
have a good starting point to contribute myself. Unfortunately I'm
involved in plenty of other things and don't have the time for another
job :-(.
=C2=A0
=C2=A0
=C2=A0
=C2=A0
=C2=A0
Am 19.09.2024 um 11:41 schrieb Dieter Knueppel:
Minor update:
=C2=A0
I just figured out, that even the physical machine with std. Ubuntu
24.04 server (before the VM gets started and PCI device vanishes on
PM) reports: "Unknown hardware version found for WCN7850: 0xf"
=C2=A0
Hence the earlier question, whether "MSI HERALD-BE" or "Gigabyte
GC-WIFI7" is supported, seems still to be valid.
=C2=A0
=C2=A0
Am 18.09.2024 um 19:54 schrieb Dieter Knueppel:
Hi Jeff,
=C2=A0
thanks a lot for your update on ath11/ath12 related vfio support.
=C2=A0
That's actually bad news!
=C2=A0
Do you know whether vfio support vanished per accident or intention?
=C2=A0
I.e. I'm wondering on why the ath11 patch haven't made it into mainline?
=C2=A0
Assume there are no other 802.11be Chipsets supported by Linux, which
can be used as AP within a VM?
=C2=A0
Kind regards,
=C2=A0
Dieter
=C2=A0
=C2=A0
Am 18.09.2024 um 18:13 schrieb Jeff Johnson:
Resend since I had a typo in the ath12k e-mail list
=C2=A0
On 9/18/2024 9:05 AM, Jeff Johnson wrote:
On 9/18/2024 7:40 AM, Dieter Knueppel wrote:
Dear developer team,
=C2=A0
I have to admit, the earlier post "HTT timeout error with NCM86"
is my
fault, sorry for causing confusion.
=C2=A0
Due to earlier tests with legacy cards, the PCIe slot was still
forced
to Gen2 :-(
=C2=A0
Putting it back to <auto>, with "MSI HERALD-BE", similar to "Gigabyte
WC-WIFI7" i
=C2=A0
consistently get: "Unknown hardware version found for WCN7850: 0xf"
=C2=A0
Which nails down to the question whether any of these adapter is
already
supported?
=C2=A0
The M.2 NCM865 card as such seems to be supported.
=C2=A0
I'm wondering about the difference, as there seems to be no
additional
logic compiled
=C2=A0
on one of the two PCIe boards, just bit of glue logic.
For better support on ath12k driver issues please include the
ath12k driver
list (I've added it to this reply).
=C2=A0
In your original e-mail you said:
I'm trying to get "MSI HERALD-BE NCM865" up and running within a kvm
The ath12k driver does not support running in a VM. Even prior
ath11k-based
hardware doesn't support it.
=C2=A0
For ath11k there are some manual steps that have made it work, so
if you are
adventurous you can try doing something similar with ath12k. Refer to:
https://lore.kernel.org/all/adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com/
=C2=A0
=C2=A0
/jeff
=C2=A0
=C2=A0

