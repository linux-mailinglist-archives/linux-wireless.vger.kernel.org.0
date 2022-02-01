Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EA94A5AEF
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Feb 2022 12:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbiBALMF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Feb 2022 06:12:05 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38218 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbiBALME (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Feb 2022 06:12:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57BE960F66
        for <linux-wireless@vger.kernel.org>; Tue,  1 Feb 2022 11:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F189EC340EB;
        Tue,  1 Feb 2022 11:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643713914;
        bh=kLHEZwxJCrInxikeCNY6kKv105duD8h5Jo90LH778UM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VUrjamPcp4KBIUUA1qqkdOopMjOfS3MFSM+SnjSYmZg3g1ia4xVNS/Vf3ZNqhBnYi
         LO8/ecVe6inUagzkEVYI9dcdWDPGPGr75xjrrc7iW6Cdt5MOsRwVE3Hod7Aatu1bqg
         S+COQyBCxlYmX/XykLYPZ5UwpX29yZn/Q5Z/Gxq9AW7V1Epnm+d9B9+YRsQwJFsDDF
         Gtl97ySL9Cyc42CA2s5Ihbf/++K921cKj4tPLJYlsi+VJQ1Vh+gtuaf7+GbHmt1Jt2
         b/8UXSHM4gnRZ/yJPmTa7qkc+8xI8UgNFNYslX0yz+RkQdkKFnTLgDh+h7mOFL69Hb
         05FjHgD0NbhDQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] dt: bindings: net: add bindings to add WoW support
 for
 WCN6750
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1643261093-12400-2-git-send-email-quic_mpubbise@quicinc.com>
References: <1643261093-12400-2-git-send-email-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164371391232.32371.14261682315173244748.kvalo@kernel.org>
Date:   Tue,  1 Feb 2022 11:11:53 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> wrote:

> Add required bindings to support WoW (Wake on Wireless) for
> WCN6750 used by ATH11K driver.
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>

Please resend once all dependencies are in ath tree.

2 patches set to Changes Requested.

12726278 [1/2] dt: bindings: net: add bindings to add WoW support for WCN6750
12726277 [2/2] ath11k: Add WoW support for WCN6750

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1643261093-12400-2-git-send-email-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

