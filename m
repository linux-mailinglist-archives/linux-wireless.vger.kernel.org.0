Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A1A7B3349
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Sep 2023 15:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjI2NQW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Sep 2023 09:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjI2NQV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Sep 2023 09:16:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62511AC
        for <linux-wireless@vger.kernel.org>; Fri, 29 Sep 2023 06:16:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60ADFC433C7;
        Fri, 29 Sep 2023 13:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695993376;
        bh=cU7VTUFWrOyFPux0ewokHmAc68XzvYshho1YDazVwFk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OLY1VF3devQ8Xozp7ytGB09tP4h6jAA2z91QuSHIypO4XTRaHvkxQCz1FaiAW3LuE
         KAjP+DNwFFLwxXtFBdTW6iPgypIpiAhWPMfZHiHdGzM/BeuVrLqLD4mgPbEgbUpiww
         7nwAp2W9Uc31aZlIT9b8ovW8bdzNBpzVUNX+jPwvCd0G5+VI3aYYK5Ne6CPvi8eCdI
         EAgcXZA0MMvab8r3o5WTGKMCOSHFbX48cWiUFSuatyTGWYFUTrblCkeg7UmTgv7gYB
         Pc51ZTfcb4gY6g+gNNfwpOZR/jYEvWOLgedcnRBQ6LoDEKZDLyF6WvRO+Aj1RGYuXa
         HHklB7N/xWlCw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 02/13] wifi: ath11k: store cur_regulatory_info for each
 radio
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230920082349.29111-3-quic_wgong@quicinc.com>
References: <20230920082349.29111-3-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_jjohnson@quicinc.com>, <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169599337313.3629319.16942649855938558230.kvalo@kernel.org>
Date:   Fri, 29 Sep 2023 13:16:15 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> The regulatory info of WMI_REG_CHAN_LIST_CC_EXT_EVENTID is not saved
> in ath11k now, the info should be saved in ath11k. Save the info for
> each radio and support switch regulatory rules dynamically.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

This added a new warning:

drivers/net/wireless/ath/ath11k/wmi.c:7157: else is not generally useful after a break or return

You should guess by now what I'm going to say: please ALWAYS test your patches
with ath11k-check!

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230920082349.29111-3-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

