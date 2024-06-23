Return-Path: <linux-wireless+bounces-9464-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F3A9138DC
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Jun 2024 10:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7AC2814C2
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Jun 2024 08:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9AB450E2;
	Sun, 23 Jun 2024 08:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="Kuc4qm+R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C58417C77;
	Sun, 23 Jun 2024 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719129726; cv=none; b=hxp27fIreJAAiqlZaHHd5+4VPzTEmCPyw4U2PacmLd8XYhi7pwMsFvP4LnWjjTsABcuWicCwYCPN0V0j5S5iTFPpo4FEwdQFtcW5w2vp/M9kUA7kSZe8tt9QH91hUmpoF1nBxrZpfeBp4mjgKjH6oYjq8mSITHfAtqODkdevfkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719129726; c=relaxed/simple;
	bh=hy2ki87r3CsdFd2uUj+s2wvNocOXNjMZAbPN3I53JH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TO6Azge1E8ltBil4n/QJVhuuIqlfOpPa/LIlvrTL0364ktaTOWiOliLrbRf6LXyXh7tt3Ff44aBfxF2Zlm+UCIt6pms7o/KnJYSzzg7zwUIbJJiM3wvVPpn1enh03QwqdcuhqPpBB7Svhk3FGMJWV/qi4RJDE2pDhQmquizmUl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=Kuc4qm+R; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1719129714; bh=hy2ki87r3CsdFd2uUj+s2wvNocOXNjMZAbPN3I53JH0=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=Kuc4qm+RLkfMTLfmABd/NF5FdG4goJqKSizgr8Rh95Nv+/dZdA991kg8WfyO3gNc6
	 +2ReQTYUQd0zLBsoIx2NnvRL+BYtOn83yOvQGtwEs+oThlrW18iyYiKwChHbrVGBv5
	 3wT9N6tYQpJLkVOqIpvtliVhHaYF9QMqsSky42A0=
Date: Sun, 23 Jun 2024 10:01:54 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Jacobe Zang <jacobe.zang@wesion.com>
Cc: "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>, 
	"kvalo@kernel.org" <kvalo@kernel.org>, "duoming@zju.edu.cn" <duoming@zju.edu.cn>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "minipli@grsecurity.net" <minipli@grsecurity.net>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>, 
	"brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"heiko@sntech.de" <heiko@sntech.de>, Nick Xie <nick@khadas.com>, 
	"efectn@protonmail.com" <efectn@protonmail.com>, "jagan@edgeble.ai" <jagan@edgeble.ai>, 
	"dsimic@manjaro.org" <dsimic@manjaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] net: wireless: brcmfmac: Add support for AP6275P
Message-ID: <ksxio3vzlz4rqcwvmtthskv6lqt33ejzjes557rwnkzex2oihk@52ueay5cwuub>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Jacobe Zang <jacobe.zang@wesion.com>, "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>, 
	"kvalo@kernel.org" <kvalo@kernel.org>, "duoming@zju.edu.cn" <duoming@zju.edu.cn>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "minipli@grsecurity.net" <minipli@grsecurity.net>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>, 
	"brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"heiko@sntech.de" <heiko@sntech.de>, Nick Xie <nick@khadas.com>, 
	"efectn@protonmail.com" <efectn@protonmail.com>, "jagan@edgeble.ai" <jagan@edgeble.ai>, 
	"dsimic@manjaro.org" <dsimic@manjaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240620020015.4021696-1-jacobe.zang@wesion.com>
 <20240620020015.4021696-4-jacobe.zang@wesion.com>
 <fro2xcwsnvbxmpszny6g2p36z4zwoq4kegmpvww4twxir5piez@a3c2nbwitmab>
 <TYZPR03MB700154AE39D44B8D166344BF80CB2@TYZPR03MB7001.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYZPR03MB700154AE39D44B8D166344BF80CB2@TYZPR03MB7001.apcprd03.prod.outlook.com>

Hi Jacobe,

On Sun, Jun 23, 2024 at 02:21:39AM GMT, Jacobe Zang wrote:
> > Any reason to strip info about origin of the patch, my SoB and
> > present this work as your own?
> 
> Sincerely express my apology to Ondrej. It's really my mistake. After getting
> your permission if I could submit the patches. I jsut think if the author and
> submitter is not the same person is strange so I changed it. Next tiem I will
> avoid this mistake. Apologize again.
> 
> 
> > I sincerely hope this is just a rookie mistake so please carefully read
> the URL below:
> 
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> 
> Thanks for the guidance Arend. After reading the document I realized what a stupid mistake I made.
> 
> BTW I have another question, except the SoB of the real author, should I also post the original link in commit message?

I suggest keeping at least this part:

> Partially copied from https://lore.kernel.org/all/c7b331edd65b66521a6605177d654e55051568a3.camel@toradex.com/
> 
> (No Signed-off-by provided in the email. The code looks like some
> data copied probably from a vendor driver and adapted for the upstream
> one.)

I'm not the complete author of the patch either. I just figured out why
just adding device/chip IDs was not enough compared to what Marcel Ziswiler
tried and expanded the patch from his email, to make it work.

People using baords with AP6275P (eg. I did my debugging on QuartzPro64) will
also be interested in how to get the firmware for AP6275P, and there are some
hints for that in the above link, too. (FW filename that is in the patch for the
driver doesn't match FW name as distributed by eg. SparkLAN, which makes it
harder to find it just based on FW name from the code)

Although it would be nice to have the firmware available in linux-firmware.

Kind regards,
	o.

> ---
> Best Regards
> Jacobe

