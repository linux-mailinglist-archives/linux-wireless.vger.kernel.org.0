Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF68517830
	for <lists+linux-wireless@lfdr.de>; Mon,  2 May 2022 22:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387185AbiEBUgq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 May 2022 16:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387418AbiEBUgo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 May 2022 16:36:44 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5FDB1E2
        for <linux-wireless@vger.kernel.org>; Mon,  2 May 2022 13:33:12 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id m23so19843785ljc.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 May 2022 13:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=Gk4nfCem3ECRa7Gml0J0mN/3RZoOAdfGaQAqyHPKtiI=;
        b=Rwzm9VRKNN56nw7IiSQVZnsi3PSMlHTis14QNlhlNOI0xYsrA+6pOcd+8guWWk1aeK
         VU4BSgDbho/ehlhM4p57syivmcaNgrICddWq9UiqoJGMDrGCHBt8j0fgpigE3jvtQ6dO
         SVt7Vmv4klfMxYlvLVzdPipXtgwV5tiAAzBeAO+KnhxeOF1BQtqeKHHFgGQp9oJIY/VI
         WCZ2kgV41lZv5H9+RgrCxX8649ibXJB7iWab1GTPxp2JsAImDj6SkEe+U23aYpJMVpkJ
         QoX3jFXMVfx0nACsFZr/YFl3j8iGMwDPmUnkPmwU7mr/CHde4qAySVxQMl0dxCZtnvAw
         wp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=Gk4nfCem3ECRa7Gml0J0mN/3RZoOAdfGaQAqyHPKtiI=;
        b=gvPTZkpFyC46Y5I9xk+41h9rG9y6YAy0tUYv0eu8xdXFuyfLrTOEhNTLaWZjBkQ8ad
         LS3sM6r0pIJnMmY1xc1jhUZngxrFXZ96TSlFDUveAeQfMAuCPW/QsH+5qIkvz3cIsP4r
         YukuFS/mwP87UjIIYIasOD7uwqiwTEI5byrQ45RRHIhARe+AZ7fvLNZL6yA7Rgnxbmnb
         sm5J+KNbWECISwPmTdEULdUKhErM9ffrQwdEZ6/wmWQfWjAGF6VE400pag5oKqH7aWm5
         dRlPWtSBRaBUJXrWX40QzsFj1ZA8M/DHqiHZfw75wFbzn0kCtwUA0Ioh50I85DfFEt6Z
         XY0g==
X-Gm-Message-State: AOAM530NPplyJuqvgYMX9CzkNaq7u+8mFdJsR9MC+TY7qzz6hUSZREfw
        7XN71FeMSg+BeP+vZEzWx1a9YMP6RIjgp0OTLU0=
X-Google-Smtp-Source: ABdhPJxzDIsqiOFhS4ygX/8r5fiEqowe0tn6tzVFsA9up2bSD88dAznd410wJWFsc01oLcH0YNrMf8p8qLjfSY8eUI4=
X-Received: by 2002:a2e:9dca:0:b0:24f:2924:9295 with SMTP id
 x10-20020a2e9dca000000b0024f29249295mr8540778ljj.480.1651523590462; Mon, 02
 May 2022 13:33:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:688:b0:1a8:2581:64e0 with HTTP; Mon, 2 May 2022
 13:33:09 -0700 (PDT)
Reply-To: johnwinery@online.ee
In-Reply-To: <CAC0r5QWWDUOxkF5zY89ezmcNpvZPWHGS01H21+id9UM783h_5g@mail.gmail.com>
References: <CAC0r5QWWDUOxkF5zY89ezmcNpvZPWHGS01H21+id9UM783h_5g@mail.gmail.com>
From:   johnwinery <humghrysking@gmail.com>
Date:   Mon, 2 May 2022 13:33:09 -0700
Message-ID: <CAC0r5QVyPEzz8Vkw_jPQ_ktQFFpNrnfFnh0-GgUntvuJrYU5CA@mail.gmail.com>
Subject: Re:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Greeting ,I had written an earlier mail to you but without response
