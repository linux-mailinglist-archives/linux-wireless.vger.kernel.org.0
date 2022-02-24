Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC174C2775
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Feb 2022 10:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiBXJDw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Feb 2022 04:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbiBXJDv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Feb 2022 04:03:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEB4187E39
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 01:03:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6EF9B81C4A
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 09:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D0DC340E9;
        Thu, 24 Feb 2022 09:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645693398;
        bh=Ye/kOTRU54AFDLMzyPkcnEa1MMb05KmMsi0JsDv28tw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WJDrokWBfK0VHDtZfRMZXxCu3t7xyDI0biy+DT9SlP729C1BT0NxDxWaoU/Lkqkj8
         zzodrd13KSyffZxo4IuImFscoiM2s7FXCP3CYsEa0FQ47lHIvaKIXkYOU+6quYmaRL
         EXuf24GBifNbJKQ96tbCSAdaKxLbXSXBpTqmaJYN4KjTK6FWPGcLsxXAHA0DPt7kzc
         pTlXq2UdxLn2KvCtZiDHn3+nx/aKsDPrVHlsTMe99NxZ2YYanylkFTxOdvj8coTKSr
         qsWkODcff+/ePB1WaB1Q5B4m4EscmqERFDAeQzL6WkFxjpgzmojnO/SaIWnbMs1jli
         UqMQEkB24CvyA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCHv3] ath11k: add dbring debug support
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1645366059-11798-1-git-send-email-quic_vnaralas@quicinc.com>
References: <1645366059-11798-1-git-send-email-quic_vnaralas@quicinc.com>
To:     Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164569339560.30378.9204871614230045974.kvalo@kernel.org>
Date:   Thu, 24 Feb 2022 09:03:17 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Venkateswara Naralasetty <quic_vnaralas@quicinc.com> wrote:

> Target copies spectral report and CFR report through dbring to
> host for further processing. This mechanism involves ring and
> buffer management in the Host, FW, and uCode, where improper
> tail pointer update issues are seen.
> 
> This dbring debug support help to debug such issues by tracking
> head and tail pointer movement along with the timestamp at which
> each buffer is received and replenished.
> 
> Provide a debugfs interface to enalbe/disable dbring debug
> support and dump the dbring debug entries.
> 
> Also introduced a new hardware param to add dbring debugfs support
> for few hardwares which are using dbings.
> 
> Usage:
> 
> echo <dbr_id> <val> > /sys/kernel/debug/ath11k/ipq8074_2/
> mac0/enable_dbr_debug
> 
> dbr_id: 0 for spectral and 1 for CFR
> val: 0 - disable, 1 - enable.
> 
> Tested-on: IPQ8074 WLAN.HK.2.4.0.1-01467-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

691425b4a41f ath11k: add dbring debug support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1645366059-11798-1-git-send-email-quic_vnaralas@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

