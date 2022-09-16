Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208865BA675
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Sep 2022 07:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiIPFoe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Sep 2022 01:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiIPFoc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Sep 2022 01:44:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BDF5E669
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 22:44:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4D9BB8235A
        for <linux-wireless@vger.kernel.org>; Fri, 16 Sep 2022 05:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3E4C433D6;
        Fri, 16 Sep 2022 05:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663307063;
        bh=R1S8FgHayaYhk3ltK1TLwAkBP0yqIaxNrzlMpbcUWqg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=QKl9K0Dz71ZfLtqU4u8YitF/WPfWLWa7TFVLgzHQdUtRxUSQ18Av8t4uJUr9a7JUI
         kr7koPLdwBoqYv0aBKI/WtVnYEEYvT6uEMWo2VFlaBpE7G+uUXMsMLY8Pk6hBWwoWC
         JvxJlwUTGI8FoDjs1rPGGF5Cd9FGlpt7nu6uKCPPEZqHyhM1+6Q6QXTrgetu0UTlsz
         trl589AeiOZvbUXDh+4DgBJt3fpv5Pgq4mnvhY0KmpD7Fsj11Z6U7N/ajGEBMRPt2x
         Isj896uSB/Qnc4F7vEVuM0hxxsi89PntE1yB3YZG2sNAsppgbk5QSaJ00LEk5xbs4s
         dC70oGzlyDsXg==
From:   Kalle Valo <kvalo@kernel.org>
To:     James Prestwood <prestwoj@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] net: mac80211: remove/avoid misleading prints
References: <20220915195553.1052931-1-prestwoj@gmail.com>
Date:   Fri, 16 Sep 2022 08:44:17 +0300
In-Reply-To: <20220915195553.1052931-1-prestwoj@gmail.com> (James Prestwood's
        message of "Thu, 15 Sep 2022 12:55:53 -0700")
Message-ID: <87pmfvan66.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

James Prestwood <prestwoj@gmail.com> writes:

> At some point a few kernel debug prints started appearing which
> indicated something was sending invalid IEs:
>
> "bad VHT capabilities, disabling VHT"
> "Invalid HE elem, Disable HE"
>
> Turns out these were being printed because the local hardware
> supported HE/VHT but the peer/AP did not. Bad/invalid indicates,
> to me at least, that the IE is in some way malformed, not missing.
>
> For the HE print (ieee80211_verify_peer_he_mcs_support) it will
> now silently fail if the HE capability element is missing (still
> prints if the element size is wrong).
>
> For the VHT print, it has been removed completely and will silently
> set the DISABLE_VHT flag which is consistent with how DISABLE_HT
> is set.
>
> Signed-off-by: James Prestwood <prestwoj@gmail.com>

This has been cluttering my test logs as well, thanks for fixing this.
But the title should be:

wifi: mac80211: remove/avoid misleading prints

I assume Johannes can fix it during commit.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
