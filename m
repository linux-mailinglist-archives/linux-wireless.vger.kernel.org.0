Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEE16E62A8
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Oct 2019 14:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfJ0N23 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Oct 2019 09:28:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49548 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfJ0N23 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Oct 2019 09:28:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0ACB460D52; Sun, 27 Oct 2019 13:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572182908;
        bh=9ZZre0NuSoDeFDxf4oUJniz9M2r5yh3TTjgFWZaZdtA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LXnDmbXbqE5Pn5kUsfYvei2OaHKhD9g7VEIlFyzgpJSakPUjhAHlisivcsyNsUUMp
         LRBC+AltQKLPlam6d7Ppk5YBTrfeUQ166iiN4+Om/tAcCAKLocNdHjRK+B7Te0+5lg
         DVxjEb+a8iuDLb+GmErt/FyrqG+jy4IaBsKrHqaI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (unknown [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0BFC760BFA;
        Sun, 27 Oct 2019 13:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572182907;
        bh=9ZZre0NuSoDeFDxf4oUJniz9M2r5yh3TTjgFWZaZdtA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KWV/6SWhNivItb8uhSpxeULt5KHH5YM8fcN677+JgVRn1xDrGiB49kWgNnocXNKUr
         tw0hh5CheuFdBTGr7bRU9WcYO49ttETTT9Szdz7i8AxkIweHHpeAkj7ZirBr7NOGc9
         Jevhgcba+2cAAsP/MBO+fEmZ1yWhKyMoPkXIMy2k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0BFC760BFA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH v2 01/49] dt: bindings: net: add qcom,ath11k.yaml
References: <1571565847-10338-1-git-send-email-kvalo@codeaurora.org>
        <1571565847-10338-2-git-send-email-kvalo@codeaurora.org>
        <20191025213028.GA5117@bogus>
Date:   Sun, 27 Oct 2019 15:28:23 +0200
In-Reply-To: <20191025213028.GA5117@bogus> (Rob Herring's message of "Fri, 25
        Oct 2019 16:30:28 -0500")
Message-ID: <874kzu9v2g.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> On Sun, Oct 20, 2019 at 01:03:19PM +0300, Kalle Valo wrote:
>> ath11k is a driver for Qualcomm IEEE 802.11ax devices. Add a
>> bindings document for the driver, first documenting IPQ8074 which is the
>> only device ath11k currently supports.
>> 
>> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>> ---
>>  .../bindings/net/wireless/qcom,ath11k.yaml         | 277 +++++++++++++++++++++
>>  1 file changed, 277 insertions(+)
>> 
>> diff --git
>> a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>> b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>> new file mode 100644
>> index 000000000000..5d25542f85f8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>> @@ -0,0 +1,277 @@
>> +# SPDX-License-Identifier: BSD-3-Clause-Clear
>
> (GPL-2.0-only OR BSD-2-Clause) please.

I chose BSD-3-Clause-Clear because ath11k uses that license and I would
prefer to use the same license throughout the driver. Also it's
categorised as a preferred license:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/LICENSES/preferred

Any specific reason why you want to change the license?

>> +# Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
>> +
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/wireless/qcom,ath11k.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies ath11k wireless devices Generic Binding
>> +
>> +maintainers:
>> +  - Kalle Valo <kvalo@codeaurora.org>
>> +
>> +description: |
>> + These are dt entries used on ath11k driver. AHB based ipq8074 uses
>> most of the properties defined in this doc.
>
> Describe the h/w, not what the document is.
>
> Wrap your lines.
>
>> +
>> +properties:
>> +  compatible:
>> +    const: "qcom,ipq8074-wifi"
>
> Drop quotes.
>
>> +
>> +  reg:
>> +    description: Address and length of the register set for the device
>
> Don't need a description.
>
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    minItems: 53
>> +    maxItems: 53
>
> Assuming the list below has 53 entries min/maxItems is implied.

Will fix these.

>> +examples:
>> +  - |
>> +
>> +    q6v5_wcss: q6v5_wcss@CD00000 {
>> +    	compatible = "qcom,ipq8074-wcss-pil";
>> +    	reg = <0xCD00000 0x4040>,
>> +    	      <0x4AB000 0x20>;
>> +    	reg-names = "qdsp6",
>> +    		    "rmb";
>
> Mixed tabs and spaces. YAML needs spaces (at least at the beginning), so 
> just use spaces. More below...

Ok, I'll remove all the tabs from the doc. Thanks for the review!

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
