Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D980E49FD3B
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 16:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349739AbiA1P5J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 10:57:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52592 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349725AbiA1P5J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 10:57:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DCC6B80D30
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 15:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61595C340E0;
        Fri, 28 Jan 2022 15:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385427;
        bh=0uVEpOb+h7rctqQAQjrf1nqez07HUOriEI75Z0J0Zxc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=M3bAAcyDlMe1DmzOFH2GaVQkREZdJ+17yWCc4vrcgbWg6RIjKaCT7t5Lf25/BOfl3
         lLHgQnWPyZRxi/IM4ue8zwMTux6Tw8bZf6QLPNa0mc8hTzY/3pdoJ1lXqGtUduAIxt
         2Dn3CQbxevWm5g53vGHNujOWJoxY+N7yxHuSDvaE/7R8+4fsEubnpFoWry3mt4eSk7
         j/XIpMFL2q2yvmMq7Rz3oGES+prXOWpRPzYW38gUvwNRwOMSWu6L9deyai2b4309tv
         LYp+MPo6c9gZzFAN0ucgud70mZN9l6Iy53HC6H7I4ybgIZkqm5zXsW0TPbSDUxUEtE
         DCwzf+je82ieg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/19] rtw89: configure rx_filter according to
 FIF_PROBE_REQ
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220107034239.22002-2-pkshih@realtek.com>
References: <20220107034239.22002-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164338542435.19531.4499153220036896570.kvalo@kernel.org>
Date:   Fri, 28 Jan 2022 15:57:06 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> With this patch, we can receive probe_req and reply probe_resp, and STA
> can find us.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

12 patches applied to wireless-next.git, thanks.

6629dc5697cc rtw89: configure rx_filter according to FIF_PROBE_REQ
91644020dbd9 rtw89: use hardware SSN to TX management frame
f7e76d13bb2b rtw89: download beacon content to firmware
fccca9345b25 rtw89: add C2H handle of BCN_CNT
d62816b4a44e rtw89: implement mac80211_ops::set_tim to indicate STA to receive packets
c7df64c194f6 rtw89: allocate mac_id for each station in AP mode
742c470b5773 rtw89: extend firmware commands on states of sta_assoc and sta_disconnect
8b252070d790 rtw89: rename vif_maintain to role_maintain
283c3d886fdf rtw89: configure mac port HIQ registers
11d261f24be6 rtw89: send broadcast/multicast packets via HIQ if STAs are in sleep mode
9eecaec238c8 rtw89: set mac_id and port ID to TXWD
14f0999d49e7 rtw89: separate {init,deinit}_addr_cam functions

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220107034239.22002-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

