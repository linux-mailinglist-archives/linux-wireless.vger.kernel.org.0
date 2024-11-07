Return-Path: <linux-wireless+bounces-15101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F509C0926
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 15:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821CD1C210C5
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 14:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E2F212D2E;
	Thu,  7 Nov 2024 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="LxRCdrPY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE121E049C
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990652; cv=none; b=An/ZVYGC1FcoODwgthTw7vY/8GNgHjmdHLBPuXICaZd8L5Dv7nzYSB6ckAU9g8BhyFEEobwDHcC9b87Ewz24Cd5XPJvzZ0FqCYZr2bVRh5Rh+5OK+aiMiFo6NrShwg5OmDEBzjzQ7nbr1HmoxhrpvWpKt8zp6IDEx/ctL3TYRQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990652; c=relaxed/simple;
	bh=Ao+jQhE7Hw+qOauf/JIYFmyfKK2WX09+vxgfG9PnCxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxwHbrVTyb5z9gBmjajNJjtnEVmLffVGj/BpfhG86Q4FlzP571dcTUlTqAYgOaWo+6rmJqnrGTKLeI+Dzrc7OuP+dWrS6Z1C/6FWIAZYp9Qb3Y4FYWbBZXqMq/HT4Xid9YVY8q/E9OxKuNJ/q3j6yJbL3vsjTkA8UO8527lbhVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=LxRCdrPY; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 21948A80081;
	Thu,  7 Nov 2024 14:44:08 +0000 (UTC)
Received: from [192.168.101.118] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id D69D213C2B1;
	Thu,  7 Nov 2024 06:44:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D69D213C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1730990643;
	bh=Ao+jQhE7Hw+qOauf/JIYFmyfKK2WX09+vxgfG9PnCxA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LxRCdrPY7nngGuoyCyANBFmOOCPBqVWJq1O5EN1ZDhry/Che3Vz0xrhX7oT+ZrmpP
	 GKanAdemU1OrwC6hLYJZrdwk+ShPyMB6vDwzH4b4CyAG2EnmDxsDuXpj7DvLIHV3bi
	 ECUKLW3YkL86CybulpjR+Gc+NlVjbzqVORSWgP3M=
Message-ID: <b99509ed-7e35-4b0c-bd9d-62f4ee1ca098@candelatech.com>
Date: Thu, 7 Nov 2024 06:43:23 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iw: scan: replace passed ie buffer with alias struct
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20240930181145.1043048-1-dylan.eskew@candelatech.com>
 <20240930181145.1043048-4-dylan.eskew@candelatech.com>
 <69fa8e26fe6ebed7dbff2ab0c725d84a02b08ed8.camel@sipsolutions.net>
Content-Language: en-US
From: "Dylan E." <dylan.eskew@candelatech.com>
In-Reply-To: <69fa8e26fe6ebed7dbff2ab0c725d84a02b08ed8.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1730990648-FbQVXjpRb2HX
X-MDID-O:
 us5;ut7;1730990648;FbQVXjpRb2HX;<dylan.eskew@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

Thanks for the feedback. I didn't necessarily realize that elements
might appear multiple times in a frame, but that information paired
with your implementation advice gives me plenty to figure something
better.

-- Dylan

On 11/7/24 6:22 AM, Johannes Berg wrote:
> On Mon, 2024-09-30 at 11:11 -0700, Dylan Eskew wrote:
>> Prevent needing to reparse the ie buffer by passing
>> the ieee80211_elems struct containing the alias ie
>> pointers.
>>
> I think I see why you'd want the previous and this patch, and it's OK
> for certain elements (such as the VHT capability or HE capability where
> you'd need it), but in general it can't work this way.
>
> We could either make the parsing even more generic to be able to deal
> with elements occurring multiple times, or, perhaps more plausibly, have
> a context with only what we need (VHT capability seen here, HE
> capability for EHT, ...) filled by a pre-parsing step, and then pass
> that context around.
>
> In practice for HE/EHT we could also just pass a context around and say
> it's an error if e.g. the EHT capabilities element is in the list
> _before_ the HE capabilities element, since by spec that's not supposed
> to happen. So we could just have the HE capabilities parsing fill the
> context with the necessary information about HE (and set a validity
> flag) and then check that it was already found when we get to EHT later.
>
> However, that doesn't work for the case with capabilities/VHT ... where
> the parsing of the capabilities element is actually referencing the VHT
> element _later_ in the frame.
>
> johannes

