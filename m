Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2794C49F982
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 13:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348521AbiA1Mgq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 07:36:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34050 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348522AbiA1Mgm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 07:36:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 461C8B824FD
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 12:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAFAC340E0;
        Fri, 28 Jan 2022 12:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643373400;
        bh=p0mR1n9ytCzDF6gknLkijc6pYipo5egtlddRvfLC/ro=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=sdFlzZFXR5OFDCuMAuV6YwEqjwooa0geVyu4ny2HTFUbZX4FyDCN71pTYSFmOYKLy
         H0WaVSzs2LC1B1frcx0eD77iJQ/JTR9vTYVcOFMX1j1XYamnjJlJVfPyZMni5i/WDB
         unzxCQmvOd2h7riNbnNVaciZRrR6B0/koGhmAAHbkzljvYpTvpZ5jItA74b1tQcjLe
         +0PIsjpcURMlRVRAWtedP44ZbdxRDg1Z08779k05fwwzP9Cp0tdq63sfxxFfhx+UBg
         L8fbc6Z1jUK2GGfffLLI0hFvWRamSd+tXnvZAvQ0ud0LrUbZ5LGaX0NuQT64WzPjsY
         Ie6MrY3CippWA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: avoid firmware crash when reg set for
 QCA6390/WCN6855
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220119041355.32014-1-quic_wgong@quicinc.com>
References: <20220119041355.32014-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164337339737.4876.9836049185308281740.kvalo@kernel.org>
Date:   Fri, 28 Jan 2022 12:36:38 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> For the NL80211_REGDOM_SET_BY_USER hint from cfg80211, it set the new
> alpha2 code to ath11k, then ath11k send WMI_SET_INIT_COUNTRY_CMDID to
> firmware for all chips currently. When test with WCN6855/QCA6390 chips,
> this WMI CMD leads firmware crash.
> 
> For AP based chips(ipq8074/qcn9074), WMI_SET_INIT_COUNTRY_CMDID is used
> to send to firmware, for STATION based chips(WCN6855/QCA6390), it need to
> use another WMI CMD WMI_SET_CURRENT_COUNTRY_CMDID.
> 
> Add flag current_cc_support in hardware parameters, it is used to
> distinguish AP/STA platform. After that, the firmware will work
> normal and the regulatory feature works well for QCA6390/WCN6855.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03003-QCAHSPSWPL_V1_V2_SILICONZ_LITE-2
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

0d6e997b7621 ath11k: avoid firmware crash when reg set for QCA6390/WCN6855

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220119041355.32014-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

