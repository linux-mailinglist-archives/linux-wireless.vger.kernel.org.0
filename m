Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A6D6946BD
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 14:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjBMNPM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 08:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjBMNPG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 08:15:06 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015401A670
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 05:15:03 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C0BB1636DD4A;
        Mon, 13 Feb 2023 14:15:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MWux1QefvsHK; Mon, 13 Feb 2023 14:15:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7BFDD6399217;
        Mon, 13 Feb 2023 14:15:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7kfiiSziCj4W; Mon, 13 Feb 2023 14:15:02 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5D795636DD4A;
        Mon, 13 Feb 2023 14:15:02 +0100 (CET)
Date:   Mon, 13 Feb 2023 14:15:02 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     kvalo <kvalo@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        ath11k <ath11k@lists.infradead.org>
Message-ID: <1617726247.124241.1676294102295.JavaMail.zimbra@nod.at>
In-Reply-To: <87pmadvj66.fsf@kernel.org>
References: <1263051271.53086.1674425560245.JavaMail.zimbra@nod.at> <873579wze8.fsf@kernel.org> <370539199.123516.1676291073661.JavaMail.zimbra@nod.at> <87pmadvj66.fsf@kernel.org>
Subject: Re: Resume from hibernation fails due to ath11k_pci
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Resume from hibernation fails due to ath11k_pci
Thread-Index: aNidDqcSdYsc9VDUnTvkaPgVSmJ/Vg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "kvalo" <kvalo@kernel.org>
> IIRC the issue is that ath11k expects the firmware to be running during
> suspend. And this was because shutting down the firmware for suspend
> caused problems in the MHI subsystem during resume. To fix this I
> suspect we need changes both in ath11k and in the MHI subsystem, so not
> easy.

Hm.
So, currently the device is put into WoW mode instead of powering it off because
of issues in the MHI subsystem.
At least this patch series indicates so:
https://lore.kernel.org/all/1607708150-21066-1-git-send-email-kvalo@codeaurora.org/
 
On the other hand, my device seems to have trouble with that workaround.
Maybe powering it off completely helps.

Do you have a pointer to said MHI issues?

Thanks,
//richard
