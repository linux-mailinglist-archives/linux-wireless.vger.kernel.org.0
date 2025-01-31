Return-Path: <linux-wireless+bounces-18244-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36C7A23E48
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 14:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8141882729
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 13:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF71F1C3F04;
	Fri, 31 Jan 2025 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Q4w9orF+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF39A1E4AB;
	Fri, 31 Jan 2025 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738329795; cv=none; b=PELf9M2eX9Zg+wHX1tpPMeEaThmhxreiM99NxlgHB2jfV/Iw/N//hwYH5b2RAYGSHO6F+9zMSIZyn6ABimY9FCcf3Lqds/F1Ian2N8WTFA0npAUi7D9LOQdIRE1aL5wFsFErMDta1JkZtWQDR/xvcbmjxKdZhEuscIcwUDgDW0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738329795; c=relaxed/simple;
	bh=i98dv1hcShtHP6AHCDM9O3+gtS5Xr9m1puc+d9u+8pg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bAkl+drl+kb92dGH6s42XP6iOCdkkgi+0MXM+aqvkg+apZHrAnxwEtR0ajFUBZ/TM2i8skbYt6RrJirTgyTppl1Zem4DNoZdh995qKvp1NVfqXf/SbujJxmiC3rRrtz73WYgOfJSH7UFJO01b5A0BkHAP6+lH5Jzppx71e5qrmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Q4w9orF+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=i98dv1hcShtHP6AHCDM9O3+gtS5Xr9m1puc+d9u+8pg=;
	t=1738329793; x=1739539393; b=Q4w9orF+3sIn3D/ZAndJGufB+9yl/HRP20++/DTjmqNEsuK
	1zNYphw98Jt5ebxd+AieewqKkIqPYjNfaNzevxybCQ3gewrnSDCPIhHjCtT6ECI2t/AyT1aBuRCDh
	n4Jkem2CMVX1C84o/QcX+py6CC7lDKV3zX40LUpb3RVO49tDIf2a/JgHGVTby38WjgcATiYWV6aLd
	WtEoC7cd3XsjIGwKJZwwq+8K3x6Fe0dl8JeblVy0ta+egtiWiVznkq2ZwvGIDkxPHz/tEKwd9npmf
	7BzCrhHkrgLBeeyrMD7Q0ZtiXf5HlxBL+wiBZsRjme2RI3njLiqPO3sRtewDOSOg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tdqzA-0000000G9Bj-3JqL;
	Fri, 31 Jan 2025 14:23:05 +0100
Message-ID: <21896d2788b8bc6c7fcb534cd43e75671a57f494.camel@sipsolutions.net>
Subject: Re: Stepping down as maintainer
From: Johannes Berg <johannes@sipsolutions.net>
To: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org
Cc: ath12k@lists.infradead.org, ath11k@lists.infradead.org, 
	ath10k@lists.infradead.org
Date: Fri, 31 Jan 2025 14:23:03 +0100
In-Reply-To: <87wmefguqt.fsf@kernel.org>
References: <87wmefguqt.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi Kalle, all,

> I'm stepping down from all my maintainer roles. My first commit
> feed9bab7b14 ("spi: omap2_mcspi PIO RX fix") to the kernel was back in
> 2008 for v2.6.24 so I have been here for a long time. Thank you everyone
> who I have worked with, there are too many to list here.

First and foremost, let me add my thanks to the list here. We've worked
together for many years on wireless now and I appreciate that greatly,
personally and also in the role you've played in shaping wireless, be it
through the reviews directly, or the more indirect things like sharing
the tree maintenance etc. Thank you!

This is also an opportunity to thank Qualcomm for sponsoring your work
here. Certainly I'd expect they also got a lot of value out of it, but
we the community definitely got a lot, so thank you Qualcomm!

> Jeff continues to maintain ath10k, ath11k and ath12k drivers so they are
> unaffected. But for the wireless driver maintainer (drivers/net/wireless/=
)
> there is no replacement at the moment. If anyone is interested, please
> do let Johannes and me know.

I'll be honest and say that I did delay my reply to see if anyone would
speak up, but in the short term I really didn't expect anyone to step
up. We're pretty niche in wireless, after all :)

There's obviously reluctance of netdev picking up any wireless related
activity, and that would anyway be impractical if cfg80211 and/or
mac80211 were to remain separate. There's also a clear separation of the
lists, and given the volumes involved I think that's likely better for
everyone.

In the short term at least, I therefore expect that I will (need to) be
the custodian of the wireless trees. And I say "custodian" rather than
"maintainer" quite intentionally, because I cannot really take on the
role as you've filled it in the past. Shoes a few sizes too big, I
guess.


So as the wireless community, I think we will need to come to terms with
the fact that our workflow and processes will change now, and we'll
invariably have to take on some new work. In some ways, netdev has
already undergone such a transformation in the past, with
 * maintenance shared across more people (to some extent),
 * a lot more emphasis on reviewers _other_ than the maintainers, and
 * automation to take care of rote things.

I'm not sure we will be able to find (trusted) people willing to share
the maintenance with in the short term, but the other two things seem
entirely manageable in the short term. I'm already checking if I can get
(interim) automation set up in the short term, with a more permanent
setup, independent of myself or hopefully any company, to come later.

As for reviews, I suppose that'll be a new thing in the wireless world
where pretty much everyone (with few exceptions) works in their driver
niche. I would think that was also the case for Ethernet in the past
though, where now we see "cross-vendor" Reviewed-by tags on many
patches, even ones specific to other drivers. This is where we should
get to, to distribute reviews across more people. For those of you who
may not have seen, Jakub also publishes statistics about that, e.g.
https://lore.kernel.org/netdev/20250121200710.19126f7d@kernel.org/

Hopefully then over time we'll see where things fall, and find one or
multiple people to share the tree maintenance with again. Bus factor and
all that.


However, that's only *my* vision for how we continue to maintain the
wireless tree going from here. I'm open to other suggestions (though
pre-emptively reject the suggestion that "every driver has their own
maintainer and that's good enough...")


Thanks for reading this far, and thanks again Kalle! :-)

johannes


PS: I'll update patchwork auto-delegation accordingly soon, just have to
remember when I have enough time to click all the slow buttons there

