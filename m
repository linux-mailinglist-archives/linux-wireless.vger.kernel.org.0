Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D613336B926
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Apr 2021 20:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbhDZSmh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Apr 2021 14:42:37 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:49754 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239148AbhDZSm2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Apr 2021 14:42:28 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.26])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 6355820064;
        Mon, 26 Apr 2021 18:41:45 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B88E694007E;
        Mon, 26 Apr 2021 18:41:44 +0000 (UTC)
Received: from [192.168.223.32] (75-149-161-6-Washington.hfc.comcastbusiness.net [75.149.161.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id B034513C2B3;
        Mon, 26 Apr 2021 11:41:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B034513C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1619462496;
        bh=yzDerBNFZC8MxvrfMVvZ8ayoxqDt0c427d/6l0xHWmE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LLf2+Ugq97v90q9WKP8YCPVkqwwUZRDfvAbXR6gOdbhaMOA0YlZYQY+eRkveZz7HC
         5C+QEKnjwqUay+3Yq85tIWeSPjnYo1n830YFDLmlHosK/5gVTLWWLPhw2ervyZ2bpJ
         j7Ua2JNHU8rK0vCAbO4rEWPgddVGSkLzE/uMaWbE=
Subject: Re: [PATCH 2/2] mt76: mt7915: add .set_bitrate_mask() callback
To:     Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <22e4a169831b6b54661b6eb4ef4f3a4a18dceb19.1619453772.git.ryder.lee@mediatek.com>
 <d422f0c844c5da1ee027250820b67f615a8b50e5.1619453772.git.ryder.lee@mediatek.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <7776c0d1-0578-5922-1003-f8498cc0357a@candelatech.com>
Date:   Mon, 26 Apr 2021 11:41:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <d422f0c844c5da1ee027250820b67f615a8b50e5.1619453772.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1619462505-CLonuDwr1f-K
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/26/21 9:29 AM, Ryder Lee wrote:
> Add runtime configuration for bitrate mask. Note that GI cannot be setup.
> 
> Example:
> iw dev wlan0 set bitrates vht-mcs-5 1:9 he-mcs-5 2:7
> iw dev wlan0 set bitrates legacy-5 6 he-mcs-5 2:0-11

Is this only for data frames?  In other words, is it OK to
set exactly one HE/VHT MCS rate and let mgt, bcast, mcast, still
work OK at legacy rates?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
