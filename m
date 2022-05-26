Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB698535424
	for <lists+linux-wireless@lfdr.de>; Thu, 26 May 2022 21:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346039AbiEZTym (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 May 2022 15:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiEZTyk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 May 2022 15:54:40 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87ED6880E5
        for <linux-wireless@vger.kernel.org>; Thu, 26 May 2022 12:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=BaLwaH3H7EvbC/XaHLyKKC4vVJFNvqZKWJWB8KnBpGQ=;
        t=1653594879; x=1654804479; b=UqgAh79Q027bwAPNd5/yoVuo+DMT9SgEh8tou1CSiLV2jvQ
        nWYHqk4pRX+ciWPW6SuUZH7KppnCZDxOBf2PmsJC1KNGMAgLmTmQ3oJzt1zMYVlWSdLrKvx4adbXb
        cTGXGrQnG4aSDhdGVQd1aV0jd+XVDRA9Xo0Szse2dZCndlX+XpIOndRQLHzpk9wwftLh8mdEdqSI3
        ialgb8zBL8AVKsFy+YsAAIy3fYAu0x+/1D/IVD6t5zTPVkXWIoANwUOAMwimMv5jWlpoltDrucyeF
        sy1/WqVjMVSoYcPtch8cYsGAvmxe9j8dyVEh94BDkHVAFAMvaNHwuVrhEIO6ypsg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nuJZ6-005G7X-TO;
        Thu, 26 May 2022 21:54:37 +0200
Message-ID: <79365d0387a73baa82cf07c81637a622492ed9d6.camel@sipsolutions.net>
Subject: Re: [RFC v2 59/96] cl8k: add rates.h
From:   Johannes Berg <johannes@sipsolutions.net>
To:     viktor.barna@celeno.com, linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>
Date:   Thu, 26 May 2022 21:54:36 +0200
In-Reply-To: <20220524113502.1094459-60-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
         <20220524113502.1094459-60-viktor.barna@celeno.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-05-24 at 14:34 +0300, viktor.barna@celeno.com wrote:
>=20
> +/*
> + * sw_ctrl includes eights bits (16 - 23) to be used by software.


that makes it sound like these are firmware things and should be endian
safe?

johannes
