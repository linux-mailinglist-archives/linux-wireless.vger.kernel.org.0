Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E970F3430B9
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Mar 2021 04:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhCUDSX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Mar 2021 23:18:23 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:36549 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhCUDSP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Mar 2021 23:18:15 -0400
Received: by mail-ed1-f48.google.com with SMTP id o19so15295133edc.3
        for <linux-wireless@vger.kernel.org>; Sat, 20 Mar 2021 20:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Tv3nlcUgsvJP86JYHCdntI7+Xp5kconUxgGsFBvd8kM=;
        b=DwtZ4UyaVnvIMwyzAbwF7nD0Fyxg9FhGoE7CtJr12jqYJu5UfjeBIhyGiY76zdwJAK
         6NfhJm8nJA2BxgAzZs9+UgVCusqT0L/j0ZqZ8O1Pm8eS8MGN0mEJBI/Yiaw6flXHeSAv
         +GFkxqSgc3o4v50YJSzYyICMcPx0878EdilpAMbZzaKLvASwOjYNx1sGI7emLre20EGJ
         FWvBqW5KF0IR06TjWK1u+bLZ4a9ZL3eO/psTZrA6O8G0IWx5IHAnJWa+c4TGMB2z8KEa
         q0CsCgXuT+ePsZfoLpEk1ipbojuqNl1c1q82xF7c3jG1tCBmuDgJzV7F9XtvxjAmBY8s
         kjjQ==
X-Gm-Message-State: AOAM530XCsA/0ZK9/e7i+rjAQ4PvkNMas6Y3T56F9DVuj4qUtipf5O8J
        gnn+vFNUo3CL+aiDTAO7qBKfqclc3Q==
X-Google-Smtp-Source: ABdhPJwX/ZlDxlHfk0QkqEYbKAPQE/RJhp0L+UZQ/g+iL0D5iBJcFQQHgjNnLn287BnqGthFbufCgg==
X-Received: by 2002:a50:e80c:: with SMTP id e12mr18588664edn.229.1616296694463;
        Sat, 20 Mar 2021 20:18:14 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id k26sm6286539ejx.81.2021.03.20.20.18.14
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Mar 2021 20:18:14 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id w18so15348884edc.0
        for <linux-wireless@vger.kernel.org>; Sat, 20 Mar 2021 20:18:14 -0700 (PDT)
X-Received: by 2002:a05:6402:3595:: with SMTP id y21mr18162065edc.233.1616296694221;
 Sat, 20 Mar 2021 20:18:14 -0700 (PDT)
MIME-Version: 1.0
From:   David Ross <daboross@daboross.net>
Date:   Sat, 20 Mar 2021 20:18:03 -0700
X-Gmail-Original-Message-ID: <CAJGcC5QF8ObDHshLRygLrPE0j4CnyC9cnAHXifau5oupKbmnuw@mail.gmail.com>
Message-ID: <CAJGcC5QF8ObDHshLRygLrPE0j4CnyC9cnAHXifau5oupKbmnuw@mail.gmail.com>
Subject: iwlwifi: Timeout waiting for PNVM load with AX210 chip
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

As of kernel 5.11.3, iwlwifi no longer successfully initializes my
AX210 wifi chip. It errors with

Timeout waiting for PNVM load!
Failed to start RT ucode: -110

This is with Intel Corporation Device 2725 (rev 1a), firmware version
59.601f3a66.0.

This also errors in 5.12.0-rc3. It works fine in 5.11.2.

Bug contains complete dmesg attached:
https://bugzilla.kernel.org/show_bug.cgi?id=212371

Thanks,
David Ross
