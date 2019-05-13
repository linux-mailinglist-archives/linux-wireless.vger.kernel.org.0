Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8691BB61
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 18:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbfEMQ4f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 12:56:35 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:40381 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbfEMQ4f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 12:56:35 -0400
Received: by mail-pf1-f172.google.com with SMTP id u17so7508813pfn.7
        for <linux-wireless@vger.kernel.org>; Mon, 13 May 2019 09:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=H4XP7MC3Y5NXAjSJndAzUoShX4asORqyF9dp8B/9SGM=;
        b=rMF351Uj2in4BVj1de58ML2laPLYwD/pgZ/Aqv1O5CcxvLSck9ijG+siQVABtz0ObA
         6AKmv941sbsxQaFGIuxtipIHN0FIQvwZuS4z8BNb7ezEMiOoDJ/7/EE/4v5La6Fyi5GS
         FMO9IuoCwQ1x3O76ivNeOnnUTUdsT8ml/lhLUFo0bUBH5f+fSU/7veYnWTwXSGPE83jc
         fOaQHKTB3Ms36v6+2sh3byr4X6oZdjIk+oRD7VBWUlOw5HLwe/yS7BgGNHGnom+DmaE9
         DKQmZAyhxq4rr2K+ceT0WNoj8J7zVMGD7o7KFrNEB67ED5YcLHYSO5Ut8/0Kqd8cyGnz
         5w1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=H4XP7MC3Y5NXAjSJndAzUoShX4asORqyF9dp8B/9SGM=;
        b=YWt/MMn1PqKxkQaP6LuZWH2+nJ3wsOutKkZzbhqw9oKrHNZT0zGWsefKOjNrIlx3Hj
         CCWvmKrbrzD2Y+pA1HwJq0QZo2utgPIysQeS8DvJ+Yu1OtvoChC0MesCJcZkl+EQ+APc
         VNiOwY19U6mnni8b4a2xD86JEdbS1mCQqeaA/JNv7r+DI7rRqUhUr6QgskkkvlvVOoIe
         j4oMDuWqbbjlym2RzcShkk0NCjae0kqWXcELYiPUuDiv5LUV8qxPZiEyphk8UCb+FNUT
         oDEPtaiE8IoL746zJEUmUxkrJbzhnjt5wl26MUAoyONRgK73K1HEyTOwGaZU4woG/SOM
         Y0vg==
X-Gm-Message-State: APjAAAVP1AjCrbH184wSx9QNbUBpffnotdbTkaB+T+joV6Wu0nScCLON
        QQx2A4P/3j0pzyvuZ795RPPRS3PLwlrBCxJa2OW2loI=
X-Google-Smtp-Source: APXvYqzQ2gHuLs1qlmZA6/4aVMNuvACoC6Vn3KkH2QEsnMATDdGeDQOUAeYsubXhjP4WRqcgNbNGPRb6XSuIoIYxYYQ=
X-Received: by 2002:a65:5687:: with SMTP id v7mr32549167pgs.299.1557766594433;
 Mon, 13 May 2019 09:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGJ1o_KskiCKQ8V-6U0nxWGgXXa4NWHV0EEwo41bMPSj1bbdg@mail.gmail.com>
In-Reply-To: <CAPGJ1o_KskiCKQ8V-6U0nxWGgXXa4NWHV0EEwo41bMPSj1bbdg@mail.gmail.com>
From:   Sam Samy <to.swami1@gmail.com>
Date:   Mon, 13 May 2019 09:56:23 -0700
Message-ID: <CAPGJ1o9qDYPQF882cw65uysjCmUYi6kJCmL2EUa0AXbwHj59Mg@mail.gmail.com>
Subject: ath10k 5Ghz RSSI low
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

 Hi,
 I installed master branch openwrt onto Asus MAP-AC2200 AP. It has tri
band. Its based on IPQ4019 DK04 QCA reference platform. 2 radios
(2Ghz/5Ghz) on AHB bus and one 5GHZ on PCIe bus. Its generally working
fine except one problem in 5Ghz. On both the 5Ghz radios the RSSI is
pretty low on any channel I put it in.  In one feet range I see -60dB
RSSI, where as the stock firmware that came with the AP gives an RSSI
of -36dB at one foot distance.The downstream transmit rates are MCS8/9
for most part. The 2Ghz is working fine. Its using the cal data from
the flash that came with the AP.

 Can you please suggest anyway to debug this or improve the RSSI?

 Thanks you!
