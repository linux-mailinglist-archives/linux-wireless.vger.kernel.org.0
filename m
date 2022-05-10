Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB7B522152
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 18:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244652AbiEJQhr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 May 2022 12:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345197AbiEJQhp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 May 2022 12:37:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D6F205276
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 09:33:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73143B81B13
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 16:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D101C385C2;
        Tue, 10 May 2022 16:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652200425;
        bh=ATApjDbGMfNgkdqEBc3IxlSWcXiB++i8IPcApWWpGgQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=X2LmjkjLNvJUOzLyNiGBCJtUHXAZdoZ3EIYzzPO8nr3bB93uh9Qy+2v3Q2MbaR5J+
         SqNm0Sjhj0lHCbHA6lXVONJ8BQCSy7+nJIi+S6EpbeZoN3++rH94bQVr3c8sDqH84d
         ziEzz6fCI1OtXpmIEtnAnwlqyEXpmRwzcT6SHg1T4MFugBodG0pe998ref5hC+03bb
         3z6V+5rUNhWZpv42tU1Wc80DLgDtxz0Zy+R5RK+0nwRXNRc2aZf526ba5tx5uh4CQh
         xh+2OMBg4Nr1SlL/Ee+bSN1OX/E7p9QyY4OGtgAm2MgMuLtTu43yXfQKYIhwfiDFQW
         i3EaXUC978x5w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Reuse the available memory after firmware reload
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220506141448.10340-1-quic_akolli@quicinc.com>
References: <20220506141448.10340-1-quic_akolli@quicinc.com>
To:     Anilkumar Kolli <quic_akolli@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Anilkumar Kolli <quic_akolli@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165220042141.6768.14213090210900844797.kvalo@kernel.org>
Date:   Tue, 10 May 2022 16:33:44 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <quic_akolli@quicinc.com> wrote:

> Ath11k allocates memory when firmware requests memory in QMI.
> Coldboot calibration and firmware recovery uses firmware reload.
> On firmware reload, firmware sends memory request again. If Ath11k
> allocates memory on first firmware boot, reuse the available
> memory. Also check if the segment type and size is same
> on the next firmware boot. Reuse if segment type/size is
> same as previous firmware boot else free the segment and
> allocate the segment with size/type.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.6.0.1-00752-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Anilkumar Kolli <quic_akolli@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

5962f370ce41 ath11k: Reuse the available memory after firmware reload

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220506141448.10340-1-quic_akolli@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

