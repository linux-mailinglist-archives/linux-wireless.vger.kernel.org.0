Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2037A8302
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 15:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbjITNPJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 09:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbjITNPI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 09:15:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB7191
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 06:15:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD9DC433C8;
        Wed, 20 Sep 2023 13:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695215702;
        bh=Mf/851V73fxlfhoYSnXEInZvAqBsgEPB8mWBSfVMRfk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=SofpNG1sFMsX0/WRGO9rukrOcPmdNaGf3eIhp2/7M/2JQhjgzQBt3o3aXVc6V1jWl
         Jn9Gk893DccHRpJKRXSmLTA/uER2VLJaFUIKanPIpuzDNbckt7mubK9YmI3IzJCrb2
         W3MaNxAppI+6FiQyQSNZu7gHzSr+J4+YtXXx4qUsWx5cLBpzPj6XgbR4DkJpzbq/U3
         JcfFXhGhcl/xd1PYL4+el2M/4UxGrYrCSyOI8g00XwVqh/wrFcS8H226FS1kj2Ngbl
         6qwCb/W5+yg+bTyu3LUl7rL2swsgkrRkuRZ6QKSB4XPqI+7fF0gOjECGmOpqxRrfR3
         0Pl8bKRNDvb4Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath12k: fix WARN_ON during
 ath12k_mac_update_vif_chan
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230802085852.19821-2-quic_mdharane@quicinc.com>
References: <20230802085852.19821-2-quic_mdharane@quicinc.com>
To:     Manish Dharanenthiran <quic_mdharane@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Manish Dharanenthiran <quic_mdharane@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169521569886.1118199.14851919916487311370.kvalo@kernel.org>
Date:   Wed, 20 Sep 2023 13:15:00 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manish Dharanenthiran <quic_mdharane@quicinc.com> wrote:

> Fix WARN_ON() from ath12k_mac_update_vif_chan() if vdev is not up.
> Since change_chanctx can be called even before vdev_up.
> 
> Do vdev stop followed by a vdev start in case of vdev is down.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-02903-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Manish Dharanenthiran <quic_mdharane@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

8b8b990fe495 wifi: ath12k: fix WARN_ON during ath12k_mac_update_vif_chan
3f53624f74f4 wifi: ath12k: fix radar detection in 160 MHz

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230802085852.19821-2-quic_mdharane@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

