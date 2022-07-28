Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B44583B99
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 11:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbiG1J61 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jul 2022 05:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbiG1J60 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jul 2022 05:58:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2176391F
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 02:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A340B82393
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 09:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A923FC433D6;
        Thu, 28 Jul 2022 09:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659002303;
        bh=eh6J9+wjjc2bx1UaCeoDatnwKTLpYWUqGhNpN6amZFk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=P0a0MHpw/BdD+iFT2P6TZbJTuZ6YKJmwqmMSp4Iv73cUFe7cQJmRgAtGGluLMd+4Z
         Ywpcd23+i2z+2DEvXvSFWBFro5TsVqddunUDA8bTWKEoFBKvjtAhRFJoOQHsv0PLwz
         l0sgeiskRfds5jbvk6xtjnuMmkNevDaCNSIyzvLGDhY2KET2RMzt8UrB5fb7tfAHdy
         cBG+8euRMneNpa5nYakLeoZH1byZ+ttX9W01Xepf87chlENC++N0jBqnbgH+w43MtT
         GlZ4ABDeak/I1RRgENeyx24Y1ZlvGWT2ek+FLAbSVUe5MGhB1wDJP9FF3CEs2Kh8mI
         xre+Zmx2e21nQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [1/2] wifi: brcmfmac: Add brcmf_c_set_cur_etheraddr() helper
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220708133712.102179-1-hdegoede@redhat.com>
References: <20220708133712.102179-1-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165900229993.25113.10099916000567709302.kvalo@kernel.org>
Date:   Thu, 28 Jul 2022 09:58:21 +0000 (UTC)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> wrote:

> Add a little helper to send "cur_etheraddr" commands to the interface
> and to handle the error reporting of it in a single place.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Arend van Spriel <aspriel@gmail.com>

2 patches applied to wireless-next.git, thanks.

cf1239e5b7bf wifi: brcmfmac: Add brcmf_c_set_cur_etheraddr() helper
4af4c0b93c15 wifi: brcmfmac: Replace default (not configured) MAC with a random MAC

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220708133712.102179-1-hdegoede@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

