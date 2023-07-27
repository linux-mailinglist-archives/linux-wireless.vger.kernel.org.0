Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA791764684
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 08:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjG0GNF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 02:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjG0GND (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 02:13:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C43BB6
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 23:13:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38FFC61D34
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 06:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965BAC433C8;
        Thu, 27 Jul 2023 06:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690438381;
        bh=OAvI6XopJNi1Pf1KeGKriGVhqxH7EObNZwlGc2oTbuY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=OZOqhfD8zNOLVPJlMCo41bDv4ViHZ3ibINvG8b2uJwFThMZm8GMaxlDkXC5ivd1yr
         fRnFPt6UylbmGfvkVyE7ScWVuLIR4MMAdP/6L8VmmKIS/MY76+2avyY6JTRMzThHOK
         ihE1F/9HD2O37/2tFZgmtVjiauWDZALqqwCYNzozFYGtKiAJVHKg924Ii0svy2l50v
         hAkuwrN2A7z+qZkgfanAOoc1DSWbXqwybWcCAvJ+1xWz1ssDcDhOKjL1Ud8BQjiWil
         3/GY/IWy/uET9jcKO82MAuJR7hfbEC8fCwgXQCO8uMuftw2N4GYrnE4WLyL/9kb/eI
         Sq6JcDZ94u2Sg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath11k: fix band selection for ppdu received in
 channel 177 of 5 GHz
References: <20230726044624.20507-1-quic_adisi@quicinc.com>
        <8fe1a927-14da-445c-4c48-e3f4b4c324d4@quicinc.com>
Date:   Thu, 27 Jul 2023 09:12:58 +0300
In-Reply-To: <8fe1a927-14da-445c-4c48-e3f4b4c324d4@quicinc.com> (Jeff
        Johnson's message of "Wed, 26 Jul 2023 09:54:46 -0700")
Message-ID: <87bkfx287p.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
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

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 7/25/2023 9:46 PM, Aditya Kumar Singh wrote:
>> 5 GHz band channel 177 support was added with the commit
>> "wifi: ath11k: add channel 177 into 5 GHz channel list". However,
>
> I'd use the same syntax here as in the Fixes tag:
> e5e94d10c856 ("wifi: ath11k: add channel 177 into 5 GHz channel list")
>
>> during processing for the received ppdu in ath11k_dp_rx_h_ppdu(), channel
>> number is checked only till 173. This leads to driver code checking for
>> channel and then fetching the band from it which is extra effort since
>> firmware has already given the channel number in the meta deta.
>
> nit: s/meta deta/metadata/

I can fix these in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
