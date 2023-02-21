Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F27C69E9D3
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Feb 2023 23:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjBUWBe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Feb 2023 17:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjBUWBd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Feb 2023 17:01:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D162B293;
        Tue, 21 Feb 2023 14:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DRlNhOryeVX1MrYLe6vGgybKFOjasPgWQpl/R1reKBg=; b=LBDbn5+zoM7wQKVtbBcLwpCUd9
        kFnBO8vyk3yYMS/qMN+FRKSlNQyUa96Y0v+KoR2xXDEGz7bOwCMpOkauj/r/IoRDzoTBkmxks7D4v
        hM5e+mR6fRFeB+gdfpAEk6LTmivXcMPh1V1d5P6JyalwCvijuhJwGKx1SSMsbOHc9mC1AnGf7Hko5
        i8vkine0zgUNMkm5PG9K85mQRWdBSb/Ke6+w8DStTnpRJG0uR4PQujig2mOYQajRfxKNzJycr6BR8
        mOXgFAXEz1FGbaBuUkCxBhB5GAMTdJV1gevnEehrS/rjt+fVjB9/Bhz7vFcq90CCNDDynCCnZvLVn
        q5nDeePA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUahV-009uTQ-0G; Tue, 21 Feb 2023 22:01:29 +0000
Date:   Tue, 21 Feb 2023 14:01:28 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Felix Fietkau <nbd@openwrt.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ath5k: fix an off by one check in
 ath5k_eeprom_read_freq_list()
Message-ID: <Y/U/OKYjr3lVXdTI@bombadil.infradead.org>
References: <Y+D9hPQrHfWBJhXz@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+D9hPQrHfWBJhXz@kili>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Feb 06, 2023 at 04:15:48PM +0300, Dan Carpenter wrote:
> This loop checks that i < max at the start of loop but then it does
> i++ which could put it past the end of the array.  It's harmless to
> check again and prevent a potential out of bounds.
> 
> Fixes: 1048643ea94d ("ath5k: Clean up eeprom parsing and add missing calibration data")
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

 Luis
