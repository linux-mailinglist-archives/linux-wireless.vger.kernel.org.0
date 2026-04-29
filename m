Return-Path: <linux-wireless+bounces-35542-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEmDF7JZ8Wn/gAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35542-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 03:06:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2B248DDF1
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 03:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35A48306DA59
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 01:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C30122F74A;
	Wed, 29 Apr 2026 01:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jcUaphJi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351A01514F8;
	Wed, 29 Apr 2026 01:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777424788; cv=none; b=GcJoKJdB1X7lvRutpMjBvyg2SbXiDGxWfGiFEyuX5pXXMjFl0SlPgQhoc77r++WLdfUIORgO9GDl08YB1MX+tIMf7hfzeWNMk2F2EHiDQp8Jv9HfeleUmvMeu+nM1Se1Diqfjh/ttvo3eqKkmplR0O0rZMwQsl3H2IekDMYgav4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777424788; c=relaxed/simple;
	bh=FbbMYy43PUndM6JPNtV61qlInWSiX44oXWU5kPw/J1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQP52Y8d5iKuc4++UFbDv2854fx+/0dkprAiGhg+sRy8lADGeP8MpmvlOTgxREvsGs50Eb5UfBh0oGIUlBAuhN1aYw5lkQzhEKzy5z8kDdfJj/Rs5uqzKCrTKoSOFegysPrghO6IeikePq/a31pjlkgiCC2cWBPoWGy448rfCy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jcUaphJi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WJyEk5iF/qClSow4VldMYLiNlMJs/+IOgRx7E06PJ0E=; b=jcUaphJirF4jpAsR5pNq2ZozJW
	w4uXI1olYO9kwy4WUOcz5TkLzG79ZBioNzGCAOCw+9PLMGxAPV7UKXq17hoEznOvhX1I9w5WgLmB4
	79QLQFdKVGdcw7aEKo4Hc+cLHhIUuX1NQY88sWJ8zjfmVyGpAKSt6FrFdPhmBvhkxfds=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHtNB-000RMN-PA; Wed, 29 Apr 2026 03:05:53 +0200
Date: Wed, 29 Apr 2026 03:05:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Rocky Liao <quic_rjliao@quicinc.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	daniel@makrotopia.org
Subject: Re: [PATCH 0/9] Support for block device NVMEM providers
Message-ID: <b4de6c89-dd89-4e02-8d79-911e4f9f0813@lunn.ch>
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
X-Rspamd-Queue-Id: CF2B248DDF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35542-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.infradead.org,makrotopia.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid,bootlin.com:url]

> Note that this is currently limited to eMMC-backed block devices, as
> only the eMMC core associates a firmware node with the block device
> (add_disk_fwnode). This can be easily extended in the future to
> support additional block drivers.

Would this be

https://elixir.bootlin.com/linux/v7.0.1/source/drivers/mmc/core/block.c#L2641

Looking at that function, mmc_blk_alloc_req() i don't see it doing
anything different between an eMMC and MMC.

An eMMC you don't expect to go away, since it is soldered
down. However an MMC can be ejected. Is the code prepared for that?

      Andrew

