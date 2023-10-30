Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6C67DC179
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 22:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjJ3VA6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 17:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjJ3VA4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 17:00:56 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50160F7
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 14:00:54 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1ea1742c1a5so1185658fac.0
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 14:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698699653; x=1699304453; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P8m8EAbGJbUxe5B9fBXpOTBojQ9A3raNvAoswxRtY9Q=;
        b=gYKcHxPhZuF+3d1tRKcVuAMgNwkOEj7o+xdqIdXhMCMh+UERPJr9u/i+xw+wu5fSpO
         uS4FUFqciJx+cOjfJyIDmTOqCiqp1vecaWB3McgyxDP841RMBas/v5wZ34Kpa5kp6K9c
         TUQXzrEmj0KYqehpYqLlTt+07nIsJSWXlOphx01VClNuBB7NME4b8QugJiIYJazlBtf6
         bxk8url8tN17h8gbkZAvsuQICARKIl36yVb5oN93fWO6RzX8OMghhJWDd2XwQP+EQjbS
         2w5iiqaEHWa+/bhXR9P8EzkE5brM/6HzG7xKucJKluTbDCWMWe7HahvGPvQzUJVbRW22
         Q63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698699653; x=1699304453;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P8m8EAbGJbUxe5B9fBXpOTBojQ9A3raNvAoswxRtY9Q=;
        b=GCLzpZOzHNiIv9dkAPy+E6IK+iLbCbuHfaJf1J+BNVs6ya5yzlrqfzl2bJP65wyBZ+
         GsglJmBX6EV9VNTvS2nweaSdL2Dm/2ETOcNqR/80aGFD1TOJ/xuY4V7VC/ScnhiBvUWP
         T0yTSJjlqyBfYynqkquKyyCF/opyZQX9hShHlA+UU+6O1NGXyZ0fcCyfUYTBqGSCVsVW
         HJn1BIcYnrN4j6cx0emw8z1ysyqbZ6Akjatf7p1HK3TJhrKdB2YQQ1TiSenZC9xpxERA
         wHI68L/rwmsnk8JsQNCgBVbqbwjpRFtrIhoEhHO2uLXsZE/r9H1Hz0n/3unsSrEXmmo6
         KDLg==
X-Gm-Message-State: AOJu0Ywi7tDE7WUYb2mnM1rX8hQt+WTOjfD5ua0AhUZtgOc8dNeWWVHM
        tNZ8F+/WUAlvbGB8XHLB2mHSHrc9FYrHO+diU5g=
X-Google-Smtp-Source: AGHT+IHeCj1fS8NHrfyADJ47pG0M+N1ni+AAVhnMC/OaBJv/bdXfVzLFoJehASyM4moqjbnFU8izIWDVMLvuzFuykJE=
X-Received: by 2002:a05:6870:6f09:b0:1e9:9440:fe4a with SMTP id
 qw9-20020a0568706f0900b001e99440fe4amr11989097oab.3.1698699653332; Mon, 30
 Oct 2023 14:00:53 -0700 (PDT)
MIME-Version: 1.0
From:   olivia taylor <onetapdatalist@gmail.com>
Date:   Mon, 30 Oct 2023 16:00:41 -0500
Message-ID: <CACxKAZkCJWtOYAzSpb9XmnmLDEuMyOr3CjrN=bcVjkMMcQ46qA@mail.gmail.com>
Subject: RE: AWS re:Invent Attendees List- 2023
To:     olivia taylor <onetapdatalist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Would you be interested in acquiring the AWS re:Invent Attendees Data
List for 2023?

The list includes: company or organization name, first name, last
name, full name, contact job title, verified email address, website
URL, mailing address, phone number, industry, and many more.

Number of Contacts: 50,487
Cost: $1,989

Interested? Email me back; I would love to provide more information on the list.

Kind Regards,
Olivia
Marketing Coordinator
