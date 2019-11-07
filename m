Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31A5DF3387
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 16:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388901AbfKGPib (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Nov 2019 10:38:31 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52270 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388716AbfKGPia (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Nov 2019 10:38:30 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6649860ACF; Thu,  7 Nov 2019 15:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573141109;
        bh=4I2NsGsi2oLEPVDxuh2TaPp7vZrikmhwsP5lTE2NoZ0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Sd8VY9GQE1aXB0QmpgPNYeJAGEOs9wz1n7kFwUS8vas0uOvFOYG9yuUTMWjzqzWSG
         i4oQoIok7wV9SsLo05dWg03D6oxhPw3B1UE3nOQswYrPxtVG0LlSeCb9sz6ExDJa/d
         r/67ErcXUcfIXOvXsln3OrzBnfL+IRVbvoI3MvH4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9FF4460996;
        Thu,  7 Nov 2019 15:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573141108;
        bh=4I2NsGsi2oLEPVDxuh2TaPp7vZrikmhwsP5lTE2NoZ0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Fe2kXm63JaVUTHWLtRRpOW0jE0pmLIl3dkPKq4zqiuTCl7JAFgJsxtBvrkSiYkhkJ
         ODrL2h9g269L0v1ixsF5y35ogMtXPbvCkhZBqEZW0KFFYYYjr2ly16NxaJidSnvhcd
         d442HvDa1La7EkC89l4rEMr9voOoyM/4OLmRnTnI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9FF4460996
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
Date:   Thu, 07 Nov 2019 17:38:23 +0200
In-Reply-To: <20191025213028.GA5117@bogus> (Rob Herring's message of "Fri, 25
        Oct 2019 16:30:28 -0500")
Message-ID: <87k18by9w0.fsf@kamboji.qca.qualcomm.com>
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

[...]

>> +  interrupts:
>> +    minItems: 53
>> +    maxItems: 53
>
> Assuming the list below has 53 entries min/maxItems is implied.

There's actually 52 entries in the items list below this, I need to
check if we are missing an entry or is this just a miscalculation.

>> +  interrupt-names:
>> +    minItems: 53
>> +    maxItems: 53

And I assume I can remove minItems and maxItems here as well.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
