Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACBE7D0D37
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Oct 2023 12:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376880AbjJTKdl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Oct 2023 06:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376842AbjJTKdk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Oct 2023 06:33:40 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91721BF
        for <linux-wireless@vger.kernel.org>; Fri, 20 Oct 2023 03:33:38 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507bd64814fso903757e87.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Oct 2023 03:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697798017; x=1698402817; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXW0XLbysONMykMEv6rc2JXmHxovj6+38RDfojMr8Fg=;
        b=SrzjPLMVx9eMPdGxGX2q8vRFI2I3ppeAtQstjspfLaqBDuN1P8b7rjv97SK0bXFUxx
         DWDhldDkoVI14RpRfefCKLcFmvIX2/x+tZXp6LD6VQlPWvPHmjaaq3WcPPO7HBmf/SVI
         nuCYYGpPl0chqI9vvFv9fP2tW8a1zMkYEUlIaVUt+Iau+sOzU413Lh/Iyhu4MU80JtRI
         nQhCNN5bIscvyydU9fBMei+o6IYQ5q2Zf3SWRf07LoCO0Ilt6BM8ezeHipJ19FKROHmH
         P4HS3atoZ/bCiLlvF2EbP3U+LSbBaQ69X20rQeuaW+dW7CHLS3soTHfolQF8XmmOn94P
         COEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697798017; x=1698402817;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXW0XLbysONMykMEv6rc2JXmHxovj6+38RDfojMr8Fg=;
        b=OHTmBugZU1vpKyMzUZ1tAxM7sU3vdNaOhVIfZQPZNBWuMQRQAhLMabjAy0b/lM+D8r
         tkXbKX+hJTRc7u2Npk8kaVxZ8kN0V9OPCTTJo5pnZQ7RsxSMx3DlSwcCdnYfWmsa+STg
         Vl5OZmgmL8twQfuvB2JiQAhsYGlE1sQUHbKProkKrKXPBLsHmM+M/Vuqz425ufqCyHXt
         OYxZ4AySiuhVJvUHNqI26GkDIRlgneGeVosEzhUKuYIWVXlccVeLdXMAk38vnsgTZZWD
         h/qCL79nGjsx5C2Jztvaf4XnYljjyNq+YLwbX5H9LgoUf9jM+6I3XGueZpfEzCbY/Jq4
         sFMg==
X-Gm-Message-State: AOJu0YyCsfQRCJOAHcoTyN+kjIo0Hh2aQlA7Y0tDJgVxJZEIYmwT/oXQ
        n13yJno8+OQqH9A7CRphmPtvgja6HK3yHurFuDk=
X-Google-Smtp-Source: AGHT+IG4hNfe42FcNPkrlxSCA37c8N5TnnkQc4tmvBfjore81gjkCy9rWmsn2+aD1okxY1rLkvM7pbzRl7mg2UmWVG4=
X-Received: by 2002:ac2:4241:0:b0:507:b87f:c61b with SMTP id
 m1-20020ac24241000000b00507b87fc61bmr885740lfl.66.1697798016781; Fri, 20 Oct
 2023 03:33:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9a:790c:0:b0:27b:b059:98aa with HTTP; Fri, 20 Oct 2023
 03:33:36 -0700 (PDT)
Reply-To: dominicdennis2023@protonmail.com
From:   Dominic Dennis <ikog270@gmail.com>
Date:   Fri, 20 Oct 2023 11:33:36 +0100
Message-ID: <CAOwBJfU83Ztb0Qq7GMMtw+pHeS-QFGxmtTE6MV=78h9ukKTaXA@mail.gmail.com>
Subject: Engineer
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Engineer
Am Dominic Dennis by name am from Netherlands and 53 years old? I am a
Drilling engineering am presently working on a contract with
international Oil and Gas company here in Caspian Sea in Azerbaijan
please can I have your Whats App number for easy communication
Thanks
Engineer   Dominic Dennis
