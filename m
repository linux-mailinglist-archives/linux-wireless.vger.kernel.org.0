Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0750F6C6BB8
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Mar 2023 16:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjCWPAH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Mar 2023 11:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjCWPAF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Mar 2023 11:00:05 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642E312871
        for <linux-wireless@vger.kernel.org>; Thu, 23 Mar 2023 08:00:00 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id m16so6870393qvi.12
        for <linux-wireless@vger.kernel.org>; Thu, 23 Mar 2023 08:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679583599;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7/+f2xIPdAK7VNsY1tb5txLSv3N63nfUjGPp+SvjwE=;
        b=jP/a/bLCXZnSN2U/e59APJzLp74f50Gt0sKcI4ZT9co+VhvQpJEUXaFa+t5BxV6GYA
         odbV0Xv8aKbSpUAniJCbhLJQ7x1S14CmJ/+Ezr26lQmPQvG7RplLUtE3NlzLDk0WzYiJ
         simyl/NAuvLdvQYQCvckZUAChifDT3yslpnxJ4BnrwPNgJMo2tVnWlh3nUQXUVkQ2cYv
         mPPWvL+Qdw12OOcGFPqSOMoqlaJE1VjxYDl6q35P+uwih0hhdTQDN2Qz7tpLE4s+FPxV
         J+5ZhiYTBuJJgURC9f1to8Myhwx5pC7XUolejSzF8gBF/6o1jSigCPKLFUQhzjYmjpUj
         B3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679583599;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7/+f2xIPdAK7VNsY1tb5txLSv3N63nfUjGPp+SvjwE=;
        b=YyYqlgKYC8Kdv6hFi7eWxDQEn6p14Racr6ZSsDsMLb4d8XcccgpzQUxLM4A0zRMoFL
         7sq1/MN09oIBie/IDgL9gOvPgp9yqfRxgE3J+gH+Xp1ZU1U3Eo4ghIcGukORLEjVraO3
         D4tKSU06zk9ZeMF5mosJmhcNB8J9ml1qZF5VPnxHuVXN5XrmgIa/EoDQbLUpWjE47rtg
         7d2JX0j+1tjJBF4Lm8x8QAwA8L7GhG45fRzODD/Mh0A4+oN69IBkVkJOZz8WQsdM9W6U
         C7zzK03mYH7JjeZ5TitP9b2I8zfy/ptX8Vk250BsYoTwB/vTPuBwjLLDPJbXqmXe94lk
         rDog==
X-Gm-Message-State: AO0yUKWdcwmMIdB9qhrwyXTRMQ8cEc04mDI/W7caH/ruajKtz2H6XxA2
        Nj96v45BtiIViZkQlOlPPktHqQBrfhTRuh9uhDs=
X-Google-Smtp-Source: AK7set9ZIY0dxljgqq2xWDA2OrBiplYTWQU/DUDoT3N23pXOIKx9m5/4gRBtVpIStETLtdJT4XJG929GqcYiA/Jw/+M=
X-Received: by 2002:ad4:4ba3:0:b0:56f:6b7:3a7b with SMTP id
 i3-20020ad44ba3000000b0056f06b73a7bmr1514380qvw.7.1679583599475; Thu, 23 Mar
 2023 07:59:59 -0700 (PDT)
MIME-Version: 1.0
From:   Hobbs Shaw <hobbsdatalist@gmail.com>
Date:   Thu, 23 Mar 2023 20:29:47 +0530
Message-ID: <CAAGnZZL0WT1Pqc-vs2+bdwcLCtV-rM+9veuigDhjOWKYTw+PnA@mail.gmail.com>
Subject: RE: American Society for Microbiology Attendees Email List-2023
To:     Hobbs Shaw <hobbsdatalist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,FILL_THIS_FORM_LONG,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Would you be interested in acquiring the American Society for
Microbiology  Attendees Email List-2023?

List Includes: Company Name, First Name, Last Name, Full Name, Contact
Job Title, Verified Email Address, Website URL, Mailing address, Phone
number, Industry and many more=E2=80=A6

Number of Contacts: 10,249  Verified Contacts.
Cost : $ 1,568

If you=E2=80=99re interested please let me know I will assist you with furt=
her details.

Kind Regards,
Hobbs Shaw
Marketing Coordinators
