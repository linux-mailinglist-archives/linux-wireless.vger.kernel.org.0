Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8721578C775
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Aug 2023 16:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjH2OY3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Aug 2023 10:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236960AbjH2OYS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Aug 2023 10:24:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8169ECF2
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 07:23:55 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id ffacd0b85a97d-3175e1bb38cso338880f8f.1
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 07:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=healthydataprovider.com; s=google; t=1693319034; x=1693923834;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kXIiYcuE32QPLGc8I5pGOsLZACAZ4/p0//J3WyS1ouI=;
        b=D4VrhOLb90bhG400igJXujuvGm3M1d3/EMIiczaCdV/h+8+Xouvl/AerFdqEtwa6nc
         PUhsgawh7HSvqyVYTOJySI+A7/0f+uT0s5Gu/KTBdenUyVTz/ZqD7xQowjDWF7ewxG5S
         8Eg7MbxWpk5ww+AoQ27wx3M5hj/w5ykSS7ZFDGQPA5xwn/jLuYg2A4rOqK3I28aprndP
         2leoxC9vf3nb1Xup8m7y76JMowUBCMbdEPvTNKrO5uYjhxP39cveBXLu7SFDXUNxSii+
         rQJD5V09m+ZWw2Kc45JrkKjeaTxKEiWspKgDaqWL0M3dcqwmQaSZLyR0pbjSrGoONL9Y
         CYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693319034; x=1693923834;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kXIiYcuE32QPLGc8I5pGOsLZACAZ4/p0//J3WyS1ouI=;
        b=Hsn3m/Katxekzou0627OLoDibngNoBH3N3CrOfAwmCBAFogRQQ3CS4/Jq4RhUuR4Ig
         S4t4JMd0rR3p8UXUCIFfY2Vt96PYbMrk2OxbNSCKG4LVoyj60825d0N/VAPmj6STNGy2
         TnKtPSHlJr8T+WEii5WG7G2i8Q647v7ECYiTmY0QjPHpLPuruReffUyionViT1NH1bGM
         5u9uoW3YsLpBKvNeEd30NYMsxfZ15Ih2tJDBrLJ7lsJHqMFjm6XA3quuFY1iM3t5oJ4U
         3z4LF4akTf5UL23rZFky1kYc6yRuSLzmv/0r4AZF1GMWx/augITy+HJNF548fE1y9APR
         Jdjg==
X-Gm-Message-State: AOJu0YwlRDhBW7pj3hApcEfynz3CS4wWUq4FvZbv2R0GcVa6btEs9WvS
        J4xdT8SPP9xWXYrFVxyH7hinLxpwJn4U5tugmyJeVw==
X-Google-Smtp-Source: AGHT+IF7ohBH27Z9jH4n5aznFxGSbSjynB30OJD6HCEH8g8hmlDB7WwSbQ0sjHK+QouPhPU6ELXd92BWVas5gMOQxFY=
X-Received: by 2002:adf:f9c4:0:b0:319:7624:4ca2 with SMTP id
 w4-20020adff9c4000000b0031976244ca2mr21499164wrr.0.1693319034062; Tue, 29 Aug
 2023 07:23:54 -0700 (PDT)
MIME-Version: 1.0
From:   Kathleen Miller <kathleen@healthydataprovider.com>
Date:   Tue, 29 Aug 2023 09:23:42 -0500
Message-ID: <CAF0eVau_0eoxc285XcrvGHR3O+opJvegzKQLpQw0RR2YZxw+Lg@mail.gmail.com>
Subject: RE: Money20/20 | Fintech Events and Conferences Attendees Data-List 2023
To:     Kathleen Miller <kathleen@healthydataprovider.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Would you be interested in acquiring Money20/20 Attendees Email List?

Number of Contacts: 11,198
Cost: $ 1,617

Interested? Email me back; I would love to provide more information on the list.

Kind Regards,
Kathleen Miller
Marketing Coordinator
