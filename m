Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D247B208A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 17:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjI1PKL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 11:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjI1PKL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 11:10:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313A4F9
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 08:10:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5013C433C8;
        Thu, 28 Sep 2023 15:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695913807;
        bh=NXTjTsDG7CDzX5Iwc2hmjpWNBiJoigMMBP13X72p2hY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=P8Vs8bj4/PeZwLph7YX1mzhr6DSfX1dgfRJBRlEGWIclt8xXRP6N0E3BTbgIvuU0W
         xkmGfgPRRtJ8KhcIVWBucSjbCQRnW6o3KsFJ0D/gjDigPSCZLEbCXBmLXsh9igod24
         cUDdA/s7rvhGvP6wCHoYcZzWQH21N9XLieYCpfKGgTyJJXjLOe/pOBQpScf0V5JM1/
         P8UBM03y4XImvOmPEUTQc3ooP8C/0X7ISbD+AWN4vYb3BbWmc3gWPrOel7lbBg+8o6
         4B9Pt907aFb4I2f5RHRFeJMrclkMKzDqEoUFvpmERUMHA25pYopo682OQ+8Y88aGar
         MxVcNHxZCq7MA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: call ath12k_mac_fils_discovery() without
 condition
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230905174324.25296-1-quic_alokad@quicinc.com>
References: <20230905174324.25296-1-quic_alokad@quicinc.com>
To:     Aloka Dixit <quic_alokad@quicinc.com>
Cc:     <ath12k@lists.infradead.orgi>, <linux-wireless@vger.kernel.org>,
        Aloka Dixit <quic_alokad@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169591380503.3019228.7778641788765090431.kvalo@kernel.org>
Date:   Thu, 28 Sep 2023 15:10:06 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <quic_alokad@quicinc.com> wrote:

> Mac80211 does not set flags BSS_CHANGED_FILS_DISCOVERY and
> BSS_CHANGED_UNSOL_BCAST_PROBE_RESP if there are no updates to
> FILS discovery and unsolicited broadcast probe response transmission
> configurations respectively. For BSS change operations such as channel
> switch, this results in the transmissions getting stopped because the
> driver does not send WMI command to firmware if the flags are not set.
> Remove the checks for the flags to always send the existing
> configuration to firmware.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

43a10990404f wifi: ath12k: call ath12k_mac_fils_discovery() without condition

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230905174324.25296-1-quic_alokad@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

