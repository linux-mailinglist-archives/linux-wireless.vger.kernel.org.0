Return-Path: <linux-wireless+bounces-32621-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNMnN3mjqml6UwEAu9opvQ
	(envelope-from <linux-wireless+bounces-32621-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 10:50:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D6421E3BB
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 10:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87A1430D8632
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 09:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8156C34A79A;
	Fri,  6 Mar 2026 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="qU56ni2x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3CC307494;
	Fri,  6 Mar 2026 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772790383; cv=none; b=F5blyFWkOnCzG1oVpZzKZQk1rO8IXN1FfsV9epi6ij4Xls6EB6R+IQ/rbc2JVaSo3ZZdOJ6vczWjIEepbwCGda2nlCJcQhD9fy9Fvq8j1zrZV4bZiQsTxYeotwkZqzmydSgUS4XhsW8qivLlMqlxrwAxrJQH50OKyR8Bo+GkLrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772790383; c=relaxed/simple;
	bh=p4/KWPmnqK2oC00dyUCTUQx38BPyb7n3SFjV7bzSle0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMHO/Ka/q2d16JTfxqT23UhKo4U3Se5G3Hy5VPuJYu69/t0bwBvTSvh+gAMeWFKz4XZv4DJCEMw6CnAgF07imi5PDbRoZI3Th2EWdqouZZqaWESRwM1O83gahs4PSENW4wZ33TH2/Nq/F9dpcKScjr939gYAUl6RW5iwKoIk6Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=qU56ni2x; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id E0F9622BA9;
	Fri,  6 Mar 2026 10:46:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1772790371;
	bh=fwHWaMTHGf2q55gryl1wYfenCSX2JOT+w45XCO6z0CE=; h=From:To:Subject;
	b=qU56ni2x27E3IMY/7kQHPt05dHq4vt9mkKv2vSu/KVAseYSdxOr8Y+GoWF8Hr0YJL
	 5U9GrXdQinJc1BNRBqY3XxKZCf6nmtbnXyc0N4LLXEZPzeknX9UqMJN/42Vs5Aowi9
	 DOtzmnUr1sOVdrUMkCbzlekT88xDo+LPwqh9YcDJKtgLt9hg4NCV4t9295S6bLWyP0
	 7f4b+dYio1wSGd6C4AUjKE5Pcrmp3LV8Pomt/cstyPpimNxZncbqJuObTi0puXP+po
	 Oon+SgeNqp4tAtLLhDc6B9MkmaiHod0GpUgS504V42YdN+RXwptaZZo0cS9Ymb/Nzi
	 5vrg02lDx1DAg==
Date: Fri, 6 Mar 2026 10:46:07 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Johan Hovold <johan@kernel.org>
Cc: linux-wireless@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Jakub Kicinski <kuba@kernel.org>, Stanislaw Gruszka <stf_xl@wp.pl>,
	Hin-Tak Leung <hintak.leung@gmail.com>,
	Jes Sorensen <Jes.Sorensen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] wifi: mwifiex: drop redundant device reference
Message-ID: <20260306094607.GA34779@francesco-nb>
References: <20260305110713.17725-1-johan@kernel.org>
 <20260305110713.17725-5-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305110713.17725-5-johan@kernel.org>
X-Rspamd-Queue-Id: 43D6421E3BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32621-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,chromium.org,dolcini.it,nbd.name,kernel.org,mediatek.com,wp.pl,gmail.com,realtek.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[dolcini.it:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 12:07:04PM +0100, Johan Hovold wrote:
> Driver core holds a reference to the USB interface and its parent USB
> device while the interface is bound to a driver and there is no need to
> take additional references unless the structures are needed after
> disconnect.
> 
> Drop the redundant device reference to reduce cargo culting, make it
> easier to spot drivers where an extra reference is needed, and reduce
> the risk of memory leaks when drivers fail to release it.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>


