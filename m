Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D9C4B4ECD
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 12:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351462AbiBNLiL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 06:38:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351252AbiBNLhy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 06:37:54 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169116E4FC
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 03:27:42 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id o9so16902262ljq.4
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 03:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=aN2BRs9HUKv2X0mJcu8zLnoGRs+vCi9amFLFqcvGDK8=;
        b=ZHlGFa3+PKB+TDrD2Tpl5yzG5R+QT5dyHQoLIQNMH0F2rsjhjyhBsjVTBn8ca79WeJ
         O+SFqMNMyuAtInwRVavDQ/VcnM9hNwaMPXywSP9pocXmV8lKZFZC48HZ2Wp7vixky2Yc
         Sj1HpFGDaGxjSZ/9LmYqvBcp3U8pNeMf1DwsnZo/ykwINjlDolkZY8LYXOewkfNxJtVy
         PBzgwS8jIyhDdxhQV3qtC2jBVTZx+hQT18A647sIpFh8gWZ6oJOWcjNCTRt5gXwrSa6h
         6+Ax4swu2rzIqDwj7Y6nq3ZM37gaqG4jUC6xVvz7ujSPmFkjHAvTrsCDzHApPtEpkyzC
         gYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=aN2BRs9HUKv2X0mJcu8zLnoGRs+vCi9amFLFqcvGDK8=;
        b=pSzI7vvRRidQulOqUKIrrhc/j8c62rGy/EbrJiM5FxPmo3Fqxk5Hd1rihiYbqv56j8
         CxTmVPiYLcm7QVrzn2RCwnD0CaWqVH4X/NpjIxM3wxe7bZMPV24pQ9LPi/+13z4bnKsF
         seDFBUjhOButL4/W5GmSRnp9vVO3T/89OJC+gS2493xU3O0GkHRth710B7YbUdSHqjTH
         CBE+JozVsk0Kb8jmWaHHaSXptETug/VnWdErf3RSmQgGg+7kbNZneF5MuA14qK3L7FCP
         vafiR9Hv6ROCROcv5Z2ahW85WpZ2aJWrGJq6mWHpvEDMIwtcupezRaXBW/qbnV1hPgwg
         lZ0Q==
X-Gm-Message-State: AOAM532A8fdENIdD+dY0aj7E8pRH5JJBZC70IhDO2pOJASdnpGrxKqF4
        1tLryBSEV8iuEPS9o9tSdpTHwh9IJZh5MqDhTIs=
X-Google-Smtp-Source: ABdhPJwgWehXfGRK2BiKy2CXEbjAX28WvLdFMCk3aOtv7CIGfNKGSksAOfwWsz6rh7Y/byKRMp3Qoov58vFuMBGL51g=
X-Received: by 2002:a2e:bf08:: with SMTP id c8mr8883388ljr.281.1644838060501;
 Mon, 14 Feb 2022 03:27:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6520:2032:b0:19a:6cf5:d831 with HTTP; Mon, 14 Feb 2022
 03:27:40 -0800 (PST)
Reply-To: westonjas@globalfcbofficial.com
From:   Dr Jasper Weston <missga2018@gmail.com>
Date:   Mon, 14 Feb 2022 12:27:40 +0100
Message-ID: <CAEoz5bBh5M81sCMX+DSXOcO7E3LzGvZ=LsuAqZf5M=cutdtNfg@mail.gmail.com>
Subject: URGENT REPLY NEEDED..
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=ADVANCE_FEE_4_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,
        URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4950]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [missga2018[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [missga2018[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.6 URG_BIZ Contains urgent matter
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 ADVANCE_FEE_4_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
Dear Friend

Hello, how are you and how are you dealing with the coronavirus
outbreak? Be careful, I am interested in partnering with you on a
great deal, kindly reply for more details

Warm greetings,
Dr. Jasper Weston
