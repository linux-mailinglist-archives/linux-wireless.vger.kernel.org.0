Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387D55B1C8D
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 14:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiIHMPn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 08:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiIHMPl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 08:15:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD660B7288
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 05:15:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B34EE61CC4
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 12:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F000C433C1;
        Thu,  8 Sep 2022 12:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662639337;
        bh=7CYWYb+qA5ZDBgkdQGwl08oLEGOaV3jooXzyK0p8b/E=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=U0NnvlI/DeqtccTbKaeTkksnwSVr/ILYgSSh7X9pewsi7OOU9TMYfS3H8GeMNd+Qa
         tglqgg+L6qZF0ud49tCDkBty0HeIQF0iFwUJY6ITtcY9jBPIAKiYLuB4gqCbMn7HBQ
         H239kd7bR5sZJkzvHIdS6Z332v8HXcFPWQlI/jDb9Mrlktik7MQ0Pb6XocUMqUmjrt
         w/cmlV8GMPXnkLPLJD7jRYfRAytDuVBLxxfZYLdyX5XRAS3NUp2jywI5GeRhT0AogG
         pZbdBvWGXhYB7iu6sCDpzQ7OXbpWPUW4d7xuHG+wKE0a0pdSzN5Ibtj2d2E3HRp5+F
         VFH4u5Rp020BA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/3] ath11k: Enable threaded NAPI on WCN6750
In-Reply-To: <CA+HBbNEAgMPKJFrAYGUT1x-XAX81tTNj4W5xgW-bYSm5j_r_4w@mail.gmail.com>
        (Robert Marko's message of "Thu, 8 Sep 2022 10:49:30 +0200")
References: <20220720135113.15755-1-quic_mpubbise@quicinc.com>
        <20220720135113.15755-2-quic_mpubbise@quicinc.com>
        <87czceaqng.fsf@kernel.org>
        <dcc14883-51c9-c1bb-bbea-1b309eccedf2@quicinc.com>
        <CA+HBbNGEoSyfbs=FHtWyvBnG_jh9m=Q9KW=Pcfq+pDdHWEV4mw@mail.gmail.com>
        <7615c815-ca2e-c6f1-b627-6e10f1272442@quicinc.com>
        <CA+HBbNEm9GhYcXQ9gXEb=U4x=BZTDp4UBqF8eNH1N0uCBLdadQ@mail.gmail.com>
        <5c07bcd5-574c-b13b-44c2-ef8ed9f23cf0@quicinc.com>
        <878rmucqhu.fsf@kernel.org>
        <CA+HBbNEAgMPKJFrAYGUT1x-XAX81tTNj4W5xgW-bYSm5j_r_4w@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Thu, 08 Sep 2022 15:15:31 +0300
Message-ID: <87tu5i83ks.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Robert Marko <robert.marko@sartura.hr> writes:

> On Thu, Sep 8, 2022 at 8:46 AM Kalle Valo <kvalo@kernel.org> wrote:
>
>>
>> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
>>
>> > On 9/2/2022 7:16 PM, Robert Marko wrote:
>> >> On Fri, Sep 2, 2022 at 3:42 PM Manikanta Pubbisetty
>> >> <quic_mpubbise@quicinc.com> wrote:
>> >>>
>> >>> On 9/2/2022 6:50 PM, Robert Marko wrote:
>> >>>> On Fri, Sep 2, 2022 at 3:18 PM Manikanta Pubbisetty
>> >>>> <quic_mpubbise@quicinc.com> wrote:
>> >>>>>
>> >>>>> Regardless of the chip family, even I feel that the tput changes like
>> >>>>> these should be tested on all the chipsets. Availability of the hardware
>> >>>>> and time are something which are stopping me in testing the changes on
>> >>>>> all supported targets.
>> >>>>>
>> >>>>> As I said, I had made the changes only to WCN6750 initially (using a
>> >>>>> hw_param). Can we take that approach for now and enable this for other
>> >>>>> targets only if required & upon thorough testing?
>> >>>>
>> >>>> I can tell you that on IPQ8074 threaded NAPI really improves perfromance.
>> >>>>
>> >>>
>> >>> Great. Do you have any test results on IPQ8074?
>> >>
>> >> I dont have full test results, but on Poco F2 Pro as the client @80MHz AX
>> >> I got ~720Mbps compared to ~550Mbps before.
>> >>
>> >> I can tell you that in OpenWrt, we have had it enabled for 6+ months
>> >> at this point
>> >> and its been really good.
>> >>
>> >
>> > That's a significant improvement, great to hear that. We have another
>> > strong reason to have this change in upstream driver.
>>
>> Indeed, thanks Robert. Is the code in openwrt similar as what
>> Manikanta's patch does?
>
> It's actually identical, we are also just calling dev_set_threaded
> before napi_enable.

Nice, even better :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
