Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2704F05AC
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Apr 2022 20:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiDBS7s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Apr 2022 14:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiDBS7s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Apr 2022 14:59:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A92210504E
        for <linux-wireless@vger.kernel.org>; Sat,  2 Apr 2022 11:57:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BEA1B80A25
        for <linux-wireless@vger.kernel.org>; Sat,  2 Apr 2022 18:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68E0C340EC;
        Sat,  2 Apr 2022 18:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648925872;
        bh=Edwzk91aSR6soNm7mbNhpZNF9A4whqNTasdWlpuLCn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bj5YJkIWrwG9k2/TqUS+nxux9PMEIKwuQa5Ybchnlk5zRNbFytUgeA+es9rYhXh8i
         ypZ+Hc13nNDSNoG9T7iy8PEy1CyeyVphGfVDExkouG+ArReOIeBKVGN0KYSfla82F9
         4y9kLpFq7xmufxa4+Gpx7in+27cyvO2pcJlfC3c7uqq7/dIJvbrWUVJ++HNT3ZZ0zC
         E58LPTJDBit9WsL+lD0qSL9r99fhOUYDBGAEe8Gk2sYqOc3/NSP1G5hCzAakI5fzzz
         VwWSh7mRtS7JuKcdGwfSJkTRqHGsYadbqJ94BLH1ki+Z0hjFLRDdozUm+kYahu5ypA
         p6JUrzmEb8mBQ==
Date:   Sat, 2 Apr 2022 13:57:51 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Richard Huynh <voxlympha@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory rules for Australia
 (AU)
Message-ID: <Ykicr3kUFXnIMcXt@ubuntu-x1>
References: <20220401031116.2195-1-voxlympha@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401031116.2195-1-voxlympha@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Apr 01, 2022 at 02:11:16PM +1100, Richard Huynh wrote:
> Changes allowing lower portion of WiFi 6E spectrum. (5925-6425)
> 
> Amendment: https://www.legislation.gov.au/Details/F2022L00249
> Full text: https://www.legislation.gov.au/Details/F2022C00281
> 
> Allows for both 250mW EIRP indoors or 25mW outdoors.
> However, only the former limit is defined in this commit.
> 
> Signed-off-by: Richard Huynh <voxlympha@gmail.com>

Applied, thanks!
