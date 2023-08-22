Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F3B784133
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 14:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjHVMud (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 08:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjHVMud (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 08:50:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADCB1BE
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 05:50:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AFEC61338
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 12:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D380C433C7;
        Tue, 22 Aug 2023 12:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692708630;
        bh=VOj/H3WFw6eAeJRXThByUZWJHDAa+HeOqkE4Tbwj1es=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GxQ+f4GfMdjxe14JaXdnUgyeqnvdIT+79tKy8RPl00B3ETu6V3mU0hS4Wb9nvuskx
         zNvxG2l1h9POMod6OcEwMlgS1Cl3agHi5hJtyY3NGJSfZXUeOrDJM83SNs39kAdc1m
         n5gsU3+5HJh9HYMIlvy5uNGBYQan2WRjhrAgCBk7ne3ziBhzBZ1sGnXf6EeQXuP3Ns
         7LOMJwy57X703vLSS7ZTt71gz+VIh5/jxfJl/RyRL1lRuurfOImFkEiZ0piq7koQKf
         ljbbFr1lM274WU+YH0Z33N5QzsycC/NMVOZNymY8PVCfX2qYSWS+HyWVjNHqRuab8+
         Rtm5mU+eHOEPg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath11k: fix boot failure with one MSI vector
References: <20230601033840.2997-1-quic_bqiang@quicinc.com>
        <87fs70hlel.fsf@kernel.org>
        <545cc8e8-481d-85b2-5692-43580936b48d@quicinc.com>
        <897b61ea-36d2-1ab4-9c60-9bdfd2d9cad7@quicinc.com>
        <fa70ca5e-001b-3c6b-dbc2-2853f8fc2f72@quicinc.com>
        <fcb783b4-95e9-24d8-a656-b273a79598a0@quicinc.com>
        <4720b820-523a-477a-436c-72fceb4a6a12@quicinc.com>
Date:   Tue, 22 Aug 2023 15:50:27 +0300
In-Reply-To: <4720b820-523a-477a-436c-72fceb4a6a12@quicinc.com> (Manikanta
        Pubbisetty's message of "Tue, 8 Aug 2023 10:37:47 +0530")
Message-ID: <87sf8bi6lo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> On 8/7/2023 8:59 PM, Jeff Johnson wrote:
>> On 8/7/2023 3:16 AM, Manikanta Pubbisetty wrote:
>>> No impact on WCN6750.
>>>
>>> Tested-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
>> Can you provide a Tested-on: flag that Kalle can add to the commit
>> text?
>> 
>
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-01160-QCAMSLSWPLZ-1

Excellent, thanks. The more Tested-on tags I see on the patch the more
confidence I have for the patch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
