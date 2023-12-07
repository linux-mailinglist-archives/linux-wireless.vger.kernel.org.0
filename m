Return-Path: <linux-wireless+bounces-559-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2248092E7
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 22:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47F91F2104D
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 21:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF107096E;
	Thu,  7 Dec 2023 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="YdsnpsvZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063FB1715
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 13:01:33 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 95FB118005D;
	Thu,  7 Dec 2023 21:01:30 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 7760A13C2B0;
	Thu,  7 Dec 2023 13:01:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7760A13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1701982889;
	bh=u6waVsnKLrpkLbU4WWVvRu6hgYQIyJF8c8oD5cWGx+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YdsnpsvZBSw16q2zOp34pgYg/thcdtZmjZ8sPK5i3te2yZM8+rcw/SdLl4EYR5Ppt
	 Fdh2l6nkyCPkm08u6wOb00rRKAla88a/fABx1+VgekzTJnsUHV8QT9mW1GX3GxfC5+
	 o0mwb0xQpYDOd2/JMfsfj1IqYmnx+XKWeS+BTsKk=
Message-ID: <487ef0bb-5930-e998-7daa-6f57d09d682c@candelatech.com>
Date: Thu, 7 Dec 2023 13:01:29 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/8] wifi: mt76: mt7996: add txpower setting support
Content-Language: en-US
To: shayne.chen@mediatek.com, "nbd@nbd.name" <nbd@nbd.name>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 =?UTF-8?B?QWxsZW4gWWUgKOiRieiKt+WLsyk=?= <Allen.Ye@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 =?UTF-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= <Evelyn.Tsai@mediatek.com>,
 "lorenzo@kernel.org" <lorenzo@kernel.org>, Ryder Lee
 <Ryder.Lee@mediatek.com>, =?UTF-8?B?U3RhbmxleVlQIFdhbmcgKOeOi+S+kemCpik=?=
 <StanleyYP.Wang@mediatek.com>
References: <20231102100302.22160-1-shayne.chen@mediatek.com>
 <20231102100302.22160-2-shayne.chen@mediatek.com>
 <bbf8fe7e-1098-5b33-8ed6-dee38329edf6@candelatech.com>
 <8c5fbe88bcc5b55e6d80247144e4f890fd68ef27.camel@mediatek.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <8c5fbe88bcc5b55e6d80247144e4f890fd68ef27.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1701982892-SRca-0hEqb86
X-MDID-O:
 us5;at1;1701982892;SRca-0hEqb86;<greearb@candelatech.com>;0a87ce8853dfc5be48bfe846d29ed5d9

On 12/7/23 09:15, shayne.chen@mediatek.com wrote:
> On Fri, 2023-12-01 at 15:40 -0800, Ben Greear wrote:
>>   	
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>   On 11/2/23 03:02, Shayne Chen wrote:
>>> Add support for setting txpower from upper layer and configuring
>> per-rate
>>> txpower limit table.
>>
>> Hello Shayne,
> 
> Hi Ben,
>>
>>   From what I can tell, this patch causes STA vdevs to no longer send
>> probe
>> requests when trying to associate.  I bisected to this in Felix's
>> tree that holds
>> this patch.
>>
>> Tested on x86-64, mtk7996 radio.  Specifically
>> debugged on 2.4Ghz radio, but I think it affects 5Ghz too.
>>
> I have done some tests but didn't face this issue. Could you also use
> the newer firmware to test if it still happens?

The problem remains with this firmware:

[root@ct523c-a0af ~]# ethtool -i wlan2
driver: mt7996e
version: 6.7.0-rc3+
firmware-version: ____000000-20231012001354
expansion-rom-version:
bus-info: 0000:0d:00.0
supports-statistics: yes
supports-test: no
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: no

Do you have a kernel tree that you are using successfully (not an owrt feed of patches)
that you can share?

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



