Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA3B6EF6A5
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Apr 2023 16:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241466AbjDZOnp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Apr 2023 10:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241463AbjDZOno (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Apr 2023 10:43:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C28A769A
        for <linux-wireless@vger.kernel.org>; Wed, 26 Apr 2023 07:43:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31B5362F1B
        for <linux-wireless@vger.kernel.org>; Wed, 26 Apr 2023 14:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AAFC433D2;
        Wed, 26 Apr 2023 14:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682520218;
        bh=L2Vzdv6hOho6TXdQfHRywvuKJkSdfA/V0BiA3MIf7Mc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HQW/MxDfsTK4+daANmC4qmkyDQh+XE/cJsU3UMrv4tUXe2UGgmRwSknPRPQX/UyK1
         IpzqEzflOQPjaHmxl4wk10rDjrsLLlXEP3XuDVVKYXqWEv08O3HplxM9RdBWtehlvZ
         UfxyZms3RPSk2MbFgLN2HqUwDzijkZhFYBEoUdWG8JLPMcWFQP9v8liyrx9TUClx/o
         J2LtTaFi8AAvKLtezoK8s2JiILRZbG4aOhpzvc1gJs4rY+h/918Q4JwtUoiBCzLn09
         HIm0rBwmFoFyez4ZEgStMygu7HGvy17mb/mbJkP9yz8TcQ4HPrl5Vf9o96TobiSzgq
         paxw110Brz+xw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/4] wifi: ath11k: remove unused function
 ath11k_tm_event_wmi
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230420120840.18712-2-quic_rajkbhag@quicinc.com>
References: <20230420120840.18712-2-quic_rajkbhag@quicinc.com>
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Govindaraj Saminathan <quic_gsaminat@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168252021295.23116.4251638014405306608.kvalo@kernel.org>
Date:   Wed, 26 Apr 2023 14:43:37 +0000 (UTC)
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

> From: Govindaraj Saminathan <quic_gsaminat@quicinc.com>
> 
> The function ath11k_tm_event_wmi() is only defined and it is not used
> anywhere. Hence remove unused function ath11k_tm_event_wmi().
> 
> Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Govindaraj Saminathan <quic_gsaminat@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Please wait I'll push back my changes to the pending and use that as the
baseline for v4.

4 patches set to Changes Requested.

13218645 [v3,1/4] wifi: ath11k: remove unused function ath11k_tm_event_wmi
13218646 [v3,2/4] wifi: ath11k: optimize ath11k_tm_cmd_get_version
13218648 [v3,3/4] wifi: ath11k: factory test mode support
13218647 [v3,4/4] wifi: ath11k: Allow ath11k to boot without caldata in ftm mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230420120840.18712-2-quic_rajkbhag@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

