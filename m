Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207C3729BA2
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 15:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbjFINcE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 09:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjFINcE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 09:32:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B232A3
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 06:32:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6EB4657A4
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 13:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528E9C433D2;
        Fri,  9 Jun 2023 13:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686317522;
        bh=Rw3dAMIdjdiaMCdDJYrhk/RgPHgoQhkwsP1VueIBGOg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Agdjl8FdSMrhueNuwn7Cch6xWahUS1ArVpQRVWQUhRa0UQFV1HJ7NBhZUGiAO3/pp
         gJlh421wysxOQiRXMsBrXrtJluqcrX2l5/iQmkMYNPuB0ebs98428bkEaeelojJ4vm
         gITf6unjME5FOfSnAO3AuoJQqsZkI1oNQaYRJIzq5+tO9AstfDkcqqusaabV3ceii4
         gXRT45rTkZGQsVwniZhN6fqrBBwkJtDv76JHN6CMBjuAJmsE332gXil5hq1v5sMFbv
         TKapFjCil8f0di8toqMk9u2bqsZC0ouZgGBEocPTJ4KwpxgbfnJOBWR5v9bMhKRAu6
         eboGFz0wKr40A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: Avoid NULL pointer access during management
 transmit cleanup
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230518071046.14337-1-quic_bselvara@quicinc.com>
References: <20230518071046.14337-1-quic_bselvara@quicinc.com>
To:     Balamurugan S <quic_bselvara@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Balamurugan S <quic_bselvara@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168631751914.7235.13826635338122633209.kvalo@kernel.org>
Date:   Fri,  9 Jun 2023 13:32:01 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Balamurugan S <quic_bselvara@quicinc.com> wrote:

> Currently 'ar' reference is not added in skb_cb.
> Though this is generally not used during transmit completion
> callbacks, on interface removal the remaining idr cleanup callback
> uses the ar pointer from skb_cb from management txmgmt_idr. Hence fill them
> during transmit call for proper usage to avoid NULL pointer dereference.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

054b5580a36e wifi: ath12k: Avoid NULL pointer access during management transmit cleanup

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230518071046.14337-1-quic_bselvara@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

