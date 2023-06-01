Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE687199C3
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 12:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjFAKbW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 06:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjFAKbG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 06:31:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A926E50
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 03:31:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 147EB64349
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 10:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1D3C4339E;
        Thu,  1 Jun 2023 10:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685615462;
        bh=d0fuOG/QASBwSsrWcPuJdodt8L54UCvAIEmtMbErH8Y=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=rrmGUkQ27JcFPLQ/YuHxcBnL+050wDKX+clrbzJJ9XrjFUT1r9yruDtE31scNg4Rk
         gIBlOKCLKVL7Ks34fWeqaGp+C0jP7dfyXJAbQKr2t3fSUmsw1daYudONbtW82Yl/Qb
         HEhavW2z6zI5/hlgaQ84ci1kvZNRmPugNxM+BHAIABgj+CwjdFkUJUVgkm1Jon1qI4
         Dg+zLfB5SaevAHKdtSW+AV/88Vw7+TIcjsVYLqYpSB7K6qvASKZ1BFDU52/kTGmoMV
         jNpoxaoae1TJnJg4msN8phKqvvgiFAtohIFFit88l4ELx11kny2u6eswL9Ca//qjot
         vcyWAZMvpdoHg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/4] wifi: ath11k: remove unused function
 ath11k_tm_event_wmi
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230517135934.16408-2-quic_rajkbhag@quicinc.com>
References: <20230517135934.16408-2-quic_rajkbhag@quicinc.com>
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Govindaraj Saminathan <quic_gsaminat@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168561545941.17301.10017481813934877130.kvalo@kernel.org>
Date:   Thu,  1 Jun 2023 10:31:01 +0000 (UTC)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> wrote:

> The function ath11k_tm_event_wmi() is only defined and it is not used
> anywhere. Hence remove the unused.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Govindaraj Saminathan <quic_gsaminat@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

86f85575a3f6 wifi: ath11k: remove unused function ath11k_tm_event_wmi()
b43310e44edc wifi: ath11k: factory test mode support
8aeba427296b wifi: ath11k: Allow ath11k to boot without caldata in ftm mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230517135934.16408-2-quic_rajkbhag@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

