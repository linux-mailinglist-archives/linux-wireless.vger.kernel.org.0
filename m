Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBF57C7277
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 18:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379539AbjJLQZh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 12:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379523AbjJLQZg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 12:25:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B5AE5
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 09:25:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08ABDC433C8;
        Thu, 12 Oct 2023 16:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697127933;
        bh=YNQigbYz044LjlyWkF5uH8izFEBMRQbk1jX2yJ52+HY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=owaWl7YQ8CnnS8FHNgaUmwuOWAC9NgEW/SJD0KRbScPfd64osPjXVcgNLqVU0g8oz
         ngcdI96wzEYrLaZGl3f9arnzEKoHou0vIoPcM5CneqP67ZXZxMsxMeyFmbCB8/QHGJ
         RfvZn6getXkISasQei58JKPmijzRU6NeJspdpRztm0HPn2N4d8wTtT4zDZ2YEHk/0W
         kty0qATbNINUCZKFw+QsIGWsLXNhpOIpCVrj4xIiZzCxtLTXThKfMdER+IKYMij5Y7
         dZjPzeZnvUNREq5nVsSx3SlumDxIq5ER8LHYN9gl8F29+4EleDUxStU8jaqxSYJEuO
         4kWyZS8uG4cYA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 1/4] wifi: ath12k: add TAS capability for WCN7850
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231011050004.423413-2-quic_lingbok@quicinc.com>
References: <20231011050004.423413-2-quic_lingbok@quicinc.com>
To:     Lingbo Kong <quic_lingbok@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <quic_jjohnson@quicinc.com>,
        <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169712793008.3550118.7804115872979270031.kvalo@kernel.org>
Date:   Thu, 12 Oct 2023 16:25:31 +0000 (UTC)
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
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

This adds a lot of new warnings:

drivers/net/wireless/ath/ath12k/wmi.c:7172:21: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath12k/wmi.c:7172:21:    expected restricted __le32 [usertype] length
drivers/net/wireless/ath/ath12k/wmi.c:7172:21:    got int
drivers/net/wireless/ath/ath12k/acpi.h:27: line length of 96 exceeds 90 columns
drivers/net/wireless/ath/ath12k/acpi.c:115: line length of 96 exceeds 90 columns
drivers/net/wireless/ath/ath12k/acpi.c:152: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath12k/acpi.c:154: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath12k/acpi.c:165: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath12k/acpi.c:255: line length of 91 exceeds 90 columns
drivers/net/wireless/ath/ath12k/acpi.c:257: line length of 91 exceeds 90 columns
drivers/net/wireless/ath/ath12k/acpi.c:278: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath12k/acpi.c:301: line length of 94 exceeds 90 columns
drivers/net/wireless/ath/ath12k/acpi.c:309: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath12k/acpi.c:317: line length of 96 exceeds 90 columns
drivers/net/wireless/ath/ath12k/acpi.c:328: line length of 95 exceeds 90 columns
drivers/net/wireless/ath/ath12k/acpi.c:330: line length of 95 exceeds 90 columns
drivers/net/wireless/ath/ath12k/wmi.c:6995: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath12k/wmi.c:7007: line length of 91 exceeds 90 columns
drivers/net/wireless/ath/ath12k/wmi.c:7009: line length of 94 exceeds 90 columns
drivers/net/wireless/ath/ath12k/wmi.c:7035: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath12k/wmi.c:7047: line length of 91 exceeds 90 columns
drivers/net/wireless/ath/ath12k/wmi.c:7049: line length of 94 exceeds 90 columns
drivers/net/wireless/ath/ath12k/wmi.c:7070: line length of 97 exceeds 90 columns
drivers/net/wireless/ath/ath12k/wmi.c:7079: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath12k/wmi.c:7099: line length of 91 exceeds 90 columns
drivers/net/wireless/ath/ath12k/wmi.c:7101: line length of 94 exceeds 90 columns
drivers/net/wireless/ath/ath12k/wmi.c:7128: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath12k/wmi.c:7139: line length of 91 exceeds 90 columns
drivers/net/wireless/ath/ath12k/wmi.c:7141: line length of 94 exceeds 90 columns
drivers/net/wireless/ath/ath12k/wmi.c:7168: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath12k/wmi.c:7180: line length of 91 exceeds 90 columns
drivers/net/wireless/ath/ath12k/wmi.c:7182: line length of 94 exceeds 90 columns
drivers/net/wireless/ath/ath12k/wmi.c:7207: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath12k/wmi.c:7219: line length of 91 exceeds 90 columns
drivers/net/wireless/ath/ath12k/wmi.c:7221: line length of 94 exceeds 90 columns

Please ALWAYS run ath12k-check.

4 patches set to Changes Requested.

13416565 [v6,1/4] wifi: ath12k: add TAS capability for WCN7850
13416566 [v6,2/4] wifi: ath12k: add BIOS SAR capability for WCN7850
13416564 [v6,3/4] wifi: ath12k: add adjust configuration of CCA threshold value for WCN7850
13416567 [v6,4/4] wifi: ath12k: add set band edge channel power for WCN7850

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231011050004.423413-2-quic_lingbok@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

