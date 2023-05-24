Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F9370F2FB
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 11:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjEXJhG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 05:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjEXJgp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 05:36:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E34E58
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 02:36:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1420639B6
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 09:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA40AC433D2;
        Wed, 24 May 2023 09:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684920982;
        bh=3RDAmXbPpZPlOZLbdKiVZC4UxcSl6x7J31OGNvXq5Rc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bmJlENkBDccadjEH4PGKANOqT/6lqCbALQYInWsgBP5OJU+zonwS9F0jnSYtH1Kj/
         UFt2W3H7a3OUEoqry9N6asPSLTOKBh4brdVAIr4Uil5ARjtjAq14hphcJn7IQ8JM8A
         Tyt1FOYiLwGvN7BscozZ8uwFzSHsCp311RbTSigiVbdR4AT48o5VcXd9qT2t96qvYM
         M8yI+M3iPuNBAo3xODQRHVK915onOprsEHBJXBy1Ere1iW+DI64jZ6NGCUc9b7V+Q8
         t3hduGP9XDxw8BHRhfY950yyL3Rdc2phE0vsn0FrgNRqCuTKho4oQOTSR9qedIaW8X
         JxNRFNGOPKZLA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Cc:     Tyler Stachecki <stachecki.tyler@gmail.com>,
        "open list\:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER" 
        <ath11k@lists.infradead.org>,
        "open list\:NETWORKING DRIVERS \(WIRELESS\)" 
        <linux-wireless@vger.kernel.org>, <quic_akalaise@quicinc.com>,
        <quic_mpubbise@quicinc.com>
Subject: Re: [PATCH v3] wifi: ath11k: Add rx histogram stats
References: <CAC6wqPVvke=Gy59yvYcaps2dwVzO=wfwdSTGNxFzAOWc5OpoDw@mail.gmail.com>
        <d6f794e3-7463-da7d-721e-00869faf4c17@quicinc.com>
Date:   Wed, 24 May 2023 12:36:16 +0300
In-Reply-To: <d6f794e3-7463-da7d-721e-00869faf4c17@quicinc.com> (Maharaja
        Kennadyrajan's message of "Wed, 24 May 2023 14:33:03 +0530")
Message-ID: <87h6s2kr5b.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maharaja Kennadyrajan <quic_mkenna@quicinc.com> writes:

> On 5/21/2023 11:21 PM, Tyler Stachecki wrote:
>
>> Was this really tested on QCN9074 as the commit text suggests...?
>>
>>> const struct ath11k_hw_ops ipq6018_ops = {
>>> @@ -1132,6 +1147,7 @@ const struct ath11k_hw_ops wcn6750_ops = {
>>>   .rx_desc_get_msdu_payload = ath11k_hw_qcn9074_rx_desc_get_msdu_payload,
>>>   .reo_setup = ath11k_hw_wcn6855_reo_setup,
>>>   .mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
>>> + .mpdu_info_get_mpdu_len = ath11k_hw_qcn9074_mpdu_info_get_mpdu_len,
>> ...
>>
>>> +static u32 ath11k_hal_rx_mpduinfo_get_mpdu_len(struct ath11k_base *ab,
>>> +       struct hal_rx_mpdu_info *mpdu_info)
>>> +{
>>> + return ab->hw_params.hw_ops->mpdu_info_get_mpdu_len(mpdu_info);
>>> +}
>> I think you want to put this under qcn9074_ops. As of now, when
>> QCN9074 is present, it attempts to jump to a NULL pointer as
>> mpdu_info_get_mpdu_len remains uninitialized for qcn9074_ops.
>>
>> And, do you not need to define mpdu_info_get_mpdu_len for all the
>> other hw_ops? If so, please be careful about defining it for
>> WCN6855/WCN6750 as there was a recent regression due to how the RX
>> MPDU info is provided by those firmwares as it differed from
>> IPQ8074/QCN9074. I personally do not have the appropriate literature
>> to determine whether or not this is consequential or not here as well,
>> though it seems like it would be:
>> https://lore.kernel.org/linux-wireless/20230404072234.18503-3-quic_youghand@quicinc.com/
>>
>> Tyler
>
> Thanks for your comments. Will fix this in the upcoming patchset.

I have some comments as well but I haven't been able to send them yet. I
recommend waiting for them before sending the next version.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
