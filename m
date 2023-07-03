Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A068F745F2B
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jul 2023 16:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjGCOya (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Jul 2023 10:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGCOy2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Jul 2023 10:54:28 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EA7E5F;
        Mon,  3 Jul 2023 07:54:27 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id EDDBF5C00D5;
        Mon,  3 Jul 2023 10:54:23 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 03 Jul 2023 10:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1688396063; x=1688482463; bh=Js
        OD/SvZIdkxy6EXjP9O+NhycSVS/lMDIFZrlAwZ4b0=; b=2CV/Hj/R5uyr24A7RW
        /hB/0Qco7ufNQSWW3BrKoDpvcmEHAq5RwmfVq9f3mEPQw8N1iwpQcE88gVnIB531
        BFIL26FMnNuyDgXWxqGoUq6FxGv/DUBwK8YUgVC/vkGwfAQkrmjTvhfTdgvKNBTe
        BRm3ayVivQz5//mvI2MY9jnC4g/6BlkYr/lP4mysjAIaT42dFS2C9lDlRy0LIBS2
        Ey5T/HkESyhsPM+CQS6XLM36TQdYA8kBJQkIIp+M1OPzSlZ+8lVM9ky0TVqDVZc7
        g5ttJPgzPzMhSDJMk/+33OGz32KnAOZoPF8M6JQr9DD9vJIdWPqEopRXHlPn7BdK
        ZkZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688396063; x=1688482463; bh=JsOD/SvZIdkxy
        6EXjP9O+NhycSVS/lMDIFZrlAwZ4b0=; b=E6Xe/p+0tKDxYGRmcVcVaeL5VGS2D
        gONzF7M3PoH+n4UrtCeKq5G3L/S0FnPEGEZtpxjqEKuCyJvXnrWgbqZDfpmssBfH
        Lq278uzpg8tmTTr119syMGglpfqQHpfsolcVdr1c3AcEU9A1H0U/klALuqAZTyiL
        pKgE1cGPosEa6r7ENmw3jeLvrglbP9c+N0dYvC+Ky9I3l8F/koJC2+OCUGgeUaLE
        HQxewrm+3pQxXhwUi8ouKNGsuC439KOKZGxkNu1SGJA7J/YEPgLmRn6CP+yGHR7O
        FMKRJcbZXFrQvx0VE7YgyLS5eKY6No1H4nwyrRq4clzbYEvPeSjpnaE3g==
X-ME-Sender: <xms:H-GiZIb7eys8X3kuixoD8Ec1UKEuk7n8ImKjtkKos10vaD1ONO0ioQ>
    <xme:H-GiZDaYQkNlxOvyWZnKInx0uHP2UlPoL6Z0m_a5KtM2yvyGR0ACgm7u6TlLrAxbX
    cSsKBZqf8oWl3b8iEM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:H-GiZC-rQ5Vn73jg-UQexuD4OwOdfSN5qcECJah6nZLxxXqfs81_1w>
    <xmx:H-GiZCqJ0y9nO2V5rvberimExkwuTnDo7_PFGNFwyam1XziuZ66RjQ>
    <xmx:H-GiZDrnSIXmtDGzV8S9uq00Cep3vnSoSqYnm3JFh-td281hLANYBQ>
    <xmx:H-GiZK3hL6QElMQsuWBO56Dy1yueBhusmxyGF7T-GpqUnlxyBAYcfw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 85633B60086; Mon,  3 Jul 2023 10:54:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-527-gee7b8d90aa-fm-20230629.001-gee7b8d90
Mime-Version: 1.0
Message-Id: <68d6cc8b-fbbc-44ff-9e81-bc91fbe5c40b@app.fastmail.com>
In-Reply-To: <6de44cd9-a9a0-4b76-a9b5-a3c37b97f9aa@moroto.mountain>
References: <6de44cd9-a9a0-4b76-a9b5-a3c37b97f9aa@moroto.mountain>
Date:   Mon, 03 Jul 2023 16:54:02 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dan Carpenter" <dan.carpenter@linaro.org>,
        =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     "Kalle Valo" <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ath9k: use struct_group() to silence static checker warning
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jul 3, 2023, at 16:17, Dan Carpenter wrote:
> We are deliberately copying both ba_high and ba_low so use a struct
> group to make that clear.  Otherwise static checkers like Smatch and
> Clang complain that we are copying beyond the end of the ba_low struct
> member.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
