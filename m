Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8124CD6FE
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 16:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbiCDPCB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 10:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiCDPCB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 10:02:01 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E5A177D24
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 07:01:10 -0800 (PST)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 50FA43F5FC
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 15:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646406069;
        bh=DmFax3LZSalpFiojoEblp62J4NHH+vngrBt4SmdiErg=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Q3wO/qOvPkWDr7iQwb9qVGxT8m2hGm5rgXLi2V1tefH0W2JjcCm1nPnQpaLf8BDvZ
         9zH+bWSfThoNp807IY0Z6ReKGTvGey+Y11zdX7I8Ej/atVZHpKw8O0BUduoXHSYXsS
         KuAA9C0LAVPRDa7lS55RAQdlJQUo5wY/tpzunaZ/otYvkBVvJ6s9XgdMYkPrlC+Xdx
         jhazFtHZBtW1zDW9IpGBCrN870bsKl+jFaW4gk/QABfHQUxF7eYEOEyeUEEPkcngX8
         VGIuTp4BymsVSaIdOyJACrrrLsCoBLxA/WMdF3x4d2Pjgg5O0hsvCZaAxOAy0Swcm5
         aMay+lKjspukw==
Received: by mail-il1-f200.google.com with SMTP id y11-20020a056e021beb00b002c3f8984f9eso5693037ilv.10
        for <linux-wireless@vger.kernel.org>; Fri, 04 Mar 2022 07:01:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DmFax3LZSalpFiojoEblp62J4NHH+vngrBt4SmdiErg=;
        b=xqdSMrTO65O+0M3qD/EdNMzDGtVuHx7YqRk4jVdxs5HOxRtQRPm4VZ9Qs1X4EJp341
         GXfNiQNhEtHWzsv2bl5LNhYWRAjHR0/UfYEktREm6YWOoriai8I7MmmGBmw0wEjVfcDD
         fi4vhBuUrf32IK4IZTqn4xUQsFUT/5gZ7Eqqhe8WD+8hkkE6rNNDlX5CQZcO3GQEthku
         wVBXHep4AM69g7DtvatFGZ0I856NoX207Z7EnmwGh1d8V9Z2UZZyH21pFVX4Rmqc8Dfg
         ZuJFpNsTQYGUuEKH7CYXeuGTV0fYCzV7SB5/UL+3ubLyBHvIDiNnAXZv2c4MNeFqSTAQ
         macQ==
X-Gm-Message-State: AOAM530FFN2UtgPHf+ubXNxMGVxjUr9r/TVK6qGvsf2KdgbOFlUh7A3x
        tC4uF54qRQdoVJaJWnJkilr4n5tG9Q0uNHcaWYD0q3I58ZZb8HhoKeagmVWsD9dg+Cea0+3wOeI
        aQ8hAqnjnmr1Q0PGSUEk8ob9G1O3J/febbI9Mt7PZVEeq5AMlhhptBq9jVBny
X-Received: by 2002:a05:6638:381a:b0:314:e62:27dc with SMTP id i26-20020a056638381a00b003140e6227dcmr33584972jav.59.1646406068097;
        Fri, 04 Mar 2022 07:01:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJweoydln7fzPdEY100TIffp0fujFa/bOcsOFqp3xnwoWcYigiVMEOySmhXMqgNtW3yRswh8+zAP90k9dC5gapc=
X-Received: by 2002:a05:6638:381a:b0:314:e62:27dc with SMTP id
 i26-20020a056638381a00b003140e6227dcmr33584954jav.59.1646406067875; Fri, 04
 Mar 2022 07:01:07 -0800 (PST)
MIME-Version: 1.0
References: <af43569b2247f7aff44b1ea3680d88dbe083d78d.camel@coelho.fi>
 <CA+5PVA4BbLaze8-c4R-8LESA9UhsDAJu3_FK4GZKUpVUkPKDrQ@mail.gmail.com> <CA+rHWAL+JDKJVvocS_JX6CtJ4JUDf_wRMCQ-T1ejw+gT2LOekg@mail.gmail.com>
In-Reply-To: <CA+rHWAL+JDKJVvocS_JX6CtJ4JUDf_wRMCQ-T1ejw+gT2LOekg@mail.gmail.com>
From:   You-Sheng Yang <vicamo.yang@canonical.com>
Date:   Fri, 4 Mar 2022 23:00:56 +0800
Message-ID: <CA+rHWA+RsguE_UsdCN8QfotvfTSt9VUkY5DM4nvU=bZQRMHvJA@mail.gmail.com>
Subject: Re: pull request: iwlwifi firmware updates 2022-03-03
To:     Josh Boyer <jwboyer@kernel.org>
Cc:     Luca Coelho <luca@coelho.fi>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        golan.ben.ami@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Mar 4, 2022 at 10:58 PM You-Sheng Yang
<vicamo.yang@canonical.com> wrote:

Wrong thread. Sorry.

-- 
Regards,
You-Sheng Yang
