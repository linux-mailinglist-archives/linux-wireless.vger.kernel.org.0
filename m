Return-Path: <linux-wireless+bounces-11935-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6889995E7EB
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 07:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C463B20910
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 05:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AC374055;
	Mon, 26 Aug 2024 05:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="SjXYmLFJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8C3B677
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 05:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724650247; cv=none; b=MZoH+11ibzdA20rKj+Ur76qp3DRw7tToPInB20Iygn5RCD9olz6fPXodvhazk42C7xPj7dFWmwex/14UkOVjXlRlEaDScrQW++1fy78WXHBKoUNd9QOWroCqJnOwv0kS6wPHXuGZF8gGZnriIS+zIyFGk4l7/yIbKhO2zaYsPIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724650247; c=relaxed/simple;
	bh=icpU9qsDi3NYQE9qZQUdP4k5gbHdgxAn0vSXV4NYH1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKY+yyk0s1sMGtuB4Fjlz4CePWF4g4ULc15nNAM5jciZ8xiBtgeCVX66jp1pofImnQeyv3FBlD4ZGdCX0f6OH1mwnPDbBUEWZLOWvLuh/eWFjWVwbkayYsp0K7Xg3qgX9VfB0YCMK44qb1F6c15O1e846MPCQ1y6rd0PiB6jDhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=SjXYmLFJ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3b595c18dso3489493a91.0
        for <linux-wireless@vger.kernel.org>; Sun, 25 Aug 2024 22:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1724650243; x=1725255043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eZAj8uvOya4HiP9l/CwQjSu7HVrLT1SErQUOAVQqfwI=;
        b=SjXYmLFJkKU/G4lU6HkWCElHXchI67pkV+IeneoH3zq+dUTsWjSmRd7gfzfY83spP3
         ZHhynlvKFUfiInJr7nsvSsceJRCchcirxxA11aVteRBnadlawgId72Tw44/IY8bzjcrA
         tCgD8n97EDQLiDF/BkOjYRvatahsuwTQ033MSXgI24BdSU674u2g0y/kJb4JRjFQL9p0
         APipsCZsZphOk7+LAwBROeDrjkdChfYmtGQ4OvZg2p3Q3MIupOVNjX4eAkttIVoTfelG
         WHHWzH+kuJU09r5vo3+6n0g4v8FHI9UBamckD1qTRmdOwsVgsLkBw6gnTChRXllJvLnX
         OZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724650243; x=1725255043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZAj8uvOya4HiP9l/CwQjSu7HVrLT1SErQUOAVQqfwI=;
        b=QJIKrfQhoI6f4tN9yhSyoA5uoBfhXyT7WPHXQG+9m9GlYIco7Gv5Sf2s04/XemJNjI
         4uFJfFuDQaNNl3Wl4l7+XUmfd623Ytta7nf2Bl9zC5kGv8uokA/k8PA7dQaSCqp5h8La
         uT7wjPi3h0c+xJGAxWxiPPfNrORgyTCK9ljkXGjhv1clcus0ujJXfTnMhit7EDtcY8Xw
         OPgkCyAk2b1dOK3ViQaFTlsBAdOUwUSr6xWChwcHxT1IO8Yr5mT/DUIf2SaF4YktANs2
         Q0b+yzfha24lT7sb0CVOtXpLD5xbc+OWVKjcRX5xoz8vSq7h+zeigeRju303gumL9XdO
         /LHw==
X-Forwarded-Encrypted: i=1; AJvYcCW0Mq3+7qYYQezySL4bWRcJ/9T4Nb9TN0fFbpRYzj2M3rCuY7E8+8v0t0VZ4bmFJV7v3U1onPCG0Tj/I11Haw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEBFS0R3LfIEEt9l2Gp8aOfgdeH8jdBWUQ0hh5zlYl7N3hFwZm
	IIhO4z3/YZfqc2CiCNYlzqdN7ZYYYTY1eqRfOeqBT17UbN+a70RCvuxhXfATr0c=
X-Google-Smtp-Source: AGHT+IFAfwY4jvMEw8vz45CKvkOATgMuexpgWgiFUN1H3XwTB6sTI0W3NQ8BP2OTYWCHmTL88+Ydxg==
X-Received: by 2002:a17:90a:eb11:b0:2d3:ad41:4d7a with SMTP id 98e67ed59e1d1-2d644777e33mr15300789a91.4.1724650243307;
        Sun, 25 Aug 2024 22:30:43 -0700 (PDT)
Received: from mozart.vkv.me (192-184-160-110.fiber.dynamic.sonic.net. [192.184.160.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613af1884sm8736728a91.43.2024.08.25.22.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 22:30:42 -0700 (PDT)
Date: Sun, 25 Aug 2024 22:30:40 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"briannorris@chromium.org" <briannorris@chromium.org>,
	"francesco@dolcini.it" <francesco@dolcini.it>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, calvin@wbinvd.org
Subject: Re: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to
 support iw61x
Message-ID: <ZswTABUwME3pliKW@mozart.vkv.me>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
 <Zsc1efkBHDXdZtfJ@pengutronix.de>
 <ZsuWExGZyY8Tvu6s@mozart.vkv.me>
 <PA4PR04MB96384BCB4093D621C43B047ED18B2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZsvtQCXxNJHh_DWS@mozart.vkv.me>
 <PA4PR04MB96386AB354F886DCB899F02AD18B2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PA4PR04MB96386AB354F886DCB899F02AD18B2@PA4PR04MB9638.eurprd04.prod.outlook.com>

On Monday 08/26 at 02:56 +0000, David Lin wrote:
> > From: Calvin Owens <calvin@wbinvd.org>
> > Sent: Monday, August 26, 2024 10:50 AM
> > To: David Lin <yu-hao.lin@nxp.com>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>; linux-wireless@vger.kernel.org;
> > linux-kernel@vger.kernel.org; kvalo@kernel.org; johannes@sipsolutions.net;
> > briannorris@chromium.org; francesco@dolcini.it; Pete Hsieh
> > <tsung-hsien.hsieh@nxp.com>; kernel@pengutronix.de
> > Subject: Re: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to support
> > iw61x
> > 
> > Caution: This is an external email. Please take care when clicking links or
> > opening attachments. When in doubt, report the message using the 'Report
> > this email' button
> > 
> > 
> > On Monday 08/26 at 02:33 +0000, David Lin wrote:
> > > > From: Calvin Owens <calvin@wbinvd.org>
> > > > Sent: Monday, August 26, 2024 4:38 AM
> > > > To: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Cc: David Lin <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; kvalo@kernel.org;
> > > > johannes@sipsolutions.net; briannorris@chromium.org;
> > > > francesco@dolcini.it; Pete Hsieh <tsung-hsien.hsieh@nxp.com>;
> > > > kernel@pengutronix.de; calvin@wbinvd.org
> > > > Subject: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to
> > > > support iw61x
> > > >
> > > > Caution: This is an external email. Please take care when clicking
> > > > links or opening attachments. When in doubt, report the message
> > > > using the 'Report this email' button
> > > >
> > > >
> > > > On Thursday 08/22 at 14:56 +0200, Sascha Hauer wrote:
> > > > > On Fri, Aug 09, 2024 at 05:44:50PM +0800, David Lin wrote:
> > > > > > This series adds support for IW61x which is a new family of
> > > > > > 2.4/5 GHz dual-band 1x1 Wi-Fi 6, Bluetooth/Bluetooth Low Energy
> > > > > > 5.2 and
> > > > > > 15.4 tri-radio single chip by NXP. These devices support
> > > > > > 20/40/80MHz single spatial stream in both STA and AP mode.
> > > > > > Communication to the IW61x is done via SDIO interface
> > > > > >
> > > > > > This driver is a derivative of existing Mwifiex [1] and based on
> > > > > > similar full-MAC architecture [2]. It has been tested with
> > > > > > i.MX8M Mini evaluation kits in both AP and STA mode.
> > > > > >
> > > > > > All code passes sparse and checkpatch
> > > > > >
> > > > > > Data sheet (require registration):
> > > > > > https://ww/
> > > > > > w.nxp.com%2Fproducts%2Fwireless-connectivity%2Fwi-fi-plus-blueto
> > > > > > oth-
> > > > > >
> > > >
> > &data=05%7C02%7Cyu-hao.lin%40nxp.com%7Cff25728795724a618a5208dcc5
> > > > 45c
> > > > > >
> > > >
> > 5fd%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63860215067862
> > > > 3224%
> > > > > >
> > > >
> > 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> > > > TiI6
> > > > > >
> > > >
> > Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=U0Cej8ysBD%2Fg1Sa4Ia
> > > > Ph63Ot
> > > > > > iTcemadiCfMINYM%2BRL4%3D&reserved=0
> > > > > > plus-802-15-4/2-4-5-ghz-dual-band-1x1-wi-fi-6-802-11ax-plus-blue
> > > > > > toot
> > > > > > h-5-
> > > > > > 4-plus-802-15-4-tri-radio-solution:IW612
> > > > > >
> > > > > > Known gaps to be addressed in the following patches,
> > > > > >   - Enable 11ax capabilities. This initial patch support up to 11ac.
> > > > > >   - Support DFS channel. This initial patch doesn't support DFS channel
> > in
> > > > > >     both AP/STA mode.
> > > > > >
> > > > > > This patch is presented as a request for comment with the
> > > > > > intention of being made into a patch after initial feedbacks are
> > > > > > addressed
> > > > > >
> > > > > > [1] We had considered adding IW61x to mwifiex driver, however due to
> > > > > >     FW architecture, host command interface and supported features
> > are
> > > > > >     significantly different, we have to create the new nxpwifi driver.
> > > > > >     Subsequent NXP chipsets will be added and sustained in this
> > > > > > new
> > > > driver.
> > > > >
> > > > > I added IW61x support to the mwifiex driver and besides the VDLL
> > > > > handling which must be added I didn't notice any differences.
> > > > > There might be other differences, but I doubt that these can't be
> > > > > integrated into the mwifiex driver.
> > > >
> > > > Hi Sascha,
> > > >
> > > > I'd also love to see this patchset, if you're able to share it. I
> > > > can test on an
> > > > IW612 if that's helpful at all.
> > > >
> > > > > Honestly I don't think adding a new driver is a good ideai, given
> > > > > how big wifi drivers are and how limited the review bandwidth is.
> > > > >
> > > > > What we'll end up with is that we'll receive the same patches for
> > > > > both drivers, or worse, only for one driver while the other stays
> > unpatched.
> > > >
> > > > I have some concrete experience with "in-tree driver forks" like this:
> > > > a pair of SCSI drivers named mpt2sas and mpt3sas.
> > > >
> > > > The latter was created as a near copy of the former:
> > > >
> > > >
> > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgi
> > > >
> > t.kernel%2F&data=05%7C02%7Cyu-hao.lin%40nxp.com%7C582c3c0573b74f83
> > 42
> > > >
> > 3408dcc579bc4a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638
> > 60237
> > > >
> > 3871805816%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> > V2luM
> > > >
> > zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=bLjsRTRsR%2
> > BTtA
> > > > jUIVDY396ZF%2BIkwwUFhAubTCin3IVk%3D&reserved=0
> > >
> > > .org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fco
> > m
> > > >
> > mit%2F%3Fid%3Df92363d12359&data=05%7C02%7Cyu-hao.lin%40nxp.com%7
> > > >
> > Cff25728795724a618a5208dcc545c5fd%7C686ea1d3bc2b4c6fa92cd99c5c3016
> > > >
> > 35%7C0%7C0%7C638602150678637352%7CUnknown%7CTWFpbGZsb3d8eyJW
> > > >
> > IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0
> > > >
> > %7C%7C%7C&sdata=mzrLLqJNee7vIdV47j8xVSU%2FByjh%2FnNKnRsx1nw3yNo
> > > > %3D&reserved=0
> > > >
> > > > The result was *exactly* what you forsee happening here: both
> > > > drivers were constantly missing fixes from the other, and they were
> > > > just subtly different enough that it wasn't simple to "port" patches
> > > > from one to the other. It was a frustrating experience for everybody
> > > > involved. I think their git histories prove your point, I'd
> > > > encourage everyone with a horse in this race to take a look at them.
> > > >
> > > > It took three years to finally unify them:
> > > >
> > > >
> > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgi
> > > >
> > t.kernel%2F&data=05%7C02%7Cyu-hao.lin%40nxp.com%7C582c3c0573b74f83
> > 42
> > > >
> > 3408dcc579bc4a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638
> > 60237
> > > >
> > 3871815005%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> > V2luM
> > > >
> > zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=RfY6N6WWXI
> > n0gZP
> > > > SBoRySz5eeU8WkFH2HvFHLVNgu3Q%3D&reserved=0
> > >
> > > .org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fco
> > m
> > > >
> > mit%2F%3Fid%3Dc84b06a48c4d&data=05%7C02%7Cyu-hao.lin%40nxp.com%7
> > > >
> > Cff25728795724a618a5208dcc545c5fd%7C686ea1d3bc2b4c6fa92cd99c5c3016
> > > >
> > 35%7C0%7C0%7C638602150678649431%7CUnknown%7CTWFpbGZsb3d8eyJW
> > > >
> > IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0
> > > >
> > %7C%7C%7C&sdata=UGjDfngO1POWuydIfmOL%2BR%2BqJ1BoDQW6NboQUV
> > > > q2Xh8%3D&reserved=0
> > > >
> > > > I doubt anyone would disagree that wifi drivers are much more
> > > > complex than SCSI drivers. It would be strictly *worse* here, and
> > > > the path to unifying them strictly longer.
> > > >
> > > > Thanks,
> > > > Calvin
> > > >
> > >
> > > I think Nxpwifi will support NXP new WiFi chips and Mwifiex will support
> > existed NXP WiFi chips.
> > 
> > Hi David,
> > 
> > I understand that. I don't think that really changes anything: there will still be
> > many future patches which need to be applied to both, because the bug being
> > fixed existed before the fork. As the forked driver diverges, that will only
> > become more difficult and error prone.
> > 
> > Thanks,
> > Calvin
> > 
> 
> Nxpwifi is not only a fork from Mwifiex. Especially after we modified Nxpwifi
> based on the comments from Johannes.

I understand you've done real work here. But at the same time, nearly
1/3rd of the changeset against the original driver is renaming things:

    {0}[calvin ~/linux/drivers/net/wireless/nxp/nxpwifi] tar cf ~/nxpwifi-v2.tar .
    {0}[calvin ~/linux/drivers/net/wireless/nxp/nxpwifi] cd ../../marvell/mwifiex
    {0}[calvin ~/linux/drivers/net/wireless/marvell/mwifiex] tar xf ~/nxpwifi-v2.tar
    {0}[calvin ~/linux/drivers/net/wireless/marvell/mwifiex] git add *
    {0}[calvin ~/linux/drivers/net/wireless/marvell/mwifiex] git diff --cached --shortstat
     42 files changed, 13878 insertions(+), 14274 deletions(-)
    {0}[calvin ~/linux/drivers/net/wireless/marvell/mwifiex] sed -i 's/nxpwifi/mwifiex/g' *
    {0}[calvin ~/linux/drivers/net/wireless/marvell/mwifiex] sed -i 's/NXPWIFI/MWIFIEX/g' *
    {0}[calvin ~/linux/drivers/net/wireless/marvell/mwifiex] git add *
    {0}[calvin ~/linux/drivers/net/wireless/marvell/mwifiex] git diff --cached --shortstat
     42 files changed, 9940 insertions(+), 10336 deletions(-)
    {0}[calvin ~/linux/drivers/net/wireless/marvell/mwifiex] cat * | wc -l
    45591

I'd consider that a fork. For those following at home, I pushed a branch
to github with nxpwifi v2 applied as a single patchbomb to mwifiex, with
the renames backed out:

    https://github.com/jcalvinowens/linux/tree/work/nxpwifi-on-mwifiex-no-renames

For my own selfish part, I agree with Sascha: I'd prefer to see that
changeset as patches against the existing driver, because I know from
experience that having a community built around one driver will enable
me to deliver better results for my users, and will make it easier for
me to contribute when I find bugs to fix.

But this is just one random opinion, I'm not who you need to convince :)

Thanks,
Calvin

> I think the real bugs fixes of Mwifiex will become less frequently.
> We can monitor these patches and apply them from Mwifiex to Nxpwifi.
>
> If we fix issues of Nxpwifi which is also related to Mwifiex, we will
> submit patches back to Mwifiex.
>
> Thanks,
> David 
> 

