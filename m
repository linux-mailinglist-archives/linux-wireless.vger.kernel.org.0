Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142277E41A6
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Nov 2023 15:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbjKGOPS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Nov 2023 09:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjKGOPS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Nov 2023 09:15:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3055B7
        for <linux-wireless@vger.kernel.org>; Tue,  7 Nov 2023 06:15:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6236BC433C8;
        Tue,  7 Nov 2023 14:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699366515;
        bh=niLCXo9w5fQv8tLnhe1acPySemaa56VA5icOqIofsZo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=vFXnll4Y0Wk5QxZsqkur6bnl+f7dUHI8a0jIVgfFuNUr3v3BlLHf1WyF4aBF+Vngl
         ytoqvSp2iKZcs6h9Pq5zfnZDszrBCg7TPDRr8zYl7WeBpf/vFNdasJBh37+Vv76wqZ
         MEdsAS/DUiW10Qyql66WKqzfuyiZLgc9qZ2LNomsSDr4QsFuGabW0PsUpKnkomL2CD
         9VgUVLQGFw0mPjCeha2zJ59SGrU6ePvlDizkF/lOjtbLGEbELi+SmI0+/cNCLONe4Y
         i5P+Qvu2nPbAb+uEk9Hr8kTlF4O6+0MvbN4/2P2qfPT6i7IkX1Yn+Xl1iQE89mvd6v
         nz+TSLEbkz8bg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        jithu.jance@broadcom.com
Subject: Re: [PATCH 1/1] wifi:nl80211: Extend del pmksa support for SAE and
 OWE security
References: <a4e53b3538b04ce9c3f53b216d106c6914f4ad0b.1699339021.git.vinayak.yadawad@broadcom.com>
Date:   Tue, 07 Nov 2023 16:15:11 +0200
In-Reply-To: <a4e53b3538b04ce9c3f53b216d106c6914f4ad0b.1699339021.git.vinayak.yadawad@broadcom.com>
        (Vinayak Yadawad's message of "Tue, 7 Nov 2023 12:10:18 +0530")
Message-ID: <877cmtbqfk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Vinayak Yadawad <vinayak.yadawad@broadcom.com> writes:

> Current handling of del pmksa with SSID is limited to FILS
> security. In the current change the del pmksa support is extended
> to SAE/OWE security offloads as well. For OWE/SAE offloads, the
> PMK is generated and cached at driver/FW, so user app needs the
> capability to request cache deletion based on SSID for drivers
> supporting SAE/OWE offload.
>
> Signed-off-by: Vinayak Yadawad <vinayak.yadawad@broadcom.com>

There should be a space after "wifi:" in the title. Not sure if Johannes
can fix that or if he prefers to submit a new version.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
