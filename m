Return-Path: <linux-wireless+bounces-66-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B917F84B6
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 20:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D6E1C23EBE
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 19:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669C12C1BA;
	Fri, 24 Nov 2023 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="X3lqrdxV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06E52D79
	for <linux-wireless@vger.kernel.org>; Fri, 24 Nov 2023 11:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4dR4MEH7xKCu1higgA12F2eKeCLmZwqk+iO8UpgP8k8=;
	t=1700853963; x=1702063563; b=X3lqrdxV1eUEydApa3jo8sLIi+cBfouH+23N0Zz4uvOCCOF
	7VkGvED01xNVyM+SE5R/VF5HfkQ1bJR+uq1YHBVMQuCkUQQiz8HxlUll+uXFJhPZAXsnai0VPUkxg
	3zqndEyl/y6ig93laFzlDdbeORAyUqis2dN4IT6uXCg72Dco/uyQ+hWa1sJQk2CvDYkbapuhvRNdw
	62jlgzSz7XIhkClOcTAQx1M5rgDVcsBmL3ZGP5fBrVW4KT/c7ywXIpwedfiNGSMSpKi8qaXKIWRsN
	bMqxcN2RsU2Yap+BmcwnkxcxDXlS4fnGFKS8nBuZVF1SDToiYr6leqQC4wbscGQA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6boN-00000002k4e-1kpz;
	Fri, 24 Nov 2023 20:25:59 +0100
Message-ID: <ff991106e2b09e296725be4d1fe02de1911a2a2c.camel@sipsolutions.net>
Subject: Re: [PATCH v2,1/2] wifi: mac80211: Add utilities for converting
 op_class
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael-CY Lee <michael-cy.lee@mediatek.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Evelyn Tsai <evelyn.tsai@mediatek.com>, Money Wang
 <money.wang@mediatek.com>, linux-mediatek
 <linux-mediatek@lists.infradead.org>
Date: Fri, 24 Nov 2023 20:25:58 +0100
In-Reply-To: <20231113021107.13110-1-michael-cy.lee@mediatek.com>
References: <20231113021107.13110-1-michael-cy.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Btw, I ended looking at this again...

On Mon, 2023-11-13 at 10:11 +0800, Michael-CY Lee wrote:=20
> +/**
> + * ieee80211_operating_class_to_center_freq - convert operating class to
> + * center frequency
> + *
> + * @operating_class: the operating class to convert
> + * @chan: the ieee80211_channel to convert
> + * @center_freq1: cneter frequency 1 pointer to fill
> + * @center_freq2: cneter frequency 2 pointer to fill

typos here ("center")

But maybe it'd be better to fill (or update, we could pass the channel
pointer in it) a chandef struct? Then it could also be more easily
extended to understand more opclasses in the future, perhaps S1G or DMG?

> + *
> + * Returns %true if the conversion was successful, %false otherwise.
> + */
> +bool ieee80211_operating_class_to_center_freq(u8 operating_class,
> +					      struct ieee80211_channel *chan,
> +					      u32 *center_freq1,
> +					      u32 *center_freq2);
> +
> +/**
> + * ieee80211_operating_class_to_chan_width - convert operating class to
> + * nl80211 channel width
> + *
> + * @operating_class: the operating class to convert
> + */
> +enum nl80211_chan_width
> +ieee80211_operating_class_to_chan_width(u8 operating_class);

And you'd actually get both in one function call? The chan ->
center_freq anyway implies you know the width, no? Is this really needed
separately?

>  /**
>   * ieee8 0211_chandef_to_operating_class - convert chandef to operation =
class

This also converts the other way around, btw.

> +	case 135: /* 6 GHz band; 80+80 MHz; channels 1,5,..,229 */
> +		/* TODO How to know the center_freq2 of 80+80 MHz?*/
> +		*center_freq1 =3D 0;

Well, you don't, from this. I'm actually a bit surprised 80+80 exists in
6 GHz, I thought it was treated more or less as a dead end.

johannes

