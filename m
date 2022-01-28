Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E87249FD26
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 16:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349703AbiA1Pxb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 10:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349686AbiA1Pxa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 10:53:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CE2C061714
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 07:53:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D16AB803F5
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 15:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F944C340E0;
        Fri, 28 Jan 2022 15:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385207;
        bh=/+326vQaypxsL4nvOY6Jje1FjbPxvBr+GuPuX3Z7n60=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=NdPf0hV1TwsRHlTwRpTU4cTlLFVEOWNhp2+AcZ19Z9Tf42heuYyJoCMXcT62ol/cT
         596Ni3l2F3J276edI4JixN7AEMlRNpuXoB4asmy9sRb96EZJ2LablD3VFZYR5z3cGt
         xl1BRX12sVN7SqHGg0XKzQo0ETGtjtKB+2J1Gm00eYSauWlBh/7v+v2sGq4phuKKUb
         eTz4bAYv8ze9D9MZGvL/gqyf/UKfdgDfiAIH3VETNE9csNMLWXzdj3yPUp8aaqy3u+
         flXMI/4OxXVjR/aQ8Uc+oszVz97WWBXZqpIFkDXsh2Y4k8TSPeQJkQs0Ilw0FY60Hv
         SGwDPLh3/2+tA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 13/19] rtw89: extend role_maintain to support AP mode
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220107034239.22002-14-pkshih@realtek.com>
References: <20220107034239.22002-14-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164338520563.19531.17617789676100442869.kvalo@kernel.org>
Date:   Fri, 28 Jan 2022 15:53:27 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Fill mac_id and self_role depends on the operation mode.
> 
> In AP mode, echo connected station has an unique mac_id, and each vif also
> has one mac_id to represent itself.
> 
> The self_role is assigned to vif if the operation mode is decided, and
> RTW89_SELF_ROLE_AP_CLIENT is assigned to the connected STA in AP mode,
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Dropping rest of the patches due to my comment.

7 patches set to Changes Requested.

12706170 [13/19] rtw89: extend role_maintain to support AP mode
12706171 [14/19] rtw89: add addr_cam field to sta to support AP mode
12706172 [15/19] rtw89: only STA mode change vif_type mapping dynamically
12706173 [16/19] rtw89: maintain assoc/disassoc STA states of firmware and hardware
12706174 [17/19] rtw89: implement ieee80211_ops::start_ap and stop_ap
12706175 [18/19] rtw89: debug: add stations entry to show ID assignment
12706176 [19/19] rtw89: declare AP mode support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220107034239.22002-14-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

