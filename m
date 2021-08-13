Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28B53EB656
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 15:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240706AbhHMNzK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 09:55:10 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:36644 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240068AbhHMNzK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 09:55:10 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.24])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id BC4B22A006D;
        Fri, 13 Aug 2021 13:54:42 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 465F43C0026;
        Fri, 13 Aug 2021 13:54:41 +0000 (UTC)
Received: from [192.168.254.6] (unknown [50.34.183.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id CEFC713C2B1;
        Fri, 13 Aug 2021 06:54:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com CEFC713C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628862880;
        bh=5tKunBAwMnPdA7f4AkB8bCitDfhGrzhL+wAN4/LW8Ek=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gz+xfbYwr10CiYKi0hg11kPXyeK8FKaIEqWm8Gvx4XAoQnJcQl6lbZ6Tn4iZekUYv
         fuBEHtodw38xvB+GFNyZeD9KkPMoo9heiaohDKqZRFvyeO44ZKyJhMTmXUP/sJslFv
         zLfsuZTnE5/2mUiLzYPP2pxiK3xDweuOPI7Cku2E=
Subject: Re: [PATCH v4 1/2] mt76: mt7915: fix hwmon temp sensor mem
 use-after-free
To:     Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <9f5b0cf6c4296d3a9e78a95516cf26d1db4baba9.1627696765.git.ryder.lee@mediatek.com>
 <04c61f83-e4ce-536f-7030-9050d8edfe78@nbd.name>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <44c91410-49db-b829-a69a-f9826c8ff3ee@candelatech.com>
Date:   Fri, 13 Aug 2021 06:54:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <04c61f83-e4ce-536f-7030-9050d8edfe78@nbd.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
X-MDID: 1628862883-Ux-78EVqV1pL
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/13/21 3:15 AM, Felix Fietkau wrote:
> 
> On 2021-07-31 04:17, Ryder Lee wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> Without this change, garbage is seen in the hwmon name
>> and sensors output for mt7915 is garbled.
> Where does the use-after-free bug come from? It's not obvious to me why
> using KBUILD_MODNAME instead of wiphy_name() fixes it.
> I still think the phy name should probably be part of the prefix.

We rename phy devices as part of our normal operation, I think maybe
that helps trigger the bug.

It appears that the hwmon logic does not make a copy of the incoming string,
but instead just copies a char* and expects it to never go away.  But,
I did not actually verify that.

Thanks,
Ben

> 
>> With the change:
>>
>> mt7915-pci-1400
>> Adapter: PCI adapter
>> temp1:        +49.0°C
>>
>> Fixes: d6938251bb5b (mt76: mt7915: add thermal sensor device support)
> The format is wrong (missing quotes), and the hash references a commit
> that's not in any upstream tree.
> 
> - Felix
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
