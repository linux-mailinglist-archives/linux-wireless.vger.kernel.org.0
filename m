Return-Path: <linux-wireless+bounces-13050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7014B97D4E2
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 13:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B638CB23721
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 11:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9596B143866;
	Fri, 20 Sep 2024 11:36:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4BD13D28A
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726832163; cv=none; b=Wjf+lnqu9Ot5Ah1kqcudrhz8a3CZpt5DHj0O1sDY1y3WnOguItHRGn0hL/AcVELlZpr+XqqSlJO5rvgCVVgAyMoZF48exYEXGOY48LO+2wPWk/mSQqZnBcPa/EAhZSjcxUHWu0EJ0uzmiZBD5kG7xZDwfRtZyVrWljhFPqVDIUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726832163; c=relaxed/simple;
	bh=o143WjtJEy6D6BS/T+DZI0lnzFQW5PCaHEC/ZJHF92g=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=rG9c2WEQVBVsmfFEoZtOdqDzdlF8or+ltM3HPmH9jyjV6MrVv97mZoDtDxNsLKgIKTa0ADDGz8WW5fDHguaDM3dUuzNW2r1Nkf170pcv+71x7njWg4OSA0TowCJYsL2zoW3F7wlWV7p3DKpRTJbFwHqXEG4hSLpRajRmNRqz/24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=green-communications.fr
Received: from [192.168.0.66] ([88.171.60.104]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MGhds-1snmB50gtu-009jkU; Fri, 20 Sep 2024 13:35:49 +0200
Message-ID: <106c8347-1986-43b0-93ff-7c11c204418e@green-communications.fr>
Date: Fri, 20 Sep 2024 13:35:48 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Remi Pommarel <repk@triplefau.lt>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: Nicolas Escande <nescande@freebox.fr>, linux-wireless@vger.kernel.org
References: <D4A40Q44OAY2.W3SIF6UEPBUN@freebox.fr>
 <b9d5550c-8ac1-41d7-9abb-caa11f484064@green-communications.fr>
 <c48876507ec971c9195e468e6037cc251dcf2218.camel@sipsolutions.net>
 <Zu0yRl4iyfspa8AV@pilgrim>
Content-Language: en-US
From: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Autocrypt: addr=Nicolas.Cavallari@green-communications.fr; keydata=
 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
Subject: Re: Missing wiphy lock in ieee80211_color_collision_detection_work
In-Reply-To: <Zu0yRl4iyfspa8AV@pilgrim>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Fi06CnrL68ec0AlVgS6UJeuU3pFP3d+NinptqGIIraGtiqUXLid
 0etAH17j2PDUow8xr91h0CrhQeEtXFc7NR3/1h4OlckLIrFByWOdUuTGSdH0UTYvyKMqNvt
 cOrFfYlfE4Ac0w2rHxkNJ6VXWWG9dUAyspdOwjmEIqvATyLXS5ptQ39oT75ZOSxa1SuiGei
 Cp1xetDICN/+VyTVDwf4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Qo34cXy063U=;pHBAf1DRdQOJPCKrN8/6RuX6fbC
 T7/ud/8PBzs4NlCI2aF7npE+nOYIlkrcAuTKJULB4lf770g4TGTmxoBgtLhiWEMcICJphf5BH
 68X9tW0JkX0ck4gRrURD0kE174jtFt2aTBYRctgT868XOckdq9p2GW5t9k2/w24BWLju+xk6B
 uypzkLM8Fu2viIXErvDojbkcTpnfBSUzKwNNiBRsNRAqoKROMwaAhXuSnxWmLMjE2yYcg4RGZ
 UCBd1hEZxwuwxJJXi0ijn3t81BCbTMsN9DmIYYtr+GjKIUTS9MOSZ0BpkGqPMFe4L/A3Jf/x+
 NSwiRTbokRqvvXUjL9/AueGVBeT6UxvELHBNqSQ0XTmj34tu+2vt5xO4gM+I7+Ynnj/abR9Rq
 i8QrMDv16xRRcr1edIM43zTaXIx2kYFQmo/fn6ZTeBF4pdxV/oSu9NMXsFXZy7UfVgljrHflU
 Ryc+GdOyewJAGPX8uTXU3xrofs2IsVay1UPIJ2QEpm+09SYjzPPHGpJfQ+1kT2Kg6bTXEEC/V
 C0KtABV8CYs4pmETZ6oACBsnCXF1fic3S8apTcHpylN8Id24kU2+ab7pjXunxxhr6LIg+VQlv
 2y0EhylbiyHx3QFGRwuhUl/ascHR269n56t6qR9ZV9mOhSlORV0S5JVvSaTHGAjitEu3OQrV/
 2Z3tANQ6WweE6CZ3R0Qte7d11hz8sbBWgF4BueELJYkMDM17tLhUrJzXnDKuZb53zMN2vZ8Hk
 mBu507az1rpF869KUZYN61ljpdrL3cIzw==

On 20/09/2024 10:28, Remi Pommarel wrote:
> On Thu, Sep 19, 2024 at 12:22:10PM +0200, Johannes Berg wrote:
>> On Thu, 2024-09-19 at 12:02 +0200, Nicolas Cavallari wrote:
>>>
>>>> Did I miss something ? Which one should we do ? I'm not sure of all the
>>>> implications of switching to the wiphy work queue and why it did not get
>>>> converted like the color_change_finalize_work stuff ?
>>>
>>> ieee80211_color_collision_detection_work() used to lock the wdev mutex, now it
>>> does not hold anything since 076fc8775da("wifi: cfg80211: remove wdev mutex")
>>>
>>> Also the rate limiting uses delayed_work_pending(), There is no wiphy work queue
>>> equivalent AFAIK, so the explicit lock is probably the way to go.
>>
>> That won't work, it's cancel_delayed_work_sync() under the wiphy mutex,
>> so that'll cause deadlocks (and should cause lockdep complaints about
>> them.)
> 
> Yes you are right, and AFAIU that is this kind of issue using wiphy work
> queue would prevent. With wiphy work queue if wiphy_delayed_work_cancel
> is called with wiphy lock held, work cannot be running after it returns;
> making it handy to replace cancel_delayed_work_sync() with.
> 
> So, in my opinion, switching to wiphy work queue seems to be the
> prefered solution here.
> 
> While there is no wiphy work queue equivalent of delayed_work_pending(),
> I think using timer_pending(&link->color_collision_detect_work->timer)
> to replace delayed_work_pending(), even if the semantic is a bit
> different, would be ok to fulfill the rate limiting purpose. Having the
> same delayed_work_pending() semantics on wiphy work queue would require
> to take wiphy lock which seem a bit superfluous here.
> 
> Does that make sense ?

At a cost of a spin_trylock, we can also simply take the __ratelimit() option 
(or code an equivalent) and schedule a wiphy_work immediately.

The goal is just to rate limit the work (otherwise netlink is flooded and the 
system is hosed). queue_delayed_work() and delayed_work_pending() was just an 
easy way of implementing it since it had to be a work anyway.

