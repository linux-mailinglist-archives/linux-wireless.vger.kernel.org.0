Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F69649FA4F
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 14:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbiA1NGF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 08:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbiA1NGE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 08:06:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DFAC061714
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 05:06:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 631A0B8251F
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 13:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BD6C340E0;
        Fri, 28 Jan 2022 13:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643375162;
        bh=YLdCeRRAO7aC5upx7PDW5LyeDkyTbwukVgcbaGW2FDk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mBFs3rp27b5sM9qp0wLW38fp9ZRpqcZxlaVYQBS2288G40Gytz1kcN68SyxVMJsdh
         8OsVUHbqX5DT/6hBYV6q7T6XX96J3GumboVI4i3/BywOZe1wEo7RXToTbaUHQLTtDC
         /iDRnei2CK9oIRB4cv7UUD9ZUNW7koMrS09k9twuY8CiRebu9UK8fTbCFWGm2nFIc5
         n+YWtsl7v+LcAsf+lqaQ3yW8MGkjE3RCwIWd3QwCnLf5rRnCbFKOok77qm4YY/NJSA
         vnnn2yjNMWlH2lPPctBPLUq0kUayGxj75qtGNmq22oSkEjupHseGma7w7aS1fLvWEP
         cCo+Ficn97sCQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Add peer rhash table support
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1640248077-14075-1-git-send-email-quic_periyasa@quicinc.com>
References: <1640248077-14075-1-git-send-email-quic_periyasa@quicinc.com>
To:     Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164337515701.4850.13179705947072575386.kvalo@kernel.org>
Date:   Fri, 28 Jan 2022 13:06:01 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> When more clients (128) are connected, the UL data traffic
> KPI measurement is low compared to single client. This issue
> is due to more CPU cycles spent on the peer lookup operation
> with more clients. So reduce the peer lookup operation by
> modifying the linear based lookup operation into the rhash
> based lookup operation. This improve the peak throughput
> measurement. Since this is a software algorithm change, it is
> applicable for all the platforms.
> 
> TCP UL 128 Clients test case Observation (64bit system):
> Previous: ~550 Mbps
> Now	: ~860 Mbps
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01067-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Fails to apply, please rebase.

error: patch failed: drivers/net/wireless/ath/ath11k/mac.c:4524
error: drivers/net/wireless/ath/ath11k/mac.c: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1640248077-14075-1-git-send-email-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

