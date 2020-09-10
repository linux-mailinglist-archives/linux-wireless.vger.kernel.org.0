Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B504264EC8
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 21:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgIJTZc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 15:25:32 -0400
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:40234
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731320AbgIJPsa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599752908;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=BPqL7/h9mcBs20IvOHSVnkirBfkrU50E8+7n9AQiCAA=;
        b=ZAbAInrzKdMebTej23haxoemlTjzcPTF7gZIrpQmrxMALdLD2s/PaBKlIbH50W7u
        MLzwOkm24El+GwSy2TV7nPVf//eqPIfdKbXnn8WyNpYoM9XOlbXJhjsEwfWr8XiIdCW
        A2TN3WFK7XjbUTaTPwtrhl3494NXNxLVKUG9IdS4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599752908;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=BPqL7/h9mcBs20IvOHSVnkirBfkrU50E8+7n9AQiCAA=;
        b=XHzZcuoWBSyBMYcAAxp6zIpyR7OUpSCfRSSn1qw7eQP32mFX42nkEXIunw49jpxa
        IH+19tajk32rVpVEA066N8Sj5AC7KloMCTv5JzHUhfOr7+5toeL52bgQAnYWGiBulzo
        YA1ABAsLri/zaMsh5PaWbZV0ZvGOzgonG/rk0nqY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 990ADC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Anilkumar Kolli <akolli@codeaurora.org>,
        devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH v7 1/3] dt: bindings: net: update compatible for ath11k
References: <1599551717-3801-1-git-send-email-akolli@codeaurora.org>
        <010101746cb6751a-ca300933-1174-4534-a01b-b1dbf1c1f305-000000@us-west-2.amazonses.com>
        <20200908203514.GA870402@bogus>
Date:   Thu, 10 Sep 2020 15:48:28 +0000
In-Reply-To: <20200908203514.GA870402@bogus> (Rob Herring's message of "Tue, 8
        Sep 2020 14:35:14 -0600")
Message-ID: <0101017478b42fca-a6c7ad92-949e-41c7-8088-ffce98e7b830-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.10-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> On Tue, 08 Sep 2020 07:55:31 +0000, Anilkumar Kolli wrote:
>> Add IPQ6018 wireless driver support,
>> its based on ath11k driver.
>> 
>> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
>> ---
>> V3:
>>  - Use 'enum' rather than oneOf+const.
>> V4:
>>  - removed oneOf, use just enum (Rob)
>> V5:
>>  - Fixes errors in 'make dt_binding_check' (Rob)
>> 
>>  Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.

I added Rob's Reviewed-by in the pending branch.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
