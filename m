Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2446F519B
	for <lists+linux-wireless@lfdr.de>; Wed,  3 May 2023 09:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjECHcW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 May 2023 03:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjECHbu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 May 2023 03:31:50 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFD94EDE
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 00:30:50 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b64a32fd2so5395981b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 03 May 2023 00:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683099050; x=1685691050;
        h=content-transfer-encoding:mime-version:subject:message-id:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Iuwe7YFzomxVqnp5CFO/6ropMzsm662vY9Qw+tp8e4=;
        b=nmbv0plEDPGgp6syUXUiontSo2+Qd4rPAyIt1AGlAI+wq/VPFF5yt9E834uCmiorqP
         acJpIOwo9wXJDntjornBqhN4SnKMTfEtJmkhjoeORir/qmDeuCCuXZYRXUG1TLBA/75V
         mA/QZisijQNqXoXmnn/si4sgpqPLWd0U0YCKTY1E+g5LUJCuj7lhgGaRtVUd65zHnRzQ
         9gHIDuBA/fcBea7YKFA/WdUB8glJLWqv/vUdAOob9+a37sObfdTAlWu/7hG5tqWA/Q6M
         BV1ExKojF3IIybKdXUz7ISogXCUpxM4YlbsjdGPORVK3rT2PHeiE51vEenMpugv40GH7
         iwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683099050; x=1685691050;
        h=content-transfer-encoding:mime-version:subject:message-id:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Iuwe7YFzomxVqnp5CFO/6ropMzsm662vY9Qw+tp8e4=;
        b=g0KC8L5gJGpW7uS3YRq5imEbR2w9biojqc3G4sstWLEdq1IEPfVNcMMS0zRhzE1nj2
         KT+fnk4Scj+CweEm2ikcSmO8ZSU4lnHgW5PKkov5EDPuzoiNElwQ1B25uOD76PPBJPAR
         jEHii2ivcKXLm0QCgD6BQ17A/uJAl0WF1Yk7l2v8pof1nboymnMeixX9T94KhQ+9xfT+
         RtJvP1Gm9erRNMbWB+CDwomxmxJdVEfE7UJR46TaSQypHiXw0wdvszoGdXxIYv6lnw4h
         kPFXayH6b/G9NaskRJuTeCv2cUVU4fhIZU60sQN68kgYPfwA45pdcROKoSrjWJYMBJ3L
         IBCw==
X-Gm-Message-State: AC+VfDzMXgMBBQosorqJfTafI7T24XB3bIu5Bp48KAczbSfy9T6mo7l7
        pLENGuRL69tAF2JzUbnxe/RQ0pmLxEU=
X-Google-Smtp-Source: ACHHUZ53X7pkcavV7vCCSlmkBPb7x+dZM159+5csKGWFSEzKXhJxrfx/0oq5W42iP0oK74OBv577/g==
X-Received: by 2002:a05:6a20:9596:b0:ef:e240:b55d with SMTP id iu22-20020a056a20959600b000efe240b55dmr21849988pzb.55.1683099050052;
        Wed, 03 May 2023 00:30:50 -0700 (PDT)
Received: from localhost ([2401:4900:5446:db2f::e30:7113])
        by smtp.gmail.com with ESMTPSA id h2-20020a63c002000000b004fc1d91e695sm19697074pgg.79.2023.05.03.00.30.47
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 00:30:49 -0700 (PDT)
Date:   Wed, 3 May 2023 13:00:45 +0530 (GMT+05:30)
From:   sitaramstrmydv@gmail.com
To:     linux-wireless@vger.kernel.org
Message-ID: <77426432.17.1683099045542@localhost>
Subject: =?UTF-8?Q?After_years_of_careful_study,_we=E2=80=99re_finding=E2=80=A6?=
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

How are you today? Many organizations tell us that there no longer exist barriers between technology goals and business goals. Our proprietary interviews and data collection supports the anecdotal evidence as well.
