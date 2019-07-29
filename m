Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03E2179360
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2019 20:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfG2StQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jul 2019 14:49:16 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:34022 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfG2StP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jul 2019 14:49:15 -0400
Received: by mail-io1-f43.google.com with SMTP id k8so122401665iot.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2019 11:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FwK2CyynpfZkbhNrQZK9aJMHq1DPjlfQMQyVQUJ8xqE=;
        b=u8YRLHj8HQdgf//SnVj11E9hSN4m6T/wlJHtbaAO1BkLsXPJC0dGsMym4BIzcoo7ke
         tRFaVDx6iymEi3L6M36UQLek7UX3MOkdH2/odJ2knv23Z+jYTBhqxSN6pkWfbZO7VhvO
         owQxY4kq/8WoKbgUViCfqarehxG2YXc/txw3hoEMPZ+5IRt5KStjscu+fVFhzcv/kkGi
         dc/uuuMQb2wGUmblIs0E5ELlb1HVacWWPpe2ESg151ikOJxXzw5cd2teN/qGAqH0C8ae
         uH/i5gK6cHcjtF5jQoTioqxmD9Jm27KSZbH2niSQR4Y2IILG1oYNHcvQCYQBP8XUrPOb
         7++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FwK2CyynpfZkbhNrQZK9aJMHq1DPjlfQMQyVQUJ8xqE=;
        b=Awym7q5uzDk/W5hYczg/Gz5AAZwddEQkb0VKbLvRaMvFvci/032RqADhhWqMwfozm5
         yOGKEBYB17rRM+CVc9AqNcJCEdBshZ+MmGOeZHatVabN6Lvm4SNYCZPICefpSPQ+ZjQI
         GCjFDqRyUWWI9/ts0rLwWYzlTDBhGVhASAdztXvrb8NOkkvukSqkFrZPjsLBh8uKRtl6
         6t0t3+fVKtlbmURhgvvSKxpVSgdEmJaBYVcmb2XMkUIidkA7CMTT8SfVGFZHLe9POb9c
         m2XKat9AqH8zOfMnv8IhpMJle+2SasnT22tIv2wVyXq81qcEpuP1DxFZVmMTFQZOp+5y
         b6wA==
X-Gm-Message-State: APjAAAUPRd5J6LOXwGro8nrfFx8upEa8SIX1SKvjOBBhj0ZpSpVOa8JW
        3ORILZiCoLY45nzhVw/0nNciKOfTmQTMV2jrMdmd4IdC
X-Google-Smtp-Source: APXvYqwktdtn4V0wVLUAJEPghYfMLCoj8BOXsbg5IFxQiViNPircgGy7As6aTUmLN1ZrWLpYKNFShfO/pGkbMKTn/ks=
X-Received: by 2002:a6b:f90f:: with SMTP id j15mr96206351iog.43.1564426154664;
 Mon, 29 Jul 2019 11:49:14 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Mon, 29 Jul 2019 19:49:03 +0100
Message-ID: <CALeDE9Mwtm8fVMm6Ce99aju=UqPPSaZWQR+zZtJodENZ6_m+_Q@mail.gmail.com>
Subject: Regression with the latest iwlwifi 9260 and Canon Point firmware
To:     luciano.coelho@intel.com
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Luca,

Similar to the issues seen in the thread on [1] thje 9260 we're seeing
the same reports in Fedora on both versions of the firmware [2], on
both the 9260 series but also the Cannon Point-LP CNVi wifi devices as
well. There's more details and dmesg output in that bug report.

Do you have an update on the issue?

Peter

[1] https://www.spinics.net/lists/linux-wireless/msg188200.html
[2] https://bugzilla.redhat.com/show_bug.cgi?id=1733369
