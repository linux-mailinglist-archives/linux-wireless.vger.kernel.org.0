Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7AF489C22
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jan 2022 16:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbiAJPZO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jan 2022 10:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbiAJPZO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jan 2022 10:25:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A58C06173F
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jan 2022 07:25:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFD2461300
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jan 2022 15:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4AAC36AE3;
        Mon, 10 Jan 2022 15:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641828312;
        bh=/VJ0Cw9FTAg5mzrYqiIHk7lGMB7zDTv+ZFsf5A3LoBw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GtH46hOCSkqYrTbrRYK6dH6CPvcVosVpYg5OBmSi6F6nDB+iitmXMuA899Kr2bZZc
         0k+fQ6/X/ctfp2G2Zt2NAKTUHi2vPxKl3OD2Pp2SFrMNBZh2SBli0RIfDD5bSc4Ykl
         4ekSfu3K6D6BdonnZl9TyTu8CKLzbKkWxgov7qPl8c/qu15xJ+IGPHfs6CU61DxaXY
         qhWzelmC7qGwVouNwR6fwSRz0U2gRNH0r+5IfnjOTCIW51cmu52sF5bBZ5mk/dBE8x
         FjPNSKonsFyytiw2bHN+a7KXEWTEPRRc4uvPqxK01BoqqRb8/Rx5iSjUZTLyBgN02w
         1ROTxPlFzbBRw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 00/15] ath11k: add support for 6 GHz station for various modes : LPI, SP and VLP
References: <20211224085236.9064-1-quic_wgong@quicinc.com>
Date:   Mon, 10 Jan 2022 17:25:09 +0200
In-Reply-To: <20211224085236.9064-1-quic_wgong@quicinc.com> (Wen Gong's
        message of "Fri, 24 Dec 2021 03:52:21 -0500")
Message-ID: <87h7abvciy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> v2: 
>    1. change some minor comments by Kalle.
>    2. rebased to ath.git ath-202112220603
>
> Depends on one patch:
> [v5] cfg80211: save power spectral density(psd) of regulatory rule
> https://patchwork.kernel.org/project/linux-wireless/patch/20210928085211.26186-1-wgong@codeaurora.org/

Please resubmit the patchset once the dependency is applied, I cannot do
anything before. Dropping the patchset.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
