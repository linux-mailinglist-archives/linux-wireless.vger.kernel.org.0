Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EE333D455
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Mar 2021 13:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbhCPMxl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Mar 2021 08:53:41 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:44526 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232209AbhCPMxD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Mar 2021 08:53:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id B2E5C2059C;
        Tue, 16 Mar 2021 13:53:01 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2mPXoACdOaOT; Tue, 16 Mar 2021 13:53:01 +0100 (CET)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 01FBA20590;
        Tue, 16 Mar 2021 13:53:01 +0100 (CET)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 16 Mar 2021 13:53:00 +0100
Received: from [172.18.16.185] (172.18.16.185) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 16 Mar
 2021 13:53:00 +0100
Subject: Re: [iwlwifi] v5.12-rc1: Unable to move phy0 to other network
 namespace
To:     Johannes Berg <johannes@sipsolutions.net>,
        <luciano.coelho@intel.com>
CC:     <linux-wireless@vger.kernel.org>
References: <28fee372-0dc6-6351-2b1d-c79e924952a5@secunet.com>
 <2d2e0b2031c1e8072e7a98dce9206961450c11a9.camel@sipsolutions.net>
From:   Torsten Hilbrich <torsten.hilbrich@secunet.com>
Autocrypt: addr=torsten.hilbrich@secunet.com; prefer-encrypt=mutual; keydata=
 mQENBFs5uIIBCAD4qbEieyT7sBmcro1VrCE1sSnV29a9ub8c0Xj0yw0Cz2N7LalBn4a+YeJN
 OMfL1MQvEiTxZNIzb1I0bRYcfhkhjN4+vAoPJ3q1OpSY+WUgphUbzseUk/Bq3gwvfa6/U+Hm
 o2lvEfN2dewBGptQ+DrWz+SPM1TQiwShKjowY/avaVgrABBGen3LgB0XZXEH8Q720kjP7htK
 tCGRt1T+qNIj3tZDZfPkqEVb8lTRcyn1hI3/FbDTysletRrCmkHSVbnxNzO6lw2G1H61wQhw
 YVbIVNohY61ieSJFhNLL6/UTGHtUE2IAicnsUAUKR8GiI1+3cTf233O5HaWYeOjBmTCLABEB
 AAG0L1RvcnN0ZW4gSGlsYnJpY2ggPHRvcnN0ZW4uaGlsYnJpY2hAc2VjdW5ldC5jb20+iQE3
 BBMBCAAhBQJbObiCAhsDBQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEJ7rXZh78/h8+tIH
 +QFYRQH4qh3WagcmjbG/zCe2RmZZePO8bmut2fAxY04aqJZGYUBxb5lfaWaHkstqM5sFD8Jo
 k1j5E7f1cnfwB21azdUO8fzYL889kdVOzatdT/uTjR7OjR59gpJMd4lx7fwFuZUg8z6rfWJ3
 ImjxxBgaJRL6pqaZ9lOst82O0qJKEFBR+HDUVvgh4n8TTOfKNv/dGPQhaed+2or98asdYRWo
 S/zc4ltTh4SxZjLd98pDxjlUyOJoMJeWdlMmLgWV3h1qjy4DxgQzvgATEaKjOuwtkCOcwHn7
 Unf0F2V9p4O7NFOuoVyqTBRX+5xKgzSM7VP1RlTT4FA9/7wkhhG+FEK5AQ0EWzm4ggEIAL9F
 IIPQYMx5x+zMjm8lDsmh12zoqCtMfn9QWrERd2gDS3GsORbe/i6DhYvzsulH8vsviPle4ocU
 +PaTwadfnEqm0FS7xCONYookDGfAiPS4cHWX7WrTNBP7mK3Gl1KaAOJJsMbCVAA9q4d8WL+A
 e+XrfOAetZq5gxLxDMYySNI1pIMJVrGECiboLa/LPPh2yw4jieAedW96CPuZs7rUY/5uIVt0
 Dn4/aSzV+Ixr52Z2McvNmH/VxDt59Z6jBztZIJBXpX3BC/UyH7rJOJTaqEF+EVWEpOmSoZ6u
 i1DWyqOBKnQrbUa0fpNd3aaOl2KnlgTH9upm70XZGpeJik/pQGcAEQEAAYkBHwQYAQgACQUC
 Wzm4ggIbDAAKCRCe612Ye/P4fEzqB/9gcM/bODO8o9YR86BLp0S8bF73lwIJyDHg5brjqAnz
 CtCdb4I+evI4iyU9zuN1x4V+Te5ej+mUu5CbIte8gQbo4cc9sbe/AEDoOh0lGoXKZiwtHqoh
 RZ4jOFrZJsEjOSUCLE8E8VR1afPf0SkFXLXWZfZDU28K80JWeV1BCtxutZ39bz6ybMbcCvMS
 UfwCTY0IJOiDga1K4H2HzHAqlvfzCurqe616S4S1ax+erg3KTEXylxmzcFjJU8AUZURy/lQt
 VElzs4Km1p3v6GUciCAb+Uhd12sQG2mL05jmEems9uRe3Wfke/RKp8A+Yq+p6E0A0ZOP+Okm
 LXB2q+ckPvZG
Message-ID: <850ab590-8f45-0713-0d10-69b01fad8aa1@secunet.com>
Date:   Tue, 16 Mar 2021 13:52:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2d2e0b2031c1e8072e7a98dce9206961450c11a9.camel@sipsolutions.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 16.03.21 13:09, Johannes Berg wrote:
> On Tue, 2021-03-16 at 12:38 +0100, Torsten Hilbrich wrote:
>> Hello,
>>
>> starting with kernel v5.12-rc1 (and still not working in v5.12-rc3) I'm
>> no longer able to move a wlan interface into another namespace.
>>
>> I have created a new network namespace, like in the following example:
>>
>> # ip netns add black
>>
>> Then I move the phy0 interface to that network namespace. I then expect the wlan0 interface to be removed from the initial network namespace and then to appear in the new one.
>>
>> # iw phy phy0 set netns name black
>>
>> However, starting with v5.12-rc1 (last known to be working with v5.11) the command never finishes execution. Instead, I get a number of rntl warnings and a soft hangup
> 
> Yes, oops, known bug, fix is here:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20210310215839.eadf7c43781b.I5fc6cf6676f800ab8008e03bbea9c3349b02d804@changeid/
> 
> I'll get it sent upstream soon.

I can confirm that the patch works for me.

Thanks,

	Torsten

