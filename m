Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC9B6F5A32
	for <lists+linux-wireless@lfdr.de>; Wed,  3 May 2023 16:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjECOfn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 May 2023 10:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjECOfm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 May 2023 10:35:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48CC4C3D
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 07:35:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49C95629CC
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 14:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A742C433D2;
        Wed,  3 May 2023 14:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683124535;
        bh=Dfu0Oo4wS5bbuhu/ZJTm3kewDRXpkdoWHrQ4dxVhyuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t7Ic6BvEPmFCHXXcHEM5dfIlU2WTCOCwUXuzKiUYq97cpSXEa2yaI2gK96qzjPUW0
         hKBNyct4D9jZ5hLAvAx8zDKTLK1VZVdRm3kITUi4u0PYjpep6rTYCmOsNLPsr0olZB
         OjbzWK3Zz8aO13Xpx8rQp25RVAyM3O5YmL42XwTo7u6dpPIbjPzRlTJjqk91gEDqPk
         CmPY/KtvSD0ls+KhEkR2uV+Zk+rIbqsAtzJZ50PuJdV6sfAFjjxqUKgIqh3JbP/BUJ
         UN99ZKQWTirPPwNn4aNiXYfi+19jVGTps+GdAYkPQ7/AoR8t43HToe0hukGKaIVeLI
         S+KhEJ5YZmkfQ==
Date:   Wed, 3 May 2023 09:35:34 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Keshav <the.ridikulus.rat@gmail.com>
Subject: Re: [wireless-regdb] [PATCH] wireless-regdb: update regulatory rules
 for India (IN)
Message-ID: <ZFJxNrxeA+sRft0A@ubuntu-x1>
References: <20230416013031.158433-1-sforshee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230416013031.158433-1-sforshee@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Apr 15, 2023 at 08:30:31PM -0500, Seth Forshee wrote:
> Increase the max EIRP for 2.4 GHz to 30 dBm, and add DFS for 5250-5350
> MHz and 5470-5725 MHz.
> 
> Source:
> https://dot.gov.in/spectrummanagement/delicensing-24-24835-ghz-band-gsr-45-e-5150-5350-ghz-gsr-46-e-and-5725-5875-ghz
> https://dot.gov.in/spectrummanagement/license-exemption-5-ghz-gsr-1048e-dated-22102018
> 
> Signed-off-by: Seth Forshee <sforshee@kernel.org>

Applied.
