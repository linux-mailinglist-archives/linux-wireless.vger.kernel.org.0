Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8064DCCA8
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Mar 2022 18:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbiCQRo1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 13:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbiCQRo0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 13:44:26 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2D5ABF73
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 10:43:07 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u23so2695415ejt.1
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 10:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=hJ6vnRkGqf7o3va/KYBtaxPfYuk6B8FxppLseSIcVuI=;
        b=dsWVJ0K+atufJDOcv8YxeqRCMkuO/WLwK9uDCRrG5uoEVUW9IEsH8CIcsrIVOIW0bI
         U4fYj5lZEP95+3Z1RXiN7a/kTBFbWDxkZ7LvnlTIP0K1pfAm96VlYEGFHC7Dml1eXQdB
         x0L1RpoWElhdg2HZFKAmK+FVnbdOLA7an7ByqYE47h0Yv0VhlzJU3ltxuF/NiqrVCoCI
         eOCPuWZGF8TEVg3tq4QFVJJF+3A43kFBhTdjJBftZMIGe0ljg9u8z9oebTm/nBoNh/Qt
         rj2c/jBovn3i8A1eN4TRAekBMXKmiiX4jwHAdGpYf1ktYLjqdMEH/yesMLLjN63/WyQq
         LRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=hJ6vnRkGqf7o3va/KYBtaxPfYuk6B8FxppLseSIcVuI=;
        b=BU4ao7JMLDXX9ZVCWpgZXRV7QPNySLJHgdj5li95sZxnvY58iGV10ka8MKUfTliYU3
         /PoweGJpPuYoZuAH6xKxjEV0/+ttPSvnk6sBH4Xr05OPovQzSrli+C7s9lvXtJpjp+tI
         W7Yfb/jX9ZlOlxcmBWqb99bPEuvYB/5gmcNIKfvAtjStSUfVbRh9Q3MM7E7K9HM3Pyp9
         0DuFyo2njKbDjwdzAf00VU3dguEnIc0y44zMC1QjYzu+N3iUVAJsVc8EdQlYNrldr5ns
         XQuQMgOeEoY4XIBDS9dQrKF8CYFnmr/Us4cKwUpBAnXxperw6DhP5yToLnCyUpNHMtQr
         Hl4A==
X-Gm-Message-State: AOAM533X633NVO0k0g8ZVtYBaWlZZZZ45DxZBe4UI/T73DE6YRolhT3L
        jrQ3ukvClcZGeYwRVXx4Rkg=
X-Google-Smtp-Source: ABdhPJxPwNKPS3y9zLoeqNJVAaL4rkU8sK/vaGZrXBoeWSa3NGxdfcTswmFJBG3kRB9AwjYiMp099w==
X-Received: by 2002:a17:906:3cea:b0:6da:ea45:ea9e with SMTP id d10-20020a1709063cea00b006daea45ea9emr5448219ejh.574.1647538986369;
        Thu, 17 Mar 2022 10:43:06 -0700 (PDT)
Received: from [192.168.43.30] ([197.211.61.62])
        by smtp.gmail.com with ESMTPSA id ga42-20020a1709070c2a00b006df76956b53sm2541647ejc.212.2022.03.17.10.43.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 17 Mar 2022 10:43:06 -0700 (PDT)
Message-ID: <6233732a.1c69fb81.2701b.a51f@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: meine Spende
To:     rimamnyangishaku@gmail.com
From:   rimamnyangishaku@gmail.com
Date:   Thu, 17 Mar 2022 10:42:56 -0700
Reply-To: mariaelisabethschaeffler702@gmail.com
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hallo,

Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Wirtschaftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen, die restlichen 25% dieses Ja=
hr 2022 an Einzelpersonen zu verschenken. Ich habe mich entschieden, 1.500.=
000,00 Euro an Sie zu spenden. Wenn Sie an meiner Spende interessiert sind,=
 kontaktieren Sie mich f=FCr weitere Informationen.

Unter folgendem Link k=F6nnen Sie auch mehr =FCber mich erfahren

https://en.wikipedia.org/wiki/Maria-Elisabeth_Schaeffler

Gr=FC=DFe
Gesch=E4ftsf=FChrer Wipro Limited
Maria Elisabeth Schaeffler
E-Mail: mariaelisabethschaeffler702@gmail.com
