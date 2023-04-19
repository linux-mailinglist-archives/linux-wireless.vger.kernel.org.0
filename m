Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107386E850F
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 00:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjDSWiJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 18:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjDSWiJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 18:38:09 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B317C7298
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 15:37:34 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id az21so907775uab.12
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 15:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681943798; x=1684535798;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JNSFyRlX9HEFt50WYfUgo9upxgh9bvJM99DRmR2CX4o=;
        b=A597psBi94uoZw1I01Mu/PYYMgObV7azHnWZEeUHeMBqGbRMwFmgnk5LIkkPSMwy4h
         uvrtgPlGP++FzLqaklzFJ0Mnm8Tx7xMQg3hFcoF4RVg4DgDYJpaMvMcLIbZc8TjOo1PE
         3k/qJYKW9JYo/mIAh5Km6Njts5vW0DqvjJsvOcidZVgYhFF7lT8nUmILphhuejFdPym3
         x4lH8dvl1UfF/CiegsL8V6kwzDcK2USIuc1FUFcoJzogIMk7njYnwzx7umSi32jXRVEa
         IVG7aWRlYJTsK0Fq0lYewTyJgkqrfhccOT/poYoP+f/QO52xXcV8Zsrr0cS45av+My/U
         wEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681943798; x=1684535798;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JNSFyRlX9HEFt50WYfUgo9upxgh9bvJM99DRmR2CX4o=;
        b=DqO+xx7Zu8fXJY97JajW7cSx0ETiMeWmubjA544EamecNsU2exizTLtQQ+cGGLr7OI
         lfQau0CiXU6Tx7stYQHsi0bx72mfizjVZxuQA3b4UGIIO/W/Y1RwOChN9T1L1G7TFh/x
         i1up87xaHitUwdm+donUCn5Cf92QmKxsHLUrUN6vlqVPYJWQCQvbbmcrkW5OO37Xyyeg
         0TebUGrGM1jxyWifr0BHx+o8GD30xJRew+T0a6UD50ztQ3W5sMduP2lH8ruHXhYlrCGO
         6pVKVOe4b/uxyGomgsGB8DzRqKgsCpiAHy8VJJr2MDVS8X9Irhlm7obeArLKmf92jQCo
         hefg==
X-Gm-Message-State: AAQBX9eOtDbE7gQc2GNQ2sTjNWP7VCF2znT9j+6qavjPK9wMEJvQ/vTa
        IPXOMsT6vGHOVY43qNl/sAHHzDy6AFry7xzjuyQ=
X-Google-Smtp-Source: AKy350Z7KixYsm1EME4dIAoTLmL9Y+3UksezMwxYyFUeBHPPBO1zdhqUvGZ+k5p4FxPSPb1XkDWLvBhX+ja9FtXhjeA=
X-Received: by 2002:a1f:5f93:0:b0:43b:c7bc:7203 with SMTP id
 t141-20020a1f5f93000000b0043bc7bc7203mr666957vkb.7.1681943797771; Wed, 19 Apr
 2023 15:36:37 -0700 (PDT)
MIME-Version: 1.0
From:   Sara james <techdatalist08@gmail.com>
Date:   Wed, 19 Apr 2023 17:36:23 -0500
Message-ID: <CAEtUfa8AFSV08ckoxCnLf+sBFgLnytgHwUQa1z2fZXiHuSmgXg@mail.gmail.com>
Subject: RE: ASM Microbe Attendees Email List- 2023
To:     Sara james <techdatalist08@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Would you be interested in acquiring the American Society for
Microbiology Attendees Email List -2023?

Number of Contact: - 13,558
Cost: $1,626

Interested? Email me back; I would love to provide more information on the list.

Kind Regards,
Sara James
