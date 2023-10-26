Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65ACB7D7C68
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Oct 2023 07:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjJZFoZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 01:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344265AbjJZFoR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 01:44:17 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323BB1B5
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 22:44:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ad8a822508so79578666b.0
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 22:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698299051; x=1698903851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+OJUnu5Xyo6qiAk3lOeHEj7Khwzl6sk3V/Pa66za9zA=;
        b=cZP+K4zwdlDJxQ20ukz4ZCO7pPY9CwNn85CUtpXg1+DEAP+G2kmvYpxTW844KV9o3E
         JKmyF9kzA+gkk1yjvW6NX4LbR6hvSmSEG/BH65tRWyNHjJUm+vqSxkxUugDQMVv2TFKB
         fiexzvy7hBAXqprBMd4czLTl6j6EXRGnAN8HoyXKvRkz9mO86C0trkwb6ESZAKeh3slq
         4p6hSrr8Q1exGRXiCSWbOvUPsatwv4zcYEa0nn4QVJMU3fbRvtoELhWH6KhMTbhaW0I8
         bEz6xQKYrNYyyNg3+UEht8qlWz2HOHxuRxj6OAGG/x2L6R0iC3qHV7AzH/ZZfEoQp2fs
         Ugfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698299051; x=1698903851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OJUnu5Xyo6qiAk3lOeHEj7Khwzl6sk3V/Pa66za9zA=;
        b=Sm5r3LCuSTF04ulDdqgk8sP6gTLMFgz7zluvEy7DkJbirqPQquKtnb9S7Q4Jh5dHPS
         65KpKLnVcF/i1hv6cG0D+zRGINwlkffnMDa1pfcA+sxQbmBHNbb2ciJ8j1XG3H78L57B
         4IUMW82D0sMBylCeG84VbPL3lcbafwjj3yZGwnaBpT5TI9b7CIAphQYIesoOZZ8GusNA
         spIyeU/yMYUs7lsLRjWEz5d2bOxuFFa4fzb3TBUBL/bZeXa6sG2BUn8ZBR2D4WlLTV7V
         7tvKof7G3LRlx0S9/85zWqx77+NObqrkc8nA4T/2G4r8V5PCWZJ8vp0NkUCKEyojDSpI
         W2dw==
X-Gm-Message-State: AOJu0YzAeQfx3HslQAdVkRfAO88YN1QOvTj7EjGGWEB2T/zQ1LyHCUu/
        6x7QG2swl8eTeOC8o3Fx8vnQJA==
X-Google-Smtp-Source: AGHT+IEMK+qpYHIw/wHituk5Yf/BG6b9mYwY9jed4nys7qOGnBYi4oDetXp9z8Gd4C8zc1c9u0fdXA==
X-Received: by 2002:a17:907:9306:b0:9be:b43c:38db with SMTP id bu6-20020a170907930600b009beb43c38dbmr13183863ejc.5.1698299051236;
        Wed, 25 Oct 2023 22:44:11 -0700 (PDT)
Received: from localhost ([80.95.114.184])
        by smtp.gmail.com with ESMTPSA id lh22-20020a170906f8d600b0099290e2c163sm10869118ejb.204.2023.10.25.22.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:44:10 -0700 (PDT)
Date:   Thu, 26 Oct 2023 07:44:05 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, j.vosburgh@gmail.com, andy@greyhouse.net,
        dsahern@kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
        vinicius.gomes@intel.com, johannes@sipsolutions.net,
        razor@blackwall.org, idosch@nvidia.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next] netlink: make range pointers in policies const
Message-ID: <ZTn8pUiInbowFf+y@nanopsycho>
References: <20231025162204.132528-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025162204.132528-1-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wed, Oct 25, 2023 at 06:22:04PM CEST, kuba@kernel.org wrote:
>struct nla_policy is usually constant itself, but unless
>we make the ranges inside constant we won't be able to
>make range structs const. The ranges are not modified
>by the core.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
