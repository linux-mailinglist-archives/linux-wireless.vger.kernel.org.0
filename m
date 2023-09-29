Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503477B3324
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Sep 2023 15:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjI2NOQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Sep 2023 09:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjI2NOP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Sep 2023 09:14:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E38FB7
        for <linux-wireless@vger.kernel.org>; Fri, 29 Sep 2023 06:14:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040A2C433C7;
        Fri, 29 Sep 2023 13:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695993252;
        bh=O4hzLS/XuHCuydKsZZsYUqjM14D+1V27EczXw7yQidU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=SpibCTxRqp2m8Lv8cYeJ5//+XeQf8rBn7jatf5XDCLrhkUOxBPaPO5uepJDbkf6Rz
         Es3uNhrVKhCPrK87ZJHxzs1g5jerVAsd/Ei+7s9nC6t48rqTT1WPhr/OZMNQdFz1JK
         G4s8X2uWuIA5I+1hB6A3f9wsWitGpYowYEuonfnEvhQjGjBXzUtykSkHZLBAKjtKko
         CAzj9A6wtdtByV7u5VWAp4DOWxt6QTpGs1pYOny+C1EA0cGjYbHxOLbJBpJ3EnA/Uh
         GqF+BYayhylPbYAFYCIGKiZghwUbq7xPuAqyaAKu03KgdTioHkmdMefhZiadpy5ycJ
         g0ArRX2xsVf8A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: add read variant from SMBIOS for download
 board data
References: <20230905105637.10230-1-quic_wgong@quicinc.com>
Date:   Fri, 29 Sep 2023 16:14:09 +0300
In-Reply-To: <20230905105637.10230-1-quic_wgong@quicinc.com> (Wen Gong's
        message of "Tue, 5 Sep 2023 06:56:37 -0400")
Message-ID: <87pm216s0u.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> This is to read variant from SMBIOS such as read from DT, the variant
> string will be used to one part of string which used to search board
> data from board-2.bin.
>
> Tested-on: WCN7850 hw2.0 PCI
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

This had a trivial conflict in core.h, fixed in the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=e19165609e6c2823e74ca1a1517f9213b3a540ae

No need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
