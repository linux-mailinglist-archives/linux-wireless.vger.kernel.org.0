Return-Path: <linux-wireless+bounces-34673-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HUjBYaq22mzEwkAu9opvQ
	(envelope-from <linux-wireless+bounces-34673-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 16:21:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CE13E435E
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 16:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB119300B441
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 14:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5045D373C1D;
	Sun, 12 Apr 2026 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="KSptVbYO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEFA36A01E
	for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2026 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776003713; cv=none; b=GU2LuEGdnTHPTzvRU9m+BeJSYvTXIvP72ZLDeSRTqvDi4ohDiCHue7UPWQrBxs6/LPf3/7PtZrnv+TGAhP4yIoZfo/WdFvwQ0U/0rDmRxRjdfwSTMTM03Yt0xPU9Aj4BVGBrzd84jgaCxNoQV5ARI4Gn7ifyF10gcKjbegUXSgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776003713; c=relaxed/simple;
	bh=2OzzAGEjlO1j+az6ZWcSL+63IyScuxmCxAcFSpy+ZKM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Wr5wQ8BUgFe0b7t4ZQLW3VehmiWz59d953CCAQjD3eCsSpIXsnMkqiRFHUlnZSJf5iz/ykqOZQ+2eQNamlD1tUm86GimTSlpX7gUWPo0UCGScagnhUeLN5sAw2g82UrIArObPHfGalRFI70EwuB9SJvoSvuF1NrTeVwJ2+tqFas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=KSptVbYO; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: c924a144-367a-11f1-bea8-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c924a144-367a-11f1-bea8-005056992ed3;
	Sun, 12 Apr 2026 16:20:41 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id c9237dab-367a-11f1-b5d0-0050569981f5;
	Sun, 12 Apr 2026 16:20:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=t24q5yRxR4yOwoXyL6Wkhw8RZCd6L09pdlxq+MQQ69Y=;
	b=KSptVbYOGwYLaG7QTZ/QEaSWaVtI56Jfi5OW9gLzNKN3jzKkrYDXiWH5vjJIf5XiOdS/d2tr5fLj3
	 yzG6NG6oxAWBnHYy/7wWy8Uw/HuT5d2D/Rjmjh/EllINqGjqd5oNG6PBMibHMlfYZ9fHk/CfudptSA
	 iUmoAmmZ4S3sVr2JITx4E2kqRm3MsoXwqeCxDp6D7l7Pg+0Y2mLmNvBD89mLZuXncXr+9crOjDxlXQ
	 T23BTa7m4rlz/Lbm8Y1SjePm4w5elCc+Op8T0JTy5EEcnJ7dsJBpJZeCg2YXsH+kK398MBg6ffzGsy
	 kSTOZyGl00XzLyLB0HxQKPfqLSHnfrQ==
X-KPN-MID: 33|Zh/4RFIV6k4ahLk3gbS2ptW6g0oikOdKjnbglaPGgRRHZ5S0U7XkSXN2tZuWnYK
 4W8lMdkEow5leHnJcb8DTU62kpjs00x/oz8sVlv8wp0s=
X-CMASSUN: 33|+2xea++xjgjuCBu4Eb2wRKTWrPSXnzwCBcVKCJLM+tJSJ0q2ztY7wkqfha/4n4y
 OLPVOlMVii74itIlsNPxLsw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh07 (cpxoxapps-mh07.personalcloud.so.kpn.org [10.128.135.213])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id c9166a10-367a-11f1-94b1-00505699eff2;
	Sun, 12 Apr 2026 16:20:41 +0200 (CEST)
Date: Sun, 12 Apr 2026 16:20:41 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:MAC80211" <linux-wireless@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Message-ID: <675951732.2051008.1776003641276@kpc.webmail.kpnmail.nl>
In-Reply-To: <538186550596da7b862eb7340047695267f8b71e.camel@sipsolutions.net>
References: <20260401165938.3843784-1-jkoolstra@xs4all.nl>
 <538186550596da7b862eb7340047695267f8b71e.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211_hwsim: change hwsim_class to a const struct
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-34673-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xs4all.nl:dkim,kpc.webmail.kpnmail.nl:mid]
X-Rspamd-Queue-Id: 64CE13E435E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> Op 07-04-2026 15:46 CEST schreef Johannes Berg <johannes@sipsolutions.net>:
> 
>  
> Hi,
> 
> The subject should have a "wifi: " prefix. Maybe we need a MAINTAINERS
> thing for that ...

Sounds like a good idea... I am just guessing because with the cleanup work
I am not familiar with the conventions of each subsystem I am cleaning up in.

> 
> Also, this patch doesn't apply on wireless-next, please respin.
> 

I just saw that it has been already applied.

> johannes

Thanks,
Jori.

