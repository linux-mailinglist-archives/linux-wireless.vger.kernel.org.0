Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9F951FBB6
	for <lists+linux-wireless@lfdr.de>; Mon,  9 May 2022 13:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbiEILy4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 May 2022 07:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiEILyy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 May 2022 07:54:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A91419590F
        for <linux-wireless@vger.kernel.org>; Mon,  9 May 2022 04:50:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11EC6611CA
        for <linux-wireless@vger.kernel.org>; Mon,  9 May 2022 11:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FC0C385AF;
        Mon,  9 May 2022 11:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652097053;
        bh=JrJh/aizYV5fErvoTllW4dPM77/hns+tqqCLZufThEM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=O6j9krbT3u+n0JF9SG5a96uQn6o/2ELZ5keCwVu0HcfLT/iD9YkNB7FMT+wjPMIX+
         JTTv3F52be93atRFrx5izUJ5RmiRj2T6q3fuZawxil5fMJt+4ei+QfgYc7atAi8qX1
         Ap68ChwSD0qf0fONj7tnVSpN1MRXxXWE/mXSz1pj4bqbsskNKEVPazY/PdxqFvJMiM
         SntuDFN6z34C7oQ+pKHDPr1YRlVYCv4JDuhAUe6ZzW2C44pey6P3Djq9HISgeZldUG
         Jruqh9yMkkiLdJRetm6HJNdlUXhinnZbBiPSO3FD8v4FnTJ+s5JFkYM/lvNa6MBRRX
         UIjm/7pdpPggw==
From:   Kalle Valo <kvalo@kernel.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>
Subject: Re: [PATCH 3/5] wilc1000: fix crash observed in AP mode with cfg80211_register_netdevice()
References: <20220504161924.2146601-1-ajay.kathat@microchip.com>
        <20220504161924.2146601-3-ajay.kathat@microchip.com>
Date:   Mon, 09 May 2022 14:50:46 +0300
In-Reply-To: <20220504161924.2146601-3-ajay.kathat@microchip.com> (Ajay
        Kathat's message of "Wed, 4 May 2022 16:19:26 +0000")
Message-ID: <87pmkmylex.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> writes:

> From: Ajay Singh <ajay.kathat@microchip.com>
>
> Monitor(mon.) interface is used for handling the AP mode and 'ieee80211_ptr'
> reference is not getting set for it. Like earlier implementation,
> use register_netdevice() instead of cfg80211_register_netdevice() which
> expects valid 'ieee80211_ptr' reference to avoid the possible crash.
>
> Fixes: 2fe8ef106238 ("cfg80211: change netdev registration/unregistration semantics")
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>

Is there a reason why wilc1000 does not use ieee8011_ptr? And what
earlier implementation are you referring to?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
