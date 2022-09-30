Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B96C5F0F57
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Sep 2022 17:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiI3PzC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Sep 2022 11:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiI3Pyx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Sep 2022 11:54:53 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4322C1C2F8A
        for <linux-wireless@vger.kernel.org>; Fri, 30 Sep 2022 08:54:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id 13so9948276ejn.3
        for <linux-wireless@vger.kernel.org>; Fri, 30 Sep 2022 08:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date;
        bh=drhE+K5W/TgEiD2BFiYQG+xsgGayw+tyHkiwhS9lW4U=;
        b=XVgpy8fqmFaGFjeea1DKsblTI9SjD/TuvBKaoLpQlfJDuA1VfcrpNqFVtRXDy9Ixln
         e721fye5oKGfdpelzz3EyT0/x3QITa6+EGhew6tKB0JOO8kMZcVX+Q5vw+EvTgLE8TpN
         cPfaE4QxTX5LP1WXXBR65SYCrNKYOykP0UlTpGF1Xg2DqvhKzHlfDLIIwai+Ut9ikh65
         l3omx/bXpOmTaCXjbn/LGC1E9GkYqPVvehtPuqwOKT6TSRcALsbT4zsMy1QpEoMyv6jX
         M2RIaEoggwIuws6gbzRuJWy31VO/SHZNfHinGu2tsa8WamWrDatlcr4YJQ+8j/UMLMfz
         WLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date;
        bh=drhE+K5W/TgEiD2BFiYQG+xsgGayw+tyHkiwhS9lW4U=;
        b=vVM2ZLViGOwf44EdVXndbGv29jbgLnXO/oM+WBh2ZGsmgpB7+K8F82OaiWnr0Ega8y
         IL12Oce2DLG3rXFPbGZUSI3oAa1AYLlMte91VNSY5RXG0YRDeutdfc4vPS+0l2vFDfkK
         0db2ejUb2GE0+pXoEzRNzmluP7gJEuffoaAKhafjsO8rI/NMt5ZRpo1R9r5q8VyCYeRK
         xSPZUrodBwKW+gpIV1cRfIXCHTZyiFDJqUeNzv37P4obyDXulGNwulTGCC0TmRPxUBTM
         3O96LKCj+7MN7UPQlWKILsw5SOQFhxIACC/54n6ZzcSD9oiHEVVyxro6dEQK5TFJJm61
         jUGw==
X-Gm-Message-State: ACrzQf3RyimdicT9M/BgsDlmLyMtHCPu7vf25jAIItO3Bky/s0xj7gFP
        MbkQLRD4KH4+Dsv3RABbV/APqvR1V5FlDg==
X-Google-Smtp-Source: AMsMyM7oqBDqLysPpqSikm76BK4eFs0FapeoHJdz0LcFqK+TNgDSm7YyPItIOWtMvThCa0fN5HJ5Sg==
X-Received: by 2002:a17:907:1623:b0:787:d4d5:cc61 with SMTP id hb35-20020a170907162300b00787d4d5cc61mr5877275ejc.626.1664553269070;
        Fri, 30 Sep 2022 08:54:29 -0700 (PDT)
Received: from smtpclient.apple ([2a02:aa12:e142:6b00:808f:cb60:b4f1:e108])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709063d2900b0076f0ab594e9sm1384195ejf.73.2022.09.30.08.54.27
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 08:54:28 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?Oliv=C3=A9r_Koncs=C3=A1r?= <kolynetg@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Fri, 30 Sep 2022 17:54:27 +0200
Subject: wifi driver
Message-Id: <5D8A56A3-4169-4FA6-8E54-85F6F018A378@gmail.com>
To:     linux-wireless@vger.kernel.org
X-Mailer: iPhone Mail (19D52)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

hi

can you please help me with getting wifi work on rtl. i have lenovo legion 5=
 notebook.
bit urgent i would highly appreciate.=20
i tried to wget the rtl89 but it timed out.
thanks!=20

Oliver=
