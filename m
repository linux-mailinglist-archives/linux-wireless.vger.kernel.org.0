Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37ABD6C4735
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 11:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCVKGD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 06:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCVKGA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 06:06:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E2E2E826
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 03:05:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99D3C62000
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 10:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDD7C433D2;
        Wed, 22 Mar 2023 10:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679479557;
        bh=Twu27M3OjVEot50ANfuewirgwxiZlSiBne6ZVJl4WcU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=FF7czHaLiNYmTiSglIMQNVZ6fY2sw8sBtFfiYVbZ9SrYYXbKAcFfGSRyRW5NjIs2t
         Z22HXvt4egc8v6TsOb9toWkudXingtth44eKIdzi/r+itYxfBOIVZC9bnSIJLunQT0
         c0i+UNrxhbkwc+/IIuXJfCYkUutHbcj4GaKzCzVyvUDRPYaNEdnoe/1unm5fnd0srq
         qcXa8Qmfxdo1kCSU+7ojpgvT7FK7plpbPGyMRxMceydGWhKlTHKNap7LJAx1JA8NAj
         bqTTsQiw1A/vV3hxV0ALl4egK3Qa/8Q+dMInKuMGnyochqvm3InLaIiZbc3HyrOznq
         gOuL6biYq6VJg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix firmware assert during channel switch
 for
 peer sta
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230315113202.8774-1-quic_aarasahu@quicinc.com>
References: <20230315113202.8774-1-quic_aarasahu@quicinc.com>
To:     Aaradhana Sahu <quic_aarasahu@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Aaradhana Sahu <quic_aarasahu@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167947955370.29931.1748538574703666695.kvalo@kernel.org>
Date:   Wed, 22 Mar 2023 10:05:55 +0000 (UTC)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aaradhana Sahu <quic_aarasahu@quicinc.com> wrote:

> Currently, during change in bandwidth for peer sta, host sends the
> new value of channel width via WMI_PEER_CHWIDTH set peer param command
> alone. This can lead to firmware assert in some scenario since before
> the command, firmware was having value of channel width and its
> corresponding phymode. After the command, host tries to set the new
> value of channel width alone which can become incompatible when compared
> with its phymode.
> 
> For example:
> 
> Bandwidth Upgrade
> ~~~~~~~~~~~~~~~~~~
> After association, sta is in 40 MHz bandwidth in 11ax-HE40 phymode.
> After bandwidth upgrades, sta moves to 80 MHz but as per phymode,
> max bandwidth is still 40 MHz. Hence, firmware assert is seen.
> So in this case first phymode should be moved to 11ax-HE80
> followed by bandwidth change.
> 
> Bandwidth Downgrade
> ~~~~~~~~~~~~~~~~~~
> Similarly, reverse of above is also possible when sta is in 40 MHz
> bandwidth in 11ax-HE40 phymode. Bandwidth should be changed to 20 MHz
> and if host sends phymode first then, phymode will become 11ax-HE20
> and will be incompatible with bandwidth value and hence firmware
> assert will be seen. Hence, in this case first channel width
> should be set followed by phymode.
> 
> Fix this issue by sending WMI set peer param command for phymode as
> well as bandwidth based on the type of bandwidth change i.e upgrade
> or downgrade.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

cbc0008c9b39 wifi: ath12k: fix firmware assert during channel switch for peer sta

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230315113202.8774-1-quic_aarasahu@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

