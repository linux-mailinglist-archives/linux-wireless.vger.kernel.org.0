Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5705B716C94
	for <lists+linux-wireless@lfdr.de>; Tue, 30 May 2023 20:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjE3SeH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 May 2023 14:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjE3SeG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 May 2023 14:34:06 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBDCD9
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 11:34:05 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2af2c7f2883so51400701fa.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685471644; x=1688063644;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z2XEevc/yzVQ/IpKXyPt9R+qYFqqhM7dOJPGQYDWykM=;
        b=IzxsA35Q3y4O1MhZLgxc4Rt7w+tf5MEH58FXniHIVaVo20EdXN1aQTYUJUbtKZAMRj
         42A5XdKq8FsYrIXh/tfR9za74lyTVEAdnkdwaTPpIqT6jQs0VhsQYJD88tEBsq//ZrfA
         cVq+s4wUuZh2YjcDnh9CYYA6N5ld+vIdpaXIr/e27vKKE7wr/ePe77/Yk1hWqhgK/lQ6
         Orcq3HoajJ8t5oNepgG9SELwIsMnvlbEbPdD9YK0HgXRXmMNWrQ9iHiPtazjZiowffHl
         6/aaSjEQLAPGWmJIpCar1EULgE8Bz/s67+A0PWkD6hNx6yGG/CXxZXuW9oQPDRKPAfHq
         1IYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685471644; x=1688063644;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2XEevc/yzVQ/IpKXyPt9R+qYFqqhM7dOJPGQYDWykM=;
        b=W+ipMRS59Z5yvxybt07tLi+rqw8VEjg6k5isvB+yPKNHydhgrIIM4afajHaq+3rz9a
         75c5BllQF54cvvFcVZ9pHprP7nYyt2jxzbA8zgWglOnRf9/kZtSKSLHFvb1cFNhllVka
         NDpJk23pV3RvUraGaZTSwhKT9+AutQPEa+kLbT7O6BHyAABQoqapgYSkVNpNJu6Pby4p
         THPc391LkP2l86c5CtcsfM85G5174mc8KSSibSyk93rDDBIlFk7bP+9qfvNPdhhwk++1
         R7uiolR2RVg77TLeOciyyadOuQO4myCZOgKUrjFE/EEDG64PKMF5uOsF8MHFGo66slOv
         mPAg==
X-Gm-Message-State: AC+VfDwA3Wtqzvmpupg8ENS+6T5aXzDxCJrkB1AXWPK+vGlCqlvDQspv
        j2aXq/2Xk/vDbMYwLQv0YAYqGT3DYX8jdA5fKmc=
X-Google-Smtp-Source: ACHHUZ5J4+R4SrkMHpTVN+QQ5XRCfEH2GejK7O14X8Z6/9AOgMAcoQymMJ14HSmi+/p5wCKLdNuPx4H5TxvwY3cTQ8E=
X-Received: by 2002:a2e:8ed4:0:b0:299:a7be:5775 with SMTP id
 e20-20020a2e8ed4000000b00299a7be5775mr1288044ljl.35.1685471643551; Tue, 30
 May 2023 11:34:03 -0700 (PDT)
MIME-Version: 1.0
From:   Anna Maria <attendeeslistmax2@gmail.com>
Date:   Tue, 30 May 2023 13:33:24 -0500
Message-ID: <CAG=w=PTKxvVizS+0PE4Sz-Y_i4W3-m7RjaW_KzR9Pe1dF1iF1w@mail.gmail.com>
Subject: RE: ASM Microbe Attendees Email List- 2023
To:     Anna Maria <attendeeslistmax2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

ASM Microbe- complete attendees list is available now.

Would you be interested in acquiring ASM Microbe Attendees Email List 2023?

List Includes:- Org-Name, First Name, Last Name, Contact Job Title,
Verified Email Address, Website URL, Mailing Address, Phone Number,
Fax Number, Industry and many more=E2=80=A6

Number of Contacts: - 10,386 Opt in Contacts.
Cost:-$ 1,369

Interested? Email me back; I would love to provide more information on the =
list.

Kind Regards,
Anna Maria
