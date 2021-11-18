Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF76456145
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 18:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbhKRRSr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 12:18:47 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:51996 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234001AbhKRRSq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 12:18:46 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.128])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 475FC2008D;
        Thu, 18 Nov 2021 17:15:45 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 1AA78780089;
        Thu, 18 Nov 2021 17:15:45 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id CFDCF13C2B0;
        Thu, 18 Nov 2021 09:10:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com CFDCF13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1637255442;
        bh=UxTQ7IbocXBZafqztvBeOydtDiFMtakgtM1qPLyCkfY=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=KMPp5xjY99xQgkH4QKwxppODQT4xL3v/UA7Jd2+zaLF+38s9/MNGQWrU1EDJPqJr5
         1F1DUk9DywfYba69gOEgS2B4Kc4uUUj852I0U9BpqfLz0htPynKpz5m5VzO01TqE4e
         HkuUtCioffa8cngAIJb/v1LYtjE0QsxDXs6GG4cU=
Subject: Re: [PATCH 1/8] mt76: mt7915: cache sgi in wcid.
To:     Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org
References: <20211118164549.3863-1-greearb@candelatech.com>
 <c0a09707cf9bcf1205b60c7a36e5afa2a6b2f39c.camel@mediatek.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <7ec78991-2104-a3f7-dd2f-373cf6a10019@candelatech.com>
Date:   Thu, 18 Nov 2021 09:10:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c0a09707cf9bcf1205b60c7a36e5afa2a6b2f39c.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1637255745-CZ31ZAIjyoBp
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/18/21 9:06 AM, Ryder Lee wrote:
> On Thu, 2021-11-18 at 08:45 -0800, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> Explicitly cache short_gi and he_gi in wcid, don't try to store
>> it in the wcid.rate object.  Slightly less confusing and less fragile
>> when TXS starts parsing lots of frames.
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>>
>> This is actually the first series, not that one I posted a few
>> minutes
>> ago.  txs, tx overrides and other things.  Rebased on top of 5.16

> 
> Maybe we can consider switching to use existing fixed-rate method in
> debugfs? On th other hand, that's the only way to configure HE MU UL
> fixed-rate.

This patch is to improve reported tx rates, not to control tx rates.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

