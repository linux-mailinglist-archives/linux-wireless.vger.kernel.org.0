Return-Path: <linux-wireless+bounces-15300-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4088D9C8E6A
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 16:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED351287F35
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 15:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D4913B2A9;
	Thu, 14 Nov 2024 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="NndA33Pw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04C018A6BA;
	Thu, 14 Nov 2024 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598237; cv=none; b=dLIA9D1lDTionSqeGnT37SDyqsPbpbxD8PyYkgEOBbOzb3cWkVHBsWQMHqFRQ0oJy1FjDD3x0HkUOVCKvqWYCJufKBG8dncw/y+P6eEnNub4ExOZAbRbwz+fTGLBfd78axtk51GupaJRim8F2fICI3nMrZlqEwmgWXWvAeUj+AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598237; c=relaxed/simple;
	bh=qZiKV0+6QDDCtW6IqjpULB90ofrK+M5LBpGFXUjgAA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/N3cwPQte5iu45DFrThehEMriDRXGGuvj8Pvqk41CMoZx8G3FDL27QGxSwUUfnVEEwoIa20/cQrbMZLthTGexGEaI7xZXrSiczOTHB4DDe80ANFvuPeBJ7NQdXuM21dbXbt1bISvSJqjcTM6AZuwWFd5qY08UxGlR8yelYPxxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=NndA33Pw; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=slbHfkzq0dOLGn7Z6Pl1KwEvCqv2cRrk2pL7ax3lrLQ=; t=1731598235;
	x=1732030235; b=NndA33PwvQV8qIil3qado+cqV46jvhdiiQEMrlYiRrWjiisHTJV0pb6AaetNT
	L9Y4w6aga5JA/2YKczFSae2DP5OmxGyanAv6i7R/rG0cTPTUvq1aikYOC3rTIwSHhH6EJuqE8w+LJ
	VACGcNZfTOUBbLoqMVnMXyfDznhbrGxpNtLlbs52zC7Lp+iPT5z1N2shYW1VVl8OlVlOVrq4Fvdwu
	uDpItqBrvhSKpaSnbRiIU/bqRDZCiqAGLDKnO9az8LTsDYYF5PO2bgsYmEQh3cukRO/MW/KP7OBqt
	vkVR18ueW0F2YReW+/67jn0r6SNxRubwINwHfhNdaABvZ0zNpA==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1tBbnf-0004is-Gv; Thu, 14 Nov 2024 16:30:27 +0100
Message-ID: <8a647709-8c33-4ac9-92da-bbf83ae2ed93@leemhuis.info>
Date: Thu, 14 Nov 2024 16:30:24 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] The iwl4965 driver broke somewhere between 6.10.10
 and 6.11.5 (probably 6.11rc)
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: Andrey Batyiev <batyiev@gmail.com>, linux-wireless@vger.kernel.org,
 Greg KH <gregkh@linuxfoundation.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Kalle Valo <kvalo@kernel.org>, Alf Marius <post@alfmarius.net>
References: <60f752e8-787e-44a8-92ae-48bdfc9b43e7@app.fastmail.com>
 <87wmhg61yp.fsf@kernel.org>
 <CAEQQxWx7PXw3O_j1FWn7G+DhUUXt3sEB0qDyA2+udRQ6r28FUA@mail.gmail.com>
 <4f689121-f2c1-45ec-bd5b-105a770af935@app.fastmail.com>
 <87ttcauv7x.fsf@kernel.org>
 <5f64abc6-017f-4283-bf08-dba1aea28e9d@leemhuis.info>
 <9fa869ddec6c22c0bb299676e27b7b33d3e3b5d7.camel@sipsolutions.net>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-MW
In-Reply-To: <9fa869ddec6c22c0bb299676e27b7b33d3e3b5d7.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1731598235;cb057059;
X-HE-SMSGID: 1tBbnf-0004is-Gv

[adding Linus to the list of recipients in case he want to clarify
things or pick up the revert in question directly; also CCing Greg due
to the stable aspect JFYI]

On 14.11.24 10:52, Johannes Berg wrote:
> On Thu, 2024-11-14 at 10:24 +0100, Linux regression tracking (Thorsten
> Leemhuis) wrote:
>>
>> Sigh.
> 
> Please. You really should consider adjusting your attitude on all this. 

My approach/attitude is based on actions from Linus and/or what I expect
he wants me to do, so let's bring him in to give him a chance to state
if I went to far here.

Linus, Johannes' reaction was due to this mail of mine:

https://lore.kernel.org/all/5f64abc6-017f-4283-bf08-dba1aea28e9d@leemhuis.info/

To quote a bit more than Johannes did:
"""
>>> I sent a revert to fix this:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?id=11597043d74809daf5d14256b96d6781749b3f82
>> 
>> Many thx for taking care of this!
>> 
>>> If all goes well this should be in v6.13-rc1.
>> 
>> Sigh. FWIW, I think that should have gone straight to mainline, as the
>> situation afaics is quite similar to this one where Linus clarified that
>> he wants such fixes even at this stage of the cycle:
>> 
>> https://lore.kernel.org/all/CAHk-=wis_qQy4oDNynNKi5b7Qhosmxtoj1jxo5wmB6SRUwQUBQ@mail.gmail.com/
>> 
>> Given that this is a hardware that likely is not much in use any more I
>> guess it's not making much noise about besides this mail.
>> 
>> Alf: that patch lacks a stable tag, so there is no guarantee that the
>> fix will be backported to 6.12.y and earlier; but it likely will due to
>> the Fixes tag. If it wasn't backported within 2 weeks after 6.13-rc1 is
>> out, please speak up.
>> 
>> Ciao, Thorsten
"""

BTW, the fix in question can also be found here:
https://lore.kernel.org/all/20241112142419.1023743-1-kvalo@kernel.org/

> Do you _actually_ think that everyone is just out to make everyone's
> life difficult? Because you certainly consistently make it sound like
> it. It takes time to get something into the kernel, it's not like we can
> just commit it to Linus's tree.

Well, Linus is known to have no problem at all with picking up fixes
straight from lists if there are good reasons (like the unlucky timing
we have here), as long as that does not become the norm. That approach
was actually used in the situation I pointed to, as it really is quite
similar.

And it might be the right thing to do in this situation as well, as then
the fix for this regression from v6.11-rc1 will reach 6.12 -- and likely
also reach users of 6.11.y stable releases within a week, as Greg likely
will pick this up quickly and usually publishes new stable releases at
least once per week.

If the revert is only merged during the merge window, it will likely
take the fix at least two weeks more to reach end-users, unless somebody
asks Greg "please pick this up now" once it reached mainline. Three
weeks if we for some reason get a 6.12-rc8. And if the fix is not in the
first batch of fixes picked by Greg after 6.13-rc1, there might be even
one more week on top of those outcomes. So four additional weeks if we
are really unlucky.

Things like that bother me -- and thus, yes, sorry, also influence my
attitude, which lead to the quoted "sigh". It's just that "fixes are
there, they just take a long time to reach mainline and stable releases"
is the biggest problem I see during my regression tracking work.

The problem is, that bring this up in situations like this is making the
"maintainer burnout" problem worse. I hate that and feed sorry for that.
But well, ignoring this sounds like the wrong solution as well. I could
write private "hey Linus, I think the following regression is not
handled well" mails instead. But Linus already has a lot on his plate as
well. And people call me a snitch if I do that. Hmmm. :-/

Ciao, Thorsten

