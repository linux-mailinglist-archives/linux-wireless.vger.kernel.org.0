Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A502D46E3CE
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 09:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbhLIIO0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 03:14:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39796 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbhLIIOZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 03:14:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1203BB81671
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 08:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00B4C004DD;
        Thu,  9 Dec 2021 08:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639037450;
        bh=Kx5MBSbwU5jq+zQ3PRJJLr4QP7RIu2pMRaeW29p0Z88=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=V53leU9dNHJCIf4/fImOCt4lWjv7CHFlUWwTDOXCmvizfviS//CFlEDAbBToJBeme
         haGqWJk4fexYhOkM3QRQT10DJWXYlJpiJ5ztTANKOXVagggJCi2QktdMQpnOo3OMGQ
         8DijnEw3hJj8nqkZqJvLyfe0QblYaODxGuPin/VoURORDHncfEsxv2fhHxHCK7KijN
         ABNxG4o2rF1Vdn9IXwqdTYv9xrqJlHGXRMhwCvYWDLIj5lE2f0bdoeB1SUz71agDl7
         AMNTzwujgd1kkLZtleCjFVpYxxL+PJFHdkg/If1xdPFPf4Tpku9HG/hxKAF4TNpM0e
         7uj1EQSsaYCqA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] ath11k: Add htt cmd to enable full monitor mode
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1638881695-22155-2-git-send-email-akolli@codeaurora.org>
References: <1638881695-22155-2-git-send-email-akolli@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163903744561.4504.3172414546384512849.kvalo@kernel.org>
Date:   Thu,  9 Dec 2021 08:10:49 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> wrote:

> A new hw_param full_monitor_mode is added to enable full
> monitor support for QCN9074.
> HTT_H2T_MSG_TYPE_RX_FULL_MONITOR_MODE cmd is sent to FW
> to enable the full monitor mode.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

5c1f74d24d92 ath11k: Add htt cmd to enable full monitor mode
88ee00d130f7 ath11k: add software monitor ring descriptor for full monitor
7e2ea2e94704 ath11k: Process full monitor mode rx support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1638881695-22155-2-git-send-email-akolli@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

