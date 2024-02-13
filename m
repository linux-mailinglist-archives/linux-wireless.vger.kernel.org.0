Return-Path: <linux-wireless+bounces-3544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7188532C5
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 15:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF19528564C
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 14:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5A85786C;
	Tue, 13 Feb 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="DX8XQVkP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC5857866
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833627; cv=none; b=S9j9UdrZndCy+lgd83hE6dQxdzhRepQ7/ZgD3iq+39/5JtD8Vofx3jE+9EQVhXX0WiEjWBx0pZr+1Zle82dcv8LFa0FmilXcj3hYFS4Id3+7eRutcmBXIYwTo5KLXWPOrSyInpIiw6GyDTsKJ7cfV5e5H8H4Xs0y+eMAWN86EDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833627; c=relaxed/simple;
	bh=iZ1RYsiUccQ7lkkZjla8su2Ot/G1lA/mWZS2JHQmuC4=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=i3R0Cb+ItEMH60VgmCd1UqArhipwAOTeiRFy0duf1BitkyrKQK2Nade0fNfHS3B3fA+7nSiehxdldq40+gtcJGXXwPBEuoTKXP+7nE0lZCsnK8r9uCJP/ENipQgiVbLwk3wGMCVprBLNTt7w02fCTwsMRMBAFolG9DmmaPnfnb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=DX8XQVkP; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2D1CF8C0077;
	Tue, 13 Feb 2024 14:13:41 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.116.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 240E513C2B0;
	Tue, 13 Feb 2024 06:13:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 240E513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1707833620;
	bh=iZ1RYsiUccQ7lkkZjla8su2Ot/G1lA/mWZS2JHQmuC4=;
	h=Subject:To:References:From:Date:In-Reply-To:From;
	b=DX8XQVkPN2yHcJmxa54pjBInXmglQJiCMPJ2cdFlOO2ziKpvHUX+173b60nf2e9a3
	 1n/+qn7aFN4KaftdWzrGUrF8FfXYRxG1cA05+Om+V1yLXJbQH6zqAAJgcF/s4EDxWa
	 tvadWigQ0UjgN10n6IGizSz64XJpPt8ATQ0KbELc=
Subject: Re: iwlwifi RFC related to iwl_mvm_tx_reclaim
To: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <c9b0c01e-acac-9f15-730f-a0ba991a68dc@candelatech.com>
 <9779efb62cec04926e3bb2575a8aecc8bbf0e7ff.camel@sipsolutions.net>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <2839f687-88af-ecd8-c6cb-7bdaf1808496@candelatech.com>
Date: Tue, 13 Feb 2024 06:13:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9779efb62cec04926e3bb2575a8aecc8bbf0e7ff.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1707833623-tbED2PLO3mbx
X-MDID-O:
 us5;at1;1707833623;tbED2PLO3mbx;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

On 2/13/24 1:37 AM, Johannes Berg wrote:
> On Mon, 2024-02-12 at 15:22 -0800, Ben Greear wrote:
>> I'm seeing a crash due to accessing an 'sta' object in this method that is '-2' as integer.
>>
>> It fails the initial check for null STA, but I'm thinking it might should check for IS_ERR(sta)
>> as well.
>>
>> (I have my own patch that references sta before the IS_ERR check later in the code, and this
>> causes the crash I'm seeing.  I guess upstream will not crash in this situation.).
> 
> Indeed.
> 
>> My question:  Is the patch below a preferred approach, or should I add special checks to where I
>> access sta and only exit the method lower where it already has the IS_ERR(sta) check?
> 
> You can do whatever you want in your tree, but I guess generally I'd
> advocate you assume that the code does what it should ;-)
> 
> In this case, ERR_PTR(-ENOENT) is used to indicate the station is being
> deleted, but has not yet been fully removed, and so indeed we still want
> to reclaim the frames here correctly, which the code does.
> 
> The comment below even kind of explains that?

If sta is NULL, we should still reclaim the frames?  If so the check earlier in the code where
it returns early if sta is NULL could be deleted, and add a null check down near the IS_ERR
check?

I can (and have) fixed the bug in my code, I'm trying to understand if the driver
itself needs improving here to cover an edge case.

Thanks,
Ben

> 
> johannes
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

