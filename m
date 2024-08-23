Return-Path: <linux-wireless+bounces-11865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE4595D464
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 19:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D942887DF
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 17:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E42A1925BB;
	Fri, 23 Aug 2024 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="HH0NINhU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EDD192597
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434432; cv=none; b=u863cnv0w2Q52+hGLmQkiTVIbKVJxc4ltTY0pzOjCzMNJ3P1GIMkvZXxfmEa7g9Kgtow9vVbRrhCfNHXPxhZYETpqeE2EHyRfKQfmkcyseF5ZekuQ8uFRKyaMrmDyyOq+2Xm+Ywrndo7RovBk83y3PTJXclmkB7GdMQ8nxVkI70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434432; c=relaxed/simple;
	bh=ytBtQlWPbg17M3b9oexKQN2y4mOyTkvusS+wSsqy7HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ekzqiggb5hMMJQVgsHaV46/kfK7j0wRLz0aGM6bE0e/XKd3r2ywqgemCZovIUIP73c5rjHtIDWYQdRdacyn3yecArlAl4EwBrjiHmFJ4jKOxzLWHkZID7mMp7o+TvYZy2ka7UcoRg39cTrjKGcCuxZqseEK1lbOnYPk+GiBdl+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=HH0NINhU; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EUtqJj9EPxmaaQl1nb4RqQiRp1N67hOowIRE/L6NAFw=; b=HH0NINhU2UQJH7R6QFbN4P2Oqg
	uuE0RUL6784UrigPnB9cAR59kxxt3D+krqwHxbQMQ3cLjRcjrcdR/SpNctwG3jW2naixNvcHZsbxH
	vqvR7GFpSWDK0fsZIj2Afi9MUgKb4pWEDo/1VVKcdIINYS6vMxfC9ps3oQDLgFg2KEFE=;
Received: from p4ff13de3.dip0.t-ipconnect.de ([79.241.61.227] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1shYAV-00310h-2J;
	Fri, 23 Aug 2024 19:33:47 +0200
Message-ID: <bae46387-ad36-4541-838f-8cbab20557a5@nbd.name>
Date: Fri, 23 Aug 2024 19:33:47 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 6/6] wifi: mac80211: check vif radio_mask for monitor mode
 rx
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
 <7d713206957ec56dc297d5645203b45341578588.1722885720.git-series.nbd@nbd.name>
 <01d7528bc15ee682fbe2f200bdbf39066b39309a.camel@sipsolutions.net>
From: Felix Fietkau <nbd@nbd.name>
Content-Language: en-US
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <01d7528bc15ee682fbe2f200bdbf39066b39309a.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.08.24 12:23, Johannes Berg wrote:
> On Mon, 2024-08-05 at 21:23 +0200, Felix Fietkau wrote:
>> When restricting a monitor vif to only operate on a specific set of radios,
>> filter out rx packets belonging to other radios. This only works if drivers
>> fill in radio_valid and radio_idx in the rx status.
> 
> Why does the driver need to provide the radio, it already provides the
> frequency?
> 
> But then I wonder if this doesn't go a step too far? This is pretty much
> pretending that monitor only exists on a specific sub-radio, but ...
> what for? Even userspace could filter on the frequency.
> 
> I mean ... I get that you're trying to preserve a notion that you had
> that an interface exists on a given PHY and they're all separate, but
> they're not really separate any more, get used to it?

Well, there's a performance aspect as well. When only monitoring 
specific radios (while operating normally on others), relying on 
filtering in user space or even BPF comes at a cost, since mac80211 
still has to prepare radiotap headers and potentially clone data packets 
received on other radios.

- Felix

