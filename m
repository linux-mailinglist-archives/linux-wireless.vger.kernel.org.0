Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C3E490937
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jan 2022 14:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbiAQNIz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jan 2022 08:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240127AbiAQNIu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jan 2022 08:08:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154CAC06173E
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jan 2022 05:08:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A61BB80EFF
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jan 2022 13:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE88C36AE3;
        Mon, 17 Jan 2022 13:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642424927;
        bh=mf/sb1Cwt7TIVvJhl71c/+zQwiXZL7+LbRn7cUY1d90=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fg20wILmBQ40+cptowW9Uld4aqiyZr3K0gUxFhuAJcfYRA3BrBxKbTNLYuSRU8Xsv
         rM97uw7WR9mqPxn8BVUabO6FReT3b8Xkw50sfNnQWBLXAsrnX0R9jyw9rf8jwGWzUp
         ClnKjinOvLWZO1v+Q9gPkZiAes1d57eoNR9ZqEMlGVNU1j6JfZpXZ4lV6gDh5KftjH
         oGH+dW4ckjvW5ASWAJ6Mv+BVPfEeAB1yQoQaoJ9anjrULD/ADBq/USMm2PPzr1dbnv
         89tze00nO8fGXq9IpAw+TwLD7mQqXMJO04cpLEd3ttY3J67000T/PfiYuaudphQzOQ
         dOqsi/vKdrXHA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: set WMI_PEER_40MHZ while peer assoc for 6 GHz
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220113023145.14292-1-quic_wgong@quicinc.com>
References: <20220113023145.14292-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164242492251.16331.2627237965817574376.kvalo@kernel.org>
Date:   Mon, 17 Jan 2022 13:08:45 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> When station connect to AP of 6 GHz with 40 MHz bandwidth, the TX is
> always stay 20 MHz, it is because the flag WMI_PEER_40MHZ is not set
> while peer assoc. Add the flag if remote peer is 40 MHz bandwidth.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-02892.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Fixes tag

  Fixes: 2cdf2b3cdf54 ("ath11k: add 6ghz params in peer assoc command")

has these problem(s):

  - Target SHA1 does not exist

Did you mean:

Fixes: c3a7d7eb4c98 ("ath11k: add 6 GHz params in peer assoc command")

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220113023145.14292-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

