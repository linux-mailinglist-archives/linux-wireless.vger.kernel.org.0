Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C74751D3A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jul 2023 11:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjGMJae (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jul 2023 05:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbjGMJab (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jul 2023 05:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022741FC8
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 02:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689240577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1hJc0ylj68nUplngmJ3wimbvRcnl9hkAT6fZMNYtMxg=;
        b=PDIP145SaCgB2n+yrWFI/OxZhEXuwV9urc8txvNgf7kdg1LnSn0j4tKuWQUI6NUTqzCo0R
        b8HGpz0yL4P88/trYBIvHmNEBv0LPhN03Yn2llQ4z8mnipJ1OaFLvkmFr2xfy2PZllLPzL
        P6rs8n/8PitEbuVeQpBpwYvNV5u4NTk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-dZu1Kw4eMDWFa7OHdau4hw-1; Thu, 13 Jul 2023 05:29:34 -0400
X-MC-Unique: dZu1Kw4eMDWFa7OHdau4hw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-767a1ad2175so12071485a.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 02:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689240574; x=1689845374;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1hJc0ylj68nUplngmJ3wimbvRcnl9hkAT6fZMNYtMxg=;
        b=Q1fG6WvKua+eC6ZwpwAXXh3S4TG5a4YYInZVqWA1sm9G1OqO8tsUYB4S5PakKR4Tww
         16rIq9pzwgnb/tU2SdibOrJNR+Ib+NOGzKVl9ZT0gDMP2TI0g3NEldx6H9bFhE0e9OK8
         nztzQpdPDzuE2jHBttcQUfZAnleRKjrJhZIfnaA0fWCP+baa02fAlGxDXhZml7lcb8KI
         zAXVdDrfMnpjGKDb7hBM7VKdNMi5c+7otRlvuXQhbtzjGlgA3f+j5nis7X/JorfBKSg3
         XHIeNzgPUtSVL39OC5Fng4RCrlD+YoAFFhkEonEwMJjNv8rV4uCbJ/cITGdV2AA82M9z
         fSmw==
X-Gm-Message-State: ABy/qLZoynCrfM3et0lUq1NEkKEsOcLjjMy/LUdfTIGS+2mJRkuYIxsJ
        mHrY/sKTVxW3rgUX2MSxrlPsHUYDBQczhd8zQShsX4worHx79Wlp3qUS6iO6srgxr9fZjVVK3Ax
        fja6qP6D33DuMR0AMh+z1DAgOhPM=
X-Received: by 2002:a05:620a:454a:b0:763:c764:577c with SMTP id u10-20020a05620a454a00b00763c764577cmr1299518qkp.5.1689240573876;
        Thu, 13 Jul 2023 02:29:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFizulmmPkdCmAfUhw4RJImpC+MGvmd2qV4G5//7gideYN9XgOJ3k/66LywFqLg/KxL06YjeQ==
X-Received: by 2002:a05:620a:454a:b0:763:c764:577c with SMTP id u10-20020a05620a454a00b00763c764577cmr1299497qkp.5.1689240573576;
        Thu, 13 Jul 2023 02:29:33 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id os3-20020a05620a810300b00767d7fa3d05sm2715384qkn.136.2023.07.13.02.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 02:29:33 -0700 (PDT)
Message-ID: <a9dc336793322d3525280e4f30b2acbd0c88bbf8.camel@redhat.com>
Subject: Re: [PATCH net v1] ath6kl:Fix error checking for
 debugfs_create_dir()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Wang Ming <machel@vivo.com>, Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Date:   Thu, 13 Jul 2023 11:29:30 +0200
In-Reply-To: <20230713040518.13734-1-machel@vivo.com>
References: <20230713040518.13734-1-machel@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2023-07-13 at 12:05 +0800, Wang Ming wrote:
> The debugfs_create_dir() function returns error pointers,
> it never returns NULL. Most incorrect error checks were fixed,
> but the one in ath6kl_debug_init_fs() was forgotten.
>=20
> Fix the remaining error check.
>=20
> Signed-off-by: Wang Ming <machel@vivo.com>
>=20
> Fixes: 9b9a4f2acac2 ("ath6kl: store firmware logs in skbuffs")

The SoB tag should be after the 'Fixes' one and you must avoid empty
lines in between.

(The same applies to your other patch)

Cheers,

Paolo

