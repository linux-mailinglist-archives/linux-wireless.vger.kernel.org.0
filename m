Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BAC73EFC8
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jun 2023 02:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjF0Aig (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Jun 2023 20:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjF0Aif (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Jun 2023 20:38:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204A1171A
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jun 2023 17:38:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-986d8332f50so494289266b.0
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jun 2023 17:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687826312; x=1690418312;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/8Rl2pkgLTzTzUTVZ5JxtLA9JuSZphd5ArLILZFC7I=;
        b=fUJegObV1Tn9M5K8W7KMk7+fSZd0KJL/8hfSaUdEvaY3LAxoZ2jWSpKYxgeM6ZT3dA
         4u07GVVSbvRv3nTgwq5T6R6WhAzpoCNi0YAZM8SDT85JRvaWv0c1uKx2h2CpcZhh7zld
         F7KgsaJkOn2Gi3xmCGN9y6HmDgHsEZWUeBkLdfVDoUV/LHp4jL4gotYFiXQniARuS1JX
         k4rFzvYDFRs9igqL6axV3Y1dpN+rQycxUQeOYpr2s1u7ZAD/N/87ybCGcByKqr1OT6A5
         P9FxbrAedJelhga8k7YhKjd6IYNWPHpO/81sXU4fvwE5yUcoe5MM3ESYCX9x2Z4vMXoK
         S5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687826312; x=1690418312;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/8Rl2pkgLTzTzUTVZ5JxtLA9JuSZphd5ArLILZFC7I=;
        b=e0OkySI6KaWA1hZnH2fjwTBOHBALvvLZrDlHs1AROMEUu+xwGd2oMBxUAssjisVf96
         l+eIIAFTbckfVc5LGUyE4IgFWfqE3ZMMpwk6buiNT30+N47ltOc8D9cBycbIpOdk0qwu
         oLc+jAieYr7AAGxHzbMOqmE/4PU1rkB05OfcVCzQwuPa/9kCJFx0fsgGA4/CIGR7+GOv
         1QiwAr9c9Y99ABq4i9HxkCVt8kUprF+DJIuKm2RgBCOwbX7Ika5M879+WvZbnot+9XLh
         +Lx0eCKxEBT3EPpKMXbv19GdnUlpyXLTFiq0fjIJ8QtmIHo6ObTu2KKgIV2OxY37f11f
         kuhQ==
X-Gm-Message-State: AC+VfDygcfOCKc6Gcnlvs3WSVo6j3Cw9YRGg32HKS5YbaCEEIj928bp2
        JSQMhIcf4zjF8OIr0901e/oDsNNXlrsSRiIT0sE=
X-Google-Smtp-Source: ACHHUZ5eoT27eeo2Shx3qm27A2FAYPBGB4h8lqu55bkh6Nnp7JLxCS3XD4tBvlkp5J+bMsEIeu+I39pDoFGnlDn95xo=
X-Received: by 2002:a17:907:3e87:b0:991:f427:2fe8 with SMTP id
 hs7-20020a1709073e8700b00991f4272fe8mr1672261ejc.2.1687826312264; Mon, 26 Jun
 2023 17:38:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:9281:b0:986:544c:8f8b with HTTP; Mon, 26 Jun 2023
 17:38:30 -0700 (PDT)
Reply-To: helenwilson142@gmail.com
From:   Helen Wilson <bettyraymond247@gmail.com>
Date:   Tue, 27 Jun 2023 00:38:30 +0000
Message-ID: <CADxHVhNkNAsTsZ0wQh6EEc-mtxaPEvH_N6xaZPX1rjii_Fr1Jw@mail.gmail.com>
Subject: 
To:     helenwilson142@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Saludos para ti
