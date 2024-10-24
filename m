Return-Path: <linux-wireless+bounces-14454-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3013E9ADF59
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 10:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512A01C2082F
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 08:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59668145B18;
	Thu, 24 Oct 2024 08:41:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECB06F305
	for <linux-wireless@vger.kernel.org>; Thu, 24 Oct 2024 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729759301; cv=none; b=n+rdVrGrHh6AeUH+ELFQ4WRUoZk044rhfdXl60AKJRTOzcKiyX/X36IdbMDFpiKcznbMvnCIvOtbOtA/NB5jvdjZ8gfGeAPVIpl9Rt/Wv0V/CaI345P75a01X3AntoBEDMZjPmAK1klBaJ/pgI6hAlDLC1vuBO3KISUTrcfAIbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729759301; c=relaxed/simple;
	bh=u2PjvEHkmZDnIud7iu/UCQ9Uem62TkUIeaDbY6frbP8=;
	h=Message-ID:Date:MIME-Version:To:References:From:Subject:
	 In-Reply-To:Content-Type; b=aP3fk9+ppKSD1Zjp6WucH3TV5fBPIS01WITwLFOd/RJFNfUmsCM+2HH6rVB/FwX4+kX7IMZ9darocuLpXIfeHlu/p4TKnewnTvn6ZoujvG00WfuGNADPr/hYLWVHi5pNBNALPIIoF/hTtmr3J/NhctAdXQFrnV3MrlKsW2zzNMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=green-communications.fr
Received: from [192.168.0.66] ([88.171.60.104]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MvKL3-1tvAkh3H2P-012qEZ; Thu, 24 Oct 2024 10:41:34 +0200
Message-ID: <69782bb8-7840-4870-b171-094adc5ca089@green-communications.fr>
Date: Thu, 24 Oct 2024 10:41:34 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: John Kyle Cronan <john@pbx.org>, linux-wireless@vger.kernel.org
References: <CAFqYJVEUjXPVARSj-dMS0=vhocu4=HSke_p4=PfGMBob6bGJHA@mail.gmail.com>
Content-Language: en-US
From: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Autocrypt: addr=Nicolas.Cavallari@green-communications.fr; keydata=
 xsFNBFKGRC0BEAC+nMoqcTXudlSZXH9EwSbOQuiIXTAxeVSX7WXxUvH5gqBamTSgBN+G7rvD
 UtTCSAbKkTG01rBZbbhwRl2vM0oi8Hg5sOvJ6OskKzIU4MWMzi0qNaKk2RPSE2wI7xo4N/M4
 aiJcmqhmzwLrr4FvuvTNDC+mX43/uFFQeWs4DiIRhwthO7WQmzvmmpwZIGBQxgfaveEZgzVR
 HMVVMTS1tlJntMgeb1JgYWMDUbZTRbigegrM08hrG5deK08uD9djGI9Mdu9WR1S4PCVXMVqI
 WROX4AQTCl9pgQEtnxnYeB4VvA9iInYpsg9gSR6QhZxluK0A4OFQF2HfqIwT0Z4K4xFl+9v/
 EcZRK3d5Lry9GEinFCf2H6tRDFRxxK3m3/D2UAR601Y/buIK0sCMNwcpc5yYHmBSyAxM2j2s
 29gEnhDMQbLn93cHSERaRk3lExJM7vtTxBMSPm+7DrOmIF358IHQXqrY1xYl4eBG+R2aGS30
 pH5cGycCL+VxWg8K9pSF5w4XT+XvRsaAmkvQ1GApkTjOhjDDXzWxX5w1DMKW8io3GM28lf8z
 mE156/FOlG6SQBHZZjJ22+5TiZRKO5HK+bJav8L/NeqavmZ9evNLVpr1BYiG1Ph769laSpbi
 Zt3Dar8hc+IQvR9ig7tWPbSmha95gMJP35Kwy45M+u97hAZOBwARAQABzUROaWNvbGFzIENh
 dmFsbGFyaSAobWFpbCkgPG5pY29sYXMuY2F2YWxsYXJpQGdyZWVuLWNvbW11bmljYXRpb25z
 LmZyPsLBlQQTAQgAPwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQTEcT9CxhYiex4F
 Htv4pX245AdyAgUCZvF3TwUJHdE0ogAKCRD4pX245AdyAlq5D/9+BfuYe3tXms6xJyxBe7PJ
 guDeQL5p5a/kTT3cwesRt61sA8t+iRAVuEH5kBREAPbcX7iXMtqQ5OXfWSD6pk5uBSi/vnj6
 kAlbReP9qYBq70XecEccqXP/N4MBsV8nulmyWyx37ARkqOgRPPgyCQkijpV8oHA+SMxHDyYi
 WGoOY5HdztaLCU5rpTe4+izjmLcyzPiAfNowv9DSVwU8TRsqIRoxzm4sxkU1Pe3AN0OuTiH7
 aIjirRpaXbD56YtF9ExPEoEpUvAWkWCcnCstTovqh0LasALc7l3prG+88n0nKf2yRh5rfBhm
 tQHGBiZiLholIiv4PJi9K4hM8nvzSjJnBhQwLQsedzjeXse7h0vSZGNYB9mJN1fuYOOZI7Go
 PdHddyuARe/zezU5h+tz7l6glaHpOztiHPaCgWldRpH/JqIrvDVZjBj9u719+N7J21K5BFDA
 h0PSoEjMuQU8pQJmjTuzJZzYv6Nyp/a+p6I4i4UWRNpM+B8wVl8G0HcHur7SO5MOG+YBtz3N
 MqZUZjTjoeLCJM4A48EvUiTI6igyN6KcAINjbO1eLgaBEJO9j5CLNS/n6krHxd97rRC0KB4L
 ZVghxYw9xcBNOwkLW6LmIDwuTzB8J+X3K5IKRPIPffNLHLh340A5U1Oj5jilvoaCO8rn7RVU
 /FlfmP6l6WH1T87BTQRShkQtARAAsdhjcnSDMT+Y0m9MnQ13dAe8TLW/79f7SjDN0V5L/oxM
 EhlTX9/1Qc9iTUv6ZCVwo9xK6EPvB7jXEHdwyW2Lc5PNgAYPIhIPpPemC1+HuZDQxjpHAELD
 8uMann0Jgogl9lyYPGDkWa9L0Aurd9AuCeMBX8MIiBMxKhwHrhnpU2T/DaPBwP0EcKrXd/Gr
 TNcS/C55odNsqBQ4/vYdJAVz25byMlppMAxEendO2oiUump3oyvpk9BmHBWTIGyA2xsIQKu/
 +sm12m16FqH8ppMw27te1dlMTaa+akmi59l/XFPgdARQ3UNXbNLm+pf86POtVdGhVrX8KfDJ
 r2H17IpS7jC++pp4TAagfEeaqtD5erHrRHg8UqxDYnRxB8gJbqTgFQu1MxHYyNodeDw1oJG6
 wGd0XEVswCPr1Fmeht/QRNJ1wZzB6i8/oo5X/TgYJiMGFYTPz5t6aWFp7yJZHBzLuE1JcMlN
 bcdFn60QSGI5R9RgCqcHXtxxvUXjYLIuelQl+OdPmV49Wjzknu0l9Uw3CmRGlG6vQKlWOsUz
 z32o3x+zPkLw+ciz6tNEQ6s45MUmGl2Fr+OOaYD4jc8PlRTvqj0IwVnXwCIQ28sh4FbJwsoU
 xrcINmEmYCpSIZEKR2Y7YnlVmW4fb3b3xez3pjb/jDBNDt5Dw4IFwcqT8zpIkXcAEQEAAcLB
 fAQYAQgAJgIbDBYhBMRxP0LGFiJ7HgUe2/ilfbjkB3ICBQJm8Xc4BQkd0TSLAAoJEPilfbjk
 B3ICue8P/0mjR9Hyx2MPhyNhRRsCeFpqZMUSPeBh7o8+2MShWIHLt1XurDJod4oJqIEoFZYQ
 9zzGD23up5oS84WQCb5G0EXy7tdpLLKImrKqa8xt1sLj0popUCH+A2w7B/kAOyU4HbNE2ZBx
 jX3ir1ecFIqskaOegl4ulv7As1hCvp1JxbCehgAnKphHV6yast16lhfvwt3TKUA0WmtzrA5F
 mqnIxNSQY5gWxIfGmXXceQelZ6MhZm/SYFQyDrBh+XmIhNrg3r4/rKaLSeDbeJks2Dd7ArnD
 T5n4gq87tOHQBS15Riw7uqfkUPuzkGrf6wI/L1SitHgqFkQ1fXq+fU6OwckaTvgVe82+s5oL
 xnMEywFi1zReL/r50afTnz0YWNGJ+svUGeu8/sl7Zgh++NDHpTQCqe0Xu6Q+6H9SRiSmyS1G
 sZhjWwFjk6s/RjmPhZcJ0LCYSKRSYXMgg8Pm6Z/woLFWQRt/4wc3ZvzI2zTgBgEyeu+o86cZ
 KTFSx1sD0GSkFa+SRcOMdr5L/qQ8vuFeV7LYOUFw1LIPEToJtv+K6RdTQ7avzLBWZOrmqE2r
 RppToNOj/ihnpeDsnAmdJG3/8TInGXPgWP8cEJ892///fl4Ejm1KePuro3M0qENUtY5Z6LSt
 XMjIkcCihY9vSksnm5C7d6wGxy2/Mju8s0J1tRaXkjbj
Subject: Re: How to distinguish multi PHY devices for interface naming?
In-Reply-To: <CAFqYJVEUjXPVARSj-dMS0=vhocu4=HSke_p4=PfGMBob6bGJHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:cGf3gosXpEtXyo6fRrc2AemBWA59yR48cR6im47lJDUfPqDhbBt
 0ikhPghbrUivtC64k9gx3ODAdj3/UTctO/cr6zaHJoJQ3RS1WUKoILekdX/ijPkZa1DqqEV
 9BIQQCuOgN7BptVsriHRp2dd0d3yKfOHZdVEzbgVOWUdTqVLfKKxeWjWMAhsPSSP1qsAT7Z
 c5YWebDvX1dOArpp9tCOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jBMmKrxnhqY=;RsE3GAkev6qWZJ+FLm2VbK+KYNK
 QkJ/9CXR3afQCagIxHJdMUiTwVCGgOpNI5a01C4zGsmcxUE0GKDwhKnvbwDHky+MEyZVlCcMD
 HfLfY7HVtiTdD/NI21ecChN8T+IwlwyfOs52CJfQke/26JIcnWo3hNfMlg/YJJbSF779HMAoF
 6Gqd8ThYrP3ic4yh05QpTJpGjPbYdBZwodzNBpApxrPI0CgT4aZET0PdLXG51W4oibgZ9sVta
 8HWWPE4dAxaRUQbo5ZjiYIq4bB6rsQvgF3eMH8iN+/RNqeVgRLzAN/9aP1BI/xi6NeDcjswB5
 6NuKuL1e/nYoewojne+aUhGd0QpByxA2AU1R/mqHaqRaAYhIifcEDXpxFOdFKmhLYr2hSR3NY
 S5iQkcmimUcXoL4K1NLAJYVQ7BMaKdp94eBpDUY19652em6hoZ/kXkrCg9WhWynSULd/iQQUT
 P3LKWQ5+lWBQfBmogdOE+rcp456FCMewtfG7vq43WDizQiyrg9HM8szlV/HRuUKt+HNYDxDn9
 ncok15NKMHmQtna/P/1yHBjcLmGjbE60BEfxvcbQCRXoChmtKJFGffFUXSUXYP3qAnAvmYYOD
 E7FUzydM82TDppCY4kmpoGRAidboJ3eohpolafCho8i69Hb7wksmTlrUr5yTj4r2NLroLdHr3
 yWJuE4x0dvbpQeVPqndKkAij5syYgz+Dakeufo2yupV8p7iRtJTvUrNysQPWOu3a0cKr9VpVW
 1NIj/SNc+O2UXgF7tmFec1HO85tTddDPw==

On 23/10/2024 22:58, John Kyle Cronan wrote:
> Hi all,
> 
> This is not an especially serious issue, but maybe I can get to the
> bottom of it. I was using the Mediatek mt76 wireless driver with one
> of the newer cards that presents multiple interfaces, one for 2.4g and
> one for 5g. I noticed that the usual udev setup with systemd was not
> naming them in a way that makes sense: one is wlp59s0 and the other is
> wlan0. So I investigated, and found that udev doesn't have access to
> any information that could distinguish the two interfaces that share
> the same PCI port path.
> 
> Here's the issue I opened with the Mediatek maintainer:
> https://github.com/nbd168/wireless/issues/12
> "Systemd assigns the first, wlp59s0, using the path-based name, but
> then the second one tries to assign its name in the same manner and it
> conflicts, so it has to fall back to wlan0." I took a look at the
> kernel sources for this area, as best I can understand them, and made
> the suggestion to set a netdev phys_port_id attribute uniquely for
> each interface. That would result in wlp59s0n0 and wlp59s0n1. (There
> appear to be two other possible methods, though, corresponding to 'f'
> function and 'd' device port. Unfortunately I never made it that far,
> trying to learn the implementation details.)
> 
> I got the response, "the driver is not responsible for managing
> netdevs and their attributes - that's all handled by the mac80211
> stack. What the driver does is register two ieee80211 wiphys on the
> same PCIe device. There are no separate devices here, because on a PCI
> level, there is no isolation at all. It really is a single device. The
> wiphys operate independently from each other, so naturally the
> auto-created netdevs do so as well. ... Not sure what the solution is
> here."
> 
> Is this the 802.11 stack's concern, or the device drivers'? How could
> udev get the info to distinguish these network interfaces, and which
> approach is the right one for wireless devices?

Udev is already confused with multiple vifs on a single phy on a single device. 
It is somewhat mitigated by name_assign_type and manually specifying vif names, 
but this is really a udev problem, it need to be smarter.

Now there are multiple phy on a single device, and those are the kind of devices 
that people will want to use with multiple vifs per phy: people mostly use them 
in access point mode, with maybe multiple SSIDs per band.

For mt76, currently the only reliable way to distinguish the 2.4 GHz phy from 
the 5/6 GHz phy is that the 2.4 GHz phy is always created first (there are no 
possible races), so incrementally numbering the default vifs will create a 
stable output.

Maybe there should be a phy field to locally number the phys of a single device. 
A bit like phys_port_id for netdevs.

