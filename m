Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92864B35AC
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Feb 2022 15:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbiBLOkS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Feb 2022 09:40:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiBLOkR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Feb 2022 09:40:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B49720F
        for <linux-wireless@vger.kernel.org>; Sat, 12 Feb 2022 06:40:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1D02B8069A
        for <linux-wireless@vger.kernel.org>; Sat, 12 Feb 2022 14:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E9FC340E7;
        Sat, 12 Feb 2022 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644676811;
        bh=/eFNnjWFqd1MNt+vKE4rxblGE4LU4hHpUrutMVowgQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xp42/MhRrTo9QgGkmslq+ZX1kZKGgGIrYkuT2pniQNKG6UxtS5rZ1ikFMJLf9J8kx
         WaWKyg9AKiTXbIS4Y6GoyXW8fB2+TyPaD19KGBbHAxVQMaikorKicLEDd5HPpkX1Bg
         cVyGx7NGnvnlMJYqajHwIhq8Lal2JuhrJmNy5e84/x1Bhs7B6aE+Nj4Y0KhC+BMxXm
         ekR5Ot91LhMypiDafsH9ypSn+oOVG0GsCOSDJOHzc3F/3QF2bZDhHtpbbrDhkBe7cW
         ewdFRkJOTImRCnMgENZlizs3psHnuLZ71b9EG4AQ9O2L03plYuhtLk2/8IvCx/6Qz1
         5s+RWwh8SQ5ZA==
Date:   Sat, 12 Feb 2022 08:40:10 -0600
From:   Seth Forshee <sforshee@kernel.org>
To:     Romain Izard <romain.izard.pro@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for France (FR)
 on 6 and 60 GHz
Message-ID: <YgfGynKgHRb2rhMW@ubuntu-x1>
References: <20220123204346.14588-1-romain.izard.pro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123204346.14588-1-romain.izard.pro@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Jan 23, 2022 at 09:43:46PM +0100, Romain Izard wrote:
> The French national agency for radio frequencies (ANFR) has published an updated
> revision of the normative radio band allocation table on 2021-12-14. It includes
> the authorization for the lower 6 GHz band for 802.11ax as prescribed by the EU
> 2021/1067 decision, as well as the authorization for channels 5 and 6 in the 60
> GHz band for 802.11ay.
> 
> The declaration for the 6 GHz band follows the Low Power Indoor constraints.
> 
> https://www.anfr.fr/fileadmin/mediatheque/documents/tnrbf/TNRBF_2021-12-14.pdf
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>

Applied, thanks!

