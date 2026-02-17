Return-Path: <linux-wireless+bounces-31954-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCq5DpmBlGniFAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31954-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 15:56:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4294214D56B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 15:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B56D3006982
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C6836C0CE;
	Tue, 17 Feb 2026 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="HBB1lUmZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from outbound.ms.icloud.com (p-west3-cluster2-host12-snip4-10.eps.apple.com [57.103.74.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7690536B057
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.74.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771340174; cv=none; b=kFiDN+fWcor5kS3qHnMAEBbAW1x3e2PyeK0AZ9av7MAAUCp/mc4tk3YtjzR04HJueKWxBAB7vuIkWofPQwkxKoXviL4SHid9SeV2LeD6s3aPTmMMPhtOXggxXc1hOFUxYi1jXxfi+7F9mO9S8psM+9wn8gv9sEURNbuI7qw+3dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771340174; c=relaxed/simple;
	bh=f/T+CXwYrPXcfxHkize2jcK1HM2obUgAnSNDL8bMoAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ckz7WsXk9bFYXIVpc01eoapVJozVGWjbZJ9r0j24pegCi+ZgpxwiHPO2wh+KmIUViFL6/s8jKBM5eco3BGJ+cp5rEJh6e/X6MeZJXpAKofpxFU5+91YmCFjMZTdWqfbP/0X/lWLK0+FkfU0CeVGSsLPDnbSOnk2Kw9cLIKsHwU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=HBB1lUmZ; arc=none smtp.client-ip=57.103.74.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id D86651802349;
	Tue, 17 Feb 2026 14:56:10 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1771340172; x=1773932172; bh=nyAm/lqs02Ql1AreGJxUCig2t/A5VOG4n2OrRnqF+To=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=HBB1lUmZhjmmryr6iXBJRcfLbyPSBAzzfam27mqTD7cIEfXbm+IensyRT/SNAZ8D3oAMqOD/ZdzgTA5qlsv/3DADPr1msHXOet9L2ipFeDKwBko8S8X0VSr/HCFgWtSNqU919kmBUkA2qOLlqPzrxPZRhjz6iyYp/px8CQy46gWzPpJoOaDRHJztpV6SK24uIXaD4CPXDt0M1/TUQhskBc9CP1XyKq1M+Z6tqy8C6eZks9rrZ4xSKzQywUc0yRTWc3mb17v4r1HeoFJkpdoUbC9x5pGeQra5P4Vu8igAV5xCFtfKcFs5uV9LzLGTf9K6BZwwdmAyhUUWTdLrYF/n/Q==
Received: from [192.168.178.84] (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id 9710D1802356;
	Tue, 17 Feb 2026 14:56:09 +0000 (UTC)
Message-ID: <7ce3efae-ad08-4fe4-b3c3-f1340c213a22@me.com>
Date: Tue, 17 Feb 2026 15:56:07 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Receiving broadcast data frames in AP mode
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <af5a5fc2-a7eb-4cb5-ae7e-b9513a7c7153@me.com>
 <fd9f92ac554a3ca706023b8d917b58698bf6e930.camel@sipsolutions.net>
 <c09802fb-bde5-4775-bb24-69f465c638be@me.com>
 <a1563657-3b50-4ccf-b4ea-379c2eb4ca66@me.com>
 <bb63abe8c61a02afd67921934e15c6a943a12fba.camel@sipsolutions.net>
Content-Language: en-US
From: Yannik Marchand <ymarchand@me.com>
Autocrypt: addr=ymarchand@me.com; keydata=
 xjMEaPabDRYJKwYBBAHaRw8BAQdAqVhUaWw00uOlSKhcjIJ9nmcYegKxBkeHwfpr3q/0gCfN
 Illhbm5payBNYXJjaGFuZCA8eW1hcmNoYW5kQG1lLmNvbT7CiQQTFggAMRYhBGV1/w+NFjy2
 RDy1NGHPUKmx2/rHBQJo9psNAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQYc9QqbHb+scj6wEA
 6STZLz2eXGoHx0PcTeOVAWKAK1QxVvpFKrJVnK7WiRIA/jwKcm9bjn4rZzAodKR9ZYTAnG4Y
 Z/6OgtzG8lLEZ00LzjgEaPabDRIKKwYBBAGXVQEFAQEHQA7RgOiIVWNLktblGUsi0cPRvseK
 A5VLVWC2e+B1DxtpAwEIB8J4BBgWCAAgFiEEZXX/D40WPLZEPLU0Yc9QqbHb+scFAmj2mw0C
 GwwACgkQYc9QqbHb+sfg0gD/YT3lpIWIMaiXJ4IJHZzHB5msVCxXqVlEjOjxkeA5kOgBANtO
 ZU7Tv4emRzFbGTmdUHLy95DN8i7oHk7AS84kowoF
In-Reply-To: <bb63abe8c61a02afd67921934e15c6a943a12fba.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Info-Out: v=2.4 cv=dtfWylg4 c=1 sm=1 tr=0 ts=6994818b
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=x7bEGLp0ZPQA:10 a=tQede41yXXgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=NEAV23lmAAAA:8 a=cS_Li2As19g3O7u3qZ8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nf_k9WArwwVBGAcjy-YZEwBaq1JEWJiZ
X-Proofpoint-ORIG-GUID: nf_k9WArwwVBGAcjy-YZEwBaq1JEWJiZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEyMCBTYWx0ZWRfX++JM1g3RGCYR
 GtAe/zEzZGCkJ47rNOm6Cg/AT16Kz6dBBp66YjOgwuMnTT+9sfyLFeZa4Kd9KRlZ2LyX5JOMCQ5
 OSqbusMz1mesrBM+rAvfZwq0OryvWI1L5tVesFcGz3qIvpdZhNvjAU6AsiUrzgEbeg1pL0Nz9qH
 rMsFpOTvjDPt8SsF5jhHSK9vZ+ST8KkXq7Wh4I9rtEKajCLXOTy4yxKH/XjsEo/FIbThuWXNmsn
 cAvLZXW3FLh2B7op3wYSenJegyLfzOwxrWvc6BjZ6qjEXZoAnqqjYPhHarZyETa5abAV+ZvjG3o
 Z4V50N7SskZwQs1408OSl+TN4pjoqZdBnPzH3JYeOj4Y3Atg1SchnGXgz/FZTw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_02,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170120
X-JNJ: AAAAAAABsl+CN6D+uPDhp9f4ZKf7ZPj5twcxZcsDceQ3SZGggahtBkogPF+SePaOX9Xm9oR7gbQ/M/A3sZirzvxS4nQPo+rSckxBcDBHU9PtyoaLHay+hdn11sTOvzJKgXel8ugKtajNENM8TCcmSsMSz9Q8DVutN4GzeTmEsiClNrid7oTNw/bo86XFgNfe2YbLuUgbcjENhIrXUyoiAtGvMexEnxxmptvpuvRqATy6H4Pc9jRJP+3/aU6DOuy3NEKUXjobq6qZVM6I2489s6vWsfOH333lYs8779VfCOkjFEnOCSWfddsOM+5qYogYW7McEXIt8HjF4bRXQgm8RcNb3G/gMzHlQIDg0dWJ/f3Jyzd1SsEsbMIaDvcDKsX+c+xRk8xS60+Xi5pgWUCmNeGigFlbhAsAeOlq8pjjLi0spkJ+vN80Rrx+z9h04jxAcuLzGLbOvjKH529U2B/Ah0UuDC2dhvIXXdUtcaGgcwcpZJQnIN2RzbB875+oaJ3mnb1yKbcF6BDlmHnhFymwVuIYUV5B4wYlQmpIbbJPkdXUK51+Wxh34aEup+eiSOYdTDeJKi+lHsF+TD4Cinls75uJtPw+BsueDUjYoZd4z4+IwT8fyXsJJdggjAFE2TFV1IsViN/8MvRWJXhHK3GgHGKEYYo=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[me.com,quarantine];
	R_DKIM_ALLOW(-0.20)[me.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31954-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[me.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[me.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ymarchand@me.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,me.com:mid,me.com:dkim]
X-Rspamd-Queue-Id: 4294214D56B
X-Rspamd-Action: no action

Hi Johannes,

 > Cool story. For some reason your emails never made it to the list it
 > seems? I'm replying privately because of that.

That was a mistake on my side. For the first email, I used "Reply" 
instead of "Reply All", and only realized that after the email had 
already been sent. For the second email, I accidentally sent it with 
HTML instead of plaintext (it might have been rejected for that reason).

 > I actually have a Switch 2 now, so I guess I could theoretically try
 > out some of these things - though I don't have a lot of real WiFi
 > hardware.

That's cool! I didn't know that you are interested in Nintendo games.

I am running most of my experiments with an ALFA AWUS036ACM currently, 
because my old laptop had an Intel chip, which (as you mentioned) 
filtered out too much. My new laptop has a MediaTek chip, which seems to 
work mostly fine. So, whether you need "real WiFi hardware" probably 
depends on what you currently have.

 > Have you heard of Ferris on Air?

I didn't know about FoA. Currently, I don't really have the time to port 
my implementation to a different stack, but it might be interesting if 
we run into more issues later on.

 > This is ... odd. Is there encryption? I can't imagine why they'd throw
 > away non-broadcast packets.

Yes, all data frames are encrypted with CCMP with a key that is derived 
from information in the action frame. The interesting part is that the 
first few packets do arrive at the Nintendo Switch, which makes me 
believe that my encryption algorithm is correct. After I found that 
using the broadcast address solved the problem, I have not investigated 
the issue any further.

 > That sounds pretty awkward!
 >
 > ...
 >
 > So there really is no good default mode to implement this in, and
 > while we could add a "nintendo mode" to the kernel, it'd be unlikely
 > that hardware/firmware implements it?

It was quite difficult indeed :)

The biggest issue has really been the filtering, namely:
* Dropping broadcast action frames in station mode while being 
associated with an AP.
* Dropping broadcast data frames in AP mode.
* Dropping association frames in IBSS mode.

The first issue seems to affect mostly Intel hardware, while the other 
two issues affect all my hardware.

Of course, it would be nice if this could be solved in the kernel, but 
I'm personally not familiar enough to judge whether this is possible, or 
whether it would require support from the hardware vendor.

(also, I'm leaving the previous emails quoted below in case a mailing 
list user wants to catch up)

Kind regards,
Yannik Marchand

On 17/02/2026 13:40, Johannes Berg wrote:
> Hi Yannick,
> 
> Cool story. For some reason your emails never made it to the list it
> seems? I'm replying privately because of that.
> 
> I actually have a Switch 2 now, so I guess I could theoretically try out
> some of these things - though I don't have a lot of real WiFi hardware.
> 
> Have you heard of Ferris on Air? I've been in contact with one of the
> people involved in that, might be kind of interesting to interop with
> the switch from that ;-)
> 
> https://github.com/esp32-open-mac/FoA
> 
> 
> On Fri, 2026-02-13 at 17:30 +0100, Yannik Marchand wrote:
>> Update: I have no idea why, but sending all frames to ff:ff:ff:ff:ff:ff
>> instead of the MAC address of my Switch seems to have solved the issue.
>> It looks like all UDP packets are now being received properly :)
> 
> This is ... odd. Is there encryption? I can't imagine why they'd throw
> away non-broadcast packets.
> 
>> It seems that the protocol is somewhere between ad-hoc and
>> infrastructure mode. When a station joins the network, it must send an
>> authentication and association request to the host of the network,
>> which is similar to infrastructure mode. However, once authenticated,
>> the nodes can communicate directly with each other, which is more like
>> ad-hoc mode. Interestingly, packets from the host seem to have FromDS
>> set, while packets from other nodes in the network have neither FromDS
>> nor ToDS set.
> 
> IBSS (ad-hoc) can use authentication, but it's between each pair of
> devices, and not association I think, so it's indeed different. But I
> seem to remember from some (your?) documentation that the controller or
> host has some kind of beacon with the list of members, so I guess that
> makes some sense.
> 
>> Unfortunately, using an interface in IBSS mode did not work, because
>> none of my hardware supports receiving association requests in IBSS mode.
> 
> Curious that any hardware would even bother filtering. Though Intel FW
> does maybe filter, the folks working on those lower levels are a bit
> overdoing it sometimes ;-)
> 
>> Later, I learned about WiFi-Direct and P2P. While I initially thought
>> that using a P2P-GO mode interface would make it work, it seems that
>> it suffers from the same issue as AP mode, where broadcast data frames
>> are not received.
> 
> Yeah APs don't receive real broadcast data frames, so stands to reason
> they would drop those as useless.
> 
>> Then, I tried implementing the entire protocol in monitor mode. While
>> I have learned a lot, this turned out to be quite hard.
> 
> No surprise I guess.
> 
>> Today, I have finally managed to make it somewhat work. My setup uses
>> three interfaces, which is similar to what you suggested: one in AP
>> mode, one in monitor mode, and a TAP interface. The AP mode interface
>> handles the association and authentication frames. The monitor mode
>> interface handles the data frames. After parsing and decrypting the
>> data frames, the frames are written to the TAP interface, to avoid
>> having to implement L3 as well.
> 
> That sounds pretty awkward!
> 
> I guess your hardware then has some kind of extra "allow monitor"
> though, because it seems to receive more in the combination of AP +
> monitor than in pure AP. Intel hardware still wouldn't.
> 
> So overall this seems pretty awkward to implement over general purpose
> WiFi chips since you have conflicting requirements:
> 
>   - need beacon transmission and the timing
>     (normally IBSS, AP/P2P-GO, mesh)
>   - need auth/assoc handling
>     (normally AP/P2P-GO)
>   - need multicast data RX
>     (normally IBSS, client, maybe mesh)
> 
> So there really is no good default mode to implement this in, and while
> we could add a "nintendo mode" to the kernel, it'd be unlikely that
> hardware/firmware implements it?
> 
> johannes


