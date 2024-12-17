Return-Path: <linux-wireless+bounces-16472-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC6D9F4B10
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 13:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8118C7A3F5E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 12:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8A51F12FA;
	Tue, 17 Dec 2024 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iz0FwkVn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6C71D47D9;
	Tue, 17 Dec 2024 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439091; cv=none; b=MLIzu1BjizkzkFAhVS8C8dzz/KM9VgVsaod4im/hHDPa7kXHcCQuvYuSDsm97nGYZKaayrxd48bFKMjmReWDMT6l6t10KS91P25vbS2qT0rCbqNYvY6MzkpRxyA41jQT4q8KNrwvoX5QMuROmy2yJp3EnItKeHx1Zkr/Si+Tpto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439091; c=relaxed/simple;
	bh=PKeJ3zJJK1lWuXvjotJPwclyxHWk97zOS1saNeHsrAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NC4+YCj57hYr/nwh8MH0Nv3rUvOllrVZQRtE3AhqK4uyP/LonbEtxlHiREfOC3MpPvsE4jgr58IfcGZpnAv2SAH+R8YM7JgWPkV3X1k5cMwbHsDbw4S7JPB0NffkFygBC7ZFk/OBdNFzXDlDbAOF+IQTE49FrSWqkDPgbTQqTrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iz0FwkVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E30C4CED3;
	Tue, 17 Dec 2024 12:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734439091;
	bh=PKeJ3zJJK1lWuXvjotJPwclyxHWk97zOS1saNeHsrAw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Iz0FwkVn//6Gyd4X4RdFwtlJFM5LAODVSy58IbTVpAls7fAbVon9f0EqbWWmrkFQC
	 WoMMF9LX3Wkt3S4A6uNnzY4J0CFctqZgMh9bp+p2mo+Iy/naz4PZTrckXMh621pQNA
	 gieH53Hj4HJ55ecu5j12Ur3o3/PuKSz1Aw4mSUr0BiJvuBImIBbylIuSh+UetHTcaO
	 01jnRc68cJbMUXtt1t7DmjKyd2XJr15FkZGC42CkY3L/dFuOMRF0UBXuINJsfzm0DT
	 MQK1dxio2Bc2/tEU1h2kEUl3Y/WPZjKkkTCBNcziTYTpxMVV5KwKjbEeD+f3HxosqZ
	 bD/MqgIy3U1Cw==
Message-ID: <df71bc43-86c4-43ed-90df-d0ba0fe036ae@kernel.org>
Date: Tue, 17 Dec 2024 13:38:05 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug] Deadlock between rfkill_fop_write() and
 nfc_unregister_device()
To: Johannes Berg <johannes@sipsolutions.net>,
 Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, pabeni@redhat.com,
 kuba@kernel.org, Eric Dumazet <edumazet@google.com>, davem@davemloft.net
References: <CAEkJfYOyWgJW-WAd+GhT07zd2Y3vUWz81+pjbZT9nUAsCc7FGQ@mail.gmail.com>
 <b27dc4d0c3456c6796437b26b887b931d9871977.camel@sipsolutions.net>
 <de5d98be99086a7182ba2bd0676b261349a145c4.camel@sipsolutions.net>
 <CAEkJfYP297P=RjvZ9-ctpYHXu7bDhVN0+ZBoMNz2xjzyqOakLQ@mail.gmail.com>
 <70f796f623a67b283c4fe3a1b56e59647a39ce6c.camel@sipsolutions.net>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <70f796f623a67b283c4fe3a1b56e59647a39ce6c.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/12/2024 13:09, Johannes Berg wrote:
> On Tue, 2024-12-17 at 20:01 +0800, Sam Sun wrote:
>> On Tue, Dec 17, 2024 at 7:33 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>>>
>>> On Tue, 2024-12-17 at 11:46 +0100, Johannes Berg wrote:
>>>> On Tue, 2024-12-17 at 17:33 +0800, Sam Sun wrote:
>>>>> Dear developers and maintainers,
>>>>>
>>>>> We originally encountered a task hung while using our modified
>>>>> syzkaller. It was tested against the latest upstream kernel. We
>>>>> analyzed the root cause and pinpoint the kernel crash log to the
>>>>> following two tasks.
>>>>>
>>>>
>>>> This issue has been known a very long time and should be fixed in NFC,
>>>> but I guess nobody is around to do it.
>>>>
>>>> https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
>>>>
>>>
>>> I think this one is also the same:
>>>
>>> https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
>>>
>>> and that's much older still.
>>>
>>
>> Thanks for your quick reply! I am sorry that I didn't double-check the
>> call stack of historical bugs reported by Syzbot. I will be careful
>> next time.
>>
> 
> No worries. Maybe someone who feels responsible for NFC will wake up ;-)

Patches are welcomed. The NFC stack was full of deadlocks, races and
uses-after-free. The only consolation was that all of them were
triggered by the virtual device driver, not real world cases. Many
syzkaller reports were eventually fixed, but I guess many are still open.

If anyone wants to take the responsibility for NFC in terms of actually
developing and fixes the stack, go ahead, because I have time here only
for reviews (and these are still behind netdev timeframe expectations).

Best regards,
Krzysztof

