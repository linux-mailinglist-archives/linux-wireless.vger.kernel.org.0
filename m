Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA6056BEF5
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jul 2022 20:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbiGHSXN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jul 2022 14:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239211AbiGHSWJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jul 2022 14:22:09 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D432E84EDB
        for <linux-wireless@vger.kernel.org>; Fri,  8 Jul 2022 11:22:05 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id 5so11114553plk.9
        for <linux-wireless@vger.kernel.org>; Fri, 08 Jul 2022 11:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=M6suOAdRJLxu3fPSSE3NSOk2doSz21o50xSAm6DBmvY=;
        b=NE0/TN/jxLRSF+Rm9/GZ0avM85KU4kcZMgX/9k5GgpsBkYAmLT2rPit0NlcZ34R4+G
         2aAKaL2MW6jU/QgzCThQx8bo0/DV2+j+9SwR9BHV1kbkOJNfqjRdjuPX6WCSKTmlDYC1
         7zbSldM9GLXqTJvQP9p1NMQ25EZxPAhj0sOtun03QRtyN/NeFyNwhicWBtg+kGFL68Xf
         VRJYKrmo0XqxWyr/Ld/LQMGnOfhQRUF8IWoRX+OxIkwOCOlhRSZDSKjnGlkVFvT5L7Hj
         qljhMLM2y6MI1fEewNY4mPZOiaqjYAU4KctreigAFiGRsh8oHavZf6eOHeLB+OSLgZ3q
         V9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=M6suOAdRJLxu3fPSSE3NSOk2doSz21o50xSAm6DBmvY=;
        b=zBIAEE1LYlp6leOyap3x2eBxojpWqinN6sCd+cdK5mQKiRWnctvsrYscXfP8dne4qA
         k6we2VzfdukIfJhgBxinT8MQUWEApceDChgftuOtrHUoF0H2P5DFRdmjSthb7xSRx0IK
         Qm2n5kK/s2z0d0UDP7V3l36X1ypfqbFIPwknq336e250bxb/4//HIHewk6HmO502h4BQ
         6qtKULxBjbsrMphIkCH0V30Y3cDAiqe9EJN5rj7pvxeCdbakxEX9DTGNbweN/w8etNCx
         /8r6YKNqhdTjl/cD40Zw45pbDCR2wsBJRhi8YZjRwGcCl9zpgXDnJ3b4Jzy0vU1Ks/cY
         5OTw==
X-Gm-Message-State: AJIora86ffL1gIMWF47rkVhH5NwH8joycwfMtza8B+x6scO1lvuvh1ud
        3o2Z+DIoqECee6Ke4KbmH7iUBrS9sYc=
X-Google-Smtp-Source: AGRyM1tT+IAxmzoqKoLFRCNHcOXdAyhuM2mGTKKnA5/o+edb4nDXb1FYYhQsl3XnksH71c1pEvLXiA==
X-Received: by 2002:a17:902:7c06:b0:16a:755f:86dd with SMTP id x6-20020a1709027c0600b0016a755f86ddmr4916749pll.82.1657304525106;
        Fri, 08 Jul 2022 11:22:05 -0700 (PDT)
Received: from [192.168.254.55] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id c17-20020a170902d49100b0015e8d4eb1dbsm14415689plg.37.2022.07.08.11.22.04
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 11:22:04 -0700 (PDT)
Message-ID: <1c1a0a2c454dafcfaa19995974448ee5836fd9f7.camel@gmail.com>
Subject: Expected behavior with co-located 6GHz APs?
From:   James Prestwood <prestwoj@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Fri, 08 Jul 2022 11:22:04 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-3.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I am playing around with a 6ghz AP and noticed some behavior I didn't
expect.

The first issue I ran into was the regulatory domain. I'm in the US so
6GHz should be enabled but "iw reg get" initially doesn't show any 6GHz
frequencies. Its my understanding these frequencies get enabled by
received beacons, and indeed if I do a full passive scan the regulatory
domain gets updated, e.g.

iw wlan0 scan passive

After this, I can active scan and see my 6GHz AP. Which I'm assuming
was based on the RNR element since active scanning on 6GHz is
disallowed.

BUT, if the interface goes down, the regdom reverts back to country 00
requiring a full passive scan again to unlock 6GHz. This basically
prevents a supplicant from using 6GHz without doing a time intensive
passive scan.

I would make more sense that the regdom should be updated based on
finding an RNR element in addition to the beacon itself right?

Thanks,
James

