Return-Path: <linux-wireless+bounces-33819-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFZFCeGcw2l4sAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33819-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 09:29:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5733216BB
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 09:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CC49305FDB4
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 08:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35724394794;
	Wed, 25 Mar 2026 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="cBelVIw8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB4230C35E;
	Wed, 25 Mar 2026 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774427215; cv=none; b=K0ztXBjyZWlH8vYBbVNR+rERfkb9vBCVyGDJEV0US01nYgFVnVpuebk1LIOiEZmRSfm/OZvsX7Zuw31W9qh0hXxTHrninGfhJPNkul8r6Emqwz9eO2M9ckwJXBuA7A1lAjJ8+1LpuouGioKEu11xfIjK8d7Tz6nUkZS8xuxaMHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774427215; c=relaxed/simple;
	bh=lJ+PZW1raNeYt7gcL9WHcmE1ba9Gl9OjuK6BDBqX1OI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8GaeE9hT2vc10/uro6yjXvAju32gH50WYGfvwWkJlIbC8cIILUe5AqamMgEvxISbP3/6875Hkf6S0KsE4Uql07jLGeSw+ihaJrxt9/AA8euTjN3avojftST7BG+QSHYZQiaUBGJj/L3OA7ehnp3NwPsAglZd9jbnIJkVRT16YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=cBelVIw8; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tNI7xHAkR8uTlWulPCohhQA6hyuKOQGa33GqQhmBZRU=; b=cBelVIw83R4mlNFfEA3fN1aYf+
	wu0Z3eNl9bfT0qi892NqgIGKfw7zRu/CQP/OtQaRuPHwdLhPHAFvGCjA1X0VXl9l7tfWGqyWO3uLi
	/3JACBljLkRzPY2H9x2K8VnjZLgRs66ggbnROeeVPx9ioTDcsObvcR12iRXOUxKUhfPU=;
Received: from p5b0152aa.dip0.t-ipconnect.de ([91.1.82.170] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1w5JZg-00BvtN-31;
	Wed, 25 Mar 2026 09:26:48 +0100
Message-ID: <9d43bcd8-2ea0-4c42-b0c5-341c7140bb11@nbd.name>
Date: Wed, 25 Mar 2026 09:26:48 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull request: mt76-next 2026-03-23
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless <linux-wireless@vger.kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <bf6858fc-98f0-4523-bca4-8da7ecf3738c@nbd.name>
 <3d2f9e4d3f06f93e8eb191ade69f4b43752a36bf.camel@sipsolutions.net>
 <6bd3cee4-5f9a-4af9-af42-c1ea3cbe54c3@kernel.org>
Content-Language: en-US
From: Felix Fietkau <nbd@nbd.name>
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
In-Reply-To: <6bd3cee4-5f9a-4af9-af42-c1ea3cbe54c3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33819-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[nbd.name:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.920];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nbd.name:mid]
X-Rspamd-Queue-Id: 0B5733216BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 25.03.26 08:27, Krzysztof Kozlowski wrote:
> On 24/03/2026 16:24, Johannes Berg wrote:
>> On Mon, 2026-03-23 at 10:33 +0100, Felix Fietkau wrote:
>> 
>>> The following changes since commit 9ac76f3d0bb2940db3a9684d596b9c8f301ef315:
>>>
>>>    Merge tag 'wireless-next-2026-03-19' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next (2026-03-19 15:30:20 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://github.com/nbd168/wireless tags/mt76-next-2026-03-23
>> 
>> [...]
>> 
>>>        dt-bindings: net: wireless: mt76: add mt79 PCI devices
>>>        dt-bindings: net: wireless: mt76: clarify backoff limit usage
>> 
>> OK I have no idea what happened here, apparently Ryder has a super
>> messed up email setup that ended up sending different versions with the
>> same Message-Id, so the lore archive is a big mess ... whatever is going
>> on there, please fix that.
>> 
>> But given what I _can_ see about these patches in the archive, I don't
>> want to pull this now unless I get a clear ACK from DT maintainers.
> 
> I don't get what is the question to DT maintainers here.... but there
> are no such two commits in the next and I do not see Acks from DT
> maintainers on the list.
> 
> Why were they applied without Acks? And why the nbd168 tree where they
> are applied is not in the next?

I accidentally pulled them in earlier with some other changes, but 
removed them from my tree again after Johannes pointed out the issue.
v2 of my pull request no longer contains them, so they're not on the way 
to next at this point.

- Felix

