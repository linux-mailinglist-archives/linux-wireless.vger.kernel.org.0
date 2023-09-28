Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F66C7B2168
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 17:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjI1PdQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 11:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjI1PdP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 11:33:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFB6AC
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 08:33:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2384C433C7;
        Thu, 28 Sep 2023 15:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695915193;
        bh=1LuJxiMXhASalrUfVnL7ck/q6s7MQDu+aMOcytyqgAo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HVrYmn5uyV6eBfz6Gku2xahF9bWYa7EjgsVmgaJW8lNrR3Ufw5JmmKi1BVQDUfFKh
         t24ukabQ9r4BQnaDwZfzy/x7UneGV4dqBtqsyhDYlZDX31SEI4dpvW+JeYLBB2FrIq
         dVpFgXmq/NGQpXF1HhQKsw8IG1/K3EsqOYmgbHGcWe2yYxiTjpXfOeA14wzjkrDDEu
         aejBzsLS5TVrRLfDmoppIjulT3QahFvfNDlvmntH51ZXTS3zxrjKxyLBc5qrFCe4E5
         ApccGjDgsq0MuoOwKsFZ3ouuOwyyKCZXrPzmQK0UE6gT2wTg8VOYWGHNUrFwcMdHNc
         rOfvoBcoW+ogg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/4] wifi: ath12k: add TAS capability for WCN7850
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230910082802.9198-2-quic_lingbok@quicinc.com>
References: <20230910082802.9198-2-quic_lingbok@quicinc.com>
To:     Lingbo Kong <quic_lingbok@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <quic_jjohnson@quicinc.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169591519084.3096214.13489607891365501029.kvalo@kernel.org>
Date:   Thu, 28 Sep 2023 15:33:12 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lingbo Kong <quic_lingbok@quicinc.com> wrote:

> Currently, ath12k does not support Time-Average-SAR(TAS) for WCN7850. In
> order to enable Time-Average-SAR(TAS) for WCN7850, ath12k defines
> ath12k_get_acpi_all_data() function to get TAS configuration and SAR power
> table, then sets pdev_id, param_type_id, and finally sends the TAS
> configuration, SAR power table and WMI_PDEV_SET_BIOS_INTERFACE_CMDID
> command to firmware to implement TAS during the initialization phase.
> Besides, ath12k registers an ACPI event callback so that ACPI can notify
> ath12k to get the updated SAR power table and sends it to firmware when the
> device state is changed.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Fails to apply, please rebase.

error: patch failed: drivers/net/wireless/ath/ath12k/core.h:771
error: drivers/net/wireless/ath/ath12k/core.h: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath12k/hw.c:907
error: drivers/net/wireless/ath/ath12k/hw.c: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath12k/hw.h:186
error: drivers/net/wireless/ath/ath12k/hw.h: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath12k/wmi.h:4791
error: drivers/net/wireless/ath/ath12k/wmi.h: patch does not apply
stg import: Diff does not apply cleanly

4 patches set to Changes Requested.

13378463 [v4,1/4] wifi: ath12k: add TAS capability for WCN7850
13378462 [v4,2/4] wifi: ath12k: add BIOS SAR capability for WCN7850
13378465 [v4,3/4] wifi: ath12k: add adjust configuration of CCA threshold value for WCN7850
13378464 [v4,4/4] wifi: ath12k: add set band edge channel power for WCN7850

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230910082802.9198-2-quic_lingbok@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

