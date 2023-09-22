Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607377AAA40
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Sep 2023 09:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjIVH2k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Sep 2023 03:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjIVH2j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Sep 2023 03:28:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FEE19E
        for <linux-wireless@vger.kernel.org>; Fri, 22 Sep 2023 00:28:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562F8C433C7;
        Fri, 22 Sep 2023 07:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695367713;
        bh=d1mI+0ZL2+cM7MjGZNsCyN17hETr1Hjl/AuwczI38vw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mSwKLSZnid2CdtbW8QBRLcqbwUf4BlboVFlRO1W+Gth7dhzamP0U7cRRWiTVSnAAP
         77Vv3ZT0/7BAtLpdxrWcxsJz1kHlngpbuVxK4YVkLdZyJpXk7S2xlxTyEBfMbMrhmW
         1AIQLKwip+8StiW4P1EgAXdpRPUM3mfR5iU7M3e/PRYJ3L/xgr2EWx0WlJHgpJAkwA
         1Oho73eItdheKdBghHE1miiFgV2iCeBvlrFN4IWCarpsR6L+DuPVqVPTEsjQhpSSQC
         co1VpVhmHU2PqoncTj4WMVGdJb97lktjXUR63c2TRkQYtceqUqvVDlG4zOzWh1Y2YW
         5VqhA0Gw9X1hQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless] wifi: mt76: mt76x02: fix MT76x0 external LNA
 gain
 handling
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230919194747.31647-1-nbd@nbd.name>
References: <20230919194747.31647-1-nbd@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org,
        Shiji Yang <yangshiji66@outlook.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169536771011.1992536.10976022273047975727.kvalo@kernel.org>
Date:   Fri, 22 Sep 2023 07:28:32 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> On MT76x0, LNA gain should be applied for both external and internal LNA.
> On MT76x2, LNA gain should be treated as 0 for external LNA.
> Move the LNA type based logic to mt76x2 in order to fix mt76x0.
> 
> Fixes: 2daa67588f34 ("mt76x0: unify lna_gain parsing")
> Reported-by: Shiji Yang <yangshiji66@outlook.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Patch applied to wireless.git, thanks.

684e45e120b8 wifi: mt76: mt76x02: fix MT76x0 external LNA gain handling

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230919194747.31647-1-nbd@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

