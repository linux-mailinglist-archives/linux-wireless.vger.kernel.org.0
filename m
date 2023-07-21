Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CAF75D609
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jul 2023 22:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGUU55 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jul 2023 16:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjGUU54 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jul 2023 16:57:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D185B2733
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jul 2023 13:57:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CD3661B30
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jul 2023 20:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84072C433C7;
        Fri, 21 Jul 2023 20:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689973073;
        bh=Oe1OXOQKme1fZeZy58FAYuG4ahJcLSXfLJKSJoD8Cnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BFkqimnJz+54PNp9gVNnwxX7Gand3YuRYpSfY+uW/oLKHPT3gP3kWqvNbYE7t2pz6
         T455pswYwDriri4QN+l1dzVF0H8js/JJJ0VatS8FIvhknCXplZLU01Ms9Jij17w3kD
         HaTAXosN/Ogi7e+yqa3cujnRwW+2hhcEpRip8Hz0brvQdtGtYty480Yd84TrYWn71I
         FfgVOfYlkDN8fvVnZCxK79xKo7UefZ/490XSEu9EWdTGCCmgDbiCFhAZUJsMFFAlks
         i+Q7eCs6yNCXZzL1loLD8jjG5Bhb3kJWFDfve/JW79ZToxa9JJwQ2wAh46L3llZ7rQ
         m1OK2mNgHSB9w==
Date:   Fri, 21 Jul 2023 15:57:52 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     wireless-regdb@lists.infradead.org
Cc:     Atahan Bostan <ooatahanturan@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] [PATCH] =?utf-8?Q?wir?=
 =?utf-8?Q?eless-regdb=3A_Update_regulatory_info_for_T=C3=BCrkiye?= (TR)
Message-ID: <ZLrxUL7il5s2YWsI@ubuntu-x1>
References: <20230713153228.241774-1-sforshee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713153228.241774-1-sforshee@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jul 13, 2023 at 10:32:28AM -0500, Seth Forshee wrote:
> Based on [1], add support for 6GHz and make minor adjustments to other
> ranges.
> 
> [1] https://www.btk.gov.tr/uploads/pages/ftm-teknik-olcutler-ek-5.pdf
> 
> Signed-off-by: Seth Forshee <sforshee@kernel.org>

Applied.
