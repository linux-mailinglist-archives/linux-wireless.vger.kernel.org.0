Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99985B14FC
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 08:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIHGr0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 02:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiIHGrW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 02:47:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630EAD21FD
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 23:46:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FF9C6192B
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 06:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4BFC433D6;
        Thu,  8 Sep 2022 06:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662619617;
        bh=AnEniN/1ezMQjDLZ/D6h3XTQ3sZZuGBFe25f8AVvwEU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=b8J8yFoY+GUQV2zu8knwJaeJtmPd8TE1uHZSH3ofxE5BmKp9kU/QfOkf2fzu1HfH5
         /nRxKYFXqduzfgrGlns/DHiQpsMVk0llqWOq/bDOoK8Y4H5wl3cpHpU7YUaYDBzhrj
         MjSnuCwLaDyVaTMlHnoX4ENNna/V3jKJvfqY14Lg44KoLugc2eHNTS4uFrAOCfGSpv
         7uR2WIlAPInj4mMVOfFd2zc9xL4Y2aIkZ2skhsYjNOVWiEEn2QHUMb7KPPorbtBw3j
         tam55lkj9DCHAol2cte/ycM40isssYCX0WKW92V2D+54WG+pFRc5cVBN8jdPnV2atN
         GpimgpOerNJBw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     Robert Marko <robert.marko@sartura.hr>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/3] ath11k: Enable threaded NAPI on WCN6750
References: <20220720135113.15755-1-quic_mpubbise@quicinc.com>
        <20220720135113.15755-2-quic_mpubbise@quicinc.com>
        <87czceaqng.fsf@kernel.org>
        <dcc14883-51c9-c1bb-bbea-1b309eccedf2@quicinc.com>
        <CA+HBbNGEoSyfbs=FHtWyvBnG_jh9m=Q9KW=Pcfq+pDdHWEV4mw@mail.gmail.com>
        <7615c815-ca2e-c6f1-b627-6e10f1272442@quicinc.com>
        <CA+HBbNEm9GhYcXQ9gXEb=U4x=BZTDp4UBqF8eNH1N0uCBLdadQ@mail.gmail.com>
        <5c07bcd5-574c-b13b-44c2-ef8ed9f23cf0@quicinc.com>
Date:   Thu, 08 Sep 2022 09:46:53 +0300
In-Reply-To: <5c07bcd5-574c-b13b-44c2-ef8ed9f23cf0@quicinc.com> (Manikanta
        Pubbisetty's message of "Fri, 2 Sep 2022 20:00:55 +0530")
Message-ID: <878rmucqhu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> On 9/2/2022 7:16 PM, Robert Marko wrote:
>> On Fri, Sep 2, 2022 at 3:42 PM Manikanta Pubbisetty
>> <quic_mpubbise@quicinc.com> wrote:
>>>
>>> On 9/2/2022 6:50 PM, Robert Marko wrote:
>>>> On Fri, Sep 2, 2022 at 3:18 PM Manikanta Pubbisetty
>>>> <quic_mpubbise@quicinc.com> wrote:
>>>>>
>>>>> Regardless of the chip family, even I feel that the tput changes like
>>>>> these should be tested on all the chipsets. Availability of the hardware
>>>>> and time are something which are stopping me in testing the changes on
>>>>> all supported targets.
>>>>>
>>>>> As I said, I had made the changes only to WCN6750 initially (using a
>>>>> hw_param). Can we take that approach for now and enable this for other
>>>>> targets only if required & upon thorough testing?
>>>>
>>>> I can tell you that on IPQ8074 threaded NAPI really improves perfromance.
>>>>
>>>
>>> Great. Do you have any test results on IPQ8074?
>>
>> I dont have full test results, but on Poco F2 Pro as the client @80MHz AX
>> I got ~720Mbps compared to ~550Mbps before.
>>
>> I can tell you that in OpenWrt, we have had it enabled for 6+ months
>> at this point
>> and its been really good.
>>
>
> That's a significant improvement, great to hear that. We have another
> strong reason to have this change in upstream driver.

Indeed, thanks Robert. Is the code in openwrt similar as what
Manikanta's patch does?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
