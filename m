Return-Path: <linux-wireless+bounces-10188-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E3592EC52
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 18:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6725E1C20D85
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 16:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1EE15957E;
	Thu, 11 Jul 2024 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Zn8EUmUh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C4015B999
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714192; cv=none; b=ZqQZtxtEqWMUUBFJ8HOhTWI6hm8lJuphOgMttc9a7woS8TvDHaQRS6G5QBX4DX7mF808MnSxiOLYwiJDND5C/H6fTM45uyQ6hhjHybm3L2IP2OFJOezAT7juh8WlUCZoagRsi5YvqKZA+A4+ajlN1p5nq5n81VZJOKathF1Ru5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714192; c=relaxed/simple;
	bh=pVCx1eP5Wu3y88TV+DPnYiBpDuB2YekUJsF+9eMVBrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCawHbbpaV5OiccHkNrXi/PUk30Mzf/D32lZ+2FTsCmU2gkY5BL9sOefAv2bd9K0BgfvaqDcdClw/m+wvrXxbOQPXlMtJgmdsEL6bpZAocd8p1e5VpjEWta5wfkRP/Wu/z8ZGml+bxiJHjbRYo+xXm6scFudqaG74HC20v/WZmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Zn8EUmUh; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2BD3D50049C
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 16:09:49 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 089E4180067;
	Thu, 11 Jul 2024 16:09:40 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 728B613C2B0;
	Thu, 11 Jul 2024 09:09:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 728B613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1720714180;
	bh=pVCx1eP5Wu3y88TV+DPnYiBpDuB2YekUJsF+9eMVBrM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zn8EUmUhQ35/AFUGj6m2J5y8m93KSM/ms6k2Onk505nLVy2uVmjXdm8gb54LlPbAW
	 i+WpSgjOBEYZcv9Z5WtsCUS6kieWDp+pTOejeR0crnGqdN/2npZL3NTcRTXncvoSaw
	 j03HLwUZ5ApPZrj9qWFAvM3KTJ8n1ClqsCDMZ2bs=
Message-ID: <4abe931d-f6ec-adb6-9b78-23d4c0c4b1a2@candelatech.com>
Date: Thu, 11 Jul 2024 09:09:40 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 06/18] wifi: iwlwifi: keep the TSO and workaround pages
 mapped
Content-Language: en-US
To: "Berg, Benjamin" <benjamin.berg@intel.com>,
 "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "Berg, Johannes" <johannes.berg@intel.com>
References: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
 <20240703125541.7ced468fe431.Ibb109867dc680c37fe8d891e9ab9ef64ed5c5d2d@changeid>
 <a0a7dbf2-b4c5-ddf8-59e9-7e8a067e2f11@candelatech.com>
 <64fefdf4c689a4fe039917f69b9f6d61aca0db92.camel@intel.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <64fefdf4c689a4fe039917f69b9f6d61aca0db92.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1720714182-t8gx4YYiSRCu
X-MDID-O:
 us5;at1;1720714182;t8gx4YYiSRCu;<greearb@candelatech.com>;50171c4d2da3acbebc7f7131b075104c

On 7/10/24 23:15, Berg, Benjamin wrote:
> Hi Ben,
> 
> yes, you need to apply:
> 
> commit 003eae5a28c6c9d50290a4ac9b955be912f24c9f
> Author: Benjamin Berg <benjamin.berg@intel.com>
> Date:   Tue Jul 9 14:31:49 2024 +0200
> 
>      wifi: iwlwifi: correctly reference TSO page information
> 
> 
> I had not fully tested the last revision and the error slipped
> unfortunately.

Hello Benjamin,

Sorry I did not notice that patch on the mailing list on my own.  I re-applied
the 6/18 and 7/18 patches, and the fix you mention above, and system appears stable.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



