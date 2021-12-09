Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E5E46E3AD
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 09:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbhLIIIG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 03:08:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36044 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLIIIG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 03:08:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38157B8235C;
        Thu,  9 Dec 2021 08:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A38C004DD;
        Thu,  9 Dec 2021 08:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639037071;
        bh=9lhxZnXHHgRYM2mz4B6k4tmudvFg62aL32BOfwzQz+k=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=V3zNQ1Nay5QJjhOweBn6oLHUfnyicgh2Wrh82gHmxTMwVKdXu+tqO+mTmQs+HKM2B
         PDhTkuKPD7hKYJweH5D8Mxc2T1UtBPrvPHS0zvCy2rpOnYa+j36SHQ6ktrc2lm8LFm
         0bax1gppPiu4WLAqso1f/6MKRdvuzD5qXnnjcDXKIb7ygmOt7RXecpajv1Dy3VCSYV
         FlKdxlQS7RGgnnWIT8pjXegi3azwuU8KTijWcoADRlpa4SeDTRvUKYMEGh6GGW6YD6
         C+EfiwwnOm1kgdxEL7u3/ndKxuDc0JLdi/DjsxD5IdD1r3BTdLTrQjKsNOxjmxt4W/
         miiJHDfQm453w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Anilkumar Kolli <akolli@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt: bindings: add new DT entry for ath11k PCI device support
References: <1638789319-2950-1-git-send-email-akolli@codeaurora.org>
        <Ya+/pawARpqHwTES@robh.at.kernel.org>
Date:   Thu, 09 Dec 2021 10:04:27 +0200
In-Reply-To: <Ya+/pawARpqHwTES@robh.at.kernel.org> (Rob Herring's message of
        "Tue, 7 Dec 2021 14:10:13 -0600")
Message-ID: <87y24u431w.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> On Mon, 06 Dec 2021 16:45:18 +0530, Anilkumar Kolli wrote:
>> Ath11k driver supports PCI devices such as QCN9074/QCA6390.
>> Ath11k firmware uses host DDR memory, DT entry is used to
>> reserve host DDR memory regions, send these memory base
>> addresses using DT entries.
>> 
>> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
>> ---
>> V4:
>>   - Fix dt_binding_check warnings (Rob)
>> V2:
>>   - Use reserved-memory (Rob)
>> 
>>  .../bindings/net/wireless/qcom,ath11k.yaml         | 30 ++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>> 
>
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.

Anil, please clarify. I can add the Rob's Reviewed-by if nothing was
changed since v6.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
