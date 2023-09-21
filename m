Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC6F7AA50E
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Sep 2023 00:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjIUWac (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 18:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjIUWaZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 18:30:25 -0400
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d502])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BA8768C
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:10:12 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5586:0:640:b3c3:0])
        by forward502c.mail.yandex.net (Yandex) with ESMTP id 54C0F5EA55;
        Thu, 21 Sep 2023 11:58:15 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id DwFAq3SDca60-J1zDWlCY;
        Thu, 21 Sep 2023 11:58:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1695286694; bh=+gEHwucdbnIDVVgdvxrJqZn2q9NFPe8RrwLL1a4fBj8=;
        h=In-Reply-To:Subject:To:From:Cc:Date:References:Message-ID;
        b=vZfZdhQGZkrpkERhC4uDM9m2y/E0buz0Xf85rcphGlGWQEUXiUY99BXtEmOBIfIvc
         7i+SxUVyexu+YPd65a/IYFFXBMraPCOt964dcZ+thugLK/fYNoIq0WND++OUDLsWBN
         Vq4X/82o/oNvzDA/gZQ0jBWvEgXVtxB8WHz2huSc=
Authentication-Results: mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <75483209-4ac1-305f-83fb-9e9affc104fe@yandex.ru>
Date:   Thu, 21 Sep 2023 11:58:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
        ath10k@lists.infradead.org
References: <997f4b09-7087-4788-aa2a-ef835ce6ebb3@quicinc.com>
 <20230824055117.42309-1-dmantipov@yandex.ru> <874jjpashn.fsf@kernel.org>
Content-Language: en-US
From:   Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 xsDNBGBYjL8BDAC1iFIjCNMSvYkyi04ln+5sTl5TCU9O5Ot/kaKKCstLq3TZ1zwsyeqF7S/q
 vBVSmkWHQaj80BlT/1m7BnFECMNV0M72+cTGfrX8edesMSzv/id+M+oe0adUeA07bBc2Rq2V
 YD88b1WgIkACQZVFCo+y7zXY64cZnf+NnI3jCPRfCKOFVwtj4OfkGZfcDAVAtxZCaksBpTHA
 tf24ay2PmV6q/QN+3IS9ZbHBs6maC1BQe6clFmpGMTvINJ032oN0Lm5ZkpNN+Xcp9393W34y
 v3aYT/OuT9eCbOxmjgMcXuERCMok72uqdhM8zkZlV85LRdW/Vy99u9gnu8Bm9UZrKTL94erm
 0A9LSI/6BLa1Qzvgwkyd2h1r6f2MVmy71/csplvaDTAqlF/4iA4TS0icC0iXDyD+Oh3EfvgP
 iEc0OAnNps/SrDWUdZbJpLtxDrSl/jXEvFW7KkW5nfYoXzjfrdb89/m7o1HozGr1ArnsMhQC
 Uo/HlX4pPHWqEAFKJ5HEa/0AEQEAAc0kRG1pdHJ5IEFudGlwb3YgPGRtYW50aXBvdkB5YW5k
 ZXgucnU+wsEPBBMBCAA5FiEEgi6CDXNWvLfa6d7RtgcLSrzur7cFAmBYjL8FCQWjmoACGwMF
 CwkIBwIGFQgJCgsCBRYCAwEAAAoJELYHC0q87q+34CEMAKvYwHwegsKYeQokLHXeJVg/bcx9
 gVBPj88G+hcI0+3VBdsEU0M521T4zKfS6i7FYWT+mLgf35wtj/kR4akAzU3VyucUqP92t0+T
 GTvzNiJXbb4a7uxpSvV/vExfPRG/iEKxzdnNiebSe2yS4UkxsVdwXRyH5uE0mqZbDX6Muzk8
 O6h2jfzqfLSePNsxq+Sapa7CHiSQJkRiMXOHZJfXq6D+qpvnyh92hqBmrwDYZvNPmdVRIw3f
 mRFSKqSBq5J3pCKoEvAvJ6b0oyoVEwq7PoPgslJXwiuBzYhpubvSwPkdYD32Jk9CzKEF9z26
 dPSVA9l8YJ4o023lU3tTKhSOWaZy2xwE5rYHCnBs5sSshjTYNiXflYf8pjWPbQ5So0lqxfJg
 0FlMx2S8cWC7IPjfipKGof7W1DlXl1fVPs6UwCvBGkjUoSgstSZd/OcB/qIcouTmz0Pcd/jD
 nIFNw/ImUziCdCPRd8RNAddH/Fmx8R2h/DwipNp1DGY251gIJQVO3c7AzQRgWIzAAQwAyZj1
 4kk+OmXzTpV9tkUqDGDseykicFMrEE9JTdSO7fiEE4Al86IPhITKRCrjsBdQ5QnmYXcnr3/9
 i2RFI0Q7Evp0gD242jAJYgnCMXQXvWdfC55HyppWazwybDiyufW/CV3gmiiiJtUj3d8r8q6l
 aXMOGky37sRlv1UvjGyjwOxY6hBpB2oXdbpssqFOAgEw66zL54pazMOQ6g1fWmvQhUh0TpKj
 JZRGF/sib/ifBFHA/RQfAlP/jCsgnX57EOP3ALNwQqdsd5Nm1vxPqDOtKgo7e0qx3sNyk05F
 FR+f9px6eDbjE3dYfsicZd+aUOpa35EuOPXS0MC4b8SnTB6OW+pmEu/wNzWJ0vvvxX8afgPg
 lUQELheY+/bH25DnwBnWdlp45DZlz/LdancQdiRuCU77hC4fnntk2aClJh7L9Mh4J3QpBp3d
 h+vHyESFdWo5idUSNmWoPwLSYQ/evKynzeODU/afzOrDnUBEyyyPTknDxvBQZLv0q3vT0Uiq
 caL7ABEBAAHCwPwEGAEIACYWIQSCLoINc1a8t9rp3tG2BwtKvO6vtwUCYFiMwAUJBaOagAIb
 DAAKCRC2BwtKvO6vtwe/C/40zBwVFhiQTVJ5v9heTiIwfE68ZIKVnr+tq6+/z/wrRGNro4PZ
 fnqumrZtC+nD2Aj5ktNmrwlL2gTauhMT/L0tUrr287D4AHnXfZJT9fra+1NozFm7OeYkcgxh
 EG2TElxcnXSanQffA7Xx25423FD0dkh2Z5omMqH7cvmh45hBAO/6o9VltTe9T5/6mAqUjIaY
 05v2npSKsXqavaiLt4MDutgkhFCfE5PTHWEQAjnXNd0UQeBqR7/JWS55KtwsFcPvyHblW4be
 9urNPdoikGY+vF+LtIbXBgwK0qp03ivp7Ye1NcoI4n4PkGusOCD4jrzwmD18o0b31JNd2JAB
 hETgYXDi/9rBHry1xGnjzuEBalpEiTAehORU2bOVje0FBQ8Pz1C/lhyVW/wrHlW7uNqNGuop
 Pj5JUAPxMu1UKx+0KQn6HYa0bfGqstmF+d6Stj3W5VAN5J9e80MHqxg8XuXirm/6dH/mm4xc
 tx98MCutXbJWn55RtnVKbpIiMfBrcB8=
Subject: Re: [PATCH 1/6] [v3] wifi: ath10k: cleanup CE ring initialization
In-Reply-To: <874jjpashn.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/20/23 16:23, Kalle Valo wrote:

> I have on purpose avoided to use void functions in ath10k/ath11k/ath12k.
> The problem is that if some of the functions return void and some of the
> functions return int it's much harder to review the code. 

I realize that you're constantly overloaded with reviewing a lot of patches...

> If most/all of the functions return the same error value type as int  > it makes a lot easier to read the code.

...but still not sure that this is reasonable for any non-trivial piece
of the source code.

OTOH if both you and Jeff are agreed on preserving existing ath1x style,
I will definitely take this decision into account and try to redesign
this series in attempt to fit the current design as much as possible.

Dmitry

