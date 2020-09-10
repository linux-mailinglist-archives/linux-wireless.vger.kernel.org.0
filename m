Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA95E2649A1
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 18:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgIJQYW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 12:24:22 -0400
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:56616
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726895AbgIJQWz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 12:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599754974;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=Wwfl/mzxLuQG3EceiDitXRPj53HWB0guQAHRT3dLzqs=;
        b=Ce4as5p7PusRnhDBtjK7NchbuPvWQkfmXOn2WepVsNQ/X6WN6gyjEbpTITdilQlr
        ZLWAOZriV/Hq+hB5qbJXPnXZsXCGcnGTHW++KJ7xn64yoQP1SGhF9z6i71TNEMXvjLx
        YN2C59di4XAF6m6QAD5Rouy3KRLm9zGCgQ1yye4Y=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599754974;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=Wwfl/mzxLuQG3EceiDitXRPj53HWB0guQAHRT3dLzqs=;
        b=VhO++RsC6baQUhskLcXkyL3Vq+OBg3gMcK8ABdoTX8MB+zB08onDR08I55pvtjMV
        rMkaDntM24UVsqruWt3N+5YE/eWXtC89G/3vSrp/v5/kWo712189ol3224qbbVRC7tI
        BKvXlw3eJWbCD15jINLYaoSmQY+0xQEWd1aoded0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4244C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org, loic.poulain@linaro.org
Subject: Re: [PATCH v5 0/2] wcn36xx: Miscellaneous updates
References: <20200910150845.2179320-1-bryan.odonoghue@linaro.org>
        <84a86a12-62d2-cc94-95b3-34b360ad4255@nexus-software.ie>
Date:   Thu, 10 Sep 2020 16:22:54 +0000
In-Reply-To: <84a86a12-62d2-cc94-95b3-34b360ad4255@nexus-software.ie> (Bryan
        O'Donoghue's message of "Thu, 10 Sep 2020 16:55:28 +0100")
Message-ID: <0101017478d3b53f-5a586be0-e974-42b5-a4dd-af80e33052dd-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.10-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <pure.logic@nexus-software.ie> writes:

> On 10/09/2020 16:08, Bryan O'Donoghue wrote:
>> This series is seven in a set of seven to add support for wcn3680 at 802.11ac
>> data-rates.
>>
>> This set marks functions previously declared non-static as static. In order
>> to facilitate granular standalone commits and avoid single patch
>> code-bombs. A series of functions were previously declared non-static.
>> Antecedent changes have made use of those functions so we can now mark them
>> static.
>>
>> In a similar theme of cleanup, I've added on a fix for some whitespace
>> damage in main.c and smd.c which while not strictly related to wcn3680 I've
>> opted to throw into the bucket under a "miscellaneous update" title.
>>
>> Hope that's OK.
>>
>> V5:
>> - No change to V4 but need to send the set again so that
>>    prerequisite-patch-id makes sense to the build robot here.
>>
>> V4:
>> - No functional change.
>>    Sending out full set again using --base=ath-202009090652 to aid kernel
>>    test robot
>> - https://lore.kernel.org/linux-wireless/20200908183424.2871101-1-bryan.odonoghue@linaro.org/T/#t
>>
>> V3/RESEND:
>> - Messed up my .git/config resending from my @linaro.org address
>>
>> Bryan O'Donoghue (2):
>>    wcn36xx: Mark internal smd functions static
>>    wcn36xx: Ensure spaces between functions
>>
>>   drivers/net/wireless/ath/wcn36xx/main.c |  1 +
>>   drivers/net/wireless/ath/wcn36xx/smd.c  | 65 +++++++++----------------
>>   2 files changed, 23 insertions(+), 43 deletions(-)
>>
>>
>> base-commit: 160b351d75cb50a0dd2abf9b63e1891935aa9e4a
>> prerequisite-patch-id: 9a4ac7faca179f6594c9b3a115ee69a2da540a69
>> prerequisite-patch-id: 183286f9c22d1aaa12f356651224e6b337ef1938
>> prerequisite-patch-id: af468d413daaf8d2aad195fcb43c6e66390d8468
>> prerequisite-patch-id: 08122a9557904ce5358f52dd08cc33270fa202c1
>> prerequisite-patch-id: 82e0b7c5b2e9fa80baca001cce12577d98e306a9
>> prerequisite-patch-id: 8ee7f5bd6cb5b7b7d713947b554ad93bb90d8230
>> prerequisite-patch-id: d05c2253e4523b05b2e43491aa13ceeef68fd2f0
>> prerequisite-patch-id: 8be29513d3efa64df15297bcf81ec3db55088ee1
>> prerequisite-patch-id: d267dcd834afad75a69bcd2adcccfdad6566a7ba
>> prerequisite-patch-id: 47145acae6e24e8e6580fca1dbddfbec24f7b50b
>> prerequisite-patch-id: 8c66bccb923be821cf109a3a0d3a1a028edb4930
>> prerequisite-patch-id: d0f5f3769b2963208fd2348840726fa1d3501b63
>> prerequisite-patch-id: 746f63cf58fa3bf62736435c81dba2558aba8e81
>> prerequisite-patch-id: 375bb7847ae74c63d2eacdbd0d73371aef1546fe
>> prerequisite-patch-id: 8a598e22a08b0ec233d0ec56eeb53673eb1b8feb
>> prerequisite-patch-id: b0eba574ddc35ecec2d0e39c0d3351d1b260420e
>> prerequisite-patch-id: 143a1019813b7e4974a67e9eea1f1d599c0fdfdf
>> prerequisite-patch-id: f66d9fe9eb731272b825c9430c15dca89d6c6129
>> prerequisite-patch-id: c8c2d2dd1452c357f73fc4c92e5b564d59a05562
>> prerequisite-patch-id: 273c13464a69354d32790ed7509472d9c2b11231
>> prerequisite-patch-id: adbde1c98b85a16a6500b4210d4f055b9493418c
>> prerequisite-patch-id: 559b6f9af6b26f860896dea4c7eb385ba9bdf0d5
>> prerequisite-patch-id: 94c091c0c78b754d4c842a097a6db126bf6e770f
>> prerequisite-patch-id: f2e549349c09f4675775b40bf9bb9b1f2bec6db8
>> prerequisite-patch-id: c3a6aa788141f5b8782d28dac264470c8081bb97
>> prerequisite-patch-id: 452450f26295dc4fc48dec07ba85538d78bae4b4
>> prerequisite-patch-id: 8e7850077db9ec00df9be4fe3e0e4a4e8b06fbba
>> prerequisite-patch-id: 233db8337812d9d34f99b41ccebd8758a6ada6d9
>> prerequisite-patch-id: 0bbaaf402d2dd50a50aaa6505e5d10e743cf03e5
>>
>
> Is there any reason these emails are percolating through this list so
> slowly ?

I think vger has been slow the last few days, just give it time. At
least I have not yet noticed any mails gone missing.

But please stop with the patch bombs, they are making me crazy. For
example, even just changing the state of 36 patches in patchwork takes
time.

When I said to split the huge patchset into smaller patchsets I didn't
mean that you still send _all_ of them at the _same_ time, and _every_
time you change something. This is even worse than submitting one huge
patchset. The easiest way is to send one patchset first, wait for few
days (ideally wait for me to apply it) and then send a new one.

More info in the link below.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
