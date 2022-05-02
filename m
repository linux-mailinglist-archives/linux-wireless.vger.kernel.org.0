Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF72151710E
	for <lists+linux-wireless@lfdr.de>; Mon,  2 May 2022 15:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbiEBOBP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 May 2022 10:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbiEBOBO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 May 2022 10:01:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9DCD97
        for <linux-wireless@vger.kernel.org>; Mon,  2 May 2022 06:57:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD8D460B83
        for <linux-wireless@vger.kernel.org>; Mon,  2 May 2022 13:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD21C385AC;
        Mon,  2 May 2022 13:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651499864;
        bh=UsUVrQ8Uf8ZrHtaZGxrQgHbyM/8ZtJmWeyFLUL+cXiY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Bthfaf+kqA7O5R8dVeo33lK49k7ZoAVrDsHRmNm9jKWx4K8DJOGPu62/WS/qlxldL
         A+EvwZaWCRKKDKMIiA8pR7YIQko1kMm8fh8uOMp8ilcswxSKYZJHZplfUujPD+qEQT
         6J7V2FKHitKGGhiDPYOnIwJ/ZemVqYWFijt6u4CtPKIq7U8hHqEFEuYT+oJ1jS2Zc0
         gViZVQ4pX4wTdf3KOjuJIH/DnMF9MrwqRG0M7mJwhqe4Ss5tMaQYaMFlhBGrY8xB8g
         VqkZ8/jDyGUw7Gpwf1EkOWHlcSv/Yua1OO8VVPOUwfqA6nBrnSkBtMGzqVTME1AfoA
         Ljy1k+K1ah69g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: change management tx queue to avoid connection
 timed
 out
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220428023320.4007-1-quic_wgong@quicinc.com>
References: <20220428023320.4007-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165149986115.16977.2375062909122184081.kvalo@kernel.org>
Date:   Mon,  2 May 2022 13:57:43 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> In the phase of wlan load, it has hw scan and 11d scan which sent to
> firmware by ath11k, then hw scan and 11d scan will use about 14 seconds,
> and meanwhile ath11k_reg_update_chan_list() is running in workqueue of
> ath11k_base, and wait for 11d scan/hw scan finished. When the hw scan
> finished, mac80211 will start to connect and send management packet,
> at this moment, ath11k_reg_update_chan_list() is still waiting for 11d
> scan finished, so wmi_mgmt_tx_work of ath11k will not run and thus the
> tx management packet also not send out and lead authentication timed
> out.
> 
> log:
> INFO kernel: [  187.885322] wlan0: authenticate with 72:6c:57:43:9f:90
> INFO kernel: [  187.937266] wlan0: send auth to 72:6c:57:43:9f:90 (try 1/3)
> INFO kernel: [  188.626944] wlan0: send auth to 72:6c:57:43:9f:90 (try 2/3)
> INFO kernel: [  189.650999] wlan0: send auth to 72:6c:57:43:9f:90 (try 3/3)
> INFO kernel: [  190.651917] wlan0: authentication with 72:6c:57:43:9f:90 timed out
> 
> Change wmi_mgmt_tx_work to another queue workqueue_aux of ath11k_base,
> then connection success.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

3a597f0d425b ath11k: change management tx queue to avoid connection timed out

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220428023320.4007-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

