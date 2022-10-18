Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6F7603165
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Oct 2022 19:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJRRNs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Oct 2022 13:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiJRRNr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Oct 2022 13:13:47 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B3EED984
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 10:13:45 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id cl1so14518152pjb.1
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 10:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pzpkUJ189ntl/UdbbVsn40VnhyPZPxCM/e526VHiq/A=;
        b=mk5TI2ZlH2P0M0mdG8nwOe93STGB496CxHCJatUxDbGwNQwk1jLycKFLzAbVwoRSf2
         N1UPt14UYZIF1FJ29GeLgQjRSIxIXHh7hhBoB7otUWuRvrCD3w/QufzGc2PqOid9vR7x
         kdnZsCmq7pgoEW1OOUcBA+fQfeNsL4phCA7xm1Uttq74Fn4TtXF6GnkCbryE+M69vnqT
         Q6w4hu69W+VzhNua8T3L+QtbXIRe8VyG1iOlTFJkYRscudjPrQHO0z9PVEobDmov4Ant
         adn6sbHfkd/Gx9u3cPABRZjVqT5P78JjY27pyQBIlosMUp90D4TuCJNkY+d2wOWqxmzw
         wmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzpkUJ189ntl/UdbbVsn40VnhyPZPxCM/e526VHiq/A=;
        b=3fZKk7k7r4eOOIMgMWe24LifI/fG0USWZQsKyum6r4FIRbLRlZCz1ANMg25LdfVfRf
         3h385oeJ/GS42gNe/xspSMrjOcu6xZdVqj/3hFgHIGPFcB9/dClpGDMgI1ZJBo3MQnjs
         916DS9ityxnyU3p7UQra7wYNefWht+PQkZKIjba4as2TU4sYQkKauAyGJ5i9bqzYHI9k
         X2+RpoZvIgUNJDdB3Dg3kZAOFHS8pbj6ahZVYk0zgM8Q77xwjuiDMirIdo35JhD5+kF1
         o44MVi9upA7BOcbNWCmq8j5Ek5zSSHcjvzGtwxUTMF7F64KT31mgAcDjKBdr+AOEeu5J
         P5wQ==
X-Gm-Message-State: ACrzQf3bXnUSD8MAbMAr+5bN4fbPJD2nQ7PQZFX6eLpM6J9hH567KAam
        Y9j1yHjh6A15Lgf0ISFclF4UjYavxso=
X-Google-Smtp-Source: AMsMyM5n7EJDFiAMfsc3boN93ZPelGgMLJSZoD5SgLnhwSxZeBjAslURxFqjcMbN96NTmYUanja56g==
X-Received: by 2002:a17:903:2307:b0:181:e618:b4c5 with SMTP id d7-20020a170903230700b00181e618b4c5mr4085765plh.172.1666113224822;
        Tue, 18 Oct 2022 10:13:44 -0700 (PDT)
Received: from [192.168.254.15] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902680c00b00178bd916c64sm8896362plk.265.2022.10.18.10.13.43
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 10:13:44 -0700 (PDT)
Message-ID: <52d15e34cf20ddb372b2791c18776405f57d2516.camel@gmail.com>
Subject: Reassociation is broken via CMD_CONNECT
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Date:   Tue, 18 Oct 2022 10:13:43 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Based on the documentation for PREV_BSSID:

"previous BSSID, to be used in ASSOCIATE and CONNECT commands to
specify a request to reassociate within an ESS, i.e., to use
Reassociate Request frame"

But this actually isn't true when using CMD_CONNECT. The kernel does a
full re-connect if PREV_BSSID is provided (easily verified by kernel
logs which show an Authenticate frame being sent).

This is due to, in part, cfg80211_sme_connect() calling
cfg80211_get_conn_bss() which sets the connection state to
CFG80211_CONN_AUTHENTICATE_NEXT.

I tried hacking this to set it to CFG80211_CONN_ASSOCIATE_NEXT if
prev_bssid was set, but was unable to reassociate. I think the
CMD_CONNECT path just needs to call rdev_assoc directly if PREV_BSSID
is included? or some other modifications to cfg80211_sme_connect()?

Thanks,
James


