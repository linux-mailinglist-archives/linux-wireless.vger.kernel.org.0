Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D66620A65
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 08:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbiKHHkQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 02:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbiKHHjx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 02:39:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6424047C
        for <linux-wireless@vger.kernel.org>; Mon,  7 Nov 2022 23:38:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EA586134B
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 07:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EB7C433D6;
        Tue,  8 Nov 2022 07:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667893125;
        bh=qqCHVGdy1NTRGJfq+z6rM25KMkvl/TwScrD2H6QGlqg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OOiTd5UtTMY9BKUF+z4Wqdz4gsfprgWtx53ceeiSmHVDb1vm4o28epeFs6OetwFdJ
         P2eG3oftA90ARK5/qkrPvjkqiKkKwH8MgyxTUn1B8KtXTAoi21DfDp9u3zYbRLn0B+
         MiLngALoAVjhwG7m4+W62jcqm9eijUu40RaeyF/ncdLOuvttwuZDixFcpVH48XwCrJ
         zLMAo1oywMVS7z5d1ISLDAOyVQDcAokDVz2ia2B0RLICmU3RnIHEUXDkMd6FiDuJqO
         ZtrAFt/M8jsn+kq1z/rNkXLH4JQop20u3kRuykX0Bk5d733zKWhMiDzpAavS487mpH
         kypaAPQt7iCRQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/3] wifi: brcmfmac: correctly remove all p2p vif
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221024085215.27616-2-ian.lin@infineon.com>
References: <20221024085215.27616-2-ian.lin@infineon.com>
To:     Ian Lin <ian.lin@infineon.com>
Cc:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <Double.Lo@infineon.com>,
        <ian.lin@infineon.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166789311335.4985.13018926346518083987.kvalo@kernel.org>
Date:   Tue,  8 Nov 2022 07:38:43 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ian Lin <ian.lin@infineon.com> wrote:

> From: Brian Henriquez <brian.henriquez@cypress.com>
> 
> When deleting a P2P AGO interface we should make sure that
> relevant entry in bss_idx[] array is removed. We were always
> removing only 'vif' at P2PAPI_BSSCFG_CONNECTION before,
> regardless of the number of created P2P AGO interfaces.
> brcmfmac: correctly remove all p2p vif
> 
> Signed-off-by: Brian Henriquez <brian.henriquez@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
> Signed-off-by: Ian Lin <ian.lin@infineon.com>

3 patches applied to wireless-next.git, thanks.

c7caaa6f7278 wifi: brcmfmac: correctly remove all p2p vif
52617bee3718 wifi: brcmfmac: Fix for when connect request is not success
c81c1fd4e907 wifi: brcmfmac: Avoiding Connection delay

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221024085215.27616-2-ian.lin@infineon.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

