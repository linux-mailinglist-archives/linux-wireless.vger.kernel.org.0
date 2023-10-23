Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB087D434C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Oct 2023 01:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjJWXjn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 19:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjJWXjl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 19:39:41 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833A2D78
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 16:39:37 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7e5dc8573so39047017b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 16:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698104376; x=1698709176; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ys73+HDLS38AAwKXBMPRuEWzoNWn3OMFlRtXJuB3sjs=;
        b=Z08+NHHllP4JBKJMm1OH3VU1cSml6cN8ADslXdDqVw1DQ0wUKAQxtfHXUaJfImdQN0
         4lLjmz5gEIHojq0/LxyWahyPNbadj+mMgz65fyUexsLGVT9FzGwBUE8xu85YIbXoAYEX
         3jCoyfTqx+fWVQHhNd5ZXkxZrTwyb9/L1qoiRbwA9DoqB7akl/yp5aPGzaxCXJVnZAUC
         LkbozSKxge8ohQ0k6Oqw/F7VUoCv/nHVVb5E4sIe+mkaAve4cHlkZ+ay/9M5YShM7ai1
         3xW84zFhZMdletTZ+YdWgj3oAdq9SiKc3fmbmu82Cri9eGwoJz7D+fi1QjBdkcZdezep
         zGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698104376; x=1698709176;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ys73+HDLS38AAwKXBMPRuEWzoNWn3OMFlRtXJuB3sjs=;
        b=n1XvReCHInrKua2e2Pd3uD5EQN6tRlVTsY2Spo0b4Cg2cgJl12Wo+67dI++5V+H4V/
         lpJqS6KSrhENKz79XJwUk0Z9kem7iTnYiPe8qcKrl20CHnvd98Cs/kV9+9gZwIh2aLO5
         JZ4jvJPxpc6J2/QrkKXngUAJ8C3ewLuOISP3RQsu1Rk1uI50huIx+wb9pK6sksDStbnV
         +8b3xGY6nKBpGy/tiB4dMtVJ+bu7pcULNPeY3yQsnvBn74Q7CpT9Ekz14Sq3p1k97+tA
         m405CuZ7z36oUKdp5k0bAZOdxAB1hKTEJcAvRAjBUOrdhzt2shsYGE4JUrStZ88mgfSw
         c7Cg==
X-Gm-Message-State: AOJu0YwFW2mcZ4VtSYDV4DJWbFxH94ZfOChYhu4IWJeCzM3O8oC3mRN9
        E+qbWShcbKr32cnDu9xM11rIZjt42h7XbSLOJmMqIrl+bMR7hg==
X-Google-Smtp-Source: AGHT+IGh2RfY7XpL8tDTdzGjG3Umfiqnwwr7Nx5Am2UiGWrD3C4Nv42ofS2BoNxgja1lWPJru+IFFTf+GttpJWXxLWU=
X-Received: by 2002:a25:2083:0:b0:d7e:8175:4fa9 with SMTP id
 g125-20020a252083000000b00d7e81754fa9mr9707969ybg.4.1698104376653; Mon, 23
 Oct 2023 16:39:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:758a:b0:341:7725:752c with HTTP; Mon, 23 Oct 2023
 16:39:36 -0700 (PDT)
Reply-To: tchalimbenson@gmail.com
From:   Benson Tchalim <josefernandez29a@gmail.com>
Date:   Mon, 23 Oct 2023 23:39:36 +0000
Message-ID: <CA+fqxfbFMaHKGMu4hzFJv_keJu0xGxp-C+37y+VwnWwm5RiM=w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:112c listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 0.9997]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9997]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [josefernandez29a[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--=20
Are you still using the same email because i sent you message but no
response what happen?
=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=
=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=
=A6

Verwenden Sie immer noch dieselbe E-Mail-Adresse, weil ich Ihnen eine
Nachricht geschickt habe, aber keine Antwort, was passiert?
