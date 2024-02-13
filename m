Return-Path: <linux-wireless+bounces-3546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4963D85332A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 15:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCBF1C26E4C
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 14:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A88D5A7B3;
	Tue, 13 Feb 2024 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="D2hp0Qjm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9395C5A79D
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834621; cv=none; b=GzK9qgLIqALOcVsAvk7uYmMXpHey16irzh8SRHEfVWj7HKX/I7RzP6lhlC4ooktmauLYlnuBPR581/0XQjk0HuckjQ6CuOigq6Hl3I3bN+hjBntv2xW73fURkJMcLbafEjSEpOAwUMDamGiYeWSDfMdzJFebDpzLw/dKFkPWiGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834621; c=relaxed/simple;
	bh=nnpPaDsSHI7of09/gQAxbqex21roSP2YQ8Y3pHQcRp0=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DexJxLY+G71EvyESBKUDJVZuGmuPuDIAs9KUeXrhBq7Nu2E3lDokGh5D3m4tyDRUtIneYF9XNb7YmIQKfi/mg8SscM/t5DK2bUv+gfRIAiI7A2ZsyR97hUoE4beZqNiHYsJ9JP849/PR6aX3DGhW99Ca2mmmjB0v3tAzo8ofbXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=D2hp0Qjm; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6F8FA2A1FBF
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 14:21:25 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DA0FB10006D;
	Tue, 13 Feb 2024 14:21:17 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.116.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 4A64413C2B0;
	Tue, 13 Feb 2024 06:21:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4A64413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1707834077;
	bh=nnpPaDsSHI7of09/gQAxbqex21roSP2YQ8Y3pHQcRp0=;
	h=Subject:To:References:From:Date:In-Reply-To:From;
	b=D2hp0Qjmiyd6Sgb2Xc/ADVaZ04HqppRIXR0Ed4vdotY3Enefkjwm8aGO79K5PtVdB
	 J/qZcvjKnkNtTFRv7sAphoq8sxU8nqH1Lbwe0gXXx4Yf8Fr7QO/t4/fJnhZHVwjmY0
	 sDij+vh/Jfot/OsWNzBj0loZBSeNtDtuelZpKuh8=
Subject: Re: iwlwifi RFC related to iwl_mvm_tx_reclaim
To: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <c9b0c01e-acac-9f15-730f-a0ba991a68dc@candelatech.com>
 <9779efb62cec04926e3bb2575a8aecc8bbf0e7ff.camel@sipsolutions.net>
 <2839f687-88af-ecd8-c6cb-7bdaf1808496@candelatech.com>
 <25395d1cee68fcd6d19a6c7843afd48ad8448a82.camel@sipsolutions.net>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <f46243bb-3d88-81c0-5dbe-00e9e84046d2@candelatech.com>
Date: Tue, 13 Feb 2024 06:21:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <25395d1cee68fcd6d19a6c7843afd48ad8448a82.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1707834078-xBwwTqt1PXlb
X-MDID-O:
 us5;ut7;1707834078;xBwwTqt1PXlb;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

On 2/13/24 6:14 AM, Johannes Berg wrote:
> On Tue, 2024-02-13 at 06:13 -0800, Ben Greear wrote:
>>
>> If sta is NULL, we should still reclaim the frames?  If so the check earlier in the code where
>> it returns early if sta is NULL could be deleted, and add a null check down near the IS_ERR
>> check?
> 
> If the sta is NULL something went pretty much horribly wrong, not sure
> what we should be trying to do in that case. I guess you could argue for
> reclaiming anyway, but question is how far you go and what that risks, I
> don't really know.

Ok, I haven't seen it actually be null, so will just fix my particular bug
and leave the rest as is.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

