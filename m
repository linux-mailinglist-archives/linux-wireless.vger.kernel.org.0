Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A08309F01
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Jan 2021 21:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhAaUrc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 31 Jan 2021 15:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhAaUr3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 31 Jan 2021 15:47:29 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D86C061573
        for <linux-wireless@vger.kernel.org>; Sun, 31 Jan 2021 12:46:48 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s3so2873643edi.7
        for <linux-wireless@vger.kernel.org>; Sun, 31 Jan 2021 12:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:subject:reply-to:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=dvq1MPvNC+UUn6WXzOeHefYShSdkA00farn93A4MAZU=;
        b=KCNL0/SsLW2hye1zRhxJ5HnGgiX6MIPn2zWBNm0WpAMTCj5zvEdMkANINpgMUIqKHG
         uTfW7711dLGzxKtOG+D4gI5nsFWWOgBh+F7Zx+mTaAU9G6FDwoo4uB5yg9PMCNhaB1li
         jEjjFaIHprot692sTBlUtbGgCV36HX6vLYhLgi3VEHj19eI4YwxvdBMWCXMfjLVktXhn
         lyDLkuvv8aE5a3B44e4HXeuOaSnfNWTSLOtnwylYF0AocKEP/Zevj8GNCU40jT0v5Shv
         LCN4xgxRde6OFw7fiXW0giBvwZyJ1in7jCjHEIobG/kZI3TMLrvE8KObG5DaZoOFD7zI
         iNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:subject:reply-to:to:date
         :user-agent:mime-version:content-transfer-encoding;
        bh=dvq1MPvNC+UUn6WXzOeHefYShSdkA00farn93A4MAZU=;
        b=Eg2deP2eEkX1sHi44WM594uqa9s09+gUYR686xF4XwgImWyaWnNxdbJtAZbDDzut/F
         1LRfgCKCYY/eirpziDm7LxCDY96PYctJrE3SyOjA5orLyzNTiRmyDqcEHSwgvGzmpcvX
         1qTokXngYSXqITQH/R/sbOCJEge6Mqzi99mqRWdWPz0zhZwQWTBefNPv5TZ8hG/VYm4t
         3DvXhzfhbRm8AK4C9ZeQMfMhxsacJ4/U7nYSRrRwrbP+WqbuhInMq6SUmvEV41M7VCcv
         a6PjNvsEdmpD+mg2kqoPH30Ng+2u8kim25f1OWEMffWeyRgrqZNJToAEDBm1mSAGrHcp
         ZVPA==
X-Gm-Message-State: AOAM530W0l1/bKj+hcEzgtbMRoC2d32pnka2uYpvntpRMQAiMxB9JsHN
        W7fTB2HhL499PQKk9HpzhyTELtvWAys=
X-Google-Smtp-Source: ABdhPJzmElqZb4Gn4e+L7HKvqozI6wfyq1Ve6W6oZ9UP4ngTfM1mXM1RB0sMJOsXnWQZVP9R29AEYg==
X-Received: by 2002:a05:6402:4312:: with SMTP id m18mr15748176edc.99.1612126007298;
        Sun, 31 Jan 2021 12:46:47 -0800 (PST)
Received: from [192.168.100.54] (mm-58-44-120-178.brest.dynamic.pppoe.byfly.by. [178.120.44.58])
        by smtp.gmail.com with ESMTPSA id u16sm6948609ejn.117.2021.01.31.12.46.45
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 12:46:46 -0800 (PST)
From:   Artur Sinila <logarithmus.dev@gmail.com>
X-Google-Original-From: Artur Sinila <opensource@logarithmus.dev>
Message-ID: <b7200bf4d9c10c1968ac87e9fb84e9cd97ebcac5.camel@logarithmus.dev>
Subject: Hello there
Reply-To: opensource@logarithmus.dev
To:     linux-wireless@vger.kernel.org
Date:   Sun, 31 Jan 2021 23:46:44 +0300
Content-Type: text/plain
User-Agent: Evolution 3.38.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello there!

