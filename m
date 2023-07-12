Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C1674FDDE
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jul 2023 05:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjGLDhG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jul 2023 23:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGLDhF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jul 2023 23:37:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646BAA1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jul 2023 20:37:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF5A7616C0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jul 2023 03:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18088C433C9;
        Wed, 12 Jul 2023 03:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689133023;
        bh=CFhAwXGRnZn1sFbKgiF9NFH9FzDSCbiccZUpYUo1XIE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zs3C8juz7ohIErM2TpO22jpL0Jv5Sw0uBZTO3HExAKM8jTB3ZU1tBefZPSs52ArF+
         x3+7XdThAe6fInFJn4g/9VhI/halYPeLF8NnfIK54co+V0edf4V3lMO4asR8fCAfNw
         vnkL+Q/9U7MOw2WeH67RR1vxlKDx8fIrkBXTy5O42fuikTlHd4FC988SHLjfVU36bR
         XF+NQco3RRLxOFuTzImgavMOS5ESMzbmetPekFbT+5NvEdWAGgY1/VxTeESMHCs+Jd
         DoKxHSyJuAg8oMs36M9/XXHEw5qn2cOYqZ8tOuGcLtXk3M3DRV0T4qcYZ1PYJp5pNo
         WHMFNOhAuE3/A==
Date:   Tue, 11 Jul 2023 20:37:02 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Benjamin Berg <benjamin.berg@intel.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH net 09/12] wifi: mac80211: fix kernel-doc notation
 warning
Message-ID: <20230711203702.001235a4@kernel.org>
In-Reply-To: <20230710230312.31197-10-rdunlap@infradead.org>
References: <20230710230312.31197-1-rdunlap@infradead.org>
        <20230710230312.31197-10-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 10 Jul 2023 16:03:09 -0700 Randy Dunlap wrote:
> + * @agg: station's active links data

That does not sound right. It'd be better to wait for the WiFi
maintainers to return to get the WiFi bits merged. Can we defer
WiFi patches for now?
