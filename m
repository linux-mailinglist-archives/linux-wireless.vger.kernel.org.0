Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0575E6A694F
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 10:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCAJA1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 04:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjCAJA0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 04:00:26 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6512615CB6
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 01:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=2tVmSYeCTIE1t+YYLfFaD0nK4yMh0yMEVLOXL+Q1qlo=;
        t=1677661225; x=1678870825; b=QMyQRENupDIYjKka6wKpNn980pZRX0auor8wSxjIef0WuJX
        k8RwB0/p+po13kU/G94/eE9Iy7Ydew1Jhfm1O7AXjB1RpIuJGgSSWp5yaMohxJO+ojUUvadRfm8ps
        9iZWGJx4DXeNEkuDLie90RJCnQZFy1+jhDlUpCTZD57C3USDn1QypUBwWuKXJDvu1Ad1SgOpkb4N1
        Y1TtJnxLzTMar8ZVWXMDHdqvjYYPkfoZS5y+O96Ex/EfU9i4/mtiypchTTu3LfG8iJM605djm0sQr
        Fqplb5hsy1ppsqymnxyRTAbChEjsMrLmJx+gbZa9A0Ge6S5/NQADLNCLNMWPKgkQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pXIJz-008ouf-0D;
        Wed, 01 Mar 2023 10:00:23 +0100
Message-ID: <1232d9382e6b93b558be79fdca27a98c0b434d16.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: ieee80211_radiotap: Add EHT radiotap
 definitions
From:   Johannes Berg <johannes@sipsolutions.net>
To:     gregory.greenman@intel.com
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>
Date:   Wed, 01 Mar 2023 10:00:22 +0100
In-Reply-To: <20230301103916.81af314d8234.I4ce78e2c558da6e5a708a8d68d61b5d7b3eb3746@changeid>
References: <20230301084347.44102-1-gregory.greenman@intel.com>
         <20230301103916.81af314d8234.I4ce78e2c558da6e5a708a8d68d61b5d7b3eb3746@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-03-01 at 10:43 +0200, gregory.greenman@intel.com wrote:
> +	IEEE80211_RADIOTAP_EHT_USIG1_MU_B0_B24_DISREGARD	=3D 0x0000001f,


And I just noticed this is also wrong, should be B20_B24?


