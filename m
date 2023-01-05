Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA7365F2A3
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jan 2023 18:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbjAER2G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Jan 2023 12:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbjAER1o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Jan 2023 12:27:44 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEB260853
        for <linux-wireless@vger.kernel.org>; Thu,  5 Jan 2023 09:23:51 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id jo4so91636280ejb.7
        for <linux-wireless@vger.kernel.org>; Thu, 05 Jan 2023 09:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JT2Gt7y/M3YLHVCyMzZwNsFe1p6EOvnpVpu2gl496w=;
        b=bnQATo5i7yL1AKzNCNlyfQQX7ALBry+gwEx2JkOVaOoArqS2RgvdbDttRg0yQ3Vm+q
         AE9WMQGeOcNuG1Fk2HiAKLe7Yk80Rd3Ubohit5v6iEub0oHtI1liH56OHUpsk32Zjg3Y
         W6L2WuCDqI7MAeeeKFbWK9Iljy7X0BoDzFI0GfLygE8dOg+hkl8ZqVfAAhzH5EkAOvwz
         lA19307MFKOwGGQ8IH2xxlKr8/C12vJqTpXxogQCfCmU5Wf0JhO+Q+C1ApRo/cb2LSk6
         sWi5xEvVB+su6kElh2EX1fsLcJR0H/DyU44e0kagAPn/yFvlXtNlEH/I1NU9tmOVgxQo
         minQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7JT2Gt7y/M3YLHVCyMzZwNsFe1p6EOvnpVpu2gl496w=;
        b=2B8cC0iqoFMj3An1KOttH9/tDB/SW9xxKwuN8CrKxqA8O7oByZE/uZjBkVNGt72ej3
         COktacnPbscTFsTXAFHQ96WwuLhOHfggk/pwDyWk2/mZ/v0VfYzMpjJgkQOMDQTgChTl
         ERXUDSqqnkIx+pmg+caLtoDhWHK6yEBh3yfp0aPe1ImRnxdsn+yDMzPP5zn7sovqKRK+
         IT1HbdqQoHRB0NGBdiJ3B5h/L4o4878uQrrV7NH1N5XgIVfyMgQ+WgJOzchiqANb5FfQ
         DDQx6+0amIX5Xe+htgfPjBQFvFIwDkv5kPhdmdRVVWu58kuYTtoiSUbIpJ8TeQ4RiGMm
         l0EA==
X-Gm-Message-State: AFqh2kpwpAAX7Lq0ZxdU9hYH2JhkXjuyDB8jLGd/ziKaxTT9NBpza6pf
        CpPQQXSa1EPrlATjE7KPoWCrQlB7hGbdkrQdzVI=
X-Google-Smtp-Source: AMrXdXsQrhFfYLpGB4l/W9Ix2jJV0Pv7iduMEbBardu66mNvKSPX8iugcvRk3ZY4dl9qAl/hcC5SZphogmfr9vasHEE=
X-Received: by 2002:a17:906:86d1:b0:78d:9e77:1f8c with SMTP id
 j17-20020a17090686d100b0078d9e771f8cmr2992774ejy.236.1672939429793; Thu, 05
 Jan 2023 09:23:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:907:c308:b0:7ff:7876:a6fd with HTTP; Thu, 5 Jan 2023
 09:23:49 -0800 (PST)
Reply-To: westernuniontransfer277@gmail.com
From:   dan Hudson <danhudson5688@gmail.com>
Date:   Thu, 5 Jan 2023 09:23:49 -0800
Message-ID: <CAPuvh=WPG21mn2tVHjXwUtQN2OrWS4uzifCR06BKR51JYrw8XA@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Good day dear,

This is to let you know that your payment is ready now, but we need
your details now so we can complete your transfer today without
no error, so please try to send us your information now
so we can continue.

We hope to confirm your information now.

Cheers,
Western Union Agent.
