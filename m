Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D5064A538
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Dec 2022 17:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiLLQnw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Dec 2022 11:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiLLQnV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Dec 2022 11:43:21 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B2210D7
        for <linux-wireless@vger.kernel.org>; Mon, 12 Dec 2022 08:40:22 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id vv4so29548003ejc.2
        for <linux-wireless@vger.kernel.org>; Mon, 12 Dec 2022 08:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NacOrdxo6or49puaQltDwyuwejdfk/XKgwzAQlckQDI=;
        b=LhkVv/hkjoh+o+Mtd64t9it5LyXdhSCf0ieLRSnTAgOFPlRUUBqchasfmnmvGEvC6/
         l+5UhMObC/4j1OHK6rdUDpeTVRyCIBEmLtWTDuhcKMhf+v2r9LvPMpAiJymShMR/NKJx
         BEvJQmp3fZLccHJfNp+q22HCb29es+ANiy5cWCvfZS26G7kpI4/k1L0f6Neiakf2Sbxl
         TlpniXrdQTlGq0W+dEuOVdGaW0KFFAYKNxpHgzkkUHoj60wzHODynWD1Ce1iWS8hiACS
         Zq5VGlayFPhEg6nlt+EAYjgdf6r6mCBbTB7yOOtUydjLoleO5n0cqZ3Z8C5LQzAhO+L4
         cMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NacOrdxo6or49puaQltDwyuwejdfk/XKgwzAQlckQDI=;
        b=djFH7kCoYkeXzh5etSov8Uv8S79uPgfWTegvlGUu1RK0/SaORO/WRDhcAc/Ji8Pxr1
         FdcLry7yxGdIxT5FI2eRoIidoQ8aI4DDLiaLgSQy3uVxdfQEXI+9I8/njqkG533hHANu
         cBtc9ShaRBv7zbl9/A1z/UVDbiXQ85k2sAHfZHbVyMKxHr3+/eUQvXA2viCrw5UsikXq
         v3zDGkHIy7RrP2DgqHpw2aRBBvmp3FosB3ThWcYiiS/00GBVqqBUtwCv/eAkomLRuuuo
         NxmPmFE3tQSvxPQmwHKJvn7PSuFgkSvZoMF0DA7NWAA4CHZdKCOwT8TRf2sgFFdnU1q/
         SMww==
X-Gm-Message-State: ANoB5pn+BPTgbEfMzJnRQHh/2F30QbVBPy5KcZrBSMPek87BHHEEG8tK
        KZgcMTv76cw342nKjjVJTdHvEqu5nCt8eny3btg605zEz2Wkcg==
X-Google-Smtp-Source: AA0mqf7AzUmYM3mevj4K+VGsr6mSBX61vL3ZP3FfHsXyCfTfBv/Nm997q6iQ89OliinzdfHPSOIuR/JhuKEMe3P3+JQ=
X-Received: by 2002:a17:906:1641:b0:7ae:7d78:9fa1 with SMTP id
 n1-20020a170906164100b007ae7d789fa1mr78752681ejd.98.1670863220556; Mon, 12
 Dec 2022 08:40:20 -0800 (PST)
MIME-Version: 1.0
From:   Joshua Richenhagen <richenhagen@gmail.com>
Date:   Mon, 12 Dec 2022 17:40:09 +0100
Message-ID: <CAJZ9B5tdZxqBG8pZhEKdzfaNqrR=8jGdNuMXJ7cYCitL7eatKw@mail.gmail.com>
Subject: Realtek 1d3e:c826 not working
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

on my new Xiaomi Book Pro 14 Ryzen with Realtek b852 using newest
kernel Linux 6.1 Wifi is not recognized at all. Is the PCIe device ID
missing in the rtw89 driver?

01:00.0 Network controller: Realtek Semiconductor Co., Ltd. Device b852
        Subsystem: Device 1d3e:c826
        Flags: fast devsel, IRQ 255, IOMMU group 11
        I/O ports at 2000 [disabled] [size=256]
        Memory at c0900000 (64-bit, non-prefetchable) [disabled] [size=1M]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [70] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [148] Device Serial Number 00-e0-4c-ff-fe-88-52-01
        Capabilities: [158] Latency Tolerance Reporting
        Capabilities: [160] L1 PM Substates

Kinds regards
Joshua Richenhagen
