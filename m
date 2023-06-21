Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EBA738813
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 16:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjFUO4F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 10:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjFUOyi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 10:54:38 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B65B3598
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 07:50:16 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-52cb8e5e9f5so3907507a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687358983; x=1689950983;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8XPvnsVHuvnzruH4m0ob+U9HvAcv1H+gfTUuHjNwMqk=;
        b=ZFccJ/zz5QpXLJ86bO9oQ53CiCtBlyR9BcYMHe8wri2iY8sy+yHT8lyAQe16PlMHOm
         FBkttF9vQO/Jpc9OOvF9ipw1hMTfVEmYct0GE7WTRZ95jb3RCOTJOkitkK42+d9selBb
         lgUlPRAl1QR1O0uWE3M2DLF6CYSrcfHeh9bLPMCSV96H8VO3HCl3g8uISJH1lFGtRZJM
         6Z3T/pOrfHwdpCw9++AwLA0XwqSw0LzpsGmvMp2mbJRe7/WnmofMXcmipfnrOA80TZ9w
         HL7zlvURh4IUB1bCMBjbmhrnLndSMSrmUctMEAuxyFAaqZx3cAcNP/YhPNp7FjlO8kB+
         vX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687358983; x=1689950983;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XPvnsVHuvnzruH4m0ob+U9HvAcv1H+gfTUuHjNwMqk=;
        b=ZGpHIOGbXQDUsA6ss+DNdgr8rqyzZT2ww+TcTMFfrgUWWdN7rSATqXUV3DyErkOHEg
         /iGl/ZzPwf39QhgEaAyOaO2TataTC5gvHYRUUC1ZEvGKLufU2boo+BX71IMiSR8PGyhE
         U0WGeHwMBAvXQxiF3ldg3vUjUv++3aIF5vdMg9sXEexwlwBUvXNkLuDiIjV77vVgfno1
         O5sv0Z6eOIe3CO1E/wJdE67yuaXHgZYyTINDQmnhQaRGtHXSeRrqctQWcgRpNF+oswc4
         VUyxNfkxAmTi3Pu949bCNI06pizAfWGu10Lu1zoeIzH/SNpta8+YN4WUG0TaImYw6dKi
         CcMQ==
X-Gm-Message-State: AC+VfDztp4mLtVTpyjPmZ2iDPVj2u52PpEEIc4EotVvKNlESdUnvsz5p
        oj22kkKxPK3HNXWpcxWIvdSytVRfDnWwqJTrwn0=
X-Google-Smtp-Source: ACHHUZ6mtjrO5+BEYS3rFPvhTFT7EkI1Z0BiBRGxnXdfcVTT6SJozADaRzleS5Q4dcH6gvT77K2bAzLQ9T1Lri0bY84=
X-Received: by 2002:a17:90b:1e0e:b0:261:110e:30c1 with SMTP id
 pg14-20020a17090b1e0e00b00261110e30c1mr126446pjb.4.1687358983381; Wed, 21 Jun
 2023 07:49:43 -0700 (PDT)
MIME-Version: 1.0
Sender: marchallthierry@gmail.com
Received: by 2002:a05:6a10:f48e:b0:4c1:804b:a102 with HTTP; Wed, 21 Jun 2023
 07:49:42 -0700 (PDT)
From:   Miss Marybeth <marybethmonson009@gmail.com>
Date:   Wed, 21 Jun 2023 14:49:42 +0000
X-Google-Sender-Auth: kviwOA1IVbbrqp63pmwRo1ue1WA
Message-ID: <CAN3qK0XShJU-E46_B+n6yCb8q4MXjhxXnH7GTZBRtNxkiWxjFw@mail.gmail.com>
Subject: Re: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hallo,

Du hast meine vorherige Nachricht erhalten? Ich habe Sie schon einmal
kontaktiert, aber die Nachricht kam nicht zur=C3=BCck, also beschloss ich,
Ihnen noch einmal zu schreiben. Bitte best=C3=A4tigen Sie, ob Sie dies
erhalten, damit ich fortfahren kann.

warte auf deine Antwort.

Gr=C3=BC=C3=9Fe,
Fr=C3=A4ulein Marybeth
