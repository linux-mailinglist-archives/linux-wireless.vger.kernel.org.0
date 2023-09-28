Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2967B204C
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 16:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjI1O7z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 10:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjI1O7y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 10:59:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09BD195
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 07:59:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F19CC433C7;
        Thu, 28 Sep 2023 14:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695913192;
        bh=lpOR4Ou6X0Ukp2Qx3zi/x5F5K/rvMjRB0w5E6unmQdQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=GUAF/hFf0ZB6v2o5F5zS+Bg6az69VlGSDwjjobk4Z0pTSplNJOvoE+POSvkElf90n
         3dRWD+p9nmpvn9n3gGSDACeW3QUL8XNzjghCnqJHGYsL32zqHBzPfbQPU9t9DPM3dv
         VU5ynJIPWlehGQ/aLXkDmV+cbCogpJJA1BTv5kOV7yEFtX8XDt3/4hW2yncM0uz/HL
         bq+VcKyUkQRDei4RpkzzNU3n36d6FTDg4VH/KkzZaKPMGYYxYGH4dLR6/eBlg+goJe
         +YYRGm7IGkkog+Y9GX7dk3bFk40WCM9WgmC/gwpbwRSQst18+Ekl9O0BSHDi+uB/wU
         yM5g+cUJ4MYwg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath12k: add support for hardware rfkill for
 WCN7850
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230906110412.182176-1-quic_lingbok@quicinc.com>
References: <20230906110412.182176-1-quic_lingbok@quicinc.com>
To:     Lingbo Kong <quic_lingbok@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <quic_jjohnson@quicinc.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169591318971.3019228.13253796564349878064.kvalo@kernel.org>
Date:   Thu, 28 Sep 2023 14:59:51 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lingbo Kong <quic_lingbok@quicinc.com> wrote:

> When hardware rfkill is enabled in the firmware, it will report the
> capability using WMI_SYS_CAP_INFO_RFKILL bit in the WMI_SERVICE_READY event
> to the host. Currently ath12k does not process this service capability. In
> order to support this, update ath12k to check if the capability is enabled,
> if so, send the GPIO information to firmware. When the firmware detects
> hardware rfkill is enabled by the user, it will report it using
> WMI_RFKILL_STATE_CHANGE_EVENTID. When ath12k receive the event, it will set
> the value of rfkill_radio_on based on whether radio_state is equal to
> WMI_RFKILL_RADIO_STATE_ON, then send WMI_PDEV_PARAM_RFKILL_ENABLE to
> firmware.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

004ccbc0dd49 wifi: ath12k: add support for hardware rfkill for WCN7850

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230906110412.182176-1-quic_lingbok@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

