Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E78569AFF8
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 16:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjBQP6G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 10:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBQP6F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 10:58:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4917119A
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 07:57:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC48861DF6
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 15:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDC1C433EF;
        Fri, 17 Feb 2023 15:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676649460;
        bh=g8Q+/5BohF9DA50sSIUOESQeowqyhkU5uSpAtgg+bIo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=PVo6edfuRWyPDs50DOZYRLy3R/jE1/D3DXWifZsAMSNSj3w1/hCoPuvyB4r81xpmJ
         cKwjzDT0dLBXpF2wgbCoJwN6fCGr/U+GBJnXyXktGT/cjx2j6ocSe4fkkCGDYhARmT
         eciGQ+mixo2sQJMEePFyxAqZgNvFf7exV54A4U/ZpOL8B8WmsjfEogSIX/4+U50Hid
         /V9Aj3mRIjf2w2RvAbooryTFvyLvK7dh5q8TKR8DdNQW9hkEK8rgN7Ha3XOieFNSlw
         NyUWTRVeqXv2Ts2lU+GMgPirXI+97yL76GSluehqnzALd2NSymSnWzGYpcy9iwUL7G
         OR62LFgFb2SLA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: Set ext passive scan flag to adjust passive
 scan start time
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221222131720.11368-1-quic_tamizhr@quicinc.com>
References: <20221222131720.11368-1-quic_tamizhr@quicinc.com>
To:     Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167664945324.27521.5550862746397183155.kvalo@kernel.org>
Date:   Fri, 17 Feb 2023 15:57:39 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tamizh Chelvam Raja <quic_tamizhr@quicinc.com> wrote:

> Set the WMI_SCAN_FLAG_EXT_PASSIVE_SCAN_START_TIME_ENHANCE flag
> while sending the scan command.  If this flag is enabled when the
> incoming scan request comes with a strict start time and its duration
> overlaps with next TBTT, then target adjust the start time accordingly
> for passive scan. Target supporting this feature will advertise
> WMI_TLV_SERVICE_PASSIVE_SCAN_START_TIME_ENHANCE.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01467-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

cf8f3d4deb02 wifi: ath11k: Set ext passive scan flag to adjust passive scan start time

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221222131720.11368-1-quic_tamizhr@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

