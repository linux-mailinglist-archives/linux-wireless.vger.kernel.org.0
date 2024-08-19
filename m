Return-Path: <linux-wireless+bounces-11620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D7D956D18
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 16:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FBB71F25DD8
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 14:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B608D16D4F2;
	Mon, 19 Aug 2024 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="onjy1EW0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5682716D4D7
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077389; cv=none; b=kCt0wMVssR8hAlqKmV3vdEte6qMPn0bSmUZ6R/tYMjmYyECvj+F+U4y3iXVHOqxoieSh7TSBiCoAe5Lkgej0lrofibxao5JIdtTc4Wg2ff4CoNClZ9WfOYSEUwypkgmOA09kWbZ+SHupqkZnF3UAwVFPAEvOpU0/SHWb5Emo0AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077389; c=relaxed/simple;
	bh=cfPZIvkFj39IEfSq8vlZ2wpc7MZksqoeS+wQBPZsjpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GoRbRMPRz0/O330Feifpz/o+EyFfAWFPAt9MvtSI7m0Zb2U3CYK0j5K4mT/A9TZw20e3a5oXjjCbvw/dPoC0bZUzFj146gS3wYMSCJZ9FTHTX/UMOYP3xNjSPmxcPzWZRW6pu1R5Xrk9BDLV1xTpselAaf48+lRItA0uR7avkEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=onjy1EW0; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8C8C2B80067;
	Mon, 19 Aug 2024 14:22:58 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.39.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id B1BEE13C2B0;
	Mon, 19 Aug 2024 07:22:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B1BEE13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1724077377;
	bh=cfPZIvkFj39IEfSq8vlZ2wpc7MZksqoeS+wQBPZsjpY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=onjy1EW0eXhEV1SrGJ0hB+d5/MigRmJtJLOooyRv++lPX3tcVnBILg8QY3L8BYsaD
	 18K1ix0NATMyNyC8qwbvmZDs0NZoSlfOa8aJNlspj9Yzxna5CmZFpqyZyq+QOdROxQ
	 KGvl+0So8KfgHPUbRpWMNK0QDtrC1I1Z20Zd3rpw=
Message-ID: <9e60638a-d85f-4c35-9370-8b42e96d1526@candelatech.com>
Date: Mon, 19 Aug 2024 07:22:56 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] wifi: mt76: mt7996: set correct beamformee SS
 capability
To: Shayne Chen <shayne.chen@mediatek.com>, Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Evelyn Tsai <evelyn.tsai@mediatek.com>,
 linux-mediatek <linux-mediatek@lists.infradead.org>,
 Howard Hsu <howard-yh.hsu@mediatek.com>
References: <20240816094635.2391-1-shayne.chen@mediatek.com>
 <20240816094635.2391-6-shayne.chen@mediatek.com>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20240816094635.2391-6-shayne.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1724077379-TIxF0z-F69XC
X-MDID-O:
 us5;at1;1724077379;TIxF0z-F69XC;<greearb@candelatech.com>;6b0fc91aa4a2e8bb560701e503333c57

On 8/16/24 02:46, Shayne Chen wrote:
> From: Howard Hsu <howard-yh.hsu@mediatek.com>
> 
> According to IEEE P802.11be/D6.0 Table 9-417n, beamformee SS field stands
> for the maximum number of spatial streams that the STA can receive in an
> EHT sounding NDP minus 1, and the minimum value of this field is 3.
> 
> This value indicates the decoding capability of a beamformee, which is
> independent of current antenna settings. Correct the value for mt7996
> and mt7992 chipsets based on their HW capability.

I thought that if user sets a specific number of antennas, the code should
act as if that were the number of physical antennas, so this change seems
wrong to me.

What use-case is this patch attempting to fix?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


