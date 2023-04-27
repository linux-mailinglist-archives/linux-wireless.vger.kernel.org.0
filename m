Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C496F06A3
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 15:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243627AbjD0NcJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 09:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243618AbjD0NcG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 09:32:06 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC934C10
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 06:32:05 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 98e67ed59e1d1-2472a3bfd23so5829380a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 06:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682602325; x=1685194325;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6F3V1Q0yuJG2H/dzr9vN1vKBPQW9aVB7bC55iKWBnMA=;
        b=cBvLo2VP+WB+/iK4D6PEa2USmUkyoe5Df5p9jCWc09UCdp1oEJo3ifXLqNbDc55gGN
         nDYuqRYLLIC/6Oaz/CAyQHv6G60yoz1avr578gVw537hHe04o8zfsQoWN9baInaknhEz
         oHL6Cod++dTJ994slrm94N0eXlEXTR70/AYr4fy9XbLk+c3qZspNQZJj6oJ7357GI8T7
         Cy+IZNpHlqZ+HVCWSD5tnZKIjYbkCuuO60Gappsm6nJhCpFM0/bBSjGU1c+oQTaZqHI7
         71LW0ZwJ1OHHHj+WoP9Ryc0KlTD5VxMY9gcMqAtqjTaLgDbVEdEzvBBuR1gf/ytNJ/uD
         RyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682602325; x=1685194325;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6F3V1Q0yuJG2H/dzr9vN1vKBPQW9aVB7bC55iKWBnMA=;
        b=E4SZWoPbUkcR1l/0ev4Um5A76eei77hvPo9C3oURUNWbxhFvXcGiSNXFbou1dSPvIL
         X8nXOcxLikfV3SKs6rv4Ew9bDL8Y7yRm+fdP41h6j2hz2AH4SLJU9KD1phJLXx5DQ3RO
         bv6FcUh6n+do/QQgRRBKgjIERZD70VqJ2EglvKuUoSykkCGbD6Hi34XyelE1p+eGRv7g
         UL2EE/6dCIPDiId95H+eOQQR9DPeYblAZZFFvUsaLKBt0A0EoKeS2kicIZqNZu+TiHOp
         7WPIAauq4H9xJiDNMOoEi03+0DO0/t1vfL2NpE3MhPDMxwCDUQ/SXJw94abFzhnqvzz9
         Enew==
X-Gm-Message-State: AC+VfDzDPx5TyYQDS/0mZeSDn1Ao9c4qaHrwsG7aPJTDFpwyU1O8MvvU
        YdB/qbPVhTPL3l6bfpwZe/v0V6bOblyeTUZCsKI=
X-Google-Smtp-Source: ACHHUZ5ZTEVYKDfp+Vf+NZ/3GqIvZBfEnbwCPVaaaQjTD/1s9BZUuZCgaXQPo9TK2MZoeeK7h7iGQEqr1vcDpcAo630=
X-Received: by 2002:a17:90a:bd98:b0:23d:16d6:2f05 with SMTP id
 z24-20020a17090abd9800b0023d16d62f05mr1799774pjr.22.1682602325029; Thu, 27
 Apr 2023 06:32:05 -0700 (PDT)
MIME-Version: 1.0
From:   Lara Taylor <usadatahub0@gmail.com>
Date:   Thu, 27 Apr 2023 08:31:51 -0500
Message-ID: <CAJpKm3YSj4bRS+EA20ZmqxjuLpjk+gmz-RFpxnkZ+j6+RRJ5bg@mail.gmail.com>
Subject: RE: ASM Microbe Attendees Email List- 2023
To:     Lara Taylor <usadatahub0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Would you be interested in acquiring the American Society For
Microbiology Attendees Data List-2023?

List Includes: Company Name, First Name, Last Name, Full Name, Contact
Job Title, Verified Email Address, Website URL, Mailing address, Phone
number, Industry and many more=E2=80=A6

Number of Contacts: 10,429
Cost: $ 1,526

Kind Regards,
Lara Taylor
Marketing Coordinator
