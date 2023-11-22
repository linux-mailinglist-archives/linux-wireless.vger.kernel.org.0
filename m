Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A0C7F4BBB
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Nov 2023 16:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbjKVP5J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Nov 2023 10:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjKVP5I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Nov 2023 10:57:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195C8D8
        for <linux-wireless@vger.kernel.org>; Wed, 22 Nov 2023 07:57:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4F0C433C7;
        Wed, 22 Nov 2023 15:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700668624;
        bh=CLTDKjc7tGVg1SF6mHzwQRTWDzes/Pl3ZQK/G5C18eg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Wz0mlPiXQX/D1oQeySMJsYZMWg1OJLNiPh8fyfzyOxLtVJnoPaFGpreIh6xjI1Xei
         LxSQNH5IzR8yOMIBPClOJoNMiV2rTzMRSnivxsyY5FO59+xFeqSeoEDuq7OhSPC7sG
         0VzyuScQE5m11gNZo8Q3F/aU6DtLamJ6RyzH4200Z/0ABK0kAJ1eGF+ytF0HtGOxav
         hFx9ddK93dPerRVJ7cbsmL4Y+h1Du3+RW98a3FxgI+BkmPDZf/zozOHsz9u6+FZPn3
         cvA/7CSC2C+RR27tiFQe9r1uaFAuKad+d7/vLCz06wFBI9cDUy8Su8orD8tAz+LOi2
         aavopRLgBWXvw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [wireless] wifi: mt76: mt7925: fix typo in mt7925_init_he_caps
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <7de6e939dc75ee08f05bf1ee73253aa7eeccf28e.1699869649.git.lorenzo@kernel.org>
References: <7de6e939dc75ee08f05bf1ee73253aa7eeccf28e.1699869649.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        nbd@nbd.name, sean.wang@mediatek.com, deren.wu@mediatek.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170066862115.94367.1410495311702800235.kvalo@kernel.org>
Date:   Wed, 22 Nov 2023 15:57:03 +0000 (UTC)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Use iftype for interface type switch in mt7925_init_he_caps routine. This found
> during code review but later Coverity reported this with id 1549845.
> 
> Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Patch applied to wireless.git, thanks.

695bfba7ca78 wifi: mt76: mt7925: fix typo in mt7925_init_he_caps

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/7de6e939dc75ee08f05bf1ee73253aa7eeccf28e.1699869649.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

