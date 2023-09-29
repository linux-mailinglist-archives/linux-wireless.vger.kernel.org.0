Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34ED07B331F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Sep 2023 15:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjI2NMD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Sep 2023 09:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjI2NMC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Sep 2023 09:12:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDE11AB
        for <linux-wireless@vger.kernel.org>; Fri, 29 Sep 2023 06:12:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05079C433C7;
        Fri, 29 Sep 2023 13:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695993120;
        bh=VwhPo7thtDa/O3CwoVZUwDUOz3iWStVOolqNk43Hng0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KQhlqnlzHYnCxgZnIW9X8aFZgEi9U8sT0BW1GANF58FKrfu+sSfpQv0R3Pa+N0OmQ
         HGGEjkkK0YBKekHzvjVJcT9IDGys2Xhv+jbXgNIaUJVRPfFA4VU+HgaH4St6amIDbo
         bAz2ami/q+6JViwsgJd6PNHFfWCuUnoYtpmT8h1x6PqdIuKynncE3NihJVkybtGZBf
         W+S9Ask6O5DLulssR49E3x1jMcDHo668+Wtv4YObQYtnFE5mF7s3ULQ+gezEsAoJgd
         OFFuyBtlOpcFezsbjZzNsUvWNfOwfMrX+ARGCivgdGq8nDHQhcFFXPn9ALxyZ0xmSu
         wnCAsStonn3Vg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH v2 0/4] wifi: ath12k: add 11d scan offload support and
 handle country code for WCN7850
References: <20230914090746.23560-1-quic_wgong@quicinc.com>
Date:   Fri, 29 Sep 2023 16:11:56 +0300
In-Reply-To: <20230914090746.23560-1-quic_wgong@quicinc.com> (Wen Gong's
        message of "Thu, 14 Sep 2023 05:07:42 -0400")
Message-ID: <87ttrd6s4j.fsf@kernel.org>
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

> v2: change per Jeff.
>     1. change alpha2 length from 3 to 2.
>     2. change wmi_11d_new_cc_ev to wmi_11d_new_cc_event.
>
> Add handler to send WMI_SET_CURRENT_COUNTRY_CMDID which is needed for 
> 11d scan offload to firmware. And add support for 11d scan offload for 
> WCN7850.
>
> Also fix firmware crash for country code set for WCN7850 and store country
> code for device recovery for WCN7850.
>
> Wen Gong (4):
>   wifi: ath12k: add configure country code for WCN7850
>   wifi: ath12k: add 11d scan offload support
>   wifi: ath12k: avoid firmware crash when reg set for WCN7850
>   wifi: ath12k: store and send country code to firmware after recovery

Patches 2 & 3 had trivial conflicts with rfkill patches, fixed in the
pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=3261a8fe9de8fd5a94215eaf0c8738c3f0051105

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=0f82a7f8a8d1944faea458f992d492daa74a968e

No need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
