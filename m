Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690E74E3226
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 22:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiCUVJN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 17:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiCUVJM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 17:09:12 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6486C1F1245
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 14:07:43 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1647896862; bh=E3fVHwETgi6kd6OHOQMJ+3QIDjucH5oXd5FIkwYrJH8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QtDtZNI/H4WMo2V494QjAdtWiPa+lTbQu4p5iSw5GIKfen6jH408jXo6UYuWq+QoA
         Cf02dHwFERkX5ng5qgM9hvs4EtgumoYYsK+JCwRCDXpVRluO/nPZ486pUIM/y5ORoc
         AXLHSTVwEhbf5qK8CpxRdOsb3c1lz1peIub7dqxLfvNk3VLsteOSzXcaSxSS7fwie4
         RlFa7GalW4UWm9j8y9GK21x5z2Nn52EfXNdZ5tML07LEde4FzRL8zF9X333rWDMGL1
         N1NvWC4gYwo6KZXKRA12Yt3ukOM+LZZHBhgCW7UJ8b+XMU3yg9CFo24hq2BJ/gD8oP
         WXp5eV6cIyVyg==
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Wenli Looi <wlooi@ucalgary.ca>
Subject: Re: [PATCH 4/6] ath9k: fix ar9003_get_eepmisc
In-Reply-To: <20220320233010.123106-5-wlooi@ucalgary.ca>
References: <20220320233010.123106-1-wlooi@ucalgary.ca>
 <20220320233010.123106-5-wlooi@ucalgary.ca>
Date:   Mon, 21 Mar 2022 22:07:41 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87mthj815u.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wenli Looi <wlooi@ucalgary.ca> writes:

> The current implementation is reading the wrong eeprom type.
>
> Fixes: d8ec2e ("ath9k: Add an eeprom_ops callback for retrieving the eepm=
isc value")
> Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
