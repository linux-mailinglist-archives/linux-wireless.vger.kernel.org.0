Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9EC7B204E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 17:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjI1PB0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 11:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjI1PBY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 11:01:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B70194
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 08:01:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CF6C433C8;
        Thu, 28 Sep 2023 15:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695913280;
        bh=Sv4ZYwTJOdt8iL9WrmtNcE/NncscTaorBT+D7H4XgLk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ePHKEK7kdeARJnGXIHDaatuXWLffil8m9TDDOfhKeuFmylbKUDrqWvSxsT0PkdCtI
         JdmfiCoYEPO0dhVDJi19IyjFzifjOSg9BStv/gfyhWpHDW7JWWsaUPGdFcYF7mZh7W
         NzxLERpHbGU7XCO72xwAIIX7UPcDWIlf5ConemRsch7k8OQ0QW90IkQp1XM8vC4iUV
         JZLMbnMm5p+zgMKBUuY+OYA6w2BJoHk3zzITfgLoo1AuK/HxNA1AVEvdADrZCQvDWL
         XwjPgGL5EqB1qQu+78IGQ1bk0YQskETFvLFu3lFoQ4IrQf8orVJ+Y2qixQjUBi+1kh
         IzRjuGxOEeDqg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix recovery fail while firmware crash when
 doing channel switch
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230905105229.10090-1-quic_wgong@quicinc.com>
References: <20230905105229.10090-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169591327779.3019228.18229314827081753794.kvalo@kernel.org>
Date:   Thu, 28 Sep 2023 15:01:19 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> When firmware crashed while channel switch running, recovery starts in
> ath12k. Then ieee80211_sta_connection_lost() will be called by function
> ieee80211_restart_work() in mac80211. And then many WMI command timeout
> because firmware is crashed. Each WMI command cost 3 seconds, then the
> total time will be large and leads recovery fail.
> 
> Hence change to set value ATH12K_FLAG_CRASH_FLUSH early and then
> ath12k_wmi_cmd_send() will not wait 3 seconds, then recovery will be
> started quickly and success.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

ecbb987b0a96 wifi: ath12k: fix recovery fail while firmware crash when doing channel switch

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230905105229.10090-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

