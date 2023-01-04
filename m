Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718DA65D231
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jan 2023 13:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjADMQB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Jan 2023 07:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjADMP7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Jan 2023 07:15:59 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FE1101CD
        for <linux-wireless@vger.kernel.org>; Wed,  4 Jan 2023 04:15:55 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id s127so20640772vsb.5
        for <linux-wireless@vger.kernel.org>; Wed, 04 Jan 2023 04:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RUY5y6zLuR5cWqeaKguClMSYR6J/UjlVX1mPxUIDiqs=;
        b=VJmLCb73UryNuQbimr+CbNAQyBR7W4yGvyxJvyca8oDYvWVnVqj7g5bHUTN+kxCSqc
         M6J5m4XgBf1sk+dTvoAU7kZ1UGKnRYcbHKwWWAiSylFKzDL9AvRUMuX41zUuYfiOBQt8
         V+gbQmCWzQaN1FoOm8Rk+sSHWLB8Mw37LriXHhPp0pyv1AzBjWqqw2YXYqArPHATvAUt
         7uw6BA9hAHu+IUt4BQM/Iv0SrdL95Qj2YjPaXiZ2QqMMcsU/9zaAliVp6E6dUfAsWEmf
         v5MWVFAq7jOmXc9qPJjvooQFevpcsoWnMQvWx+ODemG+r4SHxzPc4nhaAaj8tTDgduQn
         jETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUY5y6zLuR5cWqeaKguClMSYR6J/UjlVX1mPxUIDiqs=;
        b=YOUObS2tHWMTA/d2DhgivSOWQPqD3pAPL58kSBifFYrPkWkqeQpX4tYwFPr02pcb1l
         mJkAcV88D0tCJLdgaovpAHizDfdaDwmReG5vpKeTT9YqF+qNBIePc7SI4sPOigoHb59c
         k35h5ZJFcJk/ASvHMiA7815G+COPqN4PzuoJV+JVnbWc1s/FE/YS1PmfuO+vlllVx9Ok
         BhzmWxkTaGIWQCRqveq4/0SfisStbWOzsXZZKv9oFefzf4YnG/12KrZ3eC+FSDFZ7Ktf
         4rroQTvj3kIYDV/lNwZOjwNizQhbqaWIEvoLsaaOgITfgDEhFkETc2eL6GxZHTdfqCeD
         d3jA==
X-Gm-Message-State: AFqh2kpTIopJUYPddofDktUryT6RyenTQtwxvf+3APvuB3TzESBB5/sw
        5c6RqMmDSHWzQKQ6Yprr9CjxLPAiINQnO/DUXl8=
X-Google-Smtp-Source: AMrXdXs9Z6fy+tJM59MPMF0s8+Akct7I6gaT4gfcJFl0WIQDXbDv2TweXy/eYx9EaCLAbg4Zvcs+/VGDDKhatSS8Bfs=
X-Received: by 2002:a67:5c03:0:b0:3ce:a7c5:3757 with SMTP id
 q3-20020a675c03000000b003cea7c53757mr587901vsb.63.1672834554496; Wed, 04 Jan
 2023 04:15:54 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9f:2d84:0:0:0:0:0 with HTTP; Wed, 4 Jan 2023 04:15:54 -0800 (PST)
Reply-To: garryfoundation2022@gmail.com
From:   Garry Myles <oluyedeblessing4@gmail.com>
Date:   Wed, 4 Jan 2023 15:15:54 +0300
Message-ID: <CAGHbOor6dJX1ws5Ji0MQYHOHZdAji7MraVGYpVYHXbgqs4W8Kw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e2d listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7409]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [oluyedeblessing4[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [garryfoundation2022[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [oluyedeblessing4[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--=20
Guten Tag
Sie haben eine Spende von 2.000.000,00 =E2=82=AC von der GARRY CHARITY FOUN=
DATION.
Bitte kontaktieren Sie uns =C3=BCber: garryfoundation2022@gmail.com f=C3=BC=
r
weitere Informationen dar=C3=BCber, wie Sie diese Spende in Anspruch nehmen
k=C3=B6nnen.

mit freundlichen Gr=C3=BC=C3=9Fen
Garry Myles
