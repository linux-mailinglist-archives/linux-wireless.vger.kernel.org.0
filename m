Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF5D419A969
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2020 12:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732039AbgDAKUI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 06:20:08 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:48246 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731951AbgDAKUH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 06:20:07 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200401102006epoutp037f72658e5d84703524ce19eba3baabd2~BqtwgYKnS2204022040epoutp03E
        for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2020 10:20:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200401102006epoutp037f72658e5d84703524ce19eba3baabd2~BqtwgYKnS2204022040epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585736406;
        bh=R+Qqz4SvSjIBQnrlG8V1tWDRdpWKAL9nD7564mXbppM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=KccZaX163/Wa5oKW00i9HJbB7nY0sqAyrEXIAo/wfuSwv0jinhdE+6+fdMdBSPNCw
         EJSAW0vtpTbpsjAy3pmGIgy/cmX3s8cucgQeGN5bZTFobW/Y4uNM6YEedrootx5fHf
         vNtToC9EMKFHHQUHa+mzIhG/ciBfQZ0Qauh/kRQo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200401102005epcas1p3544878acb9a9d84c07b0ab212d24b265~BqtwK_Tfa2884528845epcas1p3R;
        Wed,  1 Apr 2020 10:20:05 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48shyp4krVzMqYkc; Wed,  1 Apr
        2020 10:20:02 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.BF.04074.2DA648E5; Wed,  1 Apr 2020 19:20:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200401102001epcas1p24d1f256edb0913bd1757d2b964e40068~BqtsP-Bpm1945119451epcas1p2q;
        Wed,  1 Apr 2020 10:20:01 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200401102001epsmtrp202938eab087c2a4a8857628c28140ee0~BqtsO114z1499614996epsmtrp2Z;
        Wed,  1 Apr 2020 10:20:01 +0000 (GMT)
X-AuditID: b6c32a39-58bff70000000fea-21-5e846ad2f3d7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.A5.04024.1DA648E5; Wed,  1 Apr 2020 19:20:01 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200401102001epsmtip2dedecab0015cc44c0f76e474f57cb59f~BqtsCveMW0549205492epsmtip2E;
        Wed,  1 Apr 2020 10:20:01 +0000 (GMT)
Subject: Re: [PATCH] brcmfmac: fix wrong location to get firmware feature
To:     Kalle Valo <kvalo@codeaurora.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        brcm80211-dev-list@cypress.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <40b711a5-869b-1dac-0ac9-e6e59d4bcd52@samsung.com>
Date:   Wed, 1 Apr 2020 19:20:13 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87r1xaf8r7.fsf@codeaurora.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmnu6lrJY4g3s3VCxeTjjMaLF96RsW
        i88tbUwWbyd+YLN42z6NyeLHohdsFj8e3WCxWLRyIZvF5V1z2CzerLjDbjH9x24mB26PWffP
        snlc7utl8mhryvTYOesuu8fnTXIBrFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaW
        FuZKCnmJuam2Si4+AbpumTlAlykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCiwL
        9IoTc4tL89L1kvNzrQwNDIxMgQoTsjOOPf/IWPCbp6LlzXnmBsZTXF2MnBwSAiYSTz4uYOti
        5OIQEtjBKLH54B5mCOcTo8S81ktMIFVCAt8YJWZdU4fpmHNgMlTRXkaJ7VMeMEI47xkl5tw+
        wgZSJSzgKfH87D1mEFtEIETizP5nYDuYBZ4wS7z89I8FJMEmoCOx/dtxoBUcHLwCdhLzL0qC
        hFkEVCSa310HC4sKREic/poIEuYVEJQ4OfMJWCcnUGd343qw45gFxCVuPZkPZctLbH87B+w4
        CYFmdonH28+zQFztItFz8AcrhC0s8er4FnYIW0ri87u9bBB2tcSu5jNQzR2MEre2NTFBJIwl
        9i+dDHYQs4CmxPpd+hBhRYmdv+cyQizmk3j3tYcVpERCgFeio00IokRF4tLrl0wwq+4++Q91
        gofE27s72CYwKs5C8tosJO/MQvLOLITFCxhZVjGKpRYU56anFhsWmCJH9iZGcKLVstzBeOyc
        zyFGAQ5GJR7eioyWOCHWxLLiytxDjBIczEoivLNdgEK8KYmVValF+fFFpTmpxYcYTYEBP5FZ
        SjQ5H5gF8kriDU2NjI2NLUwMzUwNDZXEeadez4kTEkhPLEnNTk0tSC2C6WPi4JRqYNxwTn3Z
        9BKxWQ4tB4ylF01favL2eo9rudXS3vZLH/8fb7jIvfCK85QUve7N0o+T7BoT03Jv7Nd2ajrc
        mnVEUUWk0C+1/ZxSvdKpq+rzVod3vfD9Kyx1m0f7+leGsx0dweL7exssFodP6ou6PUNotdv8
        raf2JXKs/K+wSY0pWL2sJOpO/YrZb5RYijMSDbWYi4oTAcFThxnKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWy7bCSvO7FrJY4g6dXlCxeTjjMaLF96RsW
        i88tbUwWbyd+YLN42z6NyeLHohdsFj8e3WCxWLRyIZvF5V1z2CzerLjDbjH9x24mB26PWffP
        snlc7utl8mhryvTYOesuu8fnTXIBrFFcNimpOZllqUX6dglcGceef2Qs+M1T0fLmPHMD4ymu
        LkZODgkBE4k5ByYzdzFycQgJ7GaUePyxhwUiISXx+elUti5GDiBbWOLw4WKImreMEr8WPGYD
        qREW8JR4fvYeM4gtIhAisfdNJyNIEbPAC2aJH29fsUF0/GCU2N96H2wqm4COxPZvx5lApvIK
        2EnMvygJEmYRUJFofnedCcQWFYiQeL79BiOIzSsgKHFy5hOwVk6g1u7G9WA1zALqEn/mXWKG
        sMUlbj2ZDxWXl9j+dg7zBEahWUjaZyFpmYWkZRaSlgWMLKsYJVMLinPTc4sNCwzzUsv1ihNz
        i0vz0vWS83M3MYKjS0tzB+PlJfGHGAU4GJV4eCsyWuKEWBPLiitzDzFKcDArifDOdgEK8aYk
        VlalFuXHF5XmpBYfYpTmYFES532adyxSSCA9sSQ1OzW1ILUIJsvEwSnVwJjypuygo3EDx+6J
        li2GPBvV+QstpNsWfjS7VSFVlHB2M3Py1VLGKRItl5t/NivUH/idvGvnVKadn5SkPs8ynuCS
        NcPf4X240fZVF3RkV18snSfv+//iVJWb92fOkjgZrr29z36DZf5Ww+D7Kyf/lWfe3KGiPG+V
        yjqjZR6bZXleHrUta7c576vEUpyRaKjFXFScCABPJ110qgIAAA==
X-CMS-MailID: 20200401102001epcas1p24d1f256edb0913bd1757d2b964e40068
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200330052521epcas1p1eedc926d4b11513f8502cf0c90ecf433
References: <CGME20200330052521epcas1p1eedc926d4b11513f8502cf0c90ecf433@epcas1p1.samsung.com>
        <20200330052528.10503-1-jh80.chung@samsung.com>
        <CAHp75Vey9VUSAT6j6NTSXqNUK1vwSqY=aSx3-WPoXgxCK33SDg@mail.gmail.com>
        <87r1xaf8r7.fsf@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/30/20 7:16 PM, Kalle Valo wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> 
>> On Mon, Mar 30, 2020 at 8:26 AM Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>
>>> sup_wpa feature is getting after setting feature_disable flag.
>>> If firmware is supported sup_wpa feature,  it's always enabled
>>> regardless of feature_disable flag.
>>>
>>
>>> Fixes: b8a64f0e96c2 ("brcmfmac: support 4-way handshake offloading for WPA/WPA2-PSK")
>>>
>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>
>> No blank line in between. (Dunno if you need to resend, just wait what
>> maintainer says)
> 
> I can fix that during commit, no need to resend because of this.

Thanks!

BTW, I have a question about brcmfmac's firmware feature.
When i have tested on RPI4, it seems that 4-way handshake offloading feature is using.

If I entered the wrong password, which event is triggered from firmware? 
And how does wpa_supplicant know about wrong key?

I don't have much knowledge about this..but if my analyzing is correct.

<7>[  119.278494] brcmfmac: brcmf_is_nonetwork Processing failed supplicant state: 8
...
<7>[  119.278525] brcmfmac: brcmf_bss_connect_done Report connect result - connection failed
...
<7>[  119.278726] brcmfmac: brcmf_fweh_event_worker event DEAUTH_IND (6) ifidx 0 bsscfg 0 addr 70:5d:cc:6e:b5:xx

<7>[  119.280966] brcmfmac: brcmf_fweh_event_worker event DEAUTH (5) ifidx 0 bsscfg 0 addr 70:5d:cc:6e:b5:xx


firmware is indicating DEAUTH event and driver will be controlled with it, right?
Can someone explain to me in more detail, plz? 

Best Regards,
Jaehoon Chung



> 

