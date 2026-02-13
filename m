Return-Path: <linux-wireless+bounces-31818-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCrvFxFUj2lqQQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31818-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 17:40:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8932138494
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 17:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 642CD3105C9A
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 16:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336BF35FF5D;
	Fri, 13 Feb 2026 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="oUN7c2JS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster2-host6-snip4-1.eps.apple.com [57.103.78.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02623644D5
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771000215; cv=none; b=f7TZUjdIu1P5fVDGBwiB/QQsz1TS1amXDQMqPV88BUaTNmvAhXMwJEjTRMtJH1oVEUw7Jqoxyo5EKGPsDpMsIXABUs7F6i7/Zm3vXpHJ0aa073A/KKBxvx+1tNiMdLPELWdIAbz+JGcpv5TA4E40Wrs0SiKE+j/rEHCJWFzXcXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771000215; c=relaxed/simple;
	bh=0uN39f3SnbOX1xouIr6fJzR6JOCUwXFa+CjA+dbcc6s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=cx2jy8eAwfQWMUKO2Nq+fW3t+ObxzG1izsFpOvG3gSFcpU40GpTiJWYDoDgVXk5XcUOcSHFm2QBqg3+8dOKsEAj38YY9AwQPHzts3FWSizgFAPM2lFqg04F6CjvDvbKt7+zs5+IGlMQdkOq7wB0eHanW8Bcqrej561cNr1IjXcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=oUN7c2JS; arc=none smtp.client-ip=57.103.78.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-9 (Postfix) with ESMTPS id 26525180017A;
	Fri, 13 Feb 2026 16:30:10 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1771000212; x=1773592212; bh=MRVHAIVootlvBPZUtFqj4u8z+cvRGFuBsvHgW7Z/cO8=; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type:x-icloud-hme; b=oUN7c2JStEx+88mkGTsNYJb4y9NpMAhsSU0bAtHyAAeoVgpk18ivELdw3Y7k87WG5SjOB7HzEXCLBhemDIKM0M0S5Br6PA2oU61vuiI69S5/eIqT4fOusok+DTL6CHKP8mg4t4dlnxDbExrHID6vax+PpsFqh+AlwkCgKiCxBDeXmjb5csHYr5BGd7jTq6IUteEs/l6vkTorSETkK5udsVrJJUUXqWDZ0o9hlInpuyGNcyyOOC+oQPvr7S8lE+Vlks8Oot5uzI2F5d4DIr3fwlsB0ZCwh7/RQzf8n9qjibKtRk2b65f75J1NCCFKH7Lo0t1Uxx8wTlpvmNol8T70MQ==
Received: from [192.168.178.84] (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-9 (Postfix) with ESMTPSA id 351AA1800169;
	Fri, 13 Feb 2026 16:30:10 +0000 (UTC)
Message-ID: <a1563657-3b50-4ccf-b4ea-379c2eb4ca66@me.com>
Date: Fri, 13 Feb 2026 17:30:07 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Receiving broadcast data frames in AP mode
From: Yannik Marchand <ymarchand@me.com>
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <af5a5fc2-a7eb-4cb5-ae7e-b9513a7c7153@me.com>
 <fd9f92ac554a3ca706023b8d917b58698bf6e930.camel@sipsolutions.net>
 <c09802fb-bde5-4775-bb24-69f465c638be@me.com>
Content-Language: en-US
Autocrypt: addr=ymarchand@me.com; keydata=
 xjMEaPabDRYJKwYBBAHaRw8BAQdAqVhUaWw00uOlSKhcjIJ9nmcYegKxBkeHwfpr3q/0gCfN
 Illhbm5payBNYXJjaGFuZCA8eW1hcmNoYW5kQG1lLmNvbT7CiQQTFggAMRYhBGV1/w+NFjy2
 RDy1NGHPUKmx2/rHBQJo9psNAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQYc9QqbHb+scj6wEA
 6STZLz2eXGoHx0PcTeOVAWKAK1QxVvpFKrJVnK7WiRIA/jwKcm9bjn4rZzAodKR9ZYTAnG4Y
 Z/6OgtzG8lLEZ00LzjgEaPabDRIKKwYBBAGXVQEFAQEHQA7RgOiIVWNLktblGUsi0cPRvseK
 A5VLVWC2e+B1DxtpAwEIB8J4BBgWCAAgFiEEZXX/D40WPLZEPLU0Yc9QqbHb+scFAmj2mw0C
 GwwACgkQYc9QqbHb+sfg0gD/YT3lpIWIMaiXJ4IJHZzHB5msVCxXqVlEjOjxkeA5kOgBANtO
 ZU7Tv4emRzFbGTmdUHLy95DN8i7oHk7AS84kowoF
In-Reply-To: <c09802fb-bde5-4775-bb24-69f465c638be@me.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: q3NvnF5WCcuzINEoX0u6nyXZZ6mt4cdI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDEyNiBTYWx0ZWRfXz0mPGHAK+9GG
 3L23uFYFli5amoWT8RzpWD1OTpOF5Wln9OC0prI/nuxJv6iKQ4NRbAKdHVULZqcr/UPYQgqDi2a
 Rtmc2LJnl1o9x9p3Go4GRD9cxk7sfVf/3wVJoB7Oduwq0590c/JowdATv01uleYWK7ESVPS6Yh+
 iZvl7y6yRgzJVVND2pq59nUTGPSHJ2eDJPKs6Tv8Xb7x8K+ubHdQlDHJG6In23sH4Tv4xu1tU4r
 kuVi8xZMJhC0voDGt/W9xYDqDUefee2hDJzCoKbhOA/0T9WaqcctQPd9DGwMO62SnkKs3EaAx5X
 rV2CC0X+yPqBFAVL5z6TLbBULMzVxE612myFdDrahhsFN4tJWoM/vR5Mes1fes=
X-Proofpoint-GUID: q3NvnF5WCcuzINEoX0u6nyXZZ6mt4cdI
X-Authority-Info-Out: v=2.4 cv=dKurWeZb c=1 sm=1 tr=0 ts=698f5193
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=x7bEGLp0ZPQA:10 a=tQede41yXXgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8
 a=9AdMxfjQAAAA:20 a=5FR47xWiclKvxG7sTEIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130126
X-JNJ: AAAAAAABhcXUwtQfIOwh4chwUTpcJiyexRSD78Dt0alzT9IR0EbYRrLQQS52vxivSXm75BpYKjlvSvzE5rwNI0oYnQIIAi0CxfbT3jbGkr2QX1v0pY5rMLdVl8sdyXjeTotSPF2jb10VPftYN4NNKYL+PXzGeuwY1n1Ioi56F7WCIxbxVcc0eJ7OOcPZK0RyjsKqSjTjZp2utypzEQHaVBiSyclb2+yhyA+Si0JLAJkf6qwk3Rf+xmvaXqHfIB7opAJofW0DbGNKra7NqHgbpOHy5LLNRZKAP9PpFXtBziNhw9pUnF1ylV0sYwz9/gGZeppogz2stVWF4Qd8K6XmDi7ljyorbDnV5BJtIsaOo55Bfriwj5rmh+V3/kyVRVcuTzlLw5LbXqyGxZKde9b3ue5rZTrHBQTqpzz4rri/nVPY2apHxkwA8GZObmmOEeGdyB0gXpARVMINc3FY+HC5Hc38jbpqmp7M0BVzHnbSSC4SbuzeKy+yNwFqV9uKqYan5NdQ/edn9Iq5kq47aAvETmBr59e1mPt7YtYtCaPWWH5tm0gDgEGe9uqDX4mPyS2IoWwgzLdVYvtWB+SPx14ddjH1UYVmZGDckPFEJsjfjkSpWhz9J0C4AvpVpQ3aZBtyaM8=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[me.com,quarantine];
	R_DKIM_ALLOW(-0.20)[me.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31818-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[me.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[me.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ymarchand@me.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,me.com:mid,me.com:dkim]
X-Rspamd-Queue-Id: A8932138494
X-Rspamd-Action: no action

Update: I have no idea why, but sending all frames to ff:ff:ff:ff:ff:ff 
instead of the MAC address of my Switch seems to have solved the issue. 
It looks like all UDP packets are now being received properly :)

Kind regards,
Yannik Marchand

On 13/02/2026 16:13, Yannik Marchand wrote:
> Hello,
>
> Thank you for these insights. I want to provide a quick status update.
>
> It seems that the protocol is somewhere between ad-hoc and 
> infrastructure mode. When a station joins the network, it must send an 
> authentication and association request to the host of the network, 
> which is similar to infrastructure mode. However, once authenticated, 
> the nodes can communicate directly with each other, which is more like 
> ad-hoc mode. Interestingly, packets from the host seem to have FromDS 
> set, while packets from other nodes in the network have neither FromDS 
> nor ToDS set.
>
> Unfortunately, using an interface in IBSS mode did not work, because 
> none of my hardware supports receiving association requests in IBSS mode.
>
> Later, I learned about WiFi-Direct and P2P. While I initially thought 
> that using a P2P-GO mode interface would make it work, it seems that 
> it suffers from the same issue as AP mode, where broadcast data frames 
> are not received.
>
> Then, I tried implementing the entire protocol in monitor mode. While 
> I have learned a lot, this turned out to be quite hard.
>
> Today, I have finally managed to make it somewhat work. My setup uses 
> three interfaces, which is similar to what you suggested: one in AP 
> mode, one in monitor mode, and a TAP interface. The AP mode interface 
> handles the association and authentication frames. The monitor mode 
> interface handles the data frames. After parsing and decrypting the 
> data frames, the frames are written to the TAP interface, to avoid 
> having to implement L3 as well.
>
> There are still some issues currently. For example, after sending 
> around 12 packets to the Nintendo Switch, the Nintendo Switch seems to 
> stop receiving packets. However, I am happy that I'm getting closer to 
> finding a working solution.
>
> Kind regards,
> Yannik Marchand
>
> On 07/10/2025 11:47, Johannes Berg wrote:
>> Hi,
>>
>>> I have been using nl80211 to implement local wireless communication 
>>> with
>>> a Nintendo Switch device. The current implementation can be found here:
>>> https://github.com/kinnay/LDN.
>>
>> :)
>>
>>> We have run into the issue that we are not receiving any data frames in
>>> AP mode. In station mode it works fine. Inspecting the traffic with
>>> Wireshark in monitor mode showed that the data frames are being sent to
>>> the broadcast address ff:ff:ff:ff:ff:ff. Some research suggested that
>>> the Linux kernel might drop these packets by design:
>>> https://github.com/torvalds/linux/blob/7f7072574127c9e971cad83a0274e86f6275c0d5/net/mac80211/rx.c#L4443. 
>>>
>>
>> Yes, a real AP will never receive broadcast data frames, since it
>> controls the BSS and all traffic flows through it. In fact, hardware or
>> firmware would likely filter them as well, so even removing this check
>> may not address this for all devices.
>>
>>> Currently, we are wondering if it is necessary to switch to adhoc mode.
>>
>> That might not be a bad idea, but then you don't have control over which
>> station is sending beacons - though I guess if you actually have
>> multiple Linux hosts it wouldn't matter so much?
>>
>>> This would be inconvenient, as not all devices support adhoc mode,
>>
>> Not all devices support AP mode either, and see above wrt. filtering, so
>> I think either way you don't have some devices.
>>
>>>   and I
>>> am also not sure how adhoc mode can be used correctly. We do need to
>>> send beacon frames, and process association requests, but
>>> NL80211_CMD_START_AP and NL80211_CMD_SET_BEACON seem to be unsupported
>>> in adhoc mode.
>>
>> I don't know what you need from the beacon - almost sounds like not much
>> - so might not need SET_BEACON rather than JOIN_IBSS. Managing stations
>> from userspace is supported for secure IBSS though, wpa_s implements
>> that.
>>
>>> * Is it correct that there is no way to receive broadcast data 
>>> frames in
>>> AP mode?
>>
>> Well, we could hack out the check, but it wouldn't necessarily fix the
>> issue. So I'd say generally, the answer is yes.
>>
>>> * Is there any documentation or example code on using adhoc mode with
>>> nl80211?
>>
>> Only whatever is in wpa_supplicant for secure IBSS. I don't think the
>> 'secure' part is really a requirement, but it's been ages.
>>
>>> * Any general advice on moving forward?
>>
>> In the past you could maybe have used 'cooked monitor' but we removed
>> that, so now I guess the best you could do in AP mode is to add a
>> monitor interface (you already say that's how some frames are
>> transmitted, though that doesn't actually seem necessary) and listen for
>> the data frames there? If the hardware/firmware actually receives them,
>> you should be able to see them there. If not, well, then it just can't
>> work in AP mode anyway.
>>
>> (I suspect, for example, that Intel hardware generally won't give you
>> the frames, but I haven't tested it now.)
>>
>>
>> In a way the bigger question is what do the consoles expect from the AP?
>> Do they, for example, go into powersave and expect traffic to be
>> buffered for them? Because in that case IBSS won't work anyway, and it
>> seems a bit hard to imagine they wouldn't...
>>
>> Or could you maybe simply not care and always make one of them the AP,
>> perhaps unless there's no real console anyway, and then you have no
>> powersave expectations on the Linux side from IBSS?
>>
>> johannes
>

