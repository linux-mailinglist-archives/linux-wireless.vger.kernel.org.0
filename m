Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0F66EEF4C
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Apr 2023 09:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbjDZH33 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Apr 2023 03:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbjDZH31 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Apr 2023 03:29:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D875F26B8
        for <linux-wireless@vger.kernel.org>; Wed, 26 Apr 2023 00:29:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A5396149D
        for <linux-wireless@vger.kernel.org>; Wed, 26 Apr 2023 07:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13DCC433EF;
        Wed, 26 Apr 2023 07:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682494165;
        bh=SJB4mMz5cNPKosH2jnVI6BjgW4ZnnuZvPIlv2NOzGYs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dLMqM58xBr5Q+YbjBW31AxPp0xk3bv6qYLChr5KrawKp0buWV4qWDiQ3tKZ+UdOYn
         OP6IfK9hMnX5vvCvaf7eUQXHqdp1JMAa1BvtMvvEP8xrwLOH6Xy8cNpEyShtPUHOLb
         obbSKmn3ov//zz/qwYy+QgB9Ol8c6FJoKmqh7HjlQHmu3frqUFyYjQEOjb0Wrdffiv
         F1IlNfh9J0+GB3uhLSPB9DPjcGAe0TCcT52IVB45oVuH5mTyYAZYA3vO4vIMxPwJUU
         mjXvxuNyE4Yt7vDC6FOsPs7S0a20lowrrTpYXLtJXmOGJH4SRE+3/tqaBeluKWKMc3
         6OogqcuvqEoYQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Subject: Re: [PATCH] wifi: ath11k: update proper pdev/vdev id for testmode command
References: <20230424092420.12794-1-quic_rajkbhag@quicinc.com>
Date:   Wed, 26 Apr 2023 10:29:22 +0300
In-Reply-To: <20230424092420.12794-1-quic_rajkbhag@quicinc.com> (Raj Kumar
        Bhagat's message of "Mon, 24 Apr 2023 14:54:20 +0530")
Message-ID: <87a5yvt831.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> writes:

> From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
>
> User can extend test mode command support to set vdev and pdev params
> for debug purpose at run time by sending vdev/pdev param set command
> through the testmode command interface.
>
> Fill the proper pdev/vdev id in driver since, pdev/vdev id details may
> not be available at user space. It will make sure that the proper
> vdev/pdev ids are sent to firmware.
>
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>
> Depends-On:
> 	[v3,3/4] wifi: ath11k: factory test mode support
>
> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---

Please add 'Depends-on' after the '---' line. This is for future
patches, no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
